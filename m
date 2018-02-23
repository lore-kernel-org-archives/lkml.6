Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuBtVe5CO1kOQk0yOrd8dct9POWENKdLrhbLdwjZQvXSCWVJO+fWg72jw246pH0N2l+wzmO
ARC-Seal: i=1; a=rsa-sha256; t=1519411773; cv=none;
        d=google.com; s=arc-20160816;
        b=QI9BXuW2FwiZpChij8jxVTZ/qXER4zU4qjf5kBeECY9ntMErskckxwXStnLcBXvl+g
         Ip2DEc/X/d9xYe0T5MJAfwuMX24Ynn6TMh6vrfLOpIJt7YZsYs5JWm3yF8atKxvS9aOl
         5F4nWrZJZWFnrA541tQzpjazYRspwuKSyc3Ll9javN+9W+gC+4tkVu9KtRPXoiUCtFxr
         +GvYgRTxUlgYr6yQUexMUqELHEbeRHfbA5w09pId9fTjWE/vsyoHDGScIM4N+WI1ZP9W
         fPVak//Bjmal43zLgBiVvbLAX2LSRWo8RaOMPD150jWWCjM3+U7oqeJPk+bZFHVLm63u
         dqfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=y/hHLmxdEv4E5n8kDLRCz7ApTZsY6Pu67PxxLCNRF4A=;
        b=HlFDLP7j2fGv9LKyG7rYWtGTlODcVVipuKwX9C/t2uXPwxMFtrNDUZqBDwJNXQUv6Y
         CPTInE/8fFGbBhdhL2ExTQQzIjNU3gGzL8FPjfpTDY97WTnRrXZwNRwQ7r71OxSx0VUx
         AheX/5O4cL0w+0jcqcwwdla853CauJZF4XTwShUnFijqPy3/RANDX/RdwHH9hrIKDVU5
         Kaam0v05UARC8UDw2uMihn/g5k5V1ByUN1QmP6w7Y5zif43lZRf6MOIT+bIO1Qnn2izB
         XIcDDbizc2BffVC6ms4F3qM64IT1UQEs5LacEacf4dX8MmNrHwbTQ9coDcYGUtLXiZDU
         PGIg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	Tianyu Lan <tianyu.lan@intel.com>
Subject: [PATCH 4.14 013/159] KVM/x86: Check input paging mode when cs.l is set
Date: Fri, 23 Feb 2018 19:25:21 +0100
Message-Id: <20180223170744.825739286@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218720259279657?=
X-GMAIL-MSGID: =?utf-8?q?1593218720259279657?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lan Tianyu <tianyu.lan@intel.com>

commit f29810335965ac1f7bcb501ee2af5f039f792416 upstream.

Reported by syzkaller:
    WARNING: CPU: 0 PID: 27962 at arch/x86/kvm/emulate.c:5631 x86_emulate_insn+0x557/0x15f0 [kvm]
    Modules linked in: kvm_intel kvm [last unloaded: kvm]
    CPU: 0 PID: 27962 Comm: syz-executor Tainted: G    B   W        4.15.0-rc2-next-20171208+ #32
    Hardware name: Intel Corporation S1200SP/S1200SP, BIOS S1200SP.86B.01.03.0006.040720161253 04/07/2016
    RIP: 0010:x86_emulate_insn+0x557/0x15f0 [kvm]
    RSP: 0018:ffff8807234476d0 EFLAGS: 00010282
    RAX: 0000000000000000 RBX: ffff88072d0237a0 RCX: ffffffffa0065c4d
    RDX: 1ffff100e5a046f9 RSI: 0000000000000003 RDI: ffff88072d0237c8
    RBP: ffff880723447728 R08: ffff88072d020000 R09: ffffffffa008d240
    R10: 0000000000000002 R11: ffffed00e7d87db3 R12: ffff88072d0237c8
    R13: ffff88072d023870 R14: ffff88072d0238c2 R15: ffffffffa008d080
    FS:  00007f8a68666700(0000) GS:ffff880802200000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: 000000002009506c CR3: 000000071fec4005 CR4: 00000000003626f0
    Call Trace:
     x86_emulate_instruction+0x3bc/0xb70 [kvm]
     ? reexecute_instruction.part.162+0x130/0x130 [kvm]
     vmx_handle_exit+0x46d/0x14f0 [kvm_intel]
     ? trace_event_raw_event_kvm_entry+0xe7/0x150 [kvm]
     ? handle_vmfunc+0x2f0/0x2f0 [kvm_intel]
     ? wait_lapic_expire+0x25/0x270 [kvm]
     vcpu_enter_guest+0x720/0x1ef0 [kvm]
     ...

When CS.L is set, vcpu should run in the 64 bit paging mode.
Current kvm set_sregs function doesn't have such check when
userspace inputs sreg values. This will lead unexpected behavior.
This patch is to add checks for CS.L, EFER.LME, EFER.LMA and
CR4.PAE when get SREG inputs from userspace in order to avoid
unexpected behavior.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Jim Mattson <jmattson@google.com>
Signed-off-by: Tianyu Lan <tianyu.lan@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/x86.c |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7474,6 +7474,29 @@ int kvm_task_switch(struct kvm_vcpu *vcp
 }
 EXPORT_SYMBOL_GPL(kvm_task_switch);
 
+int kvm_valid_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
+{
+	if ((sregs->efer & EFER_LME) && (sregs->cr0 & X86_CR0_PG_BIT)) {
+		/*
+		 * When EFER.LME and CR0.PG are set, the processor is in
+		 * 64-bit mode (though maybe in a 32-bit code segment).
+		 * CR4.PAE and EFER.LMA must be set.
+		 */
+		if (!(sregs->cr4 & X86_CR4_PAE_BIT)
+		    || !(sregs->efer & EFER_LMA))
+			return -EINVAL;
+	} else {
+		/*
+		 * Not in 64-bit mode: EFER.LMA is clear and the code
+		 * segment cannot be 64-bit.
+		 */
+		if (sregs->efer & EFER_LMA || sregs->cs.l)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
 int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
 				  struct kvm_sregs *sregs)
 {
@@ -7486,6 +7509,9 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct
 			(sregs->cr4 & X86_CR4_OSXSAVE))
 		return -EINVAL;
 
+	if (kvm_valid_sregs(vcpu, sregs))
+		return -EINVAL;
+
 	apic_base_msr.data = sregs->apic_base;
 	apic_base_msr.host_initiated = true;
 	if (kvm_set_apic_base(vcpu, &apic_base_msr))
