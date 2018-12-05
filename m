Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EACBC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0742F20645
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rzZCCPXu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0742F20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbeLESb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 13:31:57 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40596 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbeLESbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 13:31:23 -0500
Received: by mail-wr1-f68.google.com with SMTP id p4so20731108wrt.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 10:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h+LaNoZ81q4MRBS5n/cL3NFI6ELrDAeI7zFOQzJ+Ehw=;
        b=rzZCCPXuX7daRFFzxJAOKDH2oWlv80OwXPlKxnrFYeaOKqt4tFQYUir8CpVPLppyeA
         +PaD29Zpz/RKyIVO9CAz18DoTosEwSqRoPSOA4jNhf3QmL7gLluUv/BMiidATOk9KhHw
         O0maR2CL1MDHvZkjjosRclg6IKZg30ZTqe/wjhPULk47rBlBhGfJ8OhOR+wrJ0ruv/Jm
         v19mKNiQ5FzDeATo25E2QUA4U/QRnDdWIY3ukDhroxdOGxLfhd02zsnDdJcNP5EMhwnB
         d8uZ0CgT1SDLJ0SLAIMHE0HywucOzV7rSZd144JPWZqiYcqVHANMKYXpgXG7n1eatyFD
         IaLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h+LaNoZ81q4MRBS5n/cL3NFI6ELrDAeI7zFOQzJ+Ehw=;
        b=Z47Ko1+KHViRNjcfKo+ZgF60BJipDXpcCSusk7n/LD8bgjbSjfApqUPtYGJBA0nHFa
         dQQuDydXHejbkvnp5P1HlvA9GX6uAQ6rUEAv1tCbhY4aWbWzgEqD03XA00ERnozWvZ2K
         Ueb+g0u/BILq+N0+xHSTjWPCfrByVOkRX0ifuedIINF90RCemk6e75usbgLZDW72RO5H
         Gr+yzqhBzQpnoy7XKTYCGDGYUDlB8Gw5oLzcaE3tKJqFt05HEgXso7Y6BI8K7p6ERpJj
         eAXvQIn22Oi20jzLXqc6cWydKd6B6e2bBjhDYsAqOiLv0ZkIFMD1TnV1x4AM4snbUw+l
         J5fg==
X-Gm-Message-State: AA+aEWbTReDjCslgTDH5T/7NC0c73NFSZo/OChpb5FZE+eDvv43aJh0x
        SO1pKIMSsdMIt4eOgye44aM=
X-Google-Smtp-Source: AFSGD/X5vpaypZ4MY8cwNiHD1E+cYHXWfoUT6RIwCffePclDrb3cUxzyXNr5JijdTjYco0A0I+prVg==
X-Received: by 2002:adf:ee06:: with SMTP id y6mr23508899wrn.261.1544034682231;
        Wed, 05 Dec 2018 10:31:22 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id a18sm27860998wrp.13.2018.12.05.10.31.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 10:31:21 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 09/12] staging: rtl8188eu: write out multiplying in wifirate2_ratetbl_inx()
Date:   Wed,  5 Dec 2018 19:30:57 +0100
Message-Id: <20181205183100.16828-9-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181205183100.16828-1-straube.linux@gmail.com>
References: <20181205183100.16828-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Write out multiplying in wifirate2_ratetbl_inx() to improve
readabilitiy and clear checkpatch issues with missing spaces
around '*' operator.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/rtl8188eu/core/rtw_wlan_util.c    | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
index 0eb904317118..7af3dd910c93 100644
--- a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
@@ -1123,29 +1123,29 @@ static int wifirate2_ratetbl_inx(unsigned char rate)
 	rate = rate & 0x7f;
 
 	switch (rate) {
-	case 54*2:
+	case 108:
 		return 11;
-	case 48*2:
+	case 96:
 		return 10;
-	case 36*2:
+	case 72:
 		return 9;
-	case 24*2:
+	case 48:
 		return 8;
-	case 18*2:
+	case 36:
 		return 7;
-	case 12*2:
+	case 24:
 		return 6;
-	case 9*2:
+	case 18:
 		return 5;
-	case 6*2:
+	case 12:
 		return 4;
-	case 11*2:
+	case 22:
 		return 3;
 	case 11:
 		return 2;
-	case 2*2:
+	case 4:
 		return 1;
-	case 1*2:
+	case 2:
 		return 0;
 	default:
 		return 0;
-- 
2.19.2

