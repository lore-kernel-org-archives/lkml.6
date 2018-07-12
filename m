Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEBEC476E8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8D6920849
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6hRCukI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8D6920849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732355AbeGLQ1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 12:27:03 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37220 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbeGLQ1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 12:27:02 -0400
Received: by mail-ed1-f66.google.com with SMTP id v22-v6so22327113edq.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 09:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+KMamtl9zKpkUOF4V71i5K5DqQg35O6kvgINOWpT9T0=;
        b=d6hRCukIcN9WcLJNe/NCtZcqUDjibfO1tPYLTbPQKm+7GKOU760nXk9mAXo4gv4J30
         FtfNoPz0H3g7PN5/dP/40oL2ckO+V/Z0+WNJSqd1Rdufdwbb+tCnY/pf2sX5+Mt071Um
         RKXHJW4KSB4fr1ONpLHqtrmh5+1rsfNwj4djqAuH0uLTc6U/NSM4cMXNbDjqmwLm4/5L
         wCZc+85vSNZE8i/EaYF7j/e1x1TMKGs5TzbohsN3mNZzl4AAA1BIosceRKCEvxQFj4+c
         iD724vCI0aaOSzLZmDCJ8I7sSrdQ5bMYznmf72uk0wrAbwzOxDfs1DlL/nJ/CkfvaG0U
         GSzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+KMamtl9zKpkUOF4V71i5K5DqQg35O6kvgINOWpT9T0=;
        b=oDYCt6mevGyQ84AnTrRM5jJZWjuPxA6klXeB4EfHRaf8VYVE9jD9FoazXPyW+uab4Z
         xGIzRFR+4MZzn29V1YW+XmUbkOlqDYUqwwn5uXsCqNwkO8lwHedTqYirgrMJHRUlISRD
         a3GzFZBx89J2C9ir+VZIcj01IjI57+xSC0TkZxqvCNhw+XUWI4FRyDGYPfMy7CuGLXnU
         R0SHvZfh/0V4K9ENw4pydLZ4YItXQA4UnE4dVMlJru9cnru+5BkOngyhUd9VRX/Jw1Tn
         u36EE8fM4BFDHlV7evnHdIrIDcPtAGzMqcVxhOlPsGpSfbzZP2DsLfLXkr5dMsGmqKH2
         GOkw==
X-Gm-Message-State: AOUpUlF6SjPkdtzURYf4qgiCUt3jmJ3b/MuhCb90lyce8EBdIiHtsx2b
        OpdvXNKT2tKPvzYPa7cIC3A=
X-Google-Smtp-Source: AAOMgpflhJ4rQgeWOd30KOaAB8dVBaaD7FonI69Y+iZxUqXn9NbgOKOc3roSFJY3I1akyLOlocQtiQ==
X-Received: by 2002:a50:8d46:: with SMTP id t6-v6mr3184035edt.238.1531412207824;
        Thu, 12 Jul 2018 09:16:47 -0700 (PDT)
Received: from arch.localdomain (x4d0a32b7.dyn.telefonica.de. [77.10.50.183])
        by smtp.gmail.com with ESMTPSA id r11-v6sm3923921edh.32.2018.07.12.09.16.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 09:16:47 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8188eu: use strlcpy instead of strncpy
Date:   Thu, 12 Jul 2018 18:16:13 +0200
Message-Id: <20180712161613.9317-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use strlcpy instead of strncpy to avoid gcc 8 warning:
warning: '__builtin_strncpy' specified bound 16 equals destination size [-Wstringop-truncation]

The maximum length of the source string including terminating null is 5.
Hence it always fits in the destination buffer of length 16.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/os_dep/ioctl_linux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
index 80ccd19e776d..0f82a8c330f8 100644
--- a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
@@ -1912,7 +1912,7 @@ static int rtw_wx_set_enc_ext(struct net_device *dev,
 		goto exit;
 	}
 
-	strncpy((char *)param->u.crypt.alg, alg_name, IEEE_CRYPT_ALG_NAME_LEN);
+	strlcpy((char *)param->u.crypt.alg, alg_name, IEEE_CRYPT_ALG_NAME_LEN);
 
 	if (pext->ext_flags & IW_ENCODE_EXT_SET_TX_KEY)
 		param->u.crypt.set_tx = 1;
-- 
2.18.0

