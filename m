Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B27ECDFAA
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 01:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48AF920877
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 01:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZpN+aHm6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48AF920877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731269AbeGQBhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 21:37:42 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:34602 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730002AbeGQBhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 21:37:42 -0400
Received: by mail-io0-f196.google.com with SMTP id l7-v6so39701925ioj.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 18:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=BzUgvVQ4gIKUl0+bbeDMHrHE/Gt4himfMPoGzrwwrxA=;
        b=ZpN+aHm6t3x5Cztnj4IfH+bsmbSgTpytzCZ9TJP6R2NsNvV4lYFf8xZGQ8yZfLA5g4
         BPGsvE/e1pzwzPmkLBRN64gHsbbwihDj+K9ndlamiOuFho2vAFQgc2sWAW885UNv033e
         IXLiZFw8s1BTVfzckzOcH1egnNFeyEM1Wt0vw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BzUgvVQ4gIKUl0+bbeDMHrHE/Gt4himfMPoGzrwwrxA=;
        b=U/nkyvdGWFygHRVHdbt/KbmZkoqAofun8XjNv/pbcxrnmNb5n7aHQzQ4H+CU8SehhD
         l7tD85d/UktJvChT28YMDWJHl+ZDdu/luJwSCFPBJtK37iA+yulfo6tnfOm0gRbud4+m
         JyiKCqVoh+fD7EeDzVLHwR4h/5xR56Fes+zIolksPWPFffLoHlkxYRwmNSL/7bLMoL3e
         a9qkmfDZrL2fpraqng3vGTCtka0J/09wfFyuPyQ6Xwh3+vaENTvGHb4iZjPrJG4+Df+5
         RymWgUllAIt4TOs9iLNrWfxdjpsPMiJ0RIRpd5fpOE41suiQ6UF37jhx/dkCelC3MRK5
         NBAQ==
X-Gm-Message-State: AOUpUlHrVE/eTrbZJ5JpJfbpOvphcYeWuGuGgAF4wUz3mDU+1rc79sg4
        x87jiGlhoTxLqsgD9J1Q6cpi0Q==
X-Google-Smtp-Source: AAOMgpcP1+MfoZoMdqu7c0AbEK6T5M3cbAl0nfzz9seT7WCFNTW0QUpeXi1clODqRjoxR4/JW9HzbQ==
X-Received: by 2002:a6b:9681:: with SMTP id y123-v6mr10894507iod.97.1531789663914;
        Mon, 16 Jul 2018 18:07:43 -0700 (PDT)
Received: from djkurtz2.bld.corp.google.com ([2620:15c:183:0:1cfd:61a5:7215:5f9c])
        by smtp.gmail.com with ESMTPSA id k19-v6sm12212957iob.37.2018.07.16.18.07.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 18:07:43 -0700 (PDT)
From:   Daniel Kurtz <djkurtz@chromium.org>
Cc:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Nehal Shah <Nehal-bakulchandra.Shah@amd.com>,
        Ken Xue <Ken.Xue@amd.com>, Daniel Kurtz <djkurtz@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org (open list:PIN CONTROL SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] pinctrl/amd: fix gpio irq level in debugfs
Date:   Mon, 16 Jul 2018 19:07:41 -0600
Message-Id: <20180717010742.1847-1-djkurtz@chromium.org>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the AMD BKDG, the GPIO ActiveLevel bits (10:9) map to:
 00 Active High
 01 Active Low
 10 Active on both edges iff LevelTrig (bit 8) == 0
 11 Reserved

The current code has a bug where it interprets 00 => Active Low, and
01 => Active High.

Fix the bug, restrict "Active on both" to just the edge trigger case, and
refactor a bit to make the logic more readable.

Change-Id: Id7775ae4cb61d193fa7fbb83967a8c5a7cdd0de6
Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 drivers/pinctrl/pinctrl-amd.c | 14 +++++++-------
 drivers/pinctrl/pinctrl-amd.h |  4 ++++
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 04ae139671c8a8..5df5e8d64c57e7 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -247,16 +247,16 @@ static void amd_gpio_dbg_show(struct seq_file *s, struct gpio_chip *gc)
 			raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
 
 			if (pin_reg & BIT(INTERRUPT_ENABLE_OFF)) {
+				u8 level = (pin_reg >> ACTIVE_LEVEL_OFF) &
+						ACTIVE_LEVEL_MASK;
 				interrupt_enable = "interrupt is enabled|";
 
-				if (!(pin_reg & BIT(ACTIVE_LEVEL_OFF)) &&
-				    !(pin_reg & BIT(ACTIVE_LEVEL_OFF + 1)))
-					active_level = "Active low|";
-				else if (pin_reg & BIT(ACTIVE_LEVEL_OFF) &&
-					 !(pin_reg & BIT(ACTIVE_LEVEL_OFF + 1)))
+				if (level == ACTIVE_LEVEL_HIGH)
 					active_level = "Active high|";
-				else if (!(pin_reg & BIT(ACTIVE_LEVEL_OFF)) &&
-					 pin_reg & BIT(ACTIVE_LEVEL_OFF + 1))
+				else if (level == ACTIVE_LEVEL_LOW)
+					active_level = "Active low|";
+				else if (!(pin_reg & BIT(LEVEL_TRIG_OFF)) &&
+					 level == ACTIVE_LEVEL_BOTH)
 					active_level = "Active on both|";
 				else
 					active_level = "Unknown Active level|";
diff --git a/drivers/pinctrl/pinctrl-amd.h b/drivers/pinctrl/pinctrl-amd.h
index 8fa453a59da5e6..22af7edfdb38e8 100644
--- a/drivers/pinctrl/pinctrl-amd.h
+++ b/drivers/pinctrl/pinctrl-amd.h
@@ -54,6 +54,10 @@
 #define ACTIVE_LEVEL_MASK	0x3UL
 #define DRV_STRENGTH_SEL_MASK	0x3UL
 
+#define ACTIVE_LEVEL_HIGH	0x0UL
+#define ACTIVE_LEVEL_LOW	0x1UL
+#define ACTIVE_LEVEL_BOTH	0x2UL
+
 #define DB_TYPE_NO_DEBOUNCE               0x0UL
 #define DB_TYPE_PRESERVE_LOW_GLITCH       0x1UL
 #define DB_TYPE_PRESERVE_HIGH_GLITCH      0x2UL
-- 
2.18.0.203.gfac676dfb9-goog

