Return-Path: <longman@redhat.com>
X-Google-Smtp-Source: AB8JxZpXdzVT5Kgjrw260/htulMg6GGiYJiCx8SOnuG66VxdwShDOBVtIvV/dPPraxi8dcndsl+T
ARC-Seal: i=1; a=rsa-sha256; t=1524166575; cv=none;
        d=google.com; s=arc-20160816;
        b=GMczHYkL8kQDbQUmOmSAarRmuNBHYe4s3/vbZgMWSnLzYlC505ZvPJe7AGZaSUxVBg
         MOqWOlbKIBBu5d722chRGV91ShTsRZoea8d5Dp0a0G8ZBevx2SpqnUzutz3Xc4TcvluI
         gPiBCXDXPHlDDWsIInW2NQ5X6eCowCx12ahlb7z4Wd7zJ1Q5BU5o6WlrSqoqx0ycUOvq
         R5CBehHYMjT5vrJ/vMENApRzCmP5c2jmSRfI6ZvHnj3NQfhzgri8Cfjq31/nRPqRKPlc
         xeofHBLaLrCVVWZ1AmkaruNo/I7/m5R3ScD98WbIhgFsdqL1gwWhQLhjVHxqxPvDvFTE
         K13g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=7bq1Ad/dt4x89WPbl6SA+33S6eNhTodrJADsCCpaf2k=;
        b=K7TVGwykCOgJXLqfeHZlaM6u0TI/ne05duLVXKb6yevnY/OnQxQyYhx53FF708UUU9
         dMP1kwmKdEnzhRvrMPeFnjIIg4054u+dBk5YVc3yQtpFykam1ILqbMAbIObb95B+Kt38
         TWZUoC5MgDv6NgqmNH4VRucgWj1pEyVheEgkubAEs2ZxzUBTS/gyRGNdiIFO0zmbl0Bj
         Nw42fztuBa5H+8YWJL7nBrIEC9wIx3pRc7yVCNXran3zEKdjUIhOPBkzSnSI/TPgoKBr
         wJhjSHgdImSdCn2ieKnfGy9larj89LcpUC6ny5e88b2TN5NuFNeM/1uNuSAJH6cottw5
         ltDQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of longman@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=longman@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of longman@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=longman@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
From: Waiman Long <longman@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v2] proc/stat: Separate out individual irq counts into /proc/stat_irqs
Date: Thu, 19 Apr 2018 15:36:02 -0400
Message-Id: <1524166562-5644-1-git-send-email-longman@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598195278130024579?=
X-GMAIL-MSGID: =?utf-8?q?1598204490896289712?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

It was found that reading /proc/stat could be time consuming on
systems with a lot of irqs. For example, reading /proc/stat in a
certain 2-socket Skylake server took about 4.6ms because it had over
5k irqs. In that particular case, the majority of the CPU cycles for
reading /proc/stat was spent in the kstat_irqs() function.  Therefore,
application performance can be impacted if the application reads
/proc/stat rather frequently.

The "intr" line within /proc/stat contains a sum total of all the
irqs that have been serviced followed by a list of irq counts for
each individual irq number. In many cases, the first number is good
enough. The individual irq counts may not provide that much more
information.

In order to avoid this kind of performance issue, all these individual
irq counts are now separated into a new /proc/stat_irqs file. The
sum total irq count will stay in /proc/stat and be duplicated in
/proc/stat_irqs. Applications that need to look up individual irq counts
will now have to look into /proc/stat_irqs instead of /proc/stat.

v2: Update Documentation/filesystems/proc.txt accordingly.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/filesystems/proc.txt | 22 ++++++++++++-----
 fs/proc/stat.c                     | 48 ++++++++++++++++++++++++++++++++------
 2 files changed, 57 insertions(+), 13 deletions(-)

diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
index 2a84bb3..15558ff 100644
--- a/Documentation/filesystems/proc.txt
+++ b/Documentation/filesystems/proc.txt
@@ -1300,7 +1300,7 @@ since the system first booted.  For a quick look, simply cat the file:
   cpu  2255 34 2290 22625563 6290 127 456 0 0 0
   cpu0 1132 34 1441 11311718 3675 127 438 0 0 0
   cpu1 1123 0 849 11313845 2614 0 18 0 0 0
-  intr 114930548 113199788 3 0 5 263 0 4 [... lots more numbers ...]
+  intr 114930548
   ctxt 1990473
   btime 1062191376
   processes 2915
