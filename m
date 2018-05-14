Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZprdz7A435/mCq330BRXZYRRoY8XTPQ0oepkVaP51ppIWehVIsLz3W475qlYEORb9Serg8A
ARC-Seal: i=1; a=rsa-sha256; t=1526280874; cv=none;
        d=google.com; s=arc-20160816;
        b=0XXgccuz5lDWPcar9cnUfGL8MOv0hhuAuETd3xqAgHL/hAnDKe3AUyAfdF+gYelTXl
         OukeMKuMfgmNDZ0b904LSnKYuyIhs+d7gnLQgJB6KItDTITTbUO94r9f87efJyBlP2vW
         THPDVoGd9YgD+ipq7ZFOjo6yU952D7X0AcUT4BpY2MCugRDk3E2wf3bBpJ2HvkWy2eda
         r/K2c0Dto3B8IeOoc7lcoSyTRNZ91ioShBrpbDfb0BWZlVT+lUV71xDtfLKSJZzPUg3J
         8Ak+R21VjDOTaUfmwSo6MQkt7Wl6FEXU8qIlK7F+oefIRt1pe1HzByu4sdLNjc7Iv37J
         SEEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=xADEQwG9h/xpURrG1QCqBz6/UOZhWfFiVSpK2PeVhpA=;
        b=Cf+iEjbQQCAY+W7dbPcEVgK2qH7k7pwzw79SJDLcW1WdL2Ij+5l0rtei23IsS6nkbP
         E/mWyhWtxHs4epfae4kUKh8Wb3LY0Srh2Hw6TmtYsV/sX+MJ2Sl2AiZ3o3lRLVzaHB9e
         AWBpYW1xE/tRPsB8XEwHhj8bYlRIacaoXLR+SuViW0WJJRPGXWNoSBuXQE6mc3rR3KVN
         /p4GTKZoHleJFnMTXkNYKjT3Zffskkyam3NXCa2L6dtOWEbG6pDrqNv2TSrdVZHzhrcW
         AyuDi3kfLHwajpjdIUXPOCIb2A41lKvICacRKDEHL8v/KaLb+/SVNVasQi6FCvZmJwlm
         XT3A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=YbkjdIiv;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=YbkjdIiv;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH 4.9 14/36] KVM: PPC: Book3S HV: Fix trap number return from __kvmppc_vcore_entry
Date: Mon, 14 May 2018 08:48:48 +0200
Message-Id: <20180514064805.349609837@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064804.252823817@linuxfoundation.org>
References: <20180514064804.252823817@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421494023724143?=
X-GMAIL-MSGID: =?utf-8?q?1600421494023724143?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -299,7 +299,6 @@ kvm_novcpu_exit:
 	stw	r12, STACK_SLOT_TRAP(r1)
 	bl	kvmhv_commence_exit
 	nop
-	lwz	r12, STACK_SLOT_TRAP(r1)
 	b	kvmhv_switch_to_host
 
 /*
@@ -1023,6 +1022,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 
 secondary_too_late:
 	li	r12, 0
+	stw	r12, STACK_SLOT_TRAP(r1)
 	cmpdi	r4, 0
 	beq	11f
 	stw	r12, VCPU_TRAP(r4)
@@ -1266,12 +1266,12 @@ mc_cont:
 	bl	kvmhv_accumulate_time
 #endif
 
+	stw	r12, STACK_SLOT_TRAP(r1)
 	mr 	r3, r12
 	/* Increment exit count, poke other threads to exit */
 	bl	kvmhv_commence_exit
 	nop
 	ld	r9, HSTATE_KVM_VCPU(r13)
-	lwz	r12, VCPU_TRAP(r9)
 
 	/* Stop others sending VCPU interrupts to this physical CPU */
 	li	r0, -1
@@ -1549,6 +1549,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 	 * POWER7/POWER8 guest -> host partition switch code.
 	 * We don't have to lock against tlbies but we do
 	 * have to coordinate the hardware threads.
+	 * Here STACK_SLOT_TRAP(r1) contains the trap number.
 	 */
 kvmhv_switch_to_host:
 	/* Secondary threads wait for primary to do partition switch */
@@ -1599,11 +1600,11 @@ BEGIN_FTR_SECTION
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
@@ -1678,6 +1679,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 	li	r0, KVM_GUEST_MODE_NONE
 	stb	r0, HSTATE_IN_GUEST(r13)
 
+	lwz	r12, STACK_SLOT_TRAP(r1)	/* return trap # in r12 */
 	ld	r0, SFS+PPC_LR_STKOFF(r1)
 	addi	r1, r1, SFS
 	mtlr	r0
