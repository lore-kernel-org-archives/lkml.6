Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C91CC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FA3120850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544039610;
	bh=kb7XAJdPpwP1nkGwVVigzNsPM6nJ3v4fN262NV7gE10=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=KL0Y7TDBCqBSmbREybMMuQulLTN73N+OUIASFILrDawpkAcjKL8P992mw5+zwKpkC
	 y35NtVg0EMf7GsTeEhEa1GLHhnI3VJb90h+yepixOjwtAoNk04GegmBkVewuZuVpeQ
	 tdOntcPriNiMGYfj/mMw7WtVRxnKqb2Dkf/aqRDQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FA3120850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbeLETx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:53:29 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43291 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728680AbeLETvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:51:04 -0500
Received: by mail-ot1-f68.google.com with SMTP id a11so19777642otr.10;
        Wed, 05 Dec 2018 11:51:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GZgjkFET1bzPb4auc4sTGGACiXRluVD1e+x+cDDczS0=;
        b=WcPRhQr7ZzXHYle6GSrcNfsuQwoKJpWQ+1dmhtCxyI40rQtJT3FqC2fNagMgNInPZh
         TLQ60F9cD670xVMXyYkHl8GVp8GZf5iXMRBsswG62jmuTaH9YuQ1v9V2UPPykXIxjBZA
         tid0beFi58VdvCO9fh73s21BHB1Zi6CNHWZhNAlcL66idBZhv77oUb7IG3hctrVsRxUS
         uFzKlQVnuz2cJx6vSVkdcXjpwOc8SDtv9Lf18Fey020QXl3PhjzbcCpikewyNqjB1ZAr
         DWEo6oWL/hUL3wAGN4qyvfpF2J1H3NZ+OAMpONWUN7jsN/UiO+RLcmJHwf3rJ4rj3weM
         vBiw==
X-Gm-Message-State: AA+aEWbAMBK+xyYrghnEEY2b6M9V4dxRjtPY7h8OyRlhOO/yc/lAE8X8
        QcPwPYjEVTwbshw2+ipVj9wNHt0=
X-Google-Smtp-Source: AFSGD/Wjj24RRT2FIKpNfefJu+AdS4gXC88+wqCUumREbQ/I5oWnWved72BAnufWRqovEUlE2xpdWw==
X-Received: by 2002:a9d:7dd5:: with SMTP id k21mr16953195otn.214.1544039463067;
        Wed, 05 Dec 2018 11:51:03 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id k13sm25759879otj.19.2018.12.05.11.51.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 11:51:02 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org
Subject: [PATCH] leds: 88pm860x: Use of_node_name_eq for node name comparisons
Date:   Wed,  5 Dec 2018 13:50:27 -0600
Message-Id: <20181205195050.4759-11-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert string compares of DT node names to use of_node_name_eq helper
instead. This removes direct access to the node name pointer.

For instances using of_node_cmp, this has the side effect of now using
case sensitive comparisons. This should not matter for any FDT based
system which this is.

Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: linux-leds@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/leds/leds-88pm860x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/leds-88pm860x.c b/drivers/leds/leds-88pm860x.c
index 77a104d2b124..036d4a536697 100644
--- a/drivers/leds/leds-88pm860x.c
+++ b/drivers/leds/leds-88pm860x.c
@@ -130,7 +130,7 @@ static int pm860x_led_dt_init(struct platform_device *pdev,
 		return -ENODEV;
 	}
 	for_each_child_of_node(nproot, np) {
-		if (!of_node_cmp(np->name, data->name)) {
+		if (of_node_name_eq(np, data->name)) {
 			of_property_read_u32(np, "marvell,88pm860x-iset",
 					     &iset);
 			data->iset = PM8606_LED_CURRENT(iset);
-- 
2.19.1

