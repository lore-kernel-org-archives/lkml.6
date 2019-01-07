Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A0AC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0EC52087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbfAGPNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 10:13:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41892 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729519AbfAGPNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 10:13:15 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2279F9E62D;
        Mon,  7 Jan 2019 15:13:14 +0000 (UTC)
Received: from llong.com (dhcp-17-223.bos.redhat.com [10.18.17.223])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C728B60C45;
        Mon,  7 Jan 2019 15:13:12 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Daniel Colascione <dancol@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 2/2] /proc/stat: Add sysctl parameter to control irq counts latency
Date:   Mon,  7 Jan 2019 10:12:58 -0500
Message-Id: <1546873978-27797-3-git-send-email-longman@redhat.com>
In-Reply-To: <1546873978-27797-1-git-send-email-longman@redhat.com>
References: <1546873978-27797-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 07 Jan 2019 15:13:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reading /proc/stat can be slow especially if there are many irqs and on
systems with many CPUs as summation of all the percpu counts for each
of the irqs is required. On some newer systems, there can be more than
1000 irqs per socket.

Applications that need to read /proc/stat many times per seconds will
easily hit a bottleneck. In reality, the irq counts are seldom looked
at. Even those applications that read them don't really need up-to-date
information. One way to reduce the performance impact of irq counts
computation is to do it less frequently.

A new "fs/proc-stat-irqs-latency-ms" sysctl parameter is now added to
control the maximum latency in milliseconds allowed between the time
when the computation was done and when the values are reported. Setting
this parameter to an appropriate value will allow us to reduce the
performance impact of reading /proc/stat repetitively. If /proc/stat
is read once in a while, the irq counts will be accurate. Reading
/proc/stat repetitively, however, may make the counts somewhat stale.

On a 4-socket 96-core Broadwell system (HT off) with 2824 irqs,
the times for reading /proc/stat 10,000 times with various values of
proc-stat-irqs-latency-ms were:

  proc-stat-irqs-latency-ms   elapsed time   sys time
  -------------------------   ------------   --------
              0                 11.041s       9.452s
              1                 12.983s      10.314s
             10                  8.452s       5.466s
            100                  8.003s       4.882s
           1000                  8.000s       4.740s

Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/sysctl/fs.txt | 16 +++++++++++++++
 fs/proc/stat.c              | 48 +++++++++++++++++++++++++++++++++++++++++++++
 kernel/sysctl.c             | 12 ++++++++++++
 3 files changed, 76 insertions(+)

diff --git a/Documentation/sysctl/fs.txt b/Documentation/sysctl/fs.txt
index 819caf8..603d1b5 100644
--- a/Documentation/sysctl/fs.txt
+++ b/Documentation/sysctl/fs.txt
@@ -34,6 +34,7 @@ Currently, these files are in /proc/sys/fs:
 - overflowgid
 - pipe-user-pages-hard
 - pipe-user-pages-soft
+- proc-stat-irqs-latency-ms
 - protected_fifos
 - protected_hardlinks
 - protected_regular
@@ -184,6 +185,21 @@ applied.
 
 ==============================================================
 
+proc-stat-irqs-latency-ms:
+
+The maximum latency (in mseconds) between the time when the IRQ counts
+in the "intr" line of /proc/stat were computed and the time when they
+are reported.
+
+The default is 0 which means the counts are computed every time
+/proc/stat is read. As computing the IRQ counts can be the most time
+consuming part of accessing /proc/stat, setting a high enough value
+will shorten the time to read it in most cases.
+
+The actual maximum latency is rounded up to the next multiple of jiffies.
+
+==============================================================
+
 protected_fifos:
 
 The intent of this protection is to avoid unintentional writes to
diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index 4b06f1b..52f5845 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -13,6 +13,7 @@
 #include <linux/irqnr.h>
 #include <linux/sched/cputime.h>
 #include <linux/tick.h>
+#include <linux/jiffies.h>
 
 #ifndef arch_irq_stat_cpu
 #define arch_irq_stat_cpu(cpu) 0
@@ -21,6 +22,12 @@
 #define arch_irq_stat() 0
 #endif
 
+/*
+ * Maximum latency (in ms) of the irq values reported in the "intr" line.
+ * This is converted internally to multiple of jiffies.
+ */
+unsigned int proc_stat_irqs_latency_ms;
+
 #ifdef arch_idle_time
 
 static u64 get_idle_time(int cpu)
@@ -98,7 +105,48 @@ static u64 compute_stat_irqs_sum(void)
 static void show_stat_irqs(struct seq_file *p)
 {
 	int i;
+#ifdef CONFIG_PROC_SYSCTL
+	static char *irqs_buf;		   /* Buffer for irqs values */
+	static int buflen;
+	static unsigned long last_jiffies; /* Last buffer update jiffies */
+	static DEFINE_MUTEX(irqs_mutex);
+	unsigned int latency = proc_stat_irqs_latency_ms;
+
+	if (latency) {
+		char *ptr;
+
+		latency = _msecs_to_jiffies(latency);
+
+		mutex_lock(&irqs_mutex);
+		if (irqs_buf && time_before(jiffies, last_jiffies + latency))
+			goto print_out;
+
+		/*
+		 * Each irq value may require up to 11 bytes.
+		 */
+		if (!irqs_buf) {
+			irqs_buf = kmalloc(nr_irqs * 11 + 32,
+					   GFP_KERNEL | __GFP_ZERO);
+			if (!irqs_buf) {
+				mutex_unlock(&irqs_mutex);
+				goto fallback;
+			}
+		}
 
+		ptr = irqs_buf;
+		ptr += sprintf(ptr, "intr %llu", compute_stat_irqs_sum());
+		for_each_irq_nr(i)
+			ptr += sprintf(ptr, " %u", kstat_irqs_usr(i));
+		*ptr++ = '\n';
+		buflen = ptr - irqs_buf;
+		last_jiffies = jiffies;
+print_out:
+		seq_write(p, irqs_buf, buflen);
+		mutex_unlock(&irqs_mutex);
+		return;
+	}
+fallback:
+#endif
 	seq_put_decimal_ull(p, "intr ", compute_stat_irqs_sum());
 	for_each_irq_nr(i)
 		seq_put_decimal_ull(p, " ", kstat_irqs_usr(i));
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 1825f71..07010c9 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -114,6 +114,9 @@
 #ifndef CONFIG_MMU
 extern int sysctl_nr_trim_pages;
 #endif
+#ifdef CONFIG_PROC_FS
+extern unsigned int proc_stat_irqs_latency_ms;
+#endif
 
 /* Constants used for minimum and  maximum */
 #ifdef CONFIG_LOCKUP_DETECTOR
@@ -1890,6 +1893,15 @@ static int sysrq_sysctl_handler(struct ctl_table *table, int write,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= &one,
 	},
+#ifdef CONFIG_PROC_FS
+	{
+		.procname	= "proc-stat-irqs-latency-ms",
+		.data		= &proc_stat_irqs_latency_ms,
+		.maxlen		= sizeof(proc_stat_irqs_latency_ms),
+		.mode		= 0644,
+		.proc_handler	= proc_douintvec,
+	},
+#endif
 	{ }
 };
 
-- 
1.8.3.1

