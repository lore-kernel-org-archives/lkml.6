Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23838C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C506A2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lEd8tCgR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C506A2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966916AbeFSQFd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:05:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:42278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966087AbeFSQFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:05:31 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10F7D20652;
        Tue, 19 Jun 2018 16:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529424330;
        bh=4JBXws+lP39lwXv4oDVLRFfF5GmQ9b6bJ7qXAXLgOFA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lEd8tCgRuX/ih4rKkGSW26wL5e0/mBA+TEYbT+jJC503lTC+jgg6P2pjJR6IGFH66
         eUgMk98C98VEB+ROpwnubzjzz+T6b9y0eQHcEl21w0RdYb+ihIc1G2/zav3sf3fR3S
         NOwcwZ6nAvmSZWsAui/xwjhVkX/651vAizNF9Ma4=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-arch@vger.kernel.org
Subject: [PATCH -tip v6 02/27] kprobes: Remove jprobe API implementation
Date:   Wed, 20 Jun 2018 01:05:07 +0900
Message-Id: <152942430705.15209.2307050500995264322.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152942424698.15209.15245996287444292393.stgit@devbox>
References: <152942424698.15209.15245996287444292393.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove jprobe API implementations and test cases for
those APIs which is no more used.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v4:
  - Cleanup lib/Kconfig.debug description too.
 Changes in v3:
  - Remove test cases.
---
 include/linux/kprobes.h |    3 --
 kernel/kprobes.c        |   78 +--------------------------------------
 kernel/test_kprobes.c   |   94 -----------------------------------------------
 lib/Kconfig.debug       |    2 +
 4 files changed, 2 insertions(+), 175 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 9440a2fc8893..b520baa65682 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -389,9 +389,6 @@ int register_kprobe(struct kprobe *p);
 void unregister_kprobe(struct kprobe *p);
 int register_kprobes(struct kprobe **kps, int num);
 void unregister_kprobes(struct kprobe **kps, int num);
-int setjmp_pre_handler(struct kprobe *, struct pt_regs *);
-int longjmp_break_handler(struct kprobe *, struct pt_regs *);
-void jprobe_return(void);
 unsigned long arch_deref_entry_point(void *);
 
 int register_kretprobe(struct kretprobe *rp);
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index ea619021d901..69de130595f7 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1272,7 +1272,7 @@ NOKPROBE_SYMBOL(cleanup_rp_inst);
 
 /*
 * Add the new probe to ap->list. Fail if this is the
-* second jprobe at the address - two jprobes can't coexist
+* second break_handler at the address
 */
 static int add_new_kprobe(struct kprobe *ap, struct kprobe *p)
 {
@@ -1812,77 +1812,6 @@ unsigned long __weak arch_deref_entry_point(void *entry)
 	return (unsigned long)entry;
 }
 
-#if 0
-int register_jprobes(struct jprobe **jps, int num)
-{
-	int ret = 0, i;
-
-	if (num <= 0)
-		return -EINVAL;
-
-	for (i = 0; i < num; i++) {
-		ret = register_jprobe(jps[i]);
-
-		if (ret < 0) {
-			if (i > 0)
-				unregister_jprobes(jps, i);
-			break;
-		}
-	}
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(register_jprobes);
-
-int register_jprobe(struct jprobe *jp)
-{
-	unsigned long addr, offset;
-	struct kprobe *kp = &jp->kp;
-
-	/*
-	 * Verify probepoint as well as the jprobe handler are
-	 * valid function entry points.
-	 */
-	addr = arch_deref_entry_point(jp->entry);
-
-	if (kallsyms_lookup_size_offset(addr, NULL, &offset) && offset == 0 &&
-	    kprobe_on_func_entry(kp->addr, kp->symbol_name, kp->offset)) {
-		kp->pre_handler = setjmp_pre_handler;
-		kp->break_handler = longjmp_break_handler;
-		return register_kprobe(kp);
-	}
-
-	return -EINVAL;
-}
-EXPORT_SYMBOL_GPL(register_jprobe);
-
-void unregister_jprobe(struct jprobe *jp)
-{
-	unregister_jprobes(&jp, 1);
-}
-EXPORT_SYMBOL_GPL(unregister_jprobe);
-
-void unregister_jprobes(struct jprobe **jps, int num)
-{
-	int i;
-
-	if (num <= 0)
-		return;
-	mutex_lock(&kprobe_mutex);
-	for (i = 0; i < num; i++)
-		if (__unregister_kprobe_top(&jps[i]->kp) < 0)
-			jps[i]->kp.addr = NULL;
-	mutex_unlock(&kprobe_mutex);
-
-	synchronize_sched();
-	for (i = 0; i < num; i++) {
-		if (jps[i]->kp.addr)
-			__unregister_kprobe_bottom(&jps[i]->kp);
-	}
-}
-EXPORT_SYMBOL_GPL(unregister_jprobes);
-#endif
-
 #ifdef CONFIG_KRETPROBES
 /*
  * This kprobe pre_handler is registered with every kretprobe. When probe
@@ -2329,8 +2258,6 @@ static void report_probe(struct seq_file *pi, struct kprobe *p,
 
 	if (p->pre_handler == pre_handler_kretprobe)
 		kprobe_type = "r";
-	else if (p->pre_handler == setjmp_pre_handler)
-		kprobe_type = "j";
 	else
 		kprobe_type = "k";
 
@@ -2637,6 +2564,3 @@ late_initcall(debugfs_kprobe_init);
 #endif /* CONFIG_DEBUG_FS */
 
 module_init(init_kprobes);
-
-/* defined in arch/.../kernel/kprobes.c */
-EXPORT_SYMBOL_GPL(jprobe_return);
diff --git a/kernel/test_kprobes.c b/kernel/test_kprobes.c
index dd53e354f630..7bca480151b0 100644
--- a/kernel/test_kprobes.c
+++ b/kernel/test_kprobes.c
@@ -162,90 +162,6 @@ static int test_kprobes(void)
 
 }
 
