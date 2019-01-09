Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06169C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D130C206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbfAITVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 14:21:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34410 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728270AbfAITVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 14:21:03 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5AAB75F;
        Wed,  9 Jan 2019 19:21:03 +0000 (UTC)
Received: from llong.com (dhcp-17-223.bos.redhat.com [10.18.17.223])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0B5DC608DA;
        Wed,  9 Jan 2019 19:21:01 +0000 (UTC)
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
Subject: [PATCH v3 3/4] genirq: Track the number of active IRQs
Date:   Wed,  9 Jan 2019 14:20:47 -0500
Message-Id: <1547061648-16080-4-git-send-email-longman@redhat.com>
In-Reply-To: <1547061648-16080-1-git-send-email-longman@redhat.com>
References: <1547061648-16080-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 09 Jan 2019 19:21:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A new atomic variable nr_active_irqs is added to track the number of
active IRQs that have one or more interrupts serviced.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/irq/internals.h | 7 +++++--
 kernel/irq/irqdesc.c   | 5 +++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 31787c1..239ae51 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -242,10 +242,13 @@ static inline void irq_state_set_masked(struct irq_desc *desc)
 
 #undef __irqd_to_state
 
+extern atomic_t nr_active_irqs;	/* # of active IRQs */
 static inline void kstat_incr_irqs_this_cpu(struct irq_desc *desc)
 {
-	if (unlikely(__this_cpu_inc_return(*desc->kstat_irqs) == 1))
-		atomic_inc(&desc->kstat_irq_cpus);
+	if (unlikely(__this_cpu_inc_return(*desc->kstat_irqs) == 1)) {
+		if (atomic_inc_return(&desc->kstat_irq_cpus) == 1)
+			atomic_inc(&nr_active_irqs);
+	}
 	__this_cpu_inc(kstat.irqs_sum);
 }
 
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 3d2c38b..7e00c4d 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -20,6 +20,11 @@
 #include "internals.h"
 
 /*
+ * Number of active IRQs
+ */
+atomic_t nr_active_irqs;
+
+/*
  * lockdep: we want to handle all irq_desc locks as a single lock-class:
  */
 static struct lock_class_key irq_desc_lock_class;
-- 
1.8.3.1

