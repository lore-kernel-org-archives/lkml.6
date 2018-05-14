Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqUrRwAn487WLqgJAFwTVsGyZXVkInbzT3ysoNepzFCc9soWBR+it7/B81MJ3OFiBO/EtS9
ARC-Seal: i=1; a=rsa-sha256; t=1526280932; cv=none;
        d=google.com; s=arc-20160816;
        b=mx7wAsGMJHXpJtMfx+hx5LOc8J8qCNEIPMKwAgcefn8WrLUv8BW+hN1IyjcNfXNtFX
         /RHsoWXEBrS1VjsUrkWt2V2h0Ao/a2MIpyAqnOXt9UVBuI/eWVmXZMS2v5XauVURw7X7
         5ELK6Izda8shrThv8wIW6SSSpZryvVTf1cX6X2jExtVdye1T6atQDTARWeNkDsQBvb9S
         xumQhyNi+AkormI1kgE1m8yZSOE86l2owwdCLHMFKTX4Is/Xi9bIOb7D5VgA1HI+GZf1
         Ph8mseP3tSK2yhpH5nr2KA0T7KzGBogQ5hPJZc7ObqCmbw6TN8yXQaeMD4yyG2cjy0Ls
         miOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=Wf8+AH/2S0e8aD3wzmJZecDoZJvj5d05pDyyolDj6kU=;
        b=hqLlro+BInaovKOlJVclpYv2nzCwirjfg6oU1UrGYnVEonudoKdOkJnf7eZjlWMzWB
         XBUkTnoLpr1FwiTkC7+X4LGL88m4PJFdkT5gb/6gXaQfyjn9jglG8Lkd2uvkFDPgiL8X
         qC5kSYSn4H1mijL0fUb7bkovzckQEmvyBlQLUZaC/2fO6GqfANorLsyWpjBiwoa2wLdv
         bHw8Yc/ohimRf6kli/9Oo1eyOEQROUJV9/ZLaZPlw4SI3/g7QJiTFW5EAOdTZOhq3LSA
         ac5bEm5+ka6ofic1S1mMLx7Wp9rvcM6m6GNPqZvWPkQ+AQsRJqrzMdAGAcCqaPYyHh8V
         RoqQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=bipqW2QH;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=bipqW2QH;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH 4.14 18/62] KVM: PPC: Book3S HV: Fix trap number return from __kvmppc_vcore_entry
Date: Mon, 14 May 2018 08:48:34 +0200
Message-Id: <20180514064817.413157098@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064816.436958006@linuxfoundation.org>
References: <20180514064816.436958006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421494023724143?=
X-GMAIL-MSGID: =?utf-8?q?1600421555070639472?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Mackerras <paulus@ozlabs.org>

commit a8b48a4dccea77e29462e59f1dbf0d5aa1ff167c upstream.

This fixes a bug where the trap number that is returned by
__kvmppc_vcore_entry gets corrupted.  The effect of the corruption
is that IPIs get ignored on POWER9 systems when the IPI is sent via
a doorbell interrupt to a CPU which is executing in a KVM guest.
The effect of the IPI being ignored is often that another CPU locks
up inside smp_call_function_many() (and if that CPU is holding a
spinlock, other CPUs then lock up inside raw_spin_lock()).

The trap number is currently held in register r12 for most of the
assembly-language part of the guest exit path.  In that path, we
call kvmppc_subcore_exit_guest(), which is a C function, without
restoring r12 afterwards.  Depending on the kernel config and the
compiler, it may modify r12 or it may not, so some config/compiler
combinations see the bug and others don't.

To fix this, we arrange for the trap number to be stored on the
stack from the 'guest_bypass:' label until the end of the function,
then the trap number is loaded and returned in r12 as before.

Cc: stable@vger.kernel.org # v4.8+
Fixes: fd7bacbca47a ("KVM: PPC: Book3S HV: Fix TB corruption in guest exit path on HMI interrupt")
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kvm/book3s_hv_rmhandlers.S |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -308,7 +308,6 @@ kvm_novcpu_exit:
 	stw	r12, STACK_SLOT_TRAP(r1)
 	bl	kvmhv_commence_exit
 	nop
-	lwz	r12, STACK_SLOT_TRAP(r1)
 	b	kvmhv_switch_to_host
 
 /*
@@ -1136,6 +1135,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
 
 secondary_too_late:
 	li	r12, 0
+	stw	r12, STACK_SLOT_TRAP(r1)
 	cmpdi	r4, 0
 	beq	11f
 	stw	r12, VCPU_TRAP(r4)
@@ -1445,12 +1445,12 @@ mc_cont:
 1:
 #endif /* CONFIG_KVM_XICS */
 
+	stw	r12, STACK_SLOT_TRAP(r1)
 	mr 	r3, r12
 	/* Increment exit count, poke other threads to exit */
 	bl	kvmhv_commence_exit
 	nop
 	ld	r9, HSTATE_KVM_VCPU(r13)
-	lwz	r12, VCPU_TRAP(r9)
 
 	/* Stop others sending VCPU interrupts to this physical CPU */
 	li	r0, -1
@@ -1816,6 +1816,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_POWER9_DD1
 	 * POWER7/POWER8 guest -> host partition switch code.
 	 * We don't have to lock against tlbies but we do
 	 * have to coordinate the hardware threads.
+	 * Here STACK_SLOT_TRAP(r1) contains the trap number.
 	 */
 kvmhv_switch_to_host:
 	/* Secondary threads wait for primary to do partition switch */
@@ -1868,11 +1869,11 @@ BEGIN_FTR_SECTION
 END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 
 	/* If HMI, call kvmppc_realmode_hmi_handler() */
+	lwz	r12, STACK_SLOT_TRAP(r1)
 	cmpwi	r12, BOOK3S_INTERRUPT_HMI
 	bne	27f
 	bl	kvmppc_realmode_hmi_handler
 	nop
-	li	r12, BOOK3S_INTERRUPT_HMI
 	/*
 	 * At this point kvmppc_realmode_hmi_handler would have resync-ed
 	 * the TB. Hence it is not required to subtract guest timebase
@@ -1950,6 +1951,7 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_TYPE_R
 	li	r0, KVM_GUEST_MODE_NONE
 	stb	r0, HSTATE_IN_GUEST(r13)
 
+	lwz	r12, STACK_SLOT_TRAP(r1)	/* return trap # in r12 */
 	ld	r0, SFS+PPC_LR_STKOFF(r1)
 	addi	r1, r1, SFS
 	mtlr	r0
