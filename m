Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A6BC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 07:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1AF021829
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 07:39:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1AF021829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbeHMKUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 06:20:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:41894 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728055AbeHMKSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 06:18:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 33F4AAEB6;
        Mon, 13 Aug 2018 07:37:44 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org, virtualization@lists.linux-foundation.org
Cc:     akataria@vmware.com, rusty@rustcorp.com.au,
        boris.ostrovsky@oracle.com, hpa@zytor.com, tglx@linutronix.de,
        mingo@redhat.com, peterz@infradead.org,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH v2 02/11] x86/paravirt: remove clobbers parameter from paravirt patch functions
Date:   Mon, 13 Aug 2018 09:37:30 +0200
Message-Id: <20180813073739.26108-3-jgross@suse.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20180813073739.26108-1-jgross@suse.com>
References: <20180813073739.26108-1-jgross@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clobbers parameter from paravirt_patch_default() et al isn't used
any longer. Remove it.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/paravirt_types.h |  7 +++----
 arch/x86/kernel/alternative.c         |  2 +-
 arch/x86/kernel/paravirt.c            | 14 +++++---------
 arch/x86/kernel/paravirt_patch_32.c   |  5 ++---
 arch/x86/kernel/paravirt_patch_64.c   |  5 ++---
 arch/x86/kernel/vsmp_64.c             |  6 +++---
 6 files changed, 16 insertions(+), 23 deletions(-)

diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 036b2f88f105..f6e24e78633b 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -84,7 +84,7 @@ struct pv_init_ops {
 	 * the number of bytes of code generated, as we nop pad the
 	 * rest in generic code.
 	 */
-	unsigned (*patch)(u8 type, u16 clobber, void *insnbuf,
+	unsigned (*patch)(u8 type, void *insnbuf,
 			  unsigned long addr, unsigned len);
 } __no_randomize_layout;
 
@@ -370,14 +370,13 @@ extern struct pv_lock_ops pv_lock_ops;
 
 unsigned paravirt_patch_ident_32(void *insnbuf, unsigned len);
 unsigned paravirt_patch_ident_64(void *insnbuf, unsigned len);
-unsigned paravirt_patch_default(u8 type, u16 clobbers, void *insnbuf,
+unsigned paravirt_patch_default(u8 type, void *insnbuf,
 				unsigned long addr, unsigned len);
 
 unsigned paravirt_patch_insns(void *insnbuf, unsigned len,
 			      const char *start, const char *end);
 
-unsigned native_patch(u8 type, u16 clobbers, void *ibuf,
-		      unsigned long addr, unsigned len);
+unsigned native_patch(u8 type, void *ibuf, unsigned long addr, unsigned len);
 
 int paravirt_disable_iospace(void);
 
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index a481763a3776..9729cee11149 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -594,7 +594,7 @@ void __init_or_module apply_paravirt(struct paravirt_patch_site *start,
 		BUG_ON(p->len > MAX_PATCH_LEN);
 		/* prep the buffer with the original instructions */
 		memcpy(insnbuf, p->instr, p->len);
-		used = pv_init_ops.patch(p->instrtype, p->clobbers, insnbuf,
+		used = pv_init_ops.patch(p->instrtype, insnbuf,
 					 (unsigned long)p->instr, p->len);
 
 		BUG_ON(used > p->len);
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index ce560b916b1f..f0c462fe2808 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -80,10 +80,8 @@ struct branch {
 	u32 delta;
 } __attribute__((packed));
 
-static unsigned paravirt_patch_call(void *insnbuf,
-				    const void *target, u16 tgt_clobbers,
-				    unsigned long addr, u16 site_clobbers,
-				    unsigned len)
+static unsigned paravirt_patch_call(void *insnbuf, const void *target,
+				    unsigned long addr, unsigned len)
 {
 	struct branch *b = insnbuf;
 	unsigned long delta = (unsigned long)target - (addr+5);
@@ -148,7 +146,7 @@ static void *get_call_destination(u8 type)
 	return *((void **)&tmpl + type);
 }
 
-unsigned paravirt_patch_default(u8 type, u16 clobbers, void *insnbuf,
+unsigned paravirt_patch_default(u8 type, void *insnbuf,
 				unsigned long addr, unsigned len)
 {
 	void *opfunc = get_call_destination(type);
@@ -171,10 +169,8 @@ unsigned paravirt_patch_default(u8 type, u16 clobbers, void *insnbuf,
 		/* If operation requires a jmp, then jmp */
 		ret = paravirt_patch_jmp(insnbuf, opfunc, addr, len);
 	else
-		/* Otherwise call the function; assume target could
-		   clobber any caller-save reg */
-		ret = paravirt_patch_call(insnbuf, opfunc, CLBR_ANY,
-					  addr, clobbers, len);
+		/* Otherwise call the function. */
+		ret = paravirt_patch_call(insnbuf, opfunc, addr, len);
 
 	return ret;
 }
diff --git a/arch/x86/kernel/paravirt_patch_32.c b/arch/x86/kernel/paravirt_patch_32.c
index 758e69d72ebf..e5c3a438149e 100644
--- a/arch/x86/kernel/paravirt_patch_32.c
+++ b/arch/x86/kernel/paravirt_patch_32.c
@@ -30,8 +30,7 @@ unsigned paravirt_patch_ident_64(void *insnbuf, unsigned len)
 extern bool pv_is_native_spin_unlock(void);
 extern bool pv_is_native_vcpu_is_preempted(void);
 
-unsigned native_patch(u8 type, u16 clobbers, void *ibuf,
-		      unsigned long addr, unsigned len)
+unsigned native_patch(u8 type, void *ibuf, unsigned long addr, unsigned len)
 {
 	const unsigned char *start, *end;
 	unsigned ret;
@@ -70,7 +69,7 @@ unsigned native_patch(u8 type, u16 clobbers, void *ibuf,
 
 	default:
 patch_default: __maybe_unused
-		ret = paravirt_patch_default(type, clobbers, ibuf, addr, len);
+		ret = paravirt_patch_default(type, ibuf, addr, len);
 		break;
 
 patch_site:
diff --git a/arch/x86/kernel/paravirt_patch_64.c b/arch/x86/kernel/paravirt_patch_64.c
index 9edadabf04f6..893ef87eb268 100644
--- a/arch/x86/kernel/paravirt_patch_64.c
+++ b/arch/x86/kernel/paravirt_patch_64.c
@@ -38,8 +38,7 @@ unsigned paravirt_patch_ident_64(void *insnbuf, unsigned len)
 extern bool pv_is_native_spin_unlock(void);
 extern bool pv_is_native_vcpu_is_preempted(void);
 
-unsigned native_patch(u8 type, u16 clobbers, void *ibuf,
-		      unsigned long addr, unsigned len)
+unsigned native_patch(u8 type, void *ibuf, unsigned long addr, unsigned len)
 {
 	const unsigned char *start, *end;
 	unsigned ret;
@@ -80,7 +79,7 @@ unsigned native_patch(u8 type, u16 clobbers, void *ibuf,
 
 	default:
 patch_default: __maybe_unused
-		ret = paravirt_patch_default(type, clobbers, ibuf, addr, len);
+		ret = paravirt_patch_default(type, ibuf, addr, len);
 		break;
 
 patch_site:
diff --git a/arch/x86/kernel/vsmp_64.c b/arch/x86/kernel/vsmp_64.c
index 44685fb2a192..f194e5e1e95c 100644
--- a/arch/x86/kernel/vsmp_64.c
+++ b/arch/x86/kernel/vsmp_64.c
@@ -69,7 +69,7 @@ asmlinkage __visible void vsmp_irq_enable(void)
 }
 PV_CALLEE_SAVE_REGS_THUNK(vsmp_irq_enable);
 
-static unsigned __init vsmp_patch(u8 type, u16 clobbers, void *ibuf,
+static unsigned __init vsmp_patch(u8 type, void *ibuf,
 				  unsigned long addr, unsigned len)
 {
 	switch (type) {
@@ -77,9 +77,9 @@ static unsigned __init vsmp_patch(u8 type, u16 clobbers, void *ibuf,
 	case PARAVIRT_PATCH(pv_irq_ops.irq_disable):
 	case PARAVIRT_PATCH(pv_irq_ops.save_fl):
 	case PARAVIRT_PATCH(pv_irq_ops.restore_fl):
-		return paravirt_patch_default(type, clobbers, ibuf, addr, len);
+		return paravirt_patch_default(type, ibuf, addr, len);
 	default:
-		return native_patch(type, clobbers, ibuf, addr, len);
+		return native_patch(type, ibuf, addr, len);
 	}
 
 }
-- 
2.13.7

