Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1906823-1518711308-2-9550326507751063084
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518711308; b=AHgFW7h5VByiKS4TKQ3IT5T/VSVDtnszueO3g0x2fEjAzOa
    KmP/nMu7/Rkj9PHc3oEhKOiwU+ZNuysEwItIj4Pqr9XzJ5nv7smm3iBWzYJIUZBG
    y0JeoXvujdNk7iW+pqw8Kgc4o9gZpS0IpoSQ66efMhTsAfZdTd/FrPZ4TfM+Aq25
    iTV6vXwYnggDgEYwgU3Rt0P2mTm71RC4t4ykXxuPtguV0Kea6Ll+RzwggN5SXBeW
    48XmxE4HthJJIXQwDBE5WoRReBLej6XfDR8gV+VBWQ0cBvs1Ip2fZ56NKd3vlb3H
    U97pJ6zyjuJqx4hYPy5Uv+Uyl41aJKQZUA9G9jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518711308; bh=GtbiYsPAUwcL/0lRb2XDxhtbGG
    r+McaWjqTp3Tu/ICc=; b=YyekmFKsi0vNsro8msAdpJcm+HPs6bUrWKW0pvXKpO
    Vb2gPvvxb2kkWRrLwoqFJ26VePL2P42178OqFwV0zVEz0QQuHQOvWQ/+AlOvYkjD
    pc8+5bSaTzCB5/VPNC4ZI2AN5x0j7KvC07CRwP1tjbBqwxI61LQFCK+qKyWS0lE5
    auc6bQT8qWbWmKvClIdJrthlyJauZvpoxDeJWTotRUor17XdmlQsKaQYu8NmlIuj
    xkEDaigXAZi5W/Qeg8VKZmCMud7PugSEeTRlzxrwH2jaGm1ytUHg1rerTXjSuTKA
    IguZW0T8e3K2KzCb1tuLQaVFrfHA6sIltY2vrW5OftPQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424281AbeBOPon (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:44:43 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:34434 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423899AbeBOPom (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:44:42 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH 4.15 134/202] KVM: PPC: Book3S HV: Drop locks before reading guest memory
Date: Thu, 15 Feb 2018 16:17:14 +0100
Message-Id: <20180215151720.160232830@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Mackerras <paulus@ozlabs.org>

commit 36ee41d161c67a6fcf696d4817a0da31f778938c upstream.

Running with CONFIG_DEBUG_ATOMIC_SLEEP reveals that HV KVM tries to
read guest memory, in order to emulate guest instructions, while
preempt is disabled and a vcore lock is held.  This occurs in
kvmppc_handle_exit_hv(), called from post_guest_process(), when
emulating guest doorbell instructions on POWER9 systems, and also
when checking whether we have hit a hypervisor breakpoint.
Reading guest memory can cause a page fault and thus cause the
task to sleep, so we need to avoid reading guest memory while
holding a spinlock or when preempt is disabled.

To fix this, we move the preempt_enable() in kvmppc_run_core() to
before the loop that calls post_guest_process() for each vcore that
has just run, and we drop and re-take the vcore lock around the calls
to kvmppc_emulate_debug_inst() and kvmppc_emulate_doorbell_instr().

Dropping the lock is safe with respect to the iteration over the
runnable vcpus in post_guest_process(); for_each_runnable_thread
is actually safe to use locklessly.  It is possible for a vcpu
to become runnable and add itself to the runnable_threads array
(code near the beginning of kvmppc_run_vcpu()) and then get included
in the iteration in post_guest_process despite the fact that it
has not just run.  This is benign because vcpu->arch.trap and
vcpu->arch.ceded will be zero.

Fixes: 579006944e0d ("KVM: PPC: Book3S HV: Virtualize doorbell facility on POWER9")
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kvm/book3s_hv.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1005,8 +1005,6 @@ static int kvmppc_emulate_doorbell_instr
 	struct kvm *kvm = vcpu->kvm;
 	struct kvm_vcpu *tvcpu;
 
-	if (!cpu_has_feature(CPU_FTR_ARCH_300))
-		return EMULATE_FAIL;
 	if (kvmppc_get_last_inst(vcpu, INST_GENERIC, &inst) != EMULATE_DONE)
 		return RESUME_GUEST;
 	if (get_op(inst) != 31)
@@ -1056,6 +1054,7 @@ static int kvmppc_emulate_doorbell_instr
 	return RESUME_GUEST;
 }
 
+/* Called with vcpu->arch.vcore->lock held */
 static int kvmppc_handle_exit_hv(struct kvm_run *run, struct kvm_vcpu *vcpu,
 				 struct task_struct *tsk)
 {
@@ -1176,7 +1175,10 @@ static int kvmppc_handle_exit_hv(struct
 				swab32(vcpu->arch.emul_inst) :
 				vcpu->arch.emul_inst;
 		if (vcpu->guest_debug & KVM_GUESTDBG_USE_SW_BP) {
+			/* Need vcore unlocked to call kvmppc_get_last_inst */
+			spin_unlock(&vcpu->arch.vcore->lock);
 			r = kvmppc_emulate_debug_inst(run, vcpu);
+			spin_lock(&vcpu->arch.vcore->lock);
 		} else {
 			kvmppc_core_queue_program(vcpu, SRR1_PROGILL);
 			r = RESUME_GUEST;
@@ -1191,8 +1193,13 @@ static int kvmppc_handle_exit_hv(struct
 	 */
 	case BOOK3S_INTERRUPT_H_FAC_UNAVAIL:
 		r = EMULATE_FAIL;
-		if ((vcpu->arch.hfscr >> 56) == FSCR_MSGP_LG)
+		if (((vcpu->arch.hfscr >> 56) == FSCR_MSGP_LG) &&
+		    cpu_has_feature(CPU_FTR_ARCH_300)) {
+			/* Need vcore unlocked to call kvmppc_get_last_inst */
+			spin_unlock(&vcpu->arch.vcore->lock);
 			r = kvmppc_emulate_doorbell_instr(vcpu);
+			spin_lock(&vcpu->arch.vcore->lock);
+		}
 		if (r == EMULATE_FAIL) {
 			kvmppc_core_queue_program(vcpu, SRR1_PROGILL);
 			r = RESUME_GUEST;
@@ -2934,13 +2941,14 @@ static noinline void kvmppc_run_core(str
 	/* make sure updates to secondary vcpu structs are visible now */
 	smp_mb();
 
+	preempt_enable();
+
 	for (sub = 0; sub < core_info.n_subcores; ++sub) {
 		pvc = core_info.vc[sub];
 		post_guest_process(pvc, pvc == vc);
 	}
 
 	spin_lock(&vc->lock);
-	preempt_enable();
 
  out:
 	vc->vcore_state = VCORE_INACTIVE;
