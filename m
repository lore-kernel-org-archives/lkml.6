Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C746C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D96F220652
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTSSBE+T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D96F220652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967063AbeFSQRl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:17:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:48994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966516AbeFSQRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:17:39 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6E7520661;
        Tue, 19 Jun 2018 16:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529425059;
        bh=Tty1TQzE6iJ7doI5mf/RwxWLMPTDj2h8o6fUW4Z+/Vo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iTSSBE+Ti+pFj2D/x0daioke5D4j92Qob7kbghjeB51yuf/Xz784qsHgra43BOfGa
         ebfbH3o45ZIVCq0rWDADm/MYa0kpbcHfqfkvzW/W8rmdetn8Myt4hQS0O+nLfY8WcB
         DhVh9aZOaQueUb6DP+nsPqVpxTUsHvTWHo+tnANQ=
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
Subject: [PATCH -tip v6 27/27] kprobes: Remove jprobe stub API
Date:   Wed, 20 Jun 2018 01:17:15 +0900
Message-Id: <152942503572.15209.1652552217914694917.stgit@devbox>
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

Remove jprobe stub APIs from linux/kprobes.h since
the jprobe implementation was completely gone.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 include/linux/kprobes.h |   50 -----------------------------------------------
 1 file changed, 50 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index b520baa65682..e909413e4e38 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -63,7 +63,6 @@ struct pt_regs;
 struct kretprobe;
 struct kretprobe_instance;
 typedef int (*kprobe_pre_handler_t) (struct kprobe *, struct pt_regs *);
-typedef int (*kprobe_break_handler_t) (struct kprobe *, struct pt_regs *);
 typedef void (*kprobe_post_handler_t) (struct kprobe *, struct pt_regs *,
 				       unsigned long flags);
 typedef int (*kprobe_fault_handler_t) (struct kprobe *, struct pt_regs *,
@@ -101,12 +100,6 @@ struct kprobe {
 	 */
 	kprobe_fault_handler_t fault_handler;
 
-	/*
-	 * ... called if breakpoint trap occurs in probe handler.
-	 * Return 1 if it handled break, otherwise kernel will see it.
-	 */
-	kprobe_break_handler_t break_handler;
-
 	/* Saved opcode (which has been replaced with breakpoint) */
 	kprobe_opcode_t opcode;
 
@@ -155,24 +148,6 @@ static inline int kprobe_ftrace(struct kprobe *p)
 }
 
 /*
- * Special probe type that uses setjmp-longjmp type tricks to resume
- * execution at a specified entry with a matching prototype corresponding
- * to the probed function - a trick to enable arguments to become
- * accessible seamlessly by probe handling logic.
- * Note:
- * Because of the way compilers allocate stack space for local variables
- * etc upfront, regardless of sub-scopes within a function, this mirroring
- * principle currently works only for probes placed on function entry points.
- */
-struct jprobe {
-	struct kprobe kp;
-	void *entry;	/* probe handling code to jump to */
-};
-
-/* For backward compatibility with old code using JPROBE_ENTRY() */
-#define JPROBE_ENTRY(handler)	(handler)
-
-/*
  * Function-return probe -
  * Note:
  * User needs to provide a handler function, and initialize maxactive.
@@ -436,9 +411,6 @@ static inline void unregister_kprobe(struct kprobe *p)
 static inline void unregister_kprobes(struct kprobe **kps, int num)
 {
 }
-static inline void jprobe_return(void)
-{
-}
 static inline int register_kretprobe(struct kretprobe *rp)
 {
 	return -ENOSYS;
@@ -465,20 +437,6 @@ static inline int enable_kprobe(struct kprobe *kp)
 	return -ENOSYS;
 }
 #endif /* CONFIG_KPROBES */
-static inline int register_jprobe(struct jprobe *p)
-{
-	return -ENOSYS;
-}
-static inline int register_jprobes(struct jprobe **jps, int num)
-{
-	return -ENOSYS;
-}
-static inline void unregister_jprobe(struct jprobe *p)
-{
-}
-static inline void unregister_jprobes(struct jprobe **jps, int num)
-{
-}
 static inline int disable_kretprobe(struct kretprobe *rp)
 {
 	return disable_kprobe(&rp->kp);
@@ -487,14 +445,6 @@ static inline int enable_kretprobe(struct kretprobe *rp)
 {
 	return enable_kprobe(&rp->kp);
 }
-static inline int disable_jprobe(struct jprobe *jp)
-{
-	return -ENOSYS;
-}
-static inline int enable_jprobe(struct jprobe *jp)
-{
-	return -ENOSYS;
-}
 
 #ifndef CONFIG_KPROBES
 static inline bool is_kprobe_insn_slot(unsigned long addr)

