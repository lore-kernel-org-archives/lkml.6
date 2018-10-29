Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76164C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 19:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15D2320824
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 19:25:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15D2320824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbeJ3EPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 00:15:50 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:51756 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbeJ3EPu (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Tue, 30 Oct 2018 00:15:50 -0400
Received: from linux-r8p5.suse.de (prv-ext-foundry1int.gns.novell.com [137.65.251.240])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Mon, 29 Oct 2018 13:25:37 -0600
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     longman@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, dave@stgolabs.net,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH] fs/proc: introduce /proc/stat2 file
Date:   Mon, 29 Oct 2018 12:25:21 -0700
Message-Id: <20181029192521.23059-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A recent report from a large database vendor which I shall not name
shows concerns about poor performance when consuming /proc/stat info.
Particularly  kstat_irq() pops up in the profiles and most time is
being spent there. The overall system is under a lot of irqs and
almost 1k cores, thus this comes to little surprise.

Granted that procfs in general is not known for its performance,
nor designed for it, for that matter. Some users, however may be able
to overcome this performance limitation, some not. Therefore it isn't
bad having a kernel option for users that don't want any hard irq info
-- and care enough about this.

This patch introduces a new /proc/stat2 file that is identical to the
regular 'stat' except that it zeroes all hard irq statistics. The new
file is a drop in replacement to stat for users that need performance.

The stat file is not touched, of course -- this was also previously
suggested by Waiman:
https://lore.kernel.org/lkml/1524166562-5644-1-git-send-email-longman@redhat.com/

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 Documentation/filesystems/proc.txt | 12 +++++++---
 fs/proc/stat.c                     | 45 ++++++++++++++++++++++++++++++++------
 2 files changed, 47 insertions(+), 10 deletions(-)

diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
index 12a5e6e693b6..563b01decb1e 100644
--- a/Documentation/filesystems/proc.txt
+++ b/Documentation/filesystems/proc.txt
@@ -27,7 +27,7 @@ Table of Contents
   1.5	SCSI info
   1.6	Parallel port info in /proc/parport
   1.7	TTY info in /proc/tty
-  1.8	Miscellaneous kernel statistics in /proc/stat
+  1.8	Miscellaneous kernel statistics in /proc/stat and /proc/stat2
   1.9	Ext4 file system parameters
 
   2	Modifying System Parameters
@@ -140,6 +140,7 @@ Table 1-1: Process specific entries in /proc
  mem		Memory held by this process
  root		Link to the root directory of this process
  stat		Process status
+ stat2		Process status without irq information
  statm		Process memory status information
  status		Process status in human readable form
  wchan		Present with CONFIG_KALLSYMS=y: it shows the kernel function
@@ -1301,8 +1302,8 @@ To see  which  tty's  are  currently in use, you can simply look into the file
   unknown              /dev/tty        4    1-63 console 
 
 
-1.8 Miscellaneous kernel statistics in /proc/stat
--------------------------------------------------
+1.8 Miscellaneous kernel statistics in /proc/stat and /proc/stat2
+-----------------------------------------------------------------
 
 Various pieces   of  information about  kernel activity  are  available in the
 /proc/stat file.  All  of  the numbers reported  in  this file are  aggregates
@@ -1371,6 +1372,11 @@ of the possible system softirqs. The first column is the total of all
 softirqs serviced; each subsequent column is the total for that particular
 softirq.
 
+The stat2 file acts as a performance alternative to /proc/stat for workloads
+and systems that care and are under heavy irq load. In order to to be completely
+compatible, /proc/stat and /proc/stat2 are identical with the exception that the
+later will show 0 for any (hard)irq-related fields. This refers particularly
+to the "intr" line and 'irq' column for that aggregate in the cpu line.
 
 1.9 Ext4 file system parameters
 -------------------------------
diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index 535eda7857cf..349040270003 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -79,7 +79,7 @@ static u64 get_iowait_time(int cpu)
 
 #endif
 
