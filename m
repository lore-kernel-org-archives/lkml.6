Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839F7C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21B7421473
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ywj6zKJo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21B7421473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbeJEVfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 17:35:17 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55741 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729042AbeJEVfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 17:35:16 -0400
Received: by mail-wm1-f67.google.com with SMTP id 206-v6so2090590wmb.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 07:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oY/BSvM3JhSLmZavwAUTIkYFQ1yxQX6GUR+M3B9L5+8=;
        b=Ywj6zKJoLIhLOPV1+d5gt34UcGcn8WYBsSLV3ATrHG9XG4yOWdQYBB6FjAUXWfZ6EQ
         cPxQ+T0FIH5uCVu7ryocqXa00wwvpLsqP51NBWprN2/5F2dD+EpkBtoFeosC/UHicS5n
         7p50+H7eSuQA2QSkgmV1Skp5+Bfy67uJHBcN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oY/BSvM3JhSLmZavwAUTIkYFQ1yxQX6GUR+M3B9L5+8=;
        b=CCo5Qo2IAK5vjlYXjYzBkggbGcjhPUDh/MIS9JUPkZYPotgKJIDXSZ3TsLU6CtoFPs
         s7RR8VRIWcKjPw7+d/Xh6a1mQqhZspf93HoXNu9MT9WIvqNTJAzaY93uQZWSjyV+uEjv
         eXGzOkEvkTLvfZH5FV0x0lJaSZglbMi8jA+f4tDIcwcZn05Rn5Qpv7jMw3LWub4GkOCs
         9o4Q3C+FLmzdEZDtymuDGMB2AcBy5oTiocVW1Ga1SV7tfH5t1NjnY3K5Z9jTVsRdjI4h
         WXI+fRRgA+/sLI6Wsh9oyZ6fVKEnL7wNaUokL2LSiFdxAmjzrnN/oCCPelpOCDEkFHWk
         vtEA==
X-Gm-Message-State: ABuFfojmHGqsL9QK8P+/4j4FCLtqcNdn5oNMUYK1VvBYEX33X3mZHP0v
        QLDkRw6uiuztNu8CyewPtNxP7g==
X-Google-Smtp-Source: ACcGV60fKpiKzlqspgoD0C5cVlg3fHr0HDdykx62l2yriCBjiGjQUuQX7qS8QcUAhjVWFCAsLExs1g==
X-Received: by 2002:a1c:288a:: with SMTP id o132-v6mr7548709wmo.28.1538750173072;
        Fri, 05 Oct 2018 07:36:13 -0700 (PDT)
Received: from localhost.localdomain (151.240.136.77.rev.sfr.net. [77.136.240.151])
        by smtp.gmail.com with ESMTPSA id t24-v6sm14080377wra.5.2018.10.05.07.36.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Oct 2018 07:36:12 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH 06/13] clocksource/drivers/sh_cmt: Fixup for 64-bit machines
Date:   Fri,  5 Oct 2018 16:35:35 +0200
Message-Id: <1538750143-4282-6-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538750143-4282-1-git-send-email-daniel.lezcano@linaro.org>
References: <20181005143253.GE1881@mai>
 <1538750143-4282-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

When trying to use CMT for clockevents on R-Car gen3 SoCs, I noticed
that 'max_delta_ns' for the broadcast timer (CMT) was shown as 1000 in
/proc/timer_list. It turned out that when calculating it, the driver did
1 << 32 (causing what I think was undefined behavior) resulting in a zero
delta, later clamped to 1000 by cev_delta2ns(). The root cause turned out
to be that the driver abused *unsigned long* for the CMT register values
(which are 16/32-bit), so that the calculation of 'ch->max_match_value'
in sh_cmt_setup_channel() used the wrong branch. Using more proper 'u32'
instead fixed 'max_delta_ns' and even fixed the switching an active
clocksource to CMT (which caused the system to turn non-interactive
before).

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/sh_cmt.c | 72 ++++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 39 deletions(-)

diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index 6f65cf8..efaf00d 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -70,18 +70,17 @@ struct sh_cmt_info {
 	unsigned int channels_mask;
 
 	unsigned long width; /* 16 or 32 bit version of hardware block */
-	unsigned long overflow_bit;
-	unsigned long clear_bits;
+	u32 overflow_bit;
+	u32 clear_bits;
 
 	/* callbacks for CMSTR and CMCSR access */
-	unsigned long (*read_control)(void __iomem *base, unsigned long offs);
+	u32 (*read_control)(void __iomem *base, unsigned long offs);
 	void (*write_control)(void __iomem *base, unsigned long offs,
-			      unsigned long value);
+			      u32 value);
 
 	/* callbacks for CMCNT and CMCOR access */
-	unsigned long (*read_count)(void __iomem *base, unsigned long offs);
-	void (*write_count)(void __iomem *base, unsigned long offs,
-			    unsigned long value);
+	u32 (*read_count)(void __iomem *base, unsigned long offs);
+	void (*write_count)(void __iomem *base, unsigned long offs, u32 value);
 };
 
 struct sh_cmt_channel {
@@ -95,9 +94,9 @@ struct sh_cmt_channel {
 
 	unsigned int timer_bit;
 	unsigned long flags;
-	unsigned long match_value;
-	unsigned long next_match_value;
-	unsigned long max_match_value;
+	u32 match_value;
+	u32 next_match_value;
+	u32 max_match_value;
 	raw_spinlock_t lock;
 	struct clock_event_device ced;
 	struct clocksource cs;
@@ -152,24 +151,22 @@ struct sh_cmt_device {
 #define SH_CMT32_CMCSR_CKS_RCLK1	(7 << 0)
 #define SH_CMT32_CMCSR_CKS_MASK		(7 << 0)
 
-static unsigned long sh_cmt_read16(void __iomem *base, unsigned long offs)
+static u32 sh_cmt_read16(void __iomem *base, unsigned long offs)
 {
 	return ioread16(base + (offs << 1));
 }
 
-static unsigned long sh_cmt_read32(void __iomem *base, unsigned long offs)
+static u32 sh_cmt_read32(void __iomem *base, unsigned long offs)
 {
 	return ioread32(base + (offs << 2));
 }
 
-static void sh_cmt_write16(void __iomem *base, unsigned long offs,
-			   unsigned long value)
+static void sh_cmt_write16(void __iomem *base, unsigned long offs, u32 value)
 {
 	iowrite16(value, base + (offs << 1));
 }
 
-static void sh_cmt_write32(void __iomem *base, unsigned long offs,
-			   unsigned long value)
+static void sh_cmt_write32(void __iomem *base, unsigned long offs, u32 value)
 {
 	iowrite32(value, base + (offs << 2));
 }
@@ -234,7 +231,7 @@ static const struct sh_cmt_info sh_cmt_info[] = {
 #define CMCNT 1 /* channel register */
 #define CMCOR 2 /* channel register */
 
-static inline unsigned long sh_cmt_read_cmstr(struct sh_cmt_channel *ch)
+static inline u32 sh_cmt_read_cmstr(struct sh_cmt_channel *ch)
 {
 	if (ch->iostart)
 		return ch->cmt->info->read_control(ch->iostart, 0);
@@ -242,8 +239,7 @@ static inline unsigned long sh_cmt_read_cmstr(struct sh_cmt_channel *ch)
 		return ch->cmt->info->read_control(ch->cmt->mapbase, 0);
 }
 
-static inline void sh_cmt_write_cmstr(struct sh_cmt_channel *ch,
-				      unsigned long value)
+static inline void sh_cmt_write_cmstr(struct sh_cmt_channel *ch, u32 value)
 {
 	if (ch->iostart)
 		ch->cmt->info->write_control(ch->iostart, 0, value);
@@ -251,39 +247,35 @@ static inline void sh_cmt_write_cmstr(struct sh_cmt_channel *ch,
 		ch->cmt->info->write_control(ch->cmt->mapbase, 0, value);
 }
 
-static inline unsigned long sh_cmt_read_cmcsr(struct sh_cmt_channel *ch)
+static inline u32 sh_cmt_read_cmcsr(struct sh_cmt_channel *ch)
 {
 	return ch->cmt->info->read_control(ch->ioctrl, CMCSR);
 }
 
-static inline void sh_cmt_write_cmcsr(struct sh_cmt_channel *ch,
-				      unsigned long value)
+static inline void sh_cmt_write_cmcsr(struct sh_cmt_channel *ch, u32 value)
 {
 	ch->cmt->info->write_control(ch->ioctrl, CMCSR, value);
 }
 
-static inline unsigned long sh_cmt_read_cmcnt(struct sh_cmt_channel *ch)
+static inline u32 sh_cmt_read_cmcnt(struct sh_cmt_channel *ch)
 {
 	return ch->cmt->info->read_count(ch->ioctrl, CMCNT);
 }
 
-static inline void sh_cmt_write_cmcnt(struct sh_cmt_channel *ch,
-				      unsigned long value)
+static inline void sh_cmt_write_cmcnt(struct sh_cmt_channel *ch, u32 value)
 {
 	ch->cmt->info->write_count(ch->ioctrl, CMCNT, value);
 }
 
-static inline void sh_cmt_write_cmcor(struct sh_cmt_channel *ch,
-				      unsigned long value)
+static inline void sh_cmt_write_cmcor(struct sh_cmt_channel *ch, u32 value)
 {
 	ch->cmt->info->write_count(ch->ioctrl, CMCOR, value);
 }
 
-static unsigned long sh_cmt_get_counter(struct sh_cmt_channel *ch,
-					int *has_wrapped)
+static u32 sh_cmt_get_counter(struct sh_cmt_channel *ch, u32 *has_wrapped)
 {
-	unsigned long v1, v2, v3;
-	int o1, o2;
+	u32 v1, v2, v3;
+	u32 o1, o2;
 
 	o1 = sh_cmt_read_cmcsr(ch) & ch->cmt->info->overflow_bit;
 
@@ -303,7 +295,8 @@ static unsigned long sh_cmt_get_counter(struct sh_cmt_channel *ch,
 
 static void sh_cmt_start_stop_ch(struct sh_cmt_channel *ch, int start)
 {
-	unsigned long flags, value;
+	unsigned long flags;
+	u32 value;
 
 	/* start stop register shared by multiple timer channels */
 	raw_spin_lock_irqsave(&ch->cmt->lock, flags);
@@ -410,11 +403,11 @@ static void sh_cmt_disable(struct sh_cmt_channel *ch)
 static void sh_cmt_clock_event_program_verify(struct sh_cmt_channel *ch,
 					      int absolute)
 {
-	unsigned long new_match;
-	unsigned long value = ch->next_match_value;
-	unsigned long delay = 0;
-	unsigned long now = 0;
-	int has_wrapped;
+	u32 value = ch->next_match_value;
+	u32 new_match;
+	u32 delay = 0;
+	u32 now = 0;
+	u32 has_wrapped;
 
 	now = sh_cmt_get_counter(ch, &has_wrapped);
 	ch->flags |= FLAG_REPROGRAM; /* force reprogram */
@@ -611,9 +604,10 @@ static struct sh_cmt_channel *cs_to_sh_cmt(struct clocksource *cs)
 static u64 sh_cmt_clocksource_read(struct clocksource *cs)
 {
 	struct sh_cmt_channel *ch = cs_to_sh_cmt(cs);
-	unsigned long flags, raw;
+	unsigned long flags;
 	unsigned long value;
-	int has_wrapped;
+	u32 has_wrapped;
+	u32 raw;
 
 	raw_spin_lock_irqsave(&ch->lock, flags);
 	value = ch->total_cycles;
-- 
2.7.4

