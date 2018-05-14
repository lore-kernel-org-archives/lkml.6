Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZq6XZjYQdGsSmPHP/7GMKrpImThKLgImVfngD0FyB/o/enyHcV6QAuevFWCODFS3Gi1WvJX
ARC-Seal: i=1; a=rsa-sha256; t=1526280935; cv=none;
        d=google.com; s=arc-20160816;
        b=Qr5cWHiG6sH4jdcjVEgugTf+ZrczXqFfJqD/VRtwq2Tq3GB7GZJcZuYPyFHZF121Mk
         v77lyFtAUwLRYT99dYFUntPpdR9j5a+5oKhSKM2amykiUpzDNqsoadGLxzR/Act9Ovpv
         0ejYF76uLaXfFS8GzVIca8589vDBrwjymqCIkBDCw+D0KI3GqHhFPnu5JGAEfsjlJAmJ
         Z5rIUtVMH1TAKsrhXKSMv6lQIT2oJvtY2ku7Ayb0tgnhsV/wbIlUdLKQbqkTxh+gcHej
         gMj2pjbXzXBGKD61AGRF93ZUhgrefMfMPp0iSfGmRcYXiUxQgpahe9VOY6rdvtbe/lTv
         CJhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=OV3m0gQlJ3lNr+jcoiAPbYcPK7XeG5HBxnz2BhyyFsg=;
        b=vPv+fGkDYmzMVmPXIKtM0f1K4IJ8i3aTzbcNVXfchOlCFXF1WTEr0hh3C29hOp8uqP
         Y3oTcqHuxa20Us+wU+DcuS1QTyjLWCy5I4XBWUFhIwOfiME7c+CuTuYG3gzifzysnD/r
         YzXwb9TogpI2kVkU/By2zd8UIbU24rkR7e3Ujf12r++sDu++pItX7yZNofpcNpbsh0fZ
         3pNAi9z6H/oBVjwScG64avvxNmy+4zx0JnZ+1sC3ADDEy30P6RLgowTdxIZU+ZxycFV5
         2rmHT87QE4SAtCsNtAWaWQwjAht4CrIyNUc5MLFHAYT3oa+8JWkgcBF0U9s1Z8huQHvW
         h3nw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=JUwWT4No;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=JUwWT4No;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Laurent Vivier <lvivier@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH 4.14 19/62] KVM: PPC: Book3S HV: Fix guest time accounting with VIRT_CPU_ACCOUNTING_GEN
Date: Mon, 14 May 2018 08:48:35 +0200
Message-Id: <20180514064817.473327191@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064816.436958006@linuxfoundation.org>
References: <20180514064816.436958006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421558291042870?=
X-GMAIL-MSGID: =?utf-8?q?1600421558291042870?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Laurent Vivier <lvivier@redhat.com>

commit 61bd0f66ff92d5ce765ff9850fd3cbfec773c560 upstream.

Since commit 8b24e69fc47e ("KVM: PPC: Book3S HV: Close race with testing
for signals on guest entry"), if CONFIG_VIRT_CPU_ACCOUNTING_GEN is set, the
guest time is not accounted to guest time and user time, but instead to
system time.

This is because guest_enter()/guest_exit() are called while interrupts
are disabled and the tick counter cannot be updated between them.

To fix that, move guest_exit() after local_irq_enable(), and as
guest_enter() is called with IRQ disabled, call guest_enter_irqoff()
instead.

Fixes: 8b24e69fc47e ("KVM: PPC: Book3S HV: Close race with testing for signals on guest entry")
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kvm/book3s_hv.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -2847,7 +2847,7 @@ static noinline void kvmppc_run_core(str
 	 */
 	trace_hardirqs_on();
 
-	guest_enter();
+	guest_enter_irqoff();
 
 	srcu_idx = srcu_read_lock(&vc->kvm->srcu);
 
@@ -2855,8 +2855,6 @@ static noinline void kvmppc_run_core(str
 
 	srcu_read_unlock(&vc->kvm->srcu, srcu_idx);
 
-	guest_exit();
-
 	trace_hardirqs_off();
 	set_irq_happened(trap);
 
@@ -2890,6 +2888,7 @@ static noinline void kvmppc_run_core(str
 	kvmppc_set_host_core(pcpu);
 
 	local_irq_enable();
+	guest_exit();
 
 	/* Let secondaries go back to the offline loop */
 	for (i = 0; i < controlled_threads; ++i) {
