Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225AhxAV0sUvmINdEtDAypwO8VVPLVM6+Xpa6tuV7UlRBXoarlYzvb8PBqyJizu+hbi5dmTZ
ARC-Seal: i=1; a=rsa-sha256; t=1518708951; cv=none;
        d=google.com; s=arc-20160816;
        b=V6qNatJ7tiHsuboij1YmLAjE9AVEHlhsgcnP9573UN8iQvzPN+SqkDLzV6ca2pVdfw
         t64NC7ZuUEe0RBqwqs5fJyRUe5X46o2D7Lv/pUR8nbF9v1Cpg2y8dPt7VteYd8kBSQQh
         fcRCePepF3CLcTfXCAMN1L5Lyra13OjJ/1/Bn0ecCCKsMwlarndnloBIFEwPDL189l/t
         Zy5WcbwLmmTSqOzbFwk3qnta8anbzFSMta2BUs06zoByz8p8WBl6TeF71wngYLmdnw99
         8RvDc08BSNbuGnvS56sSQZfhLKznBGaXWIkU2G5H4uee9TZ6TPZpKxfoFt2RVE5CnsBD
         LOeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=WtfzdQ11VVM02uaznCl0gR1c0xCfq1MAdNS3Ofzu+hI=;
        b=ym339QQKmGUePYr61Fiw5hElSwb5ZjNn19wtleIxHjXwNaq4VHGMS5CWcrz8fj/gNu
         7fjLz7fEUgXaMhWmFmL89h7o6mv8qUxnOlzAJYp6EulwsRR3hYrc7s0fA2QbOBb10Yn1
         lKiye8PCaq37DRvgzW9MIOo5YfnNNEqrpUCBEUUnQpIx1GYpCtv6RRm0DfFM595rruAp
         vMPdwYfRV8dMTAlJ4Mu90uXbYr1beOkrAT7Jj1qUtIcKZXSYJ7+t0H3DLHqZKfJbR6Pb
         LgvvjVBm42UefD0tbDPFNcv/kvNKTBwDmFpqlHnCnztPy1fZq26yoCkg1GeawG06DX8l
         AOkg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH 4.14 139/195] KVM: PPC: Book3S HV: Make sure we dont re-enter guest without XIVE loaded
Date: Thu, 15 Feb 2018 16:17:10 +0100
Message-Id: <20180215151712.739402113@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481757453918742?=
X-GMAIL-MSGID: =?utf-8?q?1592481757453918742?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Mackerras <paulus@ozlabs.org>

commit 43ff3f65234061e08d234bdef5a9aadc19832b74 upstream.

This fixes a bug where it is possible to enter a guest on a POWER9
system without having the XIVE (interrupt controller) context loaded.
This can happen because we unload the XIVE context from the CPU
before doing the real-mode handling for machine checks.  After the
real-mode handler runs, it is possible that we re-enter the guest
via a fast path which does not load the XIVE context.

To fix this, we move the unloading of the XIVE context to come after
the real-mode machine check handler is called.

Fixes: 5af50993850a ("KVM: PPC: Book3S HV: Native usage of the XIVE interrupt controller")
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kvm/book3s_hv_rmhandlers.S |   40 ++++++++++++++++----------------
 1 file changed, 20 insertions(+), 20 deletions(-)

--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -1387,6 +1387,26 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
 	blt	deliver_guest_interrupt
 
 guest_exit_cont:		/* r9 = vcpu, r12 = trap, r13 = paca */
+	/* Save more register state  */
+	mfdar	r6
+	mfdsisr	r7
+	std	r6, VCPU_DAR(r9)
+	stw	r7, VCPU_DSISR(r9)
+	/* don't overwrite fault_dar/fault_dsisr if HDSI */
+	cmpwi	r12,BOOK3S_INTERRUPT_H_DATA_STORAGE
+	beq	mc_cont
+	std	r6, VCPU_FAULT_DAR(r9)
+	stw	r7, VCPU_FAULT_DSISR(r9)
+
+	/* See if it is a machine check */
+	cmpwi	r12, BOOK3S_INTERRUPT_MACHINE_CHECK
+	beq	machine_check_realmode
+mc_cont:
+#ifdef CONFIG_KVM_BOOK3S_HV_EXIT_TIMING
+	addi	r3, r9, VCPU_TB_RMEXIT
+	mr	r4, r9
+	bl	kvmhv_accumulate_time
+#endif
 #ifdef CONFIG_KVM_XICS
 	/* We are exiting, pull the VP from the XIVE */
 	lwz	r0, VCPU_XIVE_PUSHED(r9)
@@ -1424,26 +1444,6 @@ guest_exit_cont:		/* r9 = vcpu, r12 = tr
 	eieio
 1:
 #endif /* CONFIG_KVM_XICS */
-	/* Save more register state  */
-	mfdar	r6
-	mfdsisr	r7
-	std	r6, VCPU_DAR(r9)
-	stw	r7, VCPU_DSISR(r9)
-	/* don't overwrite fault_dar/fault_dsisr if HDSI */
-	cmpwi	r12,BOOK3S_INTERRUPT_H_DATA_STORAGE
-	beq	mc_cont
-	std	r6, VCPU_FAULT_DAR(r9)
-	stw	r7, VCPU_FAULT_DSISR(r9)
-
-	/* See if it is a machine check */
-	cmpwi	r12, BOOK3S_INTERRUPT_MACHINE_CHECK
-	beq	machine_check_realmode
-mc_cont:
-#ifdef CONFIG_KVM_BOOK3S_HV_EXIT_TIMING
-	addi	r3, r9, VCPU_TB_RMEXIT
-	mr	r4, r9
-	bl	kvmhv_accumulate_time
-#endif
 
 	mr 	r3, r12
 	/* Increment exit count, poke other threads to exit */
