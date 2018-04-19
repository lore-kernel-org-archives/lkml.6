Return-Path: <longman@redhat.com>
X-Google-Smtp-Source: AB8JxZrBL4YFi1xb4cUXioAIEELCK7xGjOs42opwT1QVK8a4F+PNN//ZTy2Ux/q9S5OMrceBN60z
ARC-Seal: i=1; a=rsa-sha256; t=1524157789; cv=none;
        d=google.com; s=arc-20160816;
        b=BzAXmCFQxdM3RS1HGJoRHyhMSbOPPpFxRuLSe1S0+CSk8ecaZTglmsiANXdR5UEWlf
         KplAYmp+CxcysJU6bUrxiO7OaWiSnljfFVbVuxGEDBuQHPdMo5MJBHZYJ/gOaDJ8z2A+
         dB6shafYakeHwlGcYrh9d9AwqPHUDaLNWNcfZvETAoEnKDRcCbI+T1fxRzbnFkx4u+v+
         BY0TKwLQF5Zs4NTRSfJKNcTzhq+hUz0uGCBVBM+HtEmDPDY2B8hopFeD5i89ZrFq60Hk
         Gv7laSrPfWbPZGNTcPgXd79GwCLbULQpX6xQujD7HzylYioNiO0GPKF18R1ebRqdlxRv
         cACA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=eVtrTvY29pDFkDpudPt2Fc9z3cSebbs+JQgCNSbrXdM=;
        b=rhjAPevT3cLdiD7LfHjwcSW61+gbV73676IhddaBhEp0XRon0IVfJRmllS9l3i0yXA
         m7DgSvxj6NfQfh7umRJ9Wr/gOM52C0P0k4QVdHZ8a1VOiIinWWN45R7M87qrkXIME8o/
         WikjFDQUqxqDsM6E+bdVtlLO5w3EpEED5xGxDHH5ipER4dfIwzzMt+bKwzE49rFpuaOp
         5TNEbnA15GQjevoHXWJ58vwg5xrmYI62mCy9syLlLGrvJyDDUdUpVez4eE/jXdKBotcv
         dyK9WfNzOfbzdbeXzYbPfi4ulKsFOUOIjOJzV6nlaZN8pAjxgnw1Ttjykd1jys+2RStJ
         Sgzw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of longman@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=longman@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of longman@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=longman@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
From: Waiman Long <longman@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH] proc/stat: Separate out individual irq counts into /proc/stat_irqs
Date: Thu, 19 Apr 2018 13:09:29 -0400
Message-Id: <1524157769-30775-1-git-send-email-longman@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598195278130024579?=
X-GMAIL-MSGID: =?utf-8?q?1598195278130024579?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

It was found that reading /proc/stat could be time consuming on
systems with a lot of irqs. For example, reading /proc/stat in a
certain 2-socket Skylake server took about 4.6ms because it had over
5k irqs. In that particular case, the majority of the CPU cycles for
reading /proc/stat was spent in the kstat_irqs() function.  Therefore,
application performance can be impacted if the application reads
/proc/stat rather frequently.

The "intr" line within /proc/stat contains a sum total of all the irqs
that have happened followed by a list of irq counts for each individual
irq number. In many cases, the first number is good enough. The
individual irq counts may not provide that much more information.

In order to avoid this kind of performance issue, all these individual
irq counts are now separated into a new /proc/stat_irqs file. The
sum total irq count will stay in /proc/stat and be duplicated in
/proc/stat_irqs. Applications that need to look up individual irq counts
will now have to look into /proc/stat_irqs instead of /proc/stat.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 fs/proc/stat.c | 48 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 41 insertions(+), 7 deletions(-)

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
