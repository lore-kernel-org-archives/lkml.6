Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEAF8C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD8A82081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jue8aUJB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD8A82081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbeKHGMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 01:12:54 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36560 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbeKHGMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 01:12:54 -0500
Received: by mail-pl1-f194.google.com with SMTP id w24-v6so8394094plq.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 12:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JR0Rfw9fH1+7vyvtLI1tXlAk1pXgLP73l2sRMfZ7/0w=;
        b=jue8aUJBNKn76Vnp3UeuEaSa+jeaznf7He/qRHEXSHSRfe5Oe7Vr8HNrxZQX1IIGlI
         bKIiCYJyNPezy7FvFGaWPHm3+mlDjJwCd0GfCL1bUrmhD5HQXOlIPcaEjlpAhBbC5Pgd
         FB9uGMd4B/JGMSzL7L9b0oAM4E2s4YOiBnElA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JR0Rfw9fH1+7vyvtLI1tXlAk1pXgLP73l2sRMfZ7/0w=;
        b=cos2mebrmzLAlxEDv0co8Vv5lG65c17w7O65498fOkcl75aX+TBvBKlJZ//vMoBPV7
         8PrEbcT6LDKVPVS/Co72mwCTleEcxY7Vl/dzZtvL0xOMHIRR0Yl8VeQLqNco2ESrWymc
         /SW4X2B9rLydIUEi1e9Qlvpic4KMFwjiEAKz+S7zN96Mm1uc2Jy2OT1OFf+FO6uO3hh6
         j6ILbz1ClcAJ4eN6G6atqL2qcxLntBHQkC1nidS9kcgCtN0ssCHb1eaOdyHbHqxoeD4Q
         eRjrwIobIlx7g4MwC5FrXatwe7qikOEAUQ4rPz/4DXgVLYk+nuICsN8lEvgF66QrZ0lI
         tcGQ==
X-Gm-Message-State: AGRZ1gLQx8Tf/iKbRci3cECQO3gVRU+yQ1JZzsUAZkEKk42oCRbHFyE2
        uqIUD1CYErPT99srChTCjshsNn6HOc4=
X-Google-Smtp-Source: AJdET5fIVbxEkRLhzffCUIsMGefvO/n1cKliRax/rVZnNRM8jXBf4rZXVm3Y5DZGEM0wBvmAaj2YgQ==
X-Received: by 2002:a17:902:da8:: with SMTP id 37-v6mr1840319plv.12.1541623251292;
        Wed, 07 Nov 2018 12:40:51 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:299d:6b87:5478:d28a])
        by smtp.gmail.com with ESMTPSA id m10-v6sm2118013pfg.180.2018.11.07.12.40.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 12:40:37 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     linux-usb@vger.kernel.org, <linux-kernel@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH] usb: dwc3: don't log probe deferrals; but do log other error codes
Date:   Wed,  7 Nov 2018 12:40:29 -0800
Message-Id: <20181107204029.88466-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's not very useful to repeat a bunch of probe deferral errors. And
it's also not very useful to log "failed" without telling the error
code.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/usb/dwc3/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 88c80fcc39f5..1ef346ba6a02 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1482,7 +1482,8 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	ret = dwc3_core_init(dwc);
 	if (ret) {
-		dev_err(dev, "failed to initialize core\n");
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "failed to initialize core: %d\n", ret);
 		goto err4;
 	}
 
-- 
2.19.1.930.g4563a0d9d0-goog

