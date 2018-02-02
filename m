Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225NpRFTk+RVVsOfm9vFuJhEgyk1ujMT74HfOq//rT6iRdJhjUAVsfzUcs3PrpXq2n2DLEgP
ARC-Seal: i=1; a=rsa-sha256; t=1517591434; cv=none;
        d=google.com; s=arc-20160816;
        b=dNeMCUuYUOxWYlNqwSvFNYQZCQTEEk3+3FAYP8nwjZ3ah7CCquUMEhPn76rZcmvRQJ
         8C4FPISv/tAAYqDZMtlpdmIHvvoYiIWy0nn2OvrSmfJQD65Of63Y90wmcvErpduKVEQ7
         06CCii/WblTgj4i37+vzumvqAOyib5PF0vMxfvLOoyccnQR9QivGp9EyNxDemPkPV+TI
         ueOK51aGRpvGJtZhlIV7Y6iVyyVlI3tio2M7nZiJrFWe0juxo2Bwgk9i/08j2Qv3nI71
         BOYxKMmQVMnOQS2AtNw9tFOXnypmntZUDGwRXf7DfHiySpfXzV0WFC3PS637+NmRd4tQ
         7SWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9I7dL3wFRXl1DGQh8G2z4ahg+GqVfbJ6a1dygELdvYU=;
        b=nz5afqwvzGddLHF1u7YMJeAQkJ8bkiJ5Dt0eY7TXEP0C4od50k1VfWB5JzL/vS41hP
         qdn+3px1qV9HnpWudmqzs32ZG25uKmxpDIehV6dVJYpWN7XuCKXZgFnZA3J9WH5jDqPC
         juf5EtOwVdrAAoCv35GTDxn0JU/FsNw3+HjT7eJomTjiu/n2YDVzSXOLRWu1jbm7Q7Al
         A3xUD0N+14VPE0vgI0E9cZxx7qPRSJp3Zt3Gm2iYwRflpCGlIseHvWGXy6i4a+nMi9so
         G+eJymis2G5vZymf+zwAGqsZF5oHUag6FCEP4jdqwQkGSdrd9Q+Wny6diQrij9INEb1D
         jJAA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"=?UTF-8?q?Jan=20H . =20Sch=C3=83=C2=B6nherr?=" <jschoenh@amazon.de>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 079/156] KVM: Let KVM_SET_SIGNAL_MASK work as advertised
Date: Fri,  2 Feb 2018 17:57:40 +0100
Message-Id: <20180202140843.850667669@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309955828632489?=
X-GMAIL-MSGID: =?utf-8?q?1591309955828632489?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Jan H. Sch�nherr" <jschoenh@amazon.de>


[ Upstream commit 20b7035c66bacc909ae3ffe92c1a1ea7db99fe4f ]

KVM API says for the signal mask you set via KVM_SET_SIGNAL_MASK, that
"any unblocked signal received [...] will cause KVM_RUN to return with
-EINTR" and that "the signal will only be delivered if not blocked by
the original signal mask".

This, however, is only true, when the calling task has a signal handler
registered for a signal. If not, signal evaluation is short-circuited for
SIG_IGN and SIG_DFL, and the signal is either ignored without KVM_RUN
returning or the whole process is terminated.

Make KVM_SET_SIGNAL_MASK behave as advertised by utilizing logic similar
to that in do_sigtimedwait() to avoid short-circuiting of signals.

Signed-off-by: Jan H. SchÃ¶nherr <jschoenh@amazon.de>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/kvm/mips.c       |    7 ++-----
 arch/powerpc/kvm/powerpc.c |    7 ++-----
 arch/s390/kvm/kvm-s390.c   |    7 ++-----
 arch/x86/kvm/x86.c         |    7 ++-----
 include/linux/kvm_host.h   |    3 +++
 virt/kvm/arm/arm.c         |    8 +++-----
 virt/kvm/kvm_main.c        |   23 +++++++++++++++++++++++
 7 files changed, 37 insertions(+), 25 deletions(-)

