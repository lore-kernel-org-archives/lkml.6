Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30A2C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B0EE205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMT7cpjm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405026AbfAPQDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:03:10 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37320 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404786AbfAPQDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:03:09 -0500
Received: by mail-pf1-f194.google.com with SMTP id y126so3264886pfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 08:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nuglaLaqAM4zKue/k6H9LxmeowaBhzx0m1mqCkpfrCE=;
        b=KMT7cpjmE3czhfGHAAeGqkjx4EVt069NgUOeMTWRexwRlvzW5VUJ4jrDODrtp/tGrL
         zWg7b0PM6v75UtBrFXlPOo6ikCysI5Y9T3FBUQY2Kqd40B1whnmkDCfaAPQ0RqnYkq1B
         asHA62ISICTixCvnDSIfUWOVI8g88drd+e4SH0y4CGI5+clexbxao9zeY+voKre5DVvf
         A9i1jEuaudfw8KzFb4dL9P1VBX1o7mIcIqLXamg5eIAaZw75lzgccYcAwtodDC5PVXYX
         nVqwIL85t37vpXzc1KmRR5CZ2oEEjOWnXJwgqc9f/Lm9Gki2WnuAJPyGmmURCcmm9Li4
         8JjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nuglaLaqAM4zKue/k6H9LxmeowaBhzx0m1mqCkpfrCE=;
        b=kTYhNPWG/YkEWWHH+c/gGzMlClS0wBe3u3bZh59W879xR+eXp/WeLeY1BF8nSmI2fj
         ol1eUoUWNeUDVSrBqTKi6Vkd80Fdql4QZM29WRGs74tIfwhoEMH8v7Ifx+brpsZKNO12
         nPwe4yJxvZW7tpGZRQO9/E0jL2yKoFSE4k2NfBUIaUdaTy+bht/09NJehXuliskXU76K
         At/z9XFCFiEN5CeRHPLSP01Q445kn8Q6kskpqqzBnl4uoDIOfgiXZTMOP8tR1vHJxULr
         JPH8JgT3p4w5IBwkhIFipr43NXEMGsmIyVO6XLqe2MzcQdStYRZJ4dMWeXKrtRLCxZA7
         tY4Q==
X-Gm-Message-State: AJcUukf4vuGNb7AoTDDSknCvAW6G5CdsGRnNm4S7nz/bIkDeLqFVO3TI
        BPQBiCfEhk7qBf77n9dhrDs=
