Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4066AC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA1D421477
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HTqrsXJh";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TClUCJQ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA1D421477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbeHXSVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 14:21:09 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55524 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbeHXSVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 14:21:09 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 29B2960B7E; Fri, 24 Aug 2018 14:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535121970;
        bh=CBdH3+oVRW+5hyGxp4QwnDgiUzIA5xUZiYHUa2im4tQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=HTqrsXJhuqxkguqe9aFlv2/3xZNd5am7ecw3wANw2YWIvnBvJrcyf0URpvND+oGYu
         0tyGXRzbqH2AtEQ1pDsr03iTsxsy6UEcSB+usJEAjZaYDRF6IPSwRDEjrV5Y7Nz8Y+
         wwf/0ZKRtuufOVIyOSmUDfsprW72Y5nbtS0VFNB4=
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E3B2B6083E;
        Fri, 24 Aug 2018 14:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535121964;
        bh=CBdH3+oVRW+5hyGxp4QwnDgiUzIA5xUZiYHUa2im4tQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=TClUCJQ5UDw+Q6jbzZ0ge7JUFzGE+9MnW9ljlv4EOQLk29XhsGRKgV9N2naypr8be
         D3ldLbhHkLEvTbU82qQaTMF6H8seFHRE7+OaL3smay7w0d09vgB8KEP9HDCzMrcQ6J
         +W0oI/QEjUsW2qbQ0I7BkVsn5p04qS0v6RgvZNGc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E3B2B6083E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Laura Abbott <labbott@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Jason Baron <jbaron@akamai.com>,
        Tony Luck <tony.luck@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Joe Perches <joe@perches.com>,
        Jim Cromie <jim.cromie@gmail.com>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [RFC PATCH v2 2/3] pstore: Add register read/write{b,w,l,q} tracing support
Date:   Fri, 24 Aug 2018 20:15:26 +0530
Message-Id: <65985f8df55b037283746559c1718a54d56e7ec4.1535119711.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1535119710.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1535119710.git.saiprakash.ranjan@codeaurora.org>
In-Reply-To: <cover.1535119710.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1535119710.git.saiprakash.ranjan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

read/write{b,w,l,q} are typically used for reading from memory
mapped registers, which can cause hangs if accessed
unclocked. Tracing these events can help in debugging
various issues faced during initial development.

We log this trace information in persistent ram buffer which
can be viewed after reset.

We use pstore_rtb_call() to write the RTB log to pstore.
RTB buffer size is taken from ramoops dt node with additional
property called rtb-size.

For reading the trace after mounting pstore, rtb-ramoops entry
can be seen in /sys/fs/pstore/ as in below sample output.

Sample output of tracing register reads/writes in drivers:

 # mount -t pstore pstore /sys/fs/pstore
 # tail /sys/fs/pstore/rtb-ramoops-0
 [LOGK_READ ] ts:36468476204  data:ffff00000800d0fc  <ffff0000084e9ee0>  gic_check_gicv2+0x58/0x60
 [LOGK_WRITE] ts:36468477715  data:ffff00000800d000  <ffff0000084e9fac>  gic_cpu_if_up+0xc4/0x110
 [LOGK_READ ] ts:36468478548  data:ffff00000800d000  <ffff0000084e9fd8>  gic_cpu_if_up+0xf0/0x110
 [LOGK_WRITE] ts:36468480319  data:ffff00000800d000  <ffff0000084e9fac>  gic_cpu_if_up+0xc4/0x110
 [LOGK_READ ] ts:36468481048  data:ffff00000800d00c  <ffff000008081a34>  gic_handle_irq+0xac/0x128
 [LOGK_WRITE] ts:36468482923  data:ffff00000800d010  <ffff000008081aac>  gic_handle_irq+0x124/0x128
 [LOGK_READ ] ts:36468483184  data:ffff00000800d00c  <ffff000008081a34>  gic_handle_irq+0xac/0x128
 [LOGK_WRITE] ts:36468485215  data:ffff00000800d010  <ffff000008081aac>  gic_handle_irq+0x124/0x128
 [LOGK_READ ] ts:36468486309  data:ffff00000800d00c  <ffff000008081a34>  gic_handle_irq+0xac/0x128
 [LOGK_WRITE] ts:36468488236  data:ffff00000800d010  <ffff000008081aac>  gic_handle_irq+0x124/0x128

