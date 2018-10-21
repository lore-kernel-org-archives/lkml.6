Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E595CECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 13:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9270C20843
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 13:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oJ/Jb5T0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9270C20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbeJUVV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 17:21:57 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46119 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbeJUVV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 17:21:57 -0400
Received: by mail-wr1-f67.google.com with SMTP id i4-v6so3250357wrr.13
        for <linux-kernel@vger.kernel.org>; Sun, 21 Oct 2018 06:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fZQ/b3g8L2ePG1mGAdPmSlgI+ftLHgPhFUHCX8y8zfc=;
        b=oJ/Jb5T0JcyWk3Oo0jVAZIOU1kbrjARGdyaOQWat0/ue/+cC4QFpmtp8jIX9ZzaN38
         06eHMZD8cp4vQgFBMyml+mRaaBbGXfAsMwWOuBJf1Fy4u5+LpKPvVR3o5a5g5C7HInZd
         RCCiq3LjcuEfKKnN4XvhxExEG2XKiIhXkThf4wtR8vmddQFVCajRM2IHkSdVVY1ylkBT
         B9ai+eHerDnGul/EkX8t8rK6F4jl01yYpKlgOEaaehHtlM1d/Y/8HwJ/hzLgwNxFX2zi
         tJBJI3z3fXPmJvCrznXmh4B5aqR4JiT2cNyCgssy9A7CUZ2NoUGqxbrmiJ/XTvPMwdMO
         HZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fZQ/b3g8L2ePG1mGAdPmSlgI+ftLHgPhFUHCX8y8zfc=;
        b=pdi2vSxHoEnxdVV44rD4LE6gt0GSwk0HjfIBCwvqwUIZPHYrNutogquS6XHwegdzSI
         4Htpsrlf2kUvYcd2Vvr0JA+p7tVr/hkJMOgdfFSgWYKAZv3ebVFdVFqX2sEn1lVkXPXU
         H9o+2CbJxr8/tjhVrPmg9+3wp2vHlXGf2+LaZjdeT//iYhEmd0OGpnEH0tF9sxOYymiX
         C+oR1hHJ86N6XNU4uV2AtuKhtrf5gK5+xu6r2RO9rKkW1CETJggzUttTosif7pPMINCt
         xn180c4usyrqtdDwIoI+BcWKXnZ0SPPN+DjEwL5Lfc39huX1ptTm6CtWouIpV84rgv7L
         hkeg==
X-Gm-Message-State: ABuFfoj7srecPen4/eRdJaPP7bC+2WYzdrwZzYugIkmRKbwQOnu4gnfk
        a0rfQIcbzjtSwtexeXCDikC7zohr
X-Google-Smtp-Source: ACcGV61bhhleLuLkA9zSqO186+/OaTdu5bgBEMu3a9pjOUkbTAcJYQEPX2FhKEIE1n81ev9UDpx2Jw==
X-Received: by 2002:a5d:480b:: with SMTP id l11-v6mr43551131wrq.28.1540127259910;
        Sun, 21 Oct 2018 06:07:39 -0700 (PDT)
Received: from artemis.netio.cloud (bzq-218-196-25.red.bezeqint.net. [81.218.196.25])
        by smtp.gmail.com with ESMTPSA id a12-v6sm20197250wrr.71.2018.10.21.06.07.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 06:07:39 -0700 (PDT)
From:   Rami Rosen <ramirose@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Rami Rosen <ramirose@gmail.com>
Subject: [PATCH] devres: fix a typo
Date:   Sun, 21 Oct 2018 16:07:19 +0300
Message-Id: <1540127239-35409-1-git-send-email-ramirose@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Rami Rosen <ramirose@gmail.com>

This patch fixes a typo in lib/devres.c.

---
 lib/devres.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/devres.c b/lib/devres.c
index faccf1a..f64cc21 100644
--- a/lib/devres.c
+++ b/lib/devres.c
@@ -290,7 +290,7 @@ static void pcim_iomap_release(struct device *gendev, void *res)
  * detach.
  *
  * This function might sleep when the table is first allocated but can
- * be safely called without context and guaranteed to succed once
+ * be safely called without context and guaranteed to succeed once
  * allocated.
  */
 void __iomem * const *pcim_iomap_table(struct pci_dev *pdev)
-- 
1.8.3.1

