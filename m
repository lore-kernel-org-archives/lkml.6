Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062AEC43612
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 11:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2542218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 11:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="RPLOhyn/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730788AbeL0LSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 06:18:48 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36113 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728373AbeL0LSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 06:18:46 -0500
Received: by mail-pl1-f195.google.com with SMTP id g9so8673228plo.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 03:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+5uWZcZTnUMYkzU8RtvAyOycmBx9913OmwDsy9awI1U=;
        b=RPLOhyn/ZPA2uv/yy5Ps3MLS8pYzhJpuRGoYpUltMvA6vmE58mz/LR/r1hDTPVthSj
         wHGROTGJdjpsCWsgskJLyojRNfU7ydpY0jwwlthiqaeA7ryGWUZQ0+ahPQxH01AuRTK+
         3Hx+FRHvO17LmtAdp0rtTqkTHKt3Pp98ijHkvLgwjjcQhEzIhcsmc8gtkuyDxHWBxbcg
         pHPML8c+qjRlbe3ieZ3HzN4Do+e99/MEaL56gUPQZ0f96tG7hwfGNV6fljrIzREvrIAx
         AReHwez1qL0cACgKMP3B4o2k9mBXWfPPsTJh09+CSLvuZTfs5lvmclBE9fHNhj4PclHC
         9ptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+5uWZcZTnUMYkzU8RtvAyOycmBx9913OmwDsy9awI1U=;
        b=iBUI/xG2vI3D09ZcuQ2xa9ZAsqzvvSDTtQJegqABEmKb/u3FAg8BT6/+Lj1lMCJjKj
         C0DDiWXyMzf53x/l2wjpbtD8ReJYMWcRWrVSfpIpM8jY+p8SdZ3demjIRKh7I1rBwkwI
         DscvbFrCiPpNb0PdF68CuNdF6Lb1h8eQFmcK3tPBKDVe0rbeCp1C/cKSzIlI2s1BIOFw
         +Vl38wDWlO+OrZCKmG0oYvfF+s6gdeRPV3LVXv33fjwKqFtOjBOWpEcnsPKC3GfsTgV+
         XCvp6GpzHB80+voj00Z4TojLejh/YUf2T8t32QW+ZgbRbd0oQR1COOKVzFgUIxDpejyu
         GpmA==
X-Gm-Message-State: AJcUukfcQh29pLUIsc6iyAoDGecJIvt/53YVgEUXGxeignktbYGT7Ifm
        Yos425Qjk9zk3OWqJE6w6yDh9g==
X-Google-Smtp-Source: ALg8bN4uDjWy44begQ0XzSRbv3KTSIhfATFvV2tBrQMSIeY9rDgNimTI//oKqEcn50oITn7TDtNGQg==
X-Received: by 2002:a17:902:8541:: with SMTP id d1mr23693793plo.205.1545909525948;
        Thu, 27 Dec 2018 03:18:45 -0800 (PST)
Received: from localhost.localdomain ([106.51.18.57])
        by smtp.gmail.com with ESMTPSA id u137sm66830105pfc.140.2018.12.27.03.18.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 03:18:45 -0800 (PST)
From:   Anup Patel <anup@brainfault.org>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup@brainfault.org>
Subject: [PATCH v4 2/5] irqchip: sifive-plic: Don't inline plic_toggle() and plic_irq_toggle()
Date:   Thu, 27 Dec 2018 16:48:18 +0530
Message-Id: <20181227111821.80908-3-anup@brainfault.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181227111821.80908-1-anup@brainfault.org>
References: <20181227111821.80908-1-anup@brainfault.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The plic_toggle() uses raw_spin_lock() and plic_irq_toggle has a
for loop so both these functions are not suitable for being inline
hence this patch removes the inline keyword.

Signed-off-by: Anup Patel <anup@brainfault.org>
---
 drivers/irqchip/irq-sifive-plic.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index c23a293a2aae..01bbbbffbcae 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -69,8 +69,8 @@ struct plic_handler {
 };
 static DEFINE_PER_CPU(struct plic_handler, plic_handlers);
 
-static inline void plic_toggle(struct plic_handler *handler,
-				int hwirq, int enable)
+static void plic_toggle(struct plic_handler *handler,
+			int hwirq, int enable)
 {
 	u32 __iomem *reg = handler->enable_base + (hwirq / 32) * sizeof(u32);
 	u32 hwirq_mask = 1 << (hwirq % 32);
@@ -83,7 +83,7 @@ static inline void plic_toggle(struct plic_handler *handler,
 	raw_spin_unlock(&handler->enable_lock);
 }
 
-static inline void plic_irq_toggle(struct irq_data *d, int enable)
+static void plic_irq_toggle(struct irq_data *d, int enable)
 {
 	int cpu;
 
-- 
2.17.1

