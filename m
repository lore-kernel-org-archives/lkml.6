Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6000FC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 16:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EA55218EA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 16:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="pG90tigs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbeLZQpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 11:45:19 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45438 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727281AbeLZQpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 11:45:17 -0500
Received: by mail-qt1-f193.google.com with SMTP id e5so17709373qtr.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 08:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=w3KbIJQiIOy8N3UGEAqIqz0OpXOEfKfCNsBPN7OzZGI=;
        b=pG90tigs07wpuGuq2rTMB/CcCulJi9YnbL+1kJRO1c6yL0SozoJNJTn7jUq2uv0wfU
         0t8g37/BhzyS5UiZ/lO0fY4Az2oXeysv2dZptLDNkM4mRTK/8FYY3LhHTMEkGkb3v32N
         SVSYeo1dEevLcJ9SdKFKxKjFLqX3IXZqoR6hOWErdd3Nu0u5JfXJbwsoLfv4WFS00pfO
         u85TqDKnr3pWyZ2yQLRIMDXHPtgS7LCCd9JXQykXLSNvS+jC55DvgB7tybectCRo+8Iz
         oroQK2w5UCz95qLK0A8ngmXfAv6VDcEeAqWQi62l2CTxVIdr09LvDVFBNjWaiGvlQ6qu
         WT2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w3KbIJQiIOy8N3UGEAqIqz0OpXOEfKfCNsBPN7OzZGI=;
        b=WKpHfhg97n7aSHBBU5hhL9JeG66pwJEKLOFE2tKIdP0Uuqe2AHacXA+PzO2tVw/OdT
         isY/mVruWKYXFRjTcxdInPDVHFmKRhY8d46uFmACrhLLiwxH58J5zQIMZbINH60MuWv7
         I3HtwmYUBuSgU3DXMUugFdfnqiOTstaNYx0CLfA4xV6T3gjuspwfrXnqvTv7+nuQ1MQS
         Z/8BnhSmrFvZwsp5x3FOjhFJFIOyMep2Ri5WDReeHJLhKEh7DheQoINlXRhJ5uPn1O1e
         Rhekg1UUpigwBj8FdHagvfl2zwzNb3sClOuzRIgPg/y1PeYWcg+54d8Ai0/K0T5iHcwO
         bX0Q==
X-Gm-Message-State: AJcUukc92j/mp7dZFN88FmrHBG2DNqusr/TJOLCPFGZ7zH9aXWFRq5e2
        bObKWcaP9dvqamobsoiWALeIig==
X-Google-Smtp-Source: AFSGD/UIqZDh/l43NNC/5cSPHlmqbsSACc21s6yjEK3DUaREi7HP/Ds2QeOZzJnO1QuQ+Lnr3yYz3A==
X-Received: by 2002:ac8:2a06:: with SMTP id k6mr19372341qtk.245.1545842715640;
        Wed, 26 Dec 2018 08:45:15 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id m41sm17874920qtc.58.2018.12.26.08.45.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Dec 2018 08:45:15 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     catalin.marinas@arm.com, will.deacon@arm.com,
        akpm@linux-foundation.org, rppt@linux.vnet.ibm.com,
        mhocko@suse.com, ard.biesheuvel@linaro.org, andrew.murray@arm.com,
        james.morse@arm.com, marc.zyngier@arm.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        pasha.tatashin@soleen.com
Subject: [PATCH v3 3/3] arm64: Early boot time stamps
Date:   Wed, 26 Dec 2018 11:45:09 -0500
Message-Id: <20181226164509.22916-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181226164509.22916-1-pasha.tatashin@soleen.com>
References: <20181226164509.22916-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow printk time stamps/sched_clock() to be available from the early
boot.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kernel/setup.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 4b0e1231625c..28126facc4ed 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -40,6 +40,7 @@
 #include <linux/efi.h>
 #include <linux/psci.h>
 #include <linux/sched/task.h>
+#include <linux/sched_clock.h>
 #include <linux/mm.h>
 
 #include <asm/acpi.h>
@@ -279,8 +280,32 @@ arch_initcall(reserve_memblock_reserved_regions);
 
 u64 __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_HWID };
 
+/*
+ * Get time stamps available early in boot, useful to identify boot time issues
+ * from the early boot.
+ */
+static __init void sched_clock_early_init(void)
+{
+	u64 (*read_time)(void) = arch_counter_get_cntvct;
+	u64 freq = arch_timer_get_cntfrq();
+
+	/*
+	 * The arm64 boot protocol mandates that CNTFRQ_EL0 reflects
+	 * the timer frequency. To avoid breakage on misconfigured
+	 * systems, do not register the early sched_clock if the
+	 * programmed value if zero. Other random values will just
+	 * result in random output.
+	 */
+	if (!freq)
+		return;
+
+	sched_clock_register(read_time, ARCH_TIMER_NBITS, freq);
+}
+
 void __init setup_arch(char **cmdline_p)
 {
+	sched_clock_early_init();
+
 	init_mm.start_code = (unsigned long) _text;
 	init_mm.end_code   = (unsigned long) _etext;
 	init_mm.end_data   = (unsigned long) _edata;
-- 
2.20.1

