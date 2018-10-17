Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B57ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 21:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A48D22145D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 21:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u6I93RsA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A48D22145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbeJRE7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 00:59:13 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44552 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbeJRE7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 00:59:13 -0400
Received: by mail-wr1-f67.google.com with SMTP id 63-v6so31193410wra.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 14:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rXEEqFsHZaBsbLkDJazPdRtpVKFHwMivlk2dm0fBkMA=;
        b=u6I93RsAIJTVqqmu25A24dvxZcLK8jeNPl7UEQSnBeBQDDX1BTyZkoF4+nS8Lb6OPN
         jGiKWecRvWjDZR6AcMFM6HYnawtGc67qjDNsg9XZG5kPAQon+9GdzCFuouY8HvPONAbN
         UfKAu9Jd3GYHJNHFq4OeCCKIswFzQCPb7v2lzA/7OHZ2NQlR4f6tk0OtY+56jMqxJLQT
         6p0rfrXB3ZjrDNsPL20z2+Y+BPVBYbRneMbHXZ0H2IpLdSE2L0BayNo6ZUHIFXCaUddV
         rZEXdArcv6SS3VYFJHl5rnsSCJiuH26D5F6sgawwE1ws3hbfBICVlJ/xGN31BZwtVvk2
         CX3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rXEEqFsHZaBsbLkDJazPdRtpVKFHwMivlk2dm0fBkMA=;
        b=BxJAmpYoFCQeL8iftCvo+uA2cCEFlTdt+no9JB7zR9BOW18xJvYeUhDodQSVdJGSwK
         oounjKoN3YFO11Vq0m2gb423YiK0PdZ3nn5uUbobdBEcv8SgqLthZrDUPzcCVKwYD8ro
         +yDF67uAVF06q/ZP6fP+Iesxfli8PU98Piq/jsARl8SS68ngEZ9xSpDfXAQkiHcCg6wN
         mfwMToihYIa/Hb07b0zk5bCFjGRbSeS0kSonAb8EDQlouJpPHATsfGzP+ljXaQ3eLmXQ
         ILTZzLIh610ks6/9wByi9/vHEVsPri8Uq7yFDcAPxMD19OHRu3+vtFEAKx8mmyDpToO2
         l/3Q==
X-Gm-Message-State: ABuFfojG+HQvaJxqFegSO7ZIvpQGMMCDI80L6Z4CY4Kgv74rN0Bw//Tj
        ZIE+LjSYv435upLVehSvlNg=
X-Google-Smtp-Source: ACcGV62bT4+Pn4D17GYeEhy/db24KHlKw1E/+qBP77O00oSB8wqHPVgxvI71dtOUy0/SNEAILXH4ww==
X-Received: by 2002:a5d:488a:: with SMTP id g10-v6mr25733354wrq.0.1539810103040;
        Wed, 17 Oct 2018 14:01:43 -0700 (PDT)
Received: from osboxes.localdomain (bzq-109-65-231-165.red.bezeqint.net. [109.65.231.165])
        by smtp.googlemail.com with ESMTPSA id 77-v6sm5006540wmv.6.2018.10.17.14.01.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Oct 2018 14:01:42 -0700 (PDT)
From:   Carmeli Tamir <carmeli.tamir@gmail.com>
To:     gregkh@linuxfoundation.org, dan.carpenter@oracle.com,
        chrisadr@gentoo.org
Cc:     carmeli.tamir@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] staging: emxx_udc: Added static modifier to udc_controller
Date:   Wed, 17 Oct 2018 17:01:29 -0400
Message-Id: <1539810089-11823-1-git-send-email-carmeli.tamir@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added static modifier to the udc_controller, since it's only
required within emxx_udc.c.

Signed-off-by: Carmeli Tamir <carmeli.tamir@gmail.com>
---
 drivers/staging/emxx_udc/emxx_udc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emxx_udc/emxx_udc.c
index 3e51476..94a4327 100644
--- a/drivers/staging/emxx_udc/emxx_udc.c
+++ b/drivers/staging/emxx_udc/emxx_udc.c
@@ -56,7 +56,7 @@ static void _nbu2ss_fifo_flush(struct nbu2ss_udc *, struct nbu2ss_ep *);
 
 /*===========================================================================*/
 /* Global */
-struct nbu2ss_udc udc_controller;
+static struct nbu2ss_udc udc_controller;
 
 /*-------------------------------------------------------------------------*/
 /* Read */
-- 
2.7.4