--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -445,10 +445,8 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(
 int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
 	int r = -EINTR;
-	sigset_t sigsaved;
 
-	if (vcpu->sigset_active)
-		sigprocmask(SIG_SETMASK, &vcpu->sigset, &sigsaved);
+	kvm_sigset_activate(vcpu);
 
 	if (vcpu->mmio_needed) {
 		if (!vcpu->mmio_is_write)
@@ -480,8 +478,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_v
 	local_irq_enable();
 
 out:
-	if (vcpu->sigset_active)
-		sigprocmask(SIG_SETMASK, &sigsaved, NULL);
+	kvm_sigset_deactivate(vcpu);
 
 	return r;
 }
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -1407,7 +1407,6 @@ int kvm_vcpu_ioctl_set_one_reg(struct kv
 int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
 	int r;
-	sigset_t sigsaved;
 
 	if (vcpu->mmio_needed) {
 		vcpu->mmio_needed = 0;
@@ -1448,16 +1447,14 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_v
 #endif
 	}
 
-	if (vcpu->sigset_active)
-		sigprocmask(SIG_SETMASK, &vcpu->sigset, &sigsaved);
+	kvm_sigset_activate(vcpu);
 
 	if (run->immediate_exit)
 		r = -EINTR;
 	else
 		r = kvmppc_vcpu_run(run, vcpu);
 
-	if (vcpu->sigset_active)
-		sigprocmask(SIG_SETMASK, &sigsaved, NULL);
+	kvm_sigset_deactivate(vcpu);
 
 	return r;
 }
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3378,7 +3378,6 @@ static void store_regs(struct kvm_vcpu *
 int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 {
 	int rc;
-	sigset_t sigsaved;
 
 	if (kvm_run->immediate_exit)
 		return -EINTR;
@@ -3388,8 +3387,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_v
 		return 0;
 	}
 
-	if (vcpu->sigset_active)
-		sigprocmask(SIG_SETMASK, &vcpu->sigset, &sigsaved);
+	kvm_sigset_activate(vcpu);
 
 	if (!kvm_s390_user_cpu_state_ctrl(vcpu->kvm)) {
 		kvm_s390_vcpu_start(vcpu);
@@ -3423,8 +3421,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_v
 	disable_cpu_timer_accounting(vcpu);
 	store_regs(vcpu, kvm_run);
 
-	if (vcpu->sigset_active)
-		sigprocmask(SIG_SETMASK, &sigsaved, NULL);
+	kvm_sigset_deactivate(vcpu);
 
 	vcpu->stat.exit_userspace++;
 	return rc;
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7245,12 +7245,10 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_v
 {
 	struct fpu *fpu = &current->thread.fpu;
 	int r;
-	sigset_t sigsaved;
 
 	fpu__initialize(fpu);
 
-	if (vcpu->sigset_active)
-		sigprocmask(SIG_SETMASK, &vcpu->sigset, &sigsaved);
+	kvm_sigset_activate(vcpu);
 
 	if (unlikely(vcpu->arch.mp_state == KVM_MP_STATE_UNINITIALIZED)) {
 		if (kvm_run->immediate_exit) {
@@ -7293,8 +7291,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_v
 
 out:
 	post_kvm_run_save(vcpu);
-	if (vcpu->sigset_active)
-		sigprocmask(SIG_SETMASK, &sigsaved, NULL);
+	kvm_sigset_deactivate(vcpu);
 
 	return r;
 }
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -714,6 +714,9 @@ int kvm_vcpu_write_guest(struct kvm_vcpu
 			 unsigned long len);
 void kvm_vcpu_mark_page_dirty(struct kvm_vcpu *vcpu, gfn_t gfn);
 
+void kvm_sigset_activate(struct kvm_vcpu *vcpu);
+void kvm_sigset_deactivate(struct kvm_vcpu *vcpu);
+
 void kvm_vcpu_block(struct kvm_vcpu *vcpu);
 void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu);
 void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu);
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -612,7 +612,6 @@ static void check_vcpu_requests(struct k
 int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
 	int ret;
-	sigset_t sigsaved;
 
 	if (unlikely(!kvm_vcpu_initialized(vcpu)))
 		return -ENOEXEC;
@@ -630,8 +629,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_v
 	if (run->immediate_exit)
 		return -EINTR;
 
-	if (vcpu->sigset_active)
-		sigprocmask(SIG_SETMASK, &vcpu->sigset, &sigsaved);
+	kvm_sigset_activate(vcpu);
 
 	ret = 1;
 	run->exit_reason = KVM_EXIT_UNKNOWN;
@@ -753,8 +751,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_v
 		kvm_pmu_update_run(vcpu);
 	}
 
-	if (vcpu->sigset_active)
-		sigprocmask(SIG_SETMASK, &sigsaved, NULL);
+	kvm_sigset_deactivate(vcpu);
+
 	return ret;
 }
 
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2073,6 +2073,29 @@ void kvm_vcpu_mark_page_dirty(struct kvm
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_mark_page_dirty);
 
+void kvm_sigset_activate(struct kvm_vcpu *vcpu)
+{
+	if (!vcpu->sigset_active)
+		return;
+
+	/*
+	 * This does a lockless modification of ->real_blocked, which is fine
+	 * because, only current can change ->real_blocked and all readers of
+	 * ->real_blocked don't care as long ->real_blocked is always a subset
+	 * of ->blocked.
+	 */
+	sigprocmask(SIG_SETMASK, &vcpu->sigset, &current->real_blocked);
+}
+
+void kvm_sigset_deactivate(struct kvm_vcpu *vcpu)
+{
+	if (!vcpu->sigset_active)
+		return;
+
+	sigprocmask(SIG_SETMASK, &current->real_blocked, NULL);
+	sigemptyset(&current->real_blocked);
+}
+
 static void grow_halt_poll_ns(struct kvm_vcpu *vcpu)
 {
 	unsigned int old, val, grow;
