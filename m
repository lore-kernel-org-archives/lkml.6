Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225d3qDPrQYSWtbHOJpdshTCv75lqvdf/1/MVPOOt9OXnpRAVfGTd372hNa2f2wjV63jkZb4
ARC-Seal: i=1; a=rsa-sha256; t=1518708954; cv=none;
        d=google.com; s=arc-20160816;
        b=rZyLWaEgTd74wIhKhADnNY1PfLD/10GjzXPDh7Pu/us0VQmdDk+shPAaEXQURmkElC
         qAciOSs4Pi1+5pVB+6NaqjvoxILOM2+AxsgiiBwYxHuXCw30YOkP0Fne1tZ3aWZppBgh
         9e4UGmykpzpAREhyCJfj4BrctYMzo8aJCddCAa+U7F/3SPFoia9C2NXoOBpyKR7sAmEV
         bfwWgEG396nwxxp1cai/4av6WIG8UYLPdyj4YyBDDj2idgMAGmMlW3KwcMKAuHnuu00R
         XDfGrxJbAhnqYbKLzhSOZgSxp0u0ObcjSdq2fP+81pRXp3aGrrdqshgD8Df6KP9u2Qeq
         kOhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7BK7f1ul03aRgzqPimsH+ezci+QdHy+6jBEkE/OxoEI=;
        b=LbGf6dDap2adDQJrgjrSIYlt/htFt+zOfdkVDHuIZAr/0lL06zHvdP9IXcWjhNtMNs
         jFmUmoEXioASvpfZHRZgW2iTiW8JZ5uYrlLplvP+d6dbhasnYqVTjIvjVSl4F6rEgEqI
         WAJvYc1caSK4S09OGDBgkq2eMCfzWwfJUn58i7ExDSufn9BJPedekoJvADM0HSQH+6qG
         B0TghrUzlwztoImt+yPoijj4nChXOz9vDuJKhKJ4vvA2i0Ivepn2Met1+3GvnZLz96N2
         OCwW0RDZffFT+S2BXlQMwqALLAxJF5OB2qZM6Gw2hZ5iLfFpP68jRndMU2fU82v6Je/8
         r8+Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH 4.14 140/195] KVM: PPC: Book3S HV: Drop locks before reading guest memory
Date: Thu, 15 Feb 2018 16:17:11 +0100
Message-Id: <20180215151712.792026657@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481759967364582?=
X-GMAIL-MSGID: =?utf-8?q?1592481759967364582?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -999,8 +999,6 @@ static int kvmppc_emulate_doorbell_instr
 	struct kvm *kvm = vcpu->kvm;
 	struct kvm_vcpu *tvcpu;
 
-	if (!cpu_has_feature(CPU_FTR_ARCH_300))
-		return EMULATE_FAIL;
 	if (kvmppc_get_last_inst(vcpu, INST_GENERIC, &inst) != EMULATE_DONE)
 		return RESUME_GUEST;
 	if (get_op(inst) != 31)
@@ -1050,6 +1048,7 @@ static int kvmppc_emulate_doorbell_instr
 	return RESUME_GUEST;
 }
 
+/* Called with vcpu->arch.vcore->lock held */
 static int kvmppc_handle_exit_hv(struct kvm_run *run, struct kvm_vcpu *vcpu,
 				 struct task_struct *tsk)
 {
@@ -1169,7 +1168,10 @@ static int kvmppc_handle_exit_hv(struct
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
@@ -1184,8 +1186,13 @@ static int kvmppc_handle_exit_hv(struct
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
@@ -2889,13 +2896,14 @@ static noinline void kvmppc_run_core(str
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