Output has below 5 fields:

 * Log type, Timestamp, Data from caller which is the address of
   read/write{b,w,l,q}, Caller ip and Caller name.

Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
---
 fs/pstore/Kconfig          | 12 +++++++
 fs/pstore/Makefile         |  1 +
 fs/pstore/inode.c          | 71 +++++++++++++++++++++++++++++++++++++-
 fs/pstore/internal.h       |  8 +++++
 fs/pstore/platform.c       |  4 +++
 fs/pstore/ram.c            | 42 ++++++++++++++++++++--
 fs/pstore/rtb.c            | 45 ++++++++++++++++++++++++
 include/linux/pstore.h     |  2 ++
 include/linux/pstore_ram.h |  1 +
 include/linux/rtb.h        |  7 ++++
 kernel/trace/trace_rtb.c   |  3 ++
 11 files changed, 193 insertions(+), 3 deletions(-)
 create mode 100644 fs/pstore/rtb.c

diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
index 503086f7f7c1..4f1ba1253dfd 100644
--- a/fs/pstore/Kconfig
+++ b/fs/pstore/Kconfig
@@ -124,6 +124,18 @@ config PSTORE_PMSG
 
 	  If unsure, say N.
 
+config PSTORE_RTB
+	bool "Log register operations like read/write"
+	depends on PSTORE && PSTORE!=m
+	depends on RTB
+	help
+	  When this option is enabled, rtb driver will log all register
+	  reads/writes into a persistent ram buffer that can be decoded
+	  and dumped after reboot through pstore filesystem. It can be used
+	  to debug readl/writel access.
+
+	  If unsure, say N.
+
 config PSTORE_FTRACE
 	bool "Persistent function tracer"
 	depends on PSTORE
diff --git a/fs/pstore/Makefile b/fs/pstore/Makefile
index 967b5891f325..c772c9420f57 100644
--- a/fs/pstore/Makefile
+++ b/fs/pstore/Makefile
@@ -9,6 +9,7 @@ pstore-objs += inode.o platform.o
 pstore-$(CONFIG_PSTORE_FTRACE)	+= ftrace.o
 
 pstore-$(CONFIG_PSTORE_PMSG)	+= pmsg.o
+pstore-$(CONFIG_PSTORE_RTB)	+= rtb.o
 
 ramoops-objs += ram.o ram_core.o
 obj-$(CONFIG_PSTORE_RAM)	+= ramoops.o
diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index 5fcb845b9fec..467fb29bfd68 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -33,6 +33,7 @@
 #include <linux/sched.h>
 #include <linux/magic.h>
 #include <linux/pstore.h>
+#include <linux/rtb.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/uaccess.h>
@@ -57,6 +58,7 @@ struct pstore_ftrace_seq_data {
 };
 
 #define REC_SIZE sizeof(struct pstore_ftrace_record)
