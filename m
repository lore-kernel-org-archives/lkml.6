Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B287EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F69B21104
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohZeri33"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F69B21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390149AbeKTDPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:15:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:52564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388976AbeKTDPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:15:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C474D208E4;
        Mon, 19 Nov 2018 16:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646251;
        bh=SF/it+jReSiynNhyTQ2D9VXVsuIhgHpUF6zhdEl4nhg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ohZeri33Qquu8IhNJbkuWRMxxLEXpQE7Bku0VkK1nXP0r7JUoQVFZB+5f0qkghD79
         VdC74NJc8RNAwmnpC8frBQRAdN3jzVujk0K/iI++TdhYdoQFLjtMVtS1CO5kNLja78
         FpcH1XZThq3CLBAn7ZSnWav6hKGJs6n1dt9tQILg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: [PATCH 4.14 094/124] kdb: print real address of pointers instead of hashed addresses
Date:   Mon, 19 Nov 2018 17:29:08 +0100
Message-Id: <20181119162630.521184022@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162612.951907286@linuxfoundation.org>
References: <20181119162612.951907286@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe Leroy <christophe.leroy@c-s.fr>

commit 568fb6f42ac6851320adaea25f8f1b94de14e40a upstream.

Since commit ad67b74d2469 ("printk: hash addresses printed with %p"),
all pointers printed with %p are printed with hashed addresses
instead of real addresses in order to avoid leaking addresses in
dmesg and syslog. But this applies to kdb too, with is unfortunate:

    Entering kdb (current=0x(ptrval), pid 329) due to Keyboard Entry
    kdb> ps
    15 sleeping system daemon (state M) processes suppressed,
    use 'ps A' to see all.
    Task Addr       Pid   Parent [*] cpu State Thread     Command
    0x(ptrval)      329      328  1    0   R  0x(ptrval) *sh

    0x(ptrval)        1        0  0    0   S  0x(ptrval)  init
    0x(ptrval)        3        2  0    0   D  0x(ptrval)  rcu_gp
    0x(ptrval)        4        2  0    0   D  0x(ptrval)  rcu_par_gp
    0x(ptrval)        5        2  0    0   D  0x(ptrval)  kworker/0:0
    0x(ptrval)        6        2  0    0   D  0x(ptrval)  kworker/0:0H
    0x(ptrval)        7        2  0    0   D  0x(ptrval)  kworker/u2:0
    0x(ptrval)        8        2  0    0   D  0x(ptrval)  mm_percpu_wq
    0x(ptrval)       10        2  0    0   D  0x(ptrval)  rcu_preempt

The whole purpose of kdb is to debug, and for debugging real addresses
need to be known. In addition, data displayed by kdb doesn't go into
dmesg.

This patch replaces all %p by %px in kdb in order to display real
addresses.

Fixes: ad67b74d2469 ("printk: hash addresses printed with %p")
Cc: <stable@vger.kernel.org>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/debug/kdb/kdb_main.c    |   14 +++++++-------
 kernel/debug/kdb/kdb_support.c |   12 ++++++------
 2 files changed, 13 insertions(+), 13 deletions(-)