X-Google-Smtp-Source: ALg8bN5c6RpBFnSpq3avYvP3dvrYG0CTPwqXrt2bUEBrXjdfpJYqstK5S0RlDHzc/RsS9VAgKd5nqQ==
X-Received: by 2002:a63:e711:: with SMTP id b17mr9219353pgi.363.1547654588253;
        Wed, 16 Jan 2019 08:03:08 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id v89sm12892594pfj.164.2019.01.16.08.03.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 08:03:07 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     tglx@linutronix.de, douliyangs@gmail.com, marc.zyngier@arm.com,
        rdunlap@infradead.org, palmer@sifive.com
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] irq: convert the code format to BIT()
Date:   Wed, 16 Jan 2019 11:03:05 -0500
Message-Id: <20190116160305.20639-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use BIT() to do some clean-up.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 include/linux/irq.h | 106 ++++++++++++++++++++++----------------------
 1 file changed, 53 insertions(+), 53 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index def2b2aac8b1..66c9801ce108 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -73,30 +73,30 @@ enum irqchip_irq_state;
  * IRQ_DISABLE_UNLAZY		- Disable lazy irq disable
  */
 enum {
-	IRQ_TYPE_NONE		= 0x00000000,
-	IRQ_TYPE_EDGE_RISING	= 0x00000001,
-	IRQ_TYPE_EDGE_FALLING	= 0x00000002,
+	IRQ_TYPE_NONE		= 0,
+	IRQ_TYPE_EDGE_RISING	= BIT(0),
+	IRQ_TYPE_EDGE_FALLING	= BIT(1),
 	IRQ_TYPE_EDGE_BOTH	= (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING),
-	IRQ_TYPE_LEVEL_HIGH	= 0x00000004,
-	IRQ_TYPE_LEVEL_LOW	= 0x00000008,
+	IRQ_TYPE_LEVEL_HIGH	= BIT(2),
+	IRQ_TYPE_LEVEL_LOW	= BIT(3),
 	IRQ_TYPE_LEVEL_MASK	= (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_LEVEL_HIGH),
-	IRQ_TYPE_SENSE_MASK	= 0x0000000f,
+	IRQ_TYPE_SENSE_MASK	= GENMASK(3,0),
 	IRQ_TYPE_DEFAULT	= IRQ_TYPE_SENSE_MASK,
 
-	IRQ_TYPE_PROBE		= 0x00000010,
-
-	IRQ_LEVEL		= (1 <<  8),
-	IRQ_PER_CPU		= (1 <<  9),
-	IRQ_NOPROBE		= (1 << 10),
-	IRQ_NOREQUEST		= (1 << 11),
-	IRQ_NOAUTOEN		= (1 << 12),
-	IRQ_NO_BALANCING	= (1 << 13),
-	IRQ_MOVE_PCNTXT		= (1 << 14),
-	IRQ_NESTED_THREAD	= (1 << 15),
-	IRQ_NOTHREAD		= (1 << 16),
-	IRQ_PER_CPU_DEVID	= (1 << 17),
-	IRQ_IS_POLLED		= (1 << 18),
-	IRQ_DISABLE_UNLAZY	= (1 << 19),
+	IRQ_TYPE_PROBE		= BIT(4),
+
+	IRQ_LEVEL		= BIT(8),
+	IRQ_PER_CPU		= BIT(9),
+	IRQ_NOPROBE		= BIT(10),
+	IRQ_NOREQUEST		= BIT(11),
+	IRQ_NOAUTOEN		= BIT(12),
+	IRQ_NO_BALANCING	= BIT(13),
+	IRQ_MOVE_PCNTXT		= BIT(14),
+	IRQ_NESTED_THREAD	= BIT(15),
+	IRQ_NOTHREAD		= BIT(16),
+	IRQ_PER_CPU_DEVID	= BIT(17),
+	IRQ_IS_POLLED		= BIT(18),
+	IRQ_DISABLE_UNLAZY	= BIT(19),
 };
 
 #define IRQF_MODIFY_MASK	\