-static int show_stat(struct seq_file *p, void *v)
+static int __show_stat(struct seq_file *p, void *v, bool irq_stats)
 {
 	int i, j;
 	u64 user, nice, system, idle, iowait, irq, softirq, steal;
@@ -100,13 +100,17 @@ static int show_stat(struct seq_file *p, void *v)
 		system += kcpustat_cpu(i).cpustat[CPUTIME_SYSTEM];
 		idle += get_idle_time(i);
 		iowait += get_iowait_time(i);
-		irq += kcpustat_cpu(i).cpustat[CPUTIME_IRQ];
 		softirq += kcpustat_cpu(i).cpustat[CPUTIME_SOFTIRQ];
 		steal += kcpustat_cpu(i).cpustat[CPUTIME_STEAL];
 		guest += kcpustat_cpu(i).cpustat[CPUTIME_GUEST];
 		guest_nice += kcpustat_cpu(i).cpustat[CPUTIME_GUEST_NICE];
-		sum += kstat_cpu_irqs_sum(i);
-		sum += arch_irq_stat_cpu(i);
+
+		if (irq_stats) {
+			irq += kcpustat_cpu(i).cpustat[CPUTIME_IRQ];
+
+			sum += kstat_cpu_irqs_sum(i);
+			sum += arch_irq_stat_cpu(i);
+		}
 
 		for (j = 0; j < NR_SOFTIRQS; j++) {
 			unsigned int softirq_stat = kstat_softirqs_cpu(j, i);
@@ -115,7 +119,9 @@ static int show_stat(struct seq_file *p, void *v)
 			sum_softirq += softirq_stat;
 		}
 	}
-	sum += arch_irq_stat();
+
+	if (irq_stats)
+		sum += arch_irq_stat();
 
 	seq_put_decimal_ull(p, "cpu  ", nsec_to_clock_t(user));
 	seq_put_decimal_ull(p, " ", nsec_to_clock_t(nice));
@@ -136,7 +142,8 @@ static int show_stat(struct seq_file *p, void *v)
 		system = kcpustat_cpu(i).cpustat[CPUTIME_SYSTEM];
 		idle = get_idle_time(i);
 		iowait = get_iowait_time(i);
-		irq = kcpustat_cpu(i).cpustat[CPUTIME_IRQ];
+		if (irq_stats)
+			irq = kcpustat_cpu(i).cpustat[CPUTIME_IRQ];
 		softirq = kcpustat_cpu(i).cpustat[CPUTIME_SOFTIRQ];
 		steal = kcpustat_cpu(i).cpustat[CPUTIME_STEAL];
 		guest = kcpustat_cpu(i).cpustat[CPUTIME_GUEST];
@@ -158,7 +165,7 @@ static int show_stat(struct seq_file *p, void *v)
 
 	/* sum again ? it could be updated? */
 	for_each_irq_nr(j)
-		seq_put_decimal_ull(p, " ", kstat_irqs_usr(j));
+		seq_put_decimal_ull(p, " ", irq_stats ? kstat_irqs_usr(j) : 0);
 
 	seq_printf(p,
 		"\nctxt %llu\n"
@@ -181,6 +188,16 @@ static int show_stat(struct seq_file *p, void *v)
 	return 0;
 }
 
+static int show_stat(struct seq_file *p, void *v)
+{
+	return __show_stat(p, v, true);
+}
+
+static int show_stat2(struct seq_file *p, void *v)
+{
+	return __show_stat(p, v, false);
+}
+
 static int stat_open(struct inode *inode, struct file *file)
 {
 	unsigned int size = 1024 + 128 * num_online_cpus();
@@ -190,6 +207,12 @@ static int stat_open(struct inode *inode, struct file *file)
 	return single_open_size(file, show_stat, NULL, size);
 }
 
+static int stat2_open(struct inode *inode, struct file *file)
+{
+	unsigned int size = 1024 + 128 * num_online_cpus();
+	return single_open_size(file, show_stat2, NULL, size);
+}
+
 static const struct file_operations proc_stat_operations = {
 	.open		= stat_open,
 	.read		= seq_read,
@@ -197,9 +220,17 @@ static const struct file_operations proc_stat_operations = {
 	.release	= single_release,
 };
 
+static const struct file_operations proc_stat2_operations = {
+	.open		= stat2_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 static int __init proc_stat_init(void)
 {
 	proc_create("stat", 0, NULL, &proc_stat_operations);
+	proc_create("stat2", 0, NULL, &proc_stat2_operations);
 	return 0;
 }
 fs_initcall(proc_stat_init);
-- 
2.16.4