--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -1182,7 +1182,7 @@ static int kdb_local(kdb_reason_t reason
 	if (reason == KDB_REASON_DEBUG) {
 		/* special case below */
 	} else {
-		kdb_printf("\nEntering kdb (current=0x%p, pid %d) ",
+		kdb_printf("\nEntering kdb (current=0x%px, pid %d) ",
 			   kdb_current, kdb_current ? kdb_current->pid : 0);
 #if defined(CONFIG_SMP)
 		kdb_printf("on processor %d ", raw_smp_processor_id());
@@ -1198,7 +1198,7 @@ static int kdb_local(kdb_reason_t reason
 		 */
 		switch (db_result) {
 		case KDB_DB_BPT:
-			kdb_printf("\nEntering kdb (0x%p, pid %d) ",
+			kdb_printf("\nEntering kdb (0x%px, pid %d) ",
 				   kdb_current, kdb_current->pid);
 #if defined(CONFIG_SMP)
 			kdb_printf("on processor %d ", raw_smp_processor_id());
@@ -2037,7 +2037,7 @@ static int kdb_lsmod(int argc, const cha
 		if (mod->state == MODULE_STATE_UNFORMED)
 			continue;
 
-		kdb_printf("%-20s%8u  0x%p ", mod->name,
+		kdb_printf("%-20s%8u  0x%px ", mod->name,
 			   mod->core_layout.size, (void *)mod);
 #ifdef CONFIG_MODULE_UNLOAD
 		kdb_printf("%4d ", module_refcount(mod));
@@ -2048,7 +2048,7 @@ static int kdb_lsmod(int argc, const cha
 			kdb_printf(" (Loading)");
 		else
 			kdb_printf(" (Live)");
-		kdb_printf(" 0x%p", mod->core_layout.base);
+		kdb_printf(" 0x%px", mod->core_layout.base);
 
 #ifdef CONFIG_MODULE_UNLOAD
 		{
@@ -2330,7 +2330,7 @@ void kdb_ps1(const struct task_struct *p
 		return;
 
 	cpu = kdb_process_cpu(p);
-	kdb_printf("0x%p %8d %8d  %d %4d   %c  0x%p %c%s\n",
+	kdb_printf("0x%px %8d %8d  %d %4d   %c  0x%px %c%s\n",
 		   (void *)p, p->pid, p->parent->pid,
 		   kdb_task_has_cpu(p), kdb_process_cpu(p),
 		   kdb_task_state_char(p),
@@ -2343,7 +2343,7 @@ void kdb_ps1(const struct task_struct *p
 		} else {
 			if (KDB_TSK(cpu) != p)
 				kdb_printf("  Error: does not match running "
-				   "process table (0x%p)\n", KDB_TSK(cpu));
+				   "process table (0x%px)\n", KDB_TSK(cpu));
 		}
 	}
 }
@@ -2722,7 +2722,7 @@ int kdb_register_flags(char *cmd,
 	for_each_kdbcmd(kp, i) {
 		if (kp->cmd_name && (strcmp(kp->cmd_name, cmd) == 0)) {
 			kdb_printf("Duplicate kdb command registered: "
-				"%s, func %p help %s\n", cmd, func, help);
+				"%s, func %px help %s\n", cmd, func, help);
 			return 1;
 		}
 	}
--- a/kernel/debug/kdb/kdb_support.c
+++ b/kernel/debug/kdb/kdb_support.c
@@ -40,7 +40,7 @@
 int kdbgetsymval(const char *symname, kdb_symtab_t *symtab)
 {
 	if (KDB_DEBUG(AR))
-		kdb_printf("kdbgetsymval: symname=%s, symtab=%p\n", symname,
+		kdb_printf("kdbgetsymval: symname=%s, symtab=%px\n", symname,
 			   symtab);
 	memset(symtab, 0, sizeof(*symtab));
 	symtab->sym_start = kallsyms_lookup_name(symname);
@@ -88,7 +88,7 @@ int kdbnearsym(unsigned long addr, kdb_s
 	char *knt1 = NULL;
 
 	if (KDB_DEBUG(AR))
-		kdb_printf("kdbnearsym: addr=0x%lx, symtab=%p\n", addr, symtab);
+		kdb_printf("kdbnearsym: addr=0x%lx, symtab=%px\n", addr, symtab);
 	memset(symtab, 0, sizeof(*symtab));
 
 	if (addr < 4096)
@@ -149,7 +149,7 @@ int kdbnearsym(unsigned long addr, kdb_s
 		symtab->mod_name = "kernel";
 	if (KDB_DEBUG(AR))
 		kdb_printf("kdbnearsym: returns %d symtab->sym_start=0x%lx, "
-		   "symtab->mod_name=%p, symtab->sym_name=%p (%s)\n", ret,
+		   "symtab->mod_name=%px, symtab->sym_name=%px (%s)\n", ret,
 		   symtab->sym_start, symtab->mod_name, symtab->sym_name,
 		   symtab->sym_name);
 
@@ -887,13 +887,13 @@ void debug_kusage(void)
 		   __func__, dah_first);
 	if (dah_first) {
 		h_used = (struct debug_alloc_header *)debug_alloc_pool;
-		kdb_printf("%s: h_used %p size %d\n", __func__, h_used,
+		kdb_printf("%s: h_used %px size %d\n", __func__, h_used,
 			   h_used->size);
 	}
 	do {
 		h_used = (struct debug_alloc_header *)
 			  ((char *)h_free + dah_overhead + h_free->size);
-		kdb_printf("%s: h_used %p size %d caller %p\n",
+		kdb_printf("%s: h_used %px size %d caller %px\n",
 			   __func__, h_used, h_used->size, h_used->caller);
 		h_free = (struct debug_alloc_header *)
 			  (debug_alloc_pool + h_free->next);
@@ -902,7 +902,7 @@ void debug_kusage(void)
 		  ((char *)h_free + dah_overhead + h_free->size);
 	if ((char *)h_used - debug_alloc_pool !=
 	    sizeof(debug_alloc_pool_aligned))
-		kdb_printf("%s: h_used %p size %d caller %p\n",
+		kdb_printf("%s: h_used %px size %d caller %px\n",
 			   __func__, h_used, h_used->size, h_used->caller);
 out:
 	spin_unlock(&dap_lock);