-#if 0
-static u32 jph_val;
-
-static u32 j_kprobe_target(u32 value)
-{
-	if (preemptible()) {
-		handler_errors++;
-		pr_err("jprobe-handler is preemptible\n");
-	}
-	if (value != rand1) {
-		handler_errors++;
-		pr_err("incorrect value in jprobe handler\n");
-	}
-
-	jph_val = rand1;
-	jprobe_return();
-	return 0;
-}
-
-static struct jprobe jp = {
-	.entry		= j_kprobe_target,
-	.kp.symbol_name = "kprobe_target"
-};
-
-static int test_jprobe(void)
-{
-	int ret;
-
-	ret = register_jprobe(&jp);
-	if (ret < 0) {
-		pr_err("register_jprobe returned %d\n", ret);
-		return ret;
-	}
-
-	ret = target(rand1);
-	unregister_jprobe(&jp);
-	if (jph_val == 0) {
-		pr_err("jprobe handler not called\n");
-		handler_errors++;
-	}
-
-	return 0;
-}
-
-static struct jprobe jp2 = {
-	.entry          = j_kprobe_target,
-	.kp.symbol_name = "kprobe_target2"
-};
-
-static int test_jprobes(void)
-{
-	int ret;
-	struct jprobe *jps[2] = {&jp, &jp2};
-
-	/* addr and flags should be cleard for reusing kprobe. */
-	jp.kp.addr = NULL;
-	jp.kp.flags = 0;
-	ret = register_jprobes(jps, 2);
-	if (ret < 0) {
-		pr_err("register_jprobes returned %d\n", ret);
-		return ret;
-	}
-
-	jph_val = 0;
-	ret = target(rand1);
-	if (jph_val == 0) {
-		pr_err("jprobe handler not called\n");
-		handler_errors++;
-	}
-
-	jph_val = 0;
-	ret = target2(rand1);
-	if (jph_val == 0) {
-		pr_err("jprobe handler2 not called\n");
-		handler_errors++;
-	}
-	unregister_jprobes(jps, 2);
-
-	return 0;
-}
-#else
-#define test_jprobe() (0)
-#define test_jprobes() (0)
-#endif
 #ifdef CONFIG_KRETPROBES
 static u32 krph_val;
 
@@ -383,16 +299,6 @@ int init_test_probes(void)
 	if (ret < 0)
 		errors++;
 
-	num_tests++;
-	ret = test_jprobe();
-	if (ret < 0)
-		errors++;
-
-	num_tests++;
-	ret = test_jprobes();
-	if (ret < 0)
-		errors++;
-
 #ifdef CONFIG_KRETPROBES
 	num_tests++;
 	ret = test_kretprobe();
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index eb885942eb0f..77677aa3c603 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1715,7 +1715,7 @@ config KPROBES_SANITY_TEST
 	default n
 	help
 	  This option provides for testing basic kprobes functionality on
-	  boot. A sample kprobe, jprobe and kretprobe are inserted and
+	  boot. Samples of kprobe and kretprobe are inserted and
 	  verified for functionality.
 
 	  Say N if you are unsure.

