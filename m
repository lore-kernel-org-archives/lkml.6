Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1AEC43444
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 655152173B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfAIRYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 12:24:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54668 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726940AbfAIRYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 12:24:24 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 772832CD7FE;
        Wed,  9 Jan 2019 17:24:24 +0000 (UTC)
Received: from llong.com (dhcp-17-223.bos.redhat.com [10.18.17.223])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 44B11600C8;
        Wed,  9 Jan 2019 17:24:23 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Daniel Colascione <dancol@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2 2/4] /proc/stat: Only do percpu sum of active IRQs
Date:   Wed,  9 Jan 2019 12:23:46 -0500
Message-Id: <1547054628-12703-3-git-send-email-longman@redhat.com>
In-Reply-To: <1547054628-12703-1-git-send-email-longman@redhat.com>
References: <1547054628-12703-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 09 Jan 2019 17:24:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent computer systems may have hundreds or even thousands of IRQs
available. However, most of them may not be active and their IRQ counts
are zero. It is just a waste of CPU cycles to do percpu summation of
those zero counts.

In order to find out if an IRQ is active, we track the transition of the
percpu count from 0 to 1 and atomically increment a new kstat_irq_cpus
counter which counts the number of CPUs that handle this particular IRQ.

The IRQ descriptor is zalloc'ed, so there is no need to initialize the
new counter.

On a 4-socket Broadwell server wwith 112 vCPUs and 2952 IRQs (2877 of
them are 0), the system time needs to read /proc/stat 50k times was
reduced from 11.200s to 8.048s. That was a execution time reduction
of 28%.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/irqdesc.h | 1 +
 kernel/irq/internals.h  | 3 ++-
 kernel/irq/irqdesc.c    | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index dd1e40d..86bbad2 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -61,6 +61,7 @@ struct irq_desc {
 	irq_preflow_handler_t	preflow_handler;
 #endif
 	struct irqaction	*action;	/* IRQ action list */
+	atomic_t		kstat_irq_cpus;	/* #cpus handling this IRQ */
 	unsigned int		status_use_accessors;
 	unsigned int		core_internal_state__do_not_mess_with_it;
 	unsigned int		depth;		/* nested irq disables */
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index ca6afa2..31787c1 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -244,7 +244,8 @@ static inline void irq_state_set_masked(struct irq_desc *desc)
 
 static inline void kstat_incr_irqs_this_cpu(struct irq_desc *desc)
 {
-	__this_cpu_inc(*desc->kstat_irqs);
+	if (unlikely(__this_cpu_inc_return(*desc->kstat_irqs) == 1))
+		atomic_inc(&desc->kstat_irq_cpus);
 	__this_cpu_inc(kstat.irqs_sum);
 }
 
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index ee062b7..3d2c38b 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -922,7 +922,7 @@ unsigned int kstat_irqs(unsigned int irq)
 	int cpu;
 	unsigned int sum = 0;
 
-	if (!desc || !desc->kstat_irqs)
+	if (!desc || !desc->kstat_irqs || !atomic_read(&desc->kstat_irq_cpus))
 		return 0;
 	for_each_possible_cpu(cpu)
 		sum += *per_cpu_ptr(desc->kstat_irqs, cpu);
-- 
1.8.3.1

