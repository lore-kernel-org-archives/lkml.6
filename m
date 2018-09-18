Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A7BC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83DEF20C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:00:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83DEF20C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730736AbeIRXeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 19:34:14 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:38035 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730633AbeIRXeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 19:34:14 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g2KIY-0004da-9r; Tue, 18 Sep 2018 12:00:30 -0600
Received: from [105.184.227.67] (helo=x220.Home)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g2KII-000459-7j; Tue, 18 Sep 2018 12:00:29 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Tue, 18 Sep 2018 19:58:50 +0200
Message-Id: <20180918175850.4437-9-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <878t3yitze.fsf@xmission.com>
References: <878t3yitze.fsf@xmission.com>
X-XM-SPF: eid=1g2KII-000459-7j;;;mid=<20180918175850.4437-9-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/+QYR/qOoQYyWi+DxjHkehuWXJ1vdhZ4I=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [REVIEW][PATCH 9/9] signal/powerpc: Use force_sig_fault where appropriate
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/powerpc/kernel/process.c             |  9 +-------
 arch/powerpc/mm/fault.c                   |  9 +-------
 arch/powerpc/platforms/cell/spu_base.c    |  4 ++--
 arch/powerpc/platforms/cell/spufs/fault.c | 26 +++++++----------------
 4 files changed, 12 insertions(+), 36 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 913c5725cdb2..553a396e7fc1 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -620,8 +620,6 @@ void do_send_trap(struct pt_regs *regs, unsigned long address,
 void do_break (struct pt_regs *regs, unsigned long address,
 		    unsigned long error_code)
 {
-	siginfo_t info;
-
 	current->thread.trap_nr = TRAP_HWBKPT;
 	if (notify_die(DIE_DABR_MATCH, "dabr_match", regs, error_code,
 			11, SIGSEGV) == NOTIFY_STOP)
@@ -634,12 +632,7 @@ void do_break (struct pt_regs *regs, unsigned long address,
 	hw_breakpoint_disable();
 
 	/* Deliver the signal to userspace */
-	clear_siginfo(&info);
-	info.si_signo = SIGTRAP;
-	info.si_errno = 0;
-	info.si_code = TRAP_HWBKPT;
-	info.si_addr = (void __user *)address;
-	force_sig_info(SIGTRAP, &info, current);
+	force_sig_fault(SIGTRAP, TRAP_HWBKPT, (void __user *)address, current);
 }
 #endif	/* CONFIG_PPC_ADV_DEBUG_REGS */
 
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 406d0e0ef096..1697e903bbf2 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -165,17 +165,10 @@ static noinline int bad_access(struct pt_regs *regs, unsigned long address)
 static int do_sigbus(struct pt_regs *regs, unsigned long address,
 		     vm_fault_t fault)
 {
-	siginfo_t info;
-
 	if (!user_mode(regs))
 		return SIGBUS;
 
 	current->thread.trap_nr = BUS_ADRERR;
-	clear_siginfo(&info);
-	info.si_signo = SIGBUS;
-	info.si_errno = 0;
-	info.si_code = BUS_ADRERR;
-	info.si_addr = (void __user *)address;
 #ifdef CONFIG_MEMORY_FAILURE
 	if (fault & (VM_FAULT_HWPOISON|VM_FAULT_HWPOISON_LARGE)) {
 		unsigned int lsb = 0; /* shutup gcc */
@@ -194,7 +187,7 @@ static int do_sigbus(struct pt_regs *regs, unsigned long address,
 	}
 
 #endif
-	force_sig_info(SIGBUS, &info, current);
+	force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address, current);
 	return 0;
 }
 
diff --git a/arch/powerpc/platforms/cell/spu_base.c b/arch/powerpc/platforms/cell/spu_base.c
index 0c45cdbac4cf..7f12c7b78c0f 100644
--- a/arch/powerpc/platforms/cell/spu_base.c
+++ b/arch/powerpc/platforms/cell/spu_base.c
@@ -50,11 +50,11 @@ struct cbe_spu_info cbe_spu_info[MAX_NUMNODES];
 EXPORT_SYMBOL_GPL(cbe_spu_info);
 
 /*
- * The spufs fault-handling code needs to call force_sig_info to raise signals
+ * The spufs fault-handling code needs to call force_sig_fault to raise signals
  * on DMA errors. Export it here to avoid general kernel-wide access to this
  * function
  */
-EXPORT_SYMBOL_GPL(force_sig_info);
+EXPORT_SYMBOL_GPL(force_sig_fault);
 
 /*
  * Protects cbe_spu_info and spu->number.
diff --git a/arch/powerpc/platforms/cell/spufs/fault.c b/arch/powerpc/platforms/cell/spufs/fault.c
index 83cf58daaa79..971ac43b5d60 100644
--- a/arch/powerpc/platforms/cell/spufs/fault.c
+++ b/arch/powerpc/platforms/cell/spufs/fault.c
@@ -36,42 +36,32 @@
 static void spufs_handle_event(struct spu_context *ctx,
 				unsigned long ea, int type)
 {
-	siginfo_t info;
-
 	if (ctx->flags & SPU_CREATE_EVENTS_ENABLED) {
 		ctx->event_return |= type;
 		wake_up_all(&ctx->stop_wq);
 		return;
 	}
 
-	clear_siginfo(&info);
-
 	switch (type) {
 	case SPE_EVENT_INVALID_DMA:
-		info.si_signo = SIGBUS;
-		info.si_code = BUS_OBJERR;
+		force_sig_fault(SIGBUS, BUS_OBJERR, NULL, current);
 		break;
 	case SPE_EVENT_SPE_DATA_STORAGE:
-		info.si_signo = SIGSEGV;
-		info.si_addr = (void __user *)ea;
-		info.si_code = SEGV_ACCERR;
 		ctx->ops->restart_dma(ctx);
+		force_sig_fault(SIGSEGV, SEGV_ACCERR, (void __user *)ea,
+				current);
 		break;
 	case SPE_EVENT_DMA_ALIGNMENT:
-		info.si_signo = SIGBUS;
 		/* DAR isn't set for an alignment fault :( */
-		info.si_code = BUS_ADRALN;
+		force_sig_fault(SIGBUS, BUS_ADRALN, NULL, current);
 		break;
 	case SPE_EVENT_SPE_ERROR:
-		info.si_signo = SIGILL;
-		info.si_addr = (void __user *)(unsigned long)
-			ctx->ops->npc_read(ctx) - 4;
-		info.si_code = ILL_ILLOPC;
+		force_sig_fault(
+			SIGILL, ILL_ILLOPC,
+			(void __user *)(unsigned long)
+			ctx->ops->npc_read(ctx) - 4, current);
 		break;
 	}
-
-	if (info.si_signo)
-		force_sig_info(info.si_signo, &info, current);
 }
 
 int spufs_handle_class0(struct spu_context *ctx)
-- 
2.17.1