+#define REC_SIZE_RTB sizeof(struct rtb_layout)
 
 static void free_pstore_private(struct pstore_private *private)
 {
@@ -131,13 +133,73 @@ static const struct seq_operations pstore_ftrace_seq_ops = {
 	.show	= pstore_ftrace_seq_show,
 };
 
+static void *pstore_rtb_seq_start(struct seq_file *s, loff_t *pos)
+{
+	struct pstore_private *ps = s->private;
+	struct pstore_ftrace_seq_data *rdata;
+
+	rdata = kzalloc(sizeof(*rdata), GFP_KERNEL);
+	if (!rdata)
+		return NULL;
+
+	rdata->off = ps->total_size % REC_SIZE_RTB;
+	rdata->off += *pos * REC_SIZE_RTB;
+	if (rdata->off + REC_SIZE_RTB > ps->total_size) {
+		kfree(rdata);
+		return NULL;
+	}
+
+	return rdata;
+}
+
+static void pstore_rtb_seq_stop(struct seq_file *s, void *v)
+{
+	kfree(v);
+}
+
+static void *pstore_rtb_seq_next(struct seq_file *s, void *v, loff_t *pos)
+{
+	struct pstore_private *ps = s->private;
+	struct pstore_ftrace_seq_data *rdata = v;
+
+	rdata->off += REC_SIZE_RTB;
+	if (rdata->off + REC_SIZE_RTB > ps->total_size)
+		return NULL;
+
+	(*pos)++;
+	return rdata;
+}
+
+static int pstore_rtb_seq_show(struct seq_file *s, void *v)
+{
+	struct pstore_private *ps = s->private;
+	struct pstore_ftrace_seq_data *rdata = v;
+	struct rtb_layout *rec;
+
+	rec = (struct rtb_layout *)(ps->record->buf + rdata->off);
+
+	seq_printf(s, "[%-10s] ts:%llu  data:%llx  <%llx>  %pS\n",
+		   rec->log_type, rec->timestamp, rec->data,
+		   rec->caller, (void *)rec->caller);
+
+	return 0;
+}
+
+static const struct seq_operations pstore_rtb_seq_ops = {
+	.start	= pstore_rtb_seq_start,
+	.next	= pstore_rtb_seq_next,
+	.stop	= pstore_rtb_seq_stop,
+	.show	= pstore_rtb_seq_show,
+};
+
 static ssize_t pstore_file_read(struct file *file, char __user *userbuf,
 						size_t count, loff_t *ppos)
 {
 	struct seq_file *sf = file->private_data;
 	struct pstore_private *ps = sf->private;
 
-	if (ps->record->type == PSTORE_TYPE_FTRACE)
+	if (ps->record->type == PSTORE_TYPE_FTRACE ||
+			ps->record->type == PSTORE_TYPE_RTB)
 		return seq_read(file, userbuf, count, ppos);
 	return simple_read_from_buffer(userbuf, count, ppos,
 				       ps->record->buf, ps->total_size);
@@ -153,6 +215,9 @@ static int pstore_file_open(struct inode *inode, struct file *file)
 	if (ps->record->type == PSTORE_TYPE_FTRACE)
 		sops = &pstore_ftrace_seq_ops;
 
+	if (ps->record->type == PSTORE_TYPE_RTB)
+		sops = &pstore_rtb_seq_ops;
+
 	err = seq_open(file, sops);
 	if (err < 0)
 		return err;
@@ -373,6 +438,10 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
 		scnprintf(name, sizeof(name), "powerpc-opal-%s-%llu",
 			  record->psi->name, record->id);
 		break;
+	case PSTORE_TYPE_RTB:
+		scnprintf(name, sizeof(name), "rtb-%s-%llu",
+			  record->psi->name, record->id);
+		break;
 	case PSTORE_TYPE_UNKNOWN:
 		scnprintf(name, sizeof(name), "unknown-%s-%llu",
 			  record->psi->name, record->id);
diff --git a/fs/pstore/internal.h b/fs/pstore/internal.h
index fb767e28aeb2..a5498e8b89d2 100644
--- a/fs/pstore/internal.h
+++ b/fs/pstore/internal.h
@@ -25,6 +25,14 @@ static inline void pstore_register_pmsg(void) {}
 static inline void pstore_unregister_pmsg(void) {}
 #endif
 
+#ifdef CONFIG_PSTORE_RTB
+extern void pstore_register_rtb(void);
+extern void pstore_unregister_rtb(void);
+#else
+static inline void pstore_register_rtb(void) {}
+static inline void pstore_unregister_rtb(void) {}
+#endif
+
 extern struct pstore_info *psinfo;
 
 extern void	pstore_set_kmsg_bytes(int);
diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 15e99d5a681d..3473a7456585 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -589,6 +589,8 @@ int pstore_register(struct pstore_info *psi)
 		pstore_register_ftrace();
 	if (psi->flags & PSTORE_FLAGS_PMSG)
 		pstore_register_pmsg();
+	if (psi->flags & PSTORE_FLAGS_RTB)
+		pstore_register_rtb();
 
 	/* Start watching for new records, if desired. */
 	if (pstore_update_ms >= 0) {
@@ -618,6 +620,8 @@ void pstore_unregister(struct pstore_info *psi)
 	del_timer_sync(&pstore_timer);
 	flush_work(&pstore_work);
 
+	if (psi->flags & PSTORE_FLAGS_RTB)
+		pstore_unregister_rtb();
 	if (psi->flags & PSTORE_FLAGS_PMSG)
 		pstore_unregister_pmsg();
 	if (psi->flags & PSTORE_FLAGS_FTRACE)
diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index bbd1e357c23d..79c00c7cf7b4 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -56,6 +56,10 @@ static ulong ramoops_pmsg_size = MIN_MEM_SIZE;
 module_param_named(pmsg_size, ramoops_pmsg_size, ulong, 0400);
 MODULE_PARM_DESC(pmsg_size, "size of user space message log");
 
+static ulong ramoops_rtb_size = MIN_MEM_SIZE;
+module_param_named(rtb_size, ramoops_rtb_size, ulong, 0400);
+MODULE_PARM_DESC(rtb_size, "size of register trace log");
+
 static unsigned long long mem_address;
 module_param_hw(mem_address, ullong, other, 0400);
 MODULE_PARM_DESC(mem_address,
@@ -88,6 +92,7 @@ struct ramoops_context {
 	struct persistent_ram_zone *cprz;	/* Console zone */
 	struct persistent_ram_zone **fprzs;	/* Ftrace zones */
 	struct persistent_ram_zone *mprz;	/* PMSG zone */
+	struct persistent_ram_zone *rprz;       /* RTB zone */
 	phys_addr_t phys_addr;
 	unsigned long size;
 	unsigned int memtype;
@@ -95,6 +100,7 @@ struct ramoops_context {
 	size_t console_size;
 	size_t ftrace_size;
 	size_t pmsg_size;
+	size_t rtb_size;
 	int dump_oops;
 	u32 flags;
 	struct persistent_ram_ecc_info ecc_info;
@@ -106,6 +112,7 @@ struct ramoops_context {
 	unsigned int max_ftrace_cnt;
 	unsigned int ftrace_read_cnt;
 	unsigned int pmsg_read_cnt;
+	unsigned int rtb_read_cnt;
 	struct pstore_info pstore;
 };
 
@@ -120,6 +127,7 @@ static int ramoops_pstore_open(struct pstore_info *psi)
 	cxt->console_read_cnt = 0;
 	cxt->ftrace_read_cnt = 0;
 	cxt->pmsg_read_cnt = 0;
+	cxt->rtb_read_cnt = 0;
 	return 0;
 }
 
@@ -282,6 +290,11 @@ static ssize_t ramoops_pstore_read(struct pstore_record *record)
 					   1, &record->id, &record->type,
 					   PSTORE_TYPE_PMSG, 0);
 
+	if (!prz_ok(prz))
+		prz = ramoops_get_next_prz(&cxt->rprz, &cxt->rtb_read_cnt,
+					   1, &record->id, &record->type,
+					   PSTORE_TYPE_RTB, 0);
+
 	/* ftrace is last since it may want to dynamically allocate memory. */
 	if (!prz_ok(prz)) {
 		if (!(cxt->flags & RAMOOPS_FLAG_FTRACE_PER_CPU)) {
@@ -404,6 +417,11 @@ static int notrace ramoops_pstore_write(struct pstore_record *record)
 	} else if (record->type == PSTORE_TYPE_PMSG) {
 		pr_warn_ratelimited("PMSG shouldn't call %s\n", __func__);
 		return -EINVAL;
+	} else if (record->type == PSTORE_TYPE_RTB) {
+		if (!cxt->rprz)
+			return -ENOMEM;
+		persistent_ram_write(cxt->rprz, record->buf, record->size);
+		return 0;
 	}
 
 	if (record->type != PSTORE_TYPE_DMESG)
@@ -483,6 +501,9 @@ static int ramoops_pstore_erase(struct pstore_record *record)
 	case PSTORE_TYPE_PMSG:
 		prz = cxt->mprz;
 		break;
+	case PSTORE_TYPE_RTB:
+		prz = cxt->rprz;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -701,6 +722,7 @@ static int ramoops_parse_dt(struct platform_device *pdev,
 	parse_size("console-size", pdata->console_size);
 	parse_size("ftrace-size", pdata->ftrace_size);
 	parse_size("pmsg-size", pdata->pmsg_size);
+	parse_size("rtb-size", pdata->rtb_size);
 	parse_size("ecc-size", pdata->ecc_info.ecc_size);
 	parse_size("flags", pdata->flags);
 
@@ -747,7 +769,8 @@ static int ramoops_probe(struct platform_device *pdev)
 	}
 
 	if (!pdata->mem_size || (!pdata->record_size && !pdata->console_size &&
-			!pdata->ftrace_size && !pdata->pmsg_size)) {
+			!pdata->ftrace_size && !pdata->pmsg_size &&
+			!pdata->rtb_size)) {
 		pr_err("The memory size and the record/console size must be "
 			"non-zero\n");
 		goto fail_out;
@@ -761,6 +784,8 @@ static int ramoops_probe(struct platform_device *pdev)
 		pdata->ftrace_size = rounddown_pow_of_two(pdata->ftrace_size);
 	if (pdata->pmsg_size && !is_power_of_2(pdata->pmsg_size))
 		pdata->pmsg_size = rounddown_pow_of_two(pdata->pmsg_size);
+	if (pdata->rtb_size && !is_power_of_2(pdata->rtb_size))
+		pdata->rtb_size = rounddown_pow_of_two(pdata->rtb_size);
 
 	cxt->size = pdata->mem_size;
 	cxt->phys_addr = pdata->mem_address;
@@ -769,6 +794,7 @@ static int ramoops_probe(struct platform_device *pdev)
 	cxt->console_size = pdata->console_size;
 	cxt->ftrace_size = pdata->ftrace_size;
 	cxt->pmsg_size = pdata->pmsg_size;
+	cxt->rtb_size = pdata->rtb_size;
 	cxt->dump_oops = pdata->dump_oops;
 	cxt->flags = pdata->flags;
 	cxt->ecc_info = pdata->ecc_info;
@@ -776,7 +802,7 @@ static int ramoops_probe(struct platform_device *pdev)
 	paddr = cxt->phys_addr;
 
 	dump_mem_sz = cxt->size - cxt->console_size - cxt->ftrace_size
-			- cxt->pmsg_size;
+			- cxt->pmsg_size - cxt->rtb_size;
 	err = ramoops_init_przs("dump", dev, cxt, &cxt->dprzs, &paddr,
 				dump_mem_sz, cxt->record_size,
 				&cxt->max_dump_cnt, 0, 0);
@@ -804,6 +830,11 @@ static int ramoops_probe(struct platform_device *pdev)
 	if (err)
 		goto fail_init_mprz;
 
+	err = ramoops_init_prz("rtb", dev, cxt, &cxt->rprz, &paddr,
+				cxt->rtb_size, 0);
+	if (err)
+		goto fail_init_rprz;
+
 	cxt->pstore.data = cxt;
 	/*
 	 * Console can handle any buffer size, so prefer LOG_LINE_MAX. If we
@@ -829,6 +860,8 @@ static int ramoops_probe(struct platform_device *pdev)
 		cxt->pstore.flags |= PSTORE_FLAGS_FTRACE;
 	if (cxt->pmsg_size)
 		cxt->pstore.flags |= PSTORE_FLAGS_PMSG;
+	if (cxt->rtb_size)
+		cxt->pstore.flags |= PSTORE_FLAGS_RTB;
 
 	err = pstore_register(&cxt->pstore);
 	if (err) {
@@ -846,6 +879,7 @@ static int ramoops_probe(struct platform_device *pdev)
 	dump_oops = pdata->dump_oops;
 	ramoops_console_size = pdata->console_size;
 	ramoops_pmsg_size = pdata->pmsg_size;
+	ramoops_rtb_size = pdata->rtb_size;
 	ramoops_ftrace_size = pdata->ftrace_size;
 
 	pr_info("attached 0x%lx@0x%llx, ecc: %d/%d\n",
@@ -858,6 +892,8 @@ static int ramoops_probe(struct platform_device *pdev)
 	kfree(cxt->pstore.buf);
 fail_clear:
 	cxt->pstore.bufsize = 0;
+	persistent_ram_free(cxt->rprz);
+fail_init_rprz:
 	persistent_ram_free(cxt->mprz);
 fail_init_mprz:
 fail_init_fprz:
@@ -877,6 +913,7 @@ static int ramoops_remove(struct platform_device *pdev)
 	kfree(cxt->pstore.buf);
 	cxt->pstore.bufsize = 0;
 
+	persistent_ram_free(cxt->rprz);
 	persistent_ram_free(cxt->mprz);
 	persistent_ram_free(cxt->cprz);
 	ramoops_free_przs(cxt);
@@ -918,6 +955,7 @@ static void ramoops_register_dummy(void)
 	dummy_data->console_size = ramoops_console_size;
 	dummy_data->ftrace_size = ramoops_ftrace_size;
 	dummy_data->pmsg_size = ramoops_pmsg_size;
+	dummy_data->rtb_size = ramoops_rtb_size;
 	dummy_data->dump_oops = dump_oops;
 	dummy_data->flags = RAMOOPS_FLAG_FTRACE_PER_CPU;
 
diff --git a/fs/pstore/rtb.c b/fs/pstore/rtb.c
new file mode 100644
index 000000000000..9fe159c38d64
--- /dev/null
+++ b/fs/pstore/rtb.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/fs.h>
+#include <linux/irqflags.h>
+#include <linux/rtb.h>
+#include <linux/smp.h>
+
+#include "internal.h"
+
+void notrace pstore_rtb_call(struct rtb_layout *start)
+{
+	unsigned long flags;
+	struct pstore_record record = {
+		.type = PSTORE_TYPE_RTB,
+		.buf = (char *)start,
+		.size = sizeof(*start),
+		.psi = psinfo,
+	};
+
+	local_irq_save(flags);
+
+	psinfo->write(&record);
+
+	local_irq_restore(flags);
+}
+
+void pstore_register_rtb(void)
+{
+	int ret;
+
+	if (!psinfo->write)
+		return;
+
+	ret = rtb_init();
+	if (ret)
+		return;
+}
+
+void pstore_unregister_rtb(void)
+{
+	rtb_exit();
+}
diff --git a/include/linux/pstore.h b/include/linux/pstore.h
index a15bc4d48752..07ae7afe9d3a 100644
--- a/include/linux/pstore.h
+++ b/include/linux/pstore.h
@@ -44,6 +44,7 @@ enum pstore_type_id {
 	PSTORE_TYPE_PPC_COMMON	= 6,
 	PSTORE_TYPE_PMSG	= 7,
 	PSTORE_TYPE_PPC_OPAL	= 8,
+	PSTORE_TYPE_RTB		= 9,
 	PSTORE_TYPE_UNKNOWN	= 255
 };
 
@@ -193,6 +194,7 @@ struct pstore_info {
 #define PSTORE_FLAGS_CONSOLE	(1 << 1)
 #define PSTORE_FLAGS_FTRACE	(1 << 2)
 #define PSTORE_FLAGS_PMSG	(1 << 3)
+#define PSTORE_FLAGS_RTB	(1 << 4)
 
 extern int pstore_register(struct pstore_info *);
 extern void pstore_unregister(struct pstore_info *);
diff --git a/include/linux/pstore_ram.h b/include/linux/pstore_ram.h
index e6d226464838..81eee723f2bb 100644
--- a/include/linux/pstore_ram.h
+++ b/include/linux/pstore_ram.h
@@ -97,6 +97,7 @@ struct ramoops_platform_data {
 	unsigned long	console_size;
 	unsigned long	ftrace_size;
 	unsigned long	pmsg_size;
+	unsigned long	rtb_size;
 	int		dump_oops;
 	u32		flags;
 	struct persistent_ram_ecc_info ecc_info;
diff --git a/include/linux/rtb.h b/include/linux/rtb.h
index a969bd020466..169a77b4a565 100644
--- a/include/linux/rtb.h
+++ b/include/linux/rtb.h
@@ -21,4 +21,11 @@ static inline int rtb_init(void) { return 0; }
 static inline void rtb_exit(void) { }
 #endif
 
+#if defined(CONFIG_PSTORE_RTB)
+extern void pstore_rtb_call(struct rtb_layout *start);
+#else
+static inline void pstore_rtb_call(struct rtb_layout *start)
+{ }
+#endif
+
 #endif /* _RTB_H */
diff --git a/kernel/trace/trace_rtb.c b/kernel/trace/trace_rtb.c
index 3e0a85e7b504..26b87b3e6a03 100644
--- a/kernel/trace/trace_rtb.c
+++ b/kernel/trace/trace_rtb.c
@@ -51,6 +51,9 @@ static void uncached_logk_pc_idx(const char *log_type, u64 caller,
 	start->timestamp = sched_clock();
 	/* Make sure data is written */
 	mb();
+#if defined(CONFIG_PSTORE_RTB)
+	pstore_rtb_call(start);
+#endif
 }
 
 static int rtb_get_idx(void)
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

