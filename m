Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuNNjxubA2MTL2QVRp0U6JIwuSsJmM2+KNpdZ80ov/tSpIrfeYEbr1avXo/Fst8GsOH7HUE
ARC-Seal: i=1; a=rsa-sha256; t=1520452114; cv=none;
        d=google.com; s=arc-20160816;
        b=dTCH05Kc0ozIRCOaCkn5FYc394a/WrfbUaLBvUx7DQFTHlLOF+ngfZllSYQGszCPHF
         uiLKcapEQRinOOwTyU94XeHnMm2mKUbsk6ISqm41hR6bkj90TnOpvObU+ZCAp/08g1C2
         rmFiMa9YIyNfVo5Jhyj46NcYXl9G0upDezY+pxXWrn4jHYSisQ/Hu1zaKWIqUxIWjqDO
         FArl3o1aohRqqpkEQjq9v708FXueVtmy01KpxEwsKMtyhD8lB0xFtSBkCxcObATNklgE
         vdEJrDb9tXaiBSmNFiC7H0rIKzwgKwsrmrlbN8F0OR4Fs4ABb82IPR/GRp3dy6iwLvRz
         F4Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=vsBQEygZNPOyuG+/zDkH0bhzxW9EHHqqTwtHrfI+2TI=;
        b=JdDM/yxYgGmk7IjJVSV+ubiQkuf74LAetv15yI3e1IJjMm1phGVMe7WSLK/AhKxUne
         itwXQlzoryQZowxZi3UVeCWDIZFqAO18gautsfkna7DbAVjwXmf1sNIat6g7aAr32+EX
         MGv2tWIOuREF4IacHrxfhnKlFutZMqulSeFffToTpPvyeviDhhxFKXVovRLAKsJ8/N09
         OPlxISLM3HcsWDw6/bAoUWU3mB6j0z2j3tfuNS6FFiPUX60Po0Ob/ANEUVurzlHW9kLT
         cFglFgNP+Wz+vn7h8qW86vAOa3lsdA5OPX3maXANE7ga4vH/YI50WnAMZ7igxJFYHhg2
         1aPw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+c1d9517cab094dae65e446c0c5b4de6c40f4dc58@syzkaller.appspotmail.com,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
	Wanpeng Li <wanpengli@tencent.com>
Subject: [PATCH 4.14 097/110] KVM: X86: Fix SMRAM accessing even if VM is shutdown
Date: Wed,  7 Mar 2018 11:39:20 -0800
Message-Id: <20180307191052.275050264@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309322777209417?=
X-GMAIL-MSGID: =?utf-8?q?1594309595900070594?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wanpeng Li <wanpengli@tencent.com>

commit 95e057e25892eaa48cad1e2d637b80d0f1a4fac5 upstream.

Reported by syzkaller:

   WARNING: CPU: 6 PID: 2434 at arch/x86/kvm/vmx.c:6660 handle_ept_misconfig+0x54/0x1e0 [kvm_intel]
   CPU: 6 PID: 2434 Comm: repro_test Not tainted 4.15.0+ #4
   RIP: 0010:handle_ept_misconfig+0x54/0x1e0 [kvm_intel]
   Call Trace:
    vmx_handle_exit+0xbd/0xe20 [kvm_intel]
    kvm_arch_vcpu_ioctl_run+0xdaf/0x1d50 [kvm]
    kvm_vcpu_ioctl+0x3e9/0x720 [kvm]
    do_vfs_ioctl+0xa4/0x6a0
    SyS_ioctl+0x79/0x90
    entry_SYSCALL_64_fastpath+0x25/0x9c

The testcase creates a first thread to issue KVM_SMI ioctl, and then creates
a second thread to mmap and operate on the same vCPU.  This triggers a race
condition when running the testcase with multiple threads. Sometimes one thread
exits with a triple fault while another thread mmaps and operates on the same
vCPU.  Because CS=0x3000/IP=0x8000 is not mapped, accessing the SMI handler
results in an EPT misconfig. This patch fixes it by returning RET_PF_EMULATE
in kvm_handle_bad_page(), which will go on to cause an emulation failure and an
exit with KVM_EXIT_INTERNAL_ERROR.

Reported-by: syzbot+c1d9517cab094dae65e446c0c5b4de6c40f4dc58@syzkaller.appspotmail.com
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/mmu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -3017,7 +3017,7 @@ static int kvm_handle_bad_page(struct kv
 		return RET_PF_RETRY;
 	}
 
-	return -EFAULT;
+	return RET_PF_EMULATE;
 }
 
 static void transparent_hugepage_adjust(struct kvm_vcpu *vcpu,