@@ -1333,11 +1333,10 @@ second).  The meanings of the columns are as follows, from left to right:
 - guest: running a normal guest
 - guest_nice: running a niced guest
 
-The "intr" line gives counts of interrupts  serviced since boot time, for each
-of the  possible system interrupts.   The first  column  is the  total of  all
-interrupts serviced  including  unnumbered  architecture specific  interrupts;
-each  subsequent column is the  total for that particular numbered interrupt.
-Unnumbered interrupts are not shown, only summed into the total.
+The "intr" line gives the total of all interrupts including unnumbered
+architecture specific interrupts serviced since boot time.  To see the
+number of interrupts serviced for a particular numbered interrupt,
+the /proc/stat_irqs file should be used instead.
 
 The "ctxt" line gives the total number of context switches across all CPUs.
 
@@ -1359,6 +1358,17 @@ of the possible system softirqs. The first column is the total of all
 softirqs serviced; each subsequent column is the total for that particular
 softirq.
 
+To see the number of interrupts serviced for each of the numbered
+interrupts, the /proc/stat_irqs file can be viewed.
+
+  > cat /proc/stat_irqs
+  intr 114930548 113199788 3 0 5 263 0 4 [... lots more numbers ...]
+
+The "intr" line gives counts of interrupts  serviced since boot time, for each
+of the  possible system interrupts.   The first  column  is the  total of  all
+interrupts serviced  including  unnumbered  architecture specific  interrupts;
+each  subsequent column is the  total for that particular numbered interrupt.
+Unnumbered interrupts are not shown, only summed into the total.
 
 1.9 Ext4 file system parameters
 -------------------------------
diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index 59749df..79e3c03 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -155,11 +155,6 @@ static int show_stat(struct seq_file *p, void *v)
 		seq_putc(p, '\n');
 	}
 	seq_put_decimal_ull(p, "intr ", (unsigned long long)sum);
-
-	/* sum again ? it could be updated? */
-	for_each_irq_nr(j)
-		seq_put_decimal_ull(p, " ", kstat_irqs_usr(j));
-
 	seq_printf(p,
 		"\nctxt %llu\n"
 		"btime %llu\n"
@@ -181,15 +176,46 @@ static int show_stat(struct seq_file *p, void *v)
 	return 0;
 }
 
+/*
+ * Showing individual irq counts can be expensive if there are a lot of
+ * irqs. So it is done in a separate procfs file to reduce performance
+ * overhead of reading other statistical counts.
+ */
+static int show_stat_irqs(struct seq_file *p, void *v)
+{
+	int i, j;
+	u64 sum = 0;
+
+	for_each_possible_cpu(i) {
+		sum += kstat_cpu_irqs_sum(i);
+		sum += arch_irq_stat_cpu(i);
+	}
+	sum += arch_irq_stat();
+
+	seq_put_decimal_ull(p, "intr ", (unsigned long long)sum);
+
+	for_each_irq_nr(j)
+		seq_put_decimal_ull(p, " ", kstat_irqs_usr(j));
+
+	seq_putc(p, '\n');
+
+	return 0;
+}
+
 static int stat_open(struct inode *inode, struct file *file)
 {
 	size_t size = 1024 + 128 * num_online_cpus();
 
-	/* minimum size to display an interrupt count : 2 bytes */
-	size += 2 * nr_irqs;
 	return single_open_size(file, show_stat, NULL, size);
 }
 
+static int stat_irqs_open(struct inode *inode, struct file *file)
+{
+	size_t size = 1024 + 16 * nr_irqs;
+
+	return single_open_size(file, show_stat_irqs, NULL, size);
+}
+
 static const struct file_operations proc_stat_operations = {
 	.open		= stat_open,
 	.read		= seq_read,
@@ -197,9 +223,17 @@ static int stat_open(struct inode *inode, struct file *file)
 	.release	= single_release,
 };
 
+static const struct file_operations proc_stat_irqs_operations = {
+	.open		= stat_irqs_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 static int __init proc_stat_init(void)
 {
 	proc_create("stat", 0, NULL, &proc_stat_operations);
+	proc_create("stat_irqs", 0, NULL, &proc_stat_irqs_operations);
 	return 0;
 }
 fs_initcall(proc_stat_init);
-- 
1.8.3.1
