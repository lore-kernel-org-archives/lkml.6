Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8966C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 840AC2184A
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfAIRYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 12:24:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47706 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbfAIRYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 12:24:23 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 55D7DCA396;
        Wed,  9 Jan 2019 17:24:23 +0000 (UTC)
Received: from llong.com (dhcp-17-223.bos.redhat.com [10.18.17.223])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D95C0600CD;
        Wed,  9 Jan 2019 17:24:21 +0000 (UTC)
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
Subject: [PATCH v2 1/4] /proc/stat: Extract irqs counting code into show_stat_irqs()
Date:   Wed,  9 Jan 2019 12:23:45 -0500
Message-Id: <1547054628-12703-2-git-send-email-longman@redhat.com>
In-Reply-To: <1547054628-12703-1-git-send-email-longman@redhat.com>
References: <1547054628-12703-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 09 Jan 2019 17:24:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code that generates the "intr" line of /proc/stat is now moved
from show_stat() into a new function - show_stat_irqs(). There is no
functional change.

Signed-off-by: Waiman Long <longman@redhat.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 fs/proc/stat.c | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index 535eda7..4b06f1b 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -79,12 +79,38 @@ static u64 get_iowait_time(int cpu)
 
 #endif
 
+static u64 compute_stat_irqs_sum(void)
+{
+	int i;
+	u64 sum = 0;
+
+	for_each_possible_cpu(i) {
+		sum += kstat_cpu_irqs_sum(i);
+		sum += arch_irq_stat_cpu(i);
+	}
+	sum += arch_irq_stat();
+	return sum;
+}
+
+/*
+ * Print out the "intr" line of /proc/stat.
+ */
+static void show_stat_irqs(struct seq_file *p)
+{
+	int i;
+
+	seq_put_decimal_ull(p, "intr ", compute_stat_irqs_sum());
+	for_each_irq_nr(i)
+		seq_put_decimal_ull(p, " ", kstat_irqs_usr(i));
+
+	seq_putc(p, '\n');
+}
+
 static int show_stat(struct seq_file *p, void *v)
 {
 	int i, j;
 	u64 user, nice, system, idle, iowait, irq, softirq, steal;
 	u64 guest, guest_nice;
-	u64 sum = 0;
 	u64 sum_softirq = 0;
 	unsigned int per_softirq_sums[NR_SOFTIRQS] = {0};
 	struct timespec64 boottime;
@@ -105,8 +131,6 @@ static int show_stat(struct seq_file *p, void *v)
 		steal += kcpustat_cpu(i).cpustat[CPUTIME_STEAL];
 		guest += kcpustat_cpu(i).cpustat[CPUTIME_GUEST];
 		guest_nice += kcpustat_cpu(i).cpustat[CPUTIME_GUEST_NICE];
-		sum += kstat_cpu_irqs_sum(i);
-		sum += arch_irq_stat_cpu(i);
 
 		for (j = 0; j < NR_SOFTIRQS; j++) {
 			unsigned int softirq_stat = kstat_softirqs_cpu(j, i);
@@ -115,7 +139,6 @@ static int show_stat(struct seq_file *p, void *v)
 			sum_softirq += softirq_stat;
 		}
 	}
-	sum += arch_irq_stat();
 
 	seq_put_decimal_ull(p, "cpu  ", nsec_to_clock_t(user));
 	seq_put_decimal_ull(p, " ", nsec_to_clock_t(nice));
@@ -154,14 +177,10 @@ static int show_stat(struct seq_file *p, void *v)
 		seq_put_decimal_ull(p, " ", nsec_to_clock_t(guest_nice));
 		seq_putc(p, '\n');
 	}
-	seq_put_decimal_ull(p, "intr ", (unsigned long long)sum);
-
-	/* sum again ? it could be updated? */
-	for_each_irq_nr(j)
-		seq_put_decimal_ull(p, " ", kstat_irqs_usr(j));
+	show_stat_irqs(p);
 
 	seq_printf(p,
-		"\nctxt %llu\n"
+		"ctxt %llu\n"
 		"btime %llu\n"
 		"processes %lu\n"
 		"procs_running %lu\n"
-- 
1.8.3.1