@@ -211,26 +211,26 @@ struct irq_data {
  * IRQD_CAN_RESERVE		- Can use reservation mode
  */
 enum {
-	IRQD_TRIGGER_MASK		= 0xf,
-	IRQD_SETAFFINITY_PENDING	= (1 <<  8),
-	IRQD_ACTIVATED			= (1 <<  9),
-	IRQD_NO_BALANCING		= (1 << 10),
-	IRQD_PER_CPU			= (1 << 11),
-	IRQD_AFFINITY_SET		= (1 << 12),
-	IRQD_LEVEL			= (1 << 13),
-	IRQD_WAKEUP_STATE		= (1 << 14),
-	IRQD_MOVE_PCNTXT		= (1 << 15),
-	IRQD_IRQ_DISABLED		= (1 << 16),
-	IRQD_IRQ_MASKED			= (1 << 17),
-	IRQD_IRQ_INPROGRESS		= (1 << 18),
-	IRQD_WAKEUP_ARMED		= (1 << 19),
-	IRQD_FORWARDED_TO_VCPU		= (1 << 20),
-	IRQD_AFFINITY_MANAGED		= (1 << 21),
-	IRQD_IRQ_STARTED		= (1 << 22),
-	IRQD_MANAGED_SHUTDOWN		= (1 << 23),
-	IRQD_SINGLE_TARGET		= (1 << 24),
-	IRQD_DEFAULT_TRIGGER_SET	= (1 << 25),
-	IRQD_CAN_RESERVE		= (1 << 26),
+	IRQD_TRIGGER_MASK		= GENMASK(3,0),
+	IRQD_SETAFFINITY_PENDING	= BIT(8),
+	IRQD_ACTIVATED			= BIT(9),
+	IRQD_NO_BALANCING		= BIT(10),
+	IRQD_PER_CPU			= BIT(11),
+	IRQD_AFFINITY_SET		= BIT(12),
+	IRQD_LEVEL			= BIT(13),
+	IRQD_WAKEUP_STATE		= BIT(14),
+	IRQD_MOVE_PCNTXT		= BIT(15),
+	IRQD_IRQ_DISABLED		= BIT(16),
+	IRQD_IRQ_MASKED			= BIT(17),
+	IRQD_IRQ_INPROGRESS		= BIT(18),
+	IRQD_WAKEUP_ARMED		= BIT(19),
+	IRQD_FORWARDED_TO_VCPU		= BIT(20),
+	IRQD_AFFINITY_MANAGED		= BIT(21),
+	IRQD_IRQ_STARTED		= BIT(22),
+	IRQD_MANAGED_SHUTDOWN		= BIT(23),
+	IRQD_SINGLE_TARGET		= BIT(24),
+	IRQD_DEFAULT_TRIGGER_SET	= BIT(25),
+	IRQD_CAN_RESERVE		= BIT(26),
 };
 
 #define __irqd_to_state(d) ACCESS_PRIVATE((d)->common, state_use_accessors)
@@ -507,14 +507,14 @@ struct irq_chip {
  * IRQCHIP_SUPPORTS_LEVEL_MSI	Chip can provide two doorbells for Level MSIs
  */
 enum {
-	IRQCHIP_SET_TYPE_MASKED		= (1 <<  0),
-	IRQCHIP_EOI_IF_HANDLED		= (1 <<  1),
-	IRQCHIP_MASK_ON_SUSPEND		= (1 <<  2),
-	IRQCHIP_ONOFFLINE_ENABLED	= (1 <<  3),
-	IRQCHIP_SKIP_SET_WAKE		= (1 <<  4),
-	IRQCHIP_ONESHOT_SAFE		= (1 <<  5),
-	IRQCHIP_EOI_THREADED		= (1 <<  6),
-	IRQCHIP_SUPPORTS_LEVEL_MSI	= (1 <<  7),
+	IRQCHIP_SET_TYPE_MASKED		= BIT(0),
+	IRQCHIP_EOI_IF_HANDLED		= BIT(1),
+	IRQCHIP_MASK_ON_SUSPEND		= BIT(2),
+	IRQCHIP_ONOFFLINE_ENABLED	= BIT(3),
+	IRQCHIP_SKIP_SET_WAKE		= BIT(4),
+	IRQCHIP_ONESHOT_SAFE		= BIT(5),
+	IRQCHIP_EOI_THREADED		= BIT(6),
+	IRQCHIP_SUPPORTS_LEVEL_MSI	= BIT(7),
 };
 
 #include <linux/irqdesc.h>
@@ -1007,11 +1007,11 @@ struct irq_chip_generic {
  * @IRQ_GC_BE_IO:		Use big-endian register accesses (default: LE)
  */
 enum irq_gc_flags {
-	IRQ_GC_INIT_MASK_CACHE		= 1 << 0,
-	IRQ_GC_INIT_NESTED_LOCK		= 1 << 1,
-	IRQ_GC_MASK_CACHE_PER_TYPE	= 1 << 2,
-	IRQ_GC_NO_MASK			= 1 << 3,
-	IRQ_GC_BE_IO			= 1 << 4,
+	IRQ_GC_INIT_MASK_CACHE		= BIT(0),
+	IRQ_GC_INIT_NESTED_LOCK		= BIT(1),
+	IRQ_GC_MASK_CACHE_PER_TYPE	= BIT(2),
+	IRQ_GC_NO_MASK			= BIT(3),
+	IRQ_GC_BE_IO			= BIT(4),
 };
 
 /*
-- 
2.17.0

