Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226yRZ4FZxi/jDWq+w2uCs7cAO2/ELG8QCwPbkMr5BrAXwHzmmpw6AvD4PCIncL+qH3Hh73W
ARC-Seal: i=1; a=rsa-sha256; t=1517590852; cv=none;
        d=google.com; s=arc-20160816;
        b=JTGIJw2OStrHn11vjdXv43DYiwo3hQM805YjxdrG+BiQ0lHuBCsFIk/zinMdRtx1Vt
         ECp/id3EpH5zOnE/7Wog4beVgkSyC4xtyADFCa50G8H+x1/PF9RnpK6lx3lk5xkP1lCa
         to5lNZRDxT+pCgEhCXSMgFyJwrWY1ZtcYvlSfk1uAJscu/Tl6vUXGlKoq5z17rjehjk7
         7afi40vjzn+od+nGqfWhcap0ssnI3oik2y56ddqUqS6EfKKPpHIypppP8q0gGY5dXo15
         3aQQpv4Yrx+X1BskpU+GXDKhAyYz+jFH90EqWiof4VzWJHwemMQPcIkGCiJQYPT+QO2f
         GhLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=O2IHJiKDUb2EIL1IdEk2MbeeUj0fWokX+tB675MZbdw=;
        b=Q9aCe0Rg+uSuZfUMaoo+BSTLAv9+AXnKoyeLcj/pBcRG+tOeUpV+fTcHwhu43weX3c
         NueZC/quyeofGmkyTYoPADoJckiEKdd37jerZom+1FtxHLfPvp4tyP7vqVdwaRMAbupg
         r7NDeuhKFST4UiQOyeHg65cPMz3fdtOrEfS0b2JeN7EMPGQHKoi3TRHM45r87J8/Cnap
         WblFTkX7etKxaZwhyI4bVeGohaaAiM1mgIjRsEgu8QxkkwHNGOr8Pwg6nUc8fyXwvcXx
         3WFtBNqlghtGQc4yAM60SoXsy8IrxH1/w20bj6VDfrwvSQTOsgMq11IWBVogHyIGopnH
         kNlQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>,
	David Hildenbrand <david@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
	Nadav Amit <nadav.amit@gmail.com>,
	Wanpeng Li <wanpeng.li@hotmail.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 36/67] KVM: VMX: Fix rflags cache during vCPU reset
Date: Fri,  2 Feb 2018 17:58:05 +0100
Message-Id: <20180202140819.570874745@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
References: <20180202140815.091718203@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309345660400496?=
X-GMAIL-MSGID: =?utf-8?q?1591309345660400496?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wanpeng Li <wanpeng.li@hotmail.com>


[ Upstream commit c37c28730bb031cc8a44a130c2555c0f3efbe2d0 ]

Reported by syzkaller:

   *** Guest State ***
   CR0: actual=0x0000000080010031, shadow=0x0000000060000010, gh_mask=fffffffffffffff7
   CR4: actual=0x0000000000002061, shadow=0x0000000000000000, gh_mask=ffffffffffffe8f1
   CR3 = 0x000000002081e000
   RSP = 0x000000000000fffa  RIP = 0x0000000000000000
   RFLAGS=0x00023000         DR7 = 0x00000000000000
          ^^^^^^^^^^
   ------------[ cut here ]------------
   WARNING: CPU: 6 PID: 24431 at /home/kernel/linux/arch/x86/kvm//x86.c:7302 kvm_arch_vcpu_ioctl_run+0x651/0x2ea0 [kvm]
   CPU: 6 PID: 24431 Comm: reprotest Tainted: G        W  OE   4.14.0+ #26
   RIP: 0010:kvm_arch_vcpu_ioctl_run+0x651/0x2ea0 [kvm]
   RSP: 0018:ffff880291d179e0 EFLAGS: 00010202
   Call Trace:
    kvm_vcpu_ioctl+0x479/0x880 [kvm]
    do_vfs_ioctl+0x142/0x9a0
    SyS_ioctl+0x74/0x80
    entry_SYSCALL_64_fastpath+0x23/0x9a

The failed vmentry is triggered by the following beautified testcase:

    #include <unistd.h>
    #include <sys/syscall.h>
    #include <string.h>
    #include <stdint.h>
    #include <linux/kvm.h>
    #include <fcntl.h>
    #include <sys/ioctl.h>

    long r[5];
    int main()
    {
        struct kvm_debugregs dr = { 0 };

        r[2] = open("/dev/kvm", O_RDONLY);
        r[3] = ioctl(r[2], KVM_CREATE_VM, 0);
        r[4] = ioctl(r[3], KVM_CREATE_VCPU, 7);
        struct kvm_guest_debug debug = {
                .control = 0xf0403,
                .arch = {
                        .debugreg[6] = 0x2,
                        .debugreg[7] = 0x2
                }
        };
        ioctl(r[4], KVM_SET_GUEST_DEBUG, &debug);
        ioctl(r[4], KVM_RUN, 0);
    }

which testcase tries to setup the processor specific debug
registers and configure vCPU for handling guest debug events through
KVM_SET_GUEST_DEBUG.  The KVM_SET_GUEST_DEBUG ioctl will get and set
rflags in order to set TF bit if single step is needed. All regs' caches
are reset to avail and GUEST_RFLAGS vmcs field is reset to 0x2 during vCPU
reset. However, the cache of rflags is not reset during vCPU reset. The
function vmx_get_rflags() returns an unreset rflags cache value since
the cache is marked avail, it is 0 after boot. Vmentry fails if the
rflags reserved bit 1 is 0.

This patch fixes it by resetting both the GUEST_RFLAGS vmcs field and
its cache to 0x2 during vCPU reset.

Reported-by: Dmitry Vyukov <dvyukov@google.com>
Tested-by: Dmitry Vyukov <dvyukov@google.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Nadav Amit <nadav.amit@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Wanpeng Li <wanpeng.li@hotmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/vmx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -4954,7 +4954,7 @@ static void vmx_vcpu_reset(struct kvm_vc
 		vmcs_write64(GUEST_IA32_DEBUGCTL, 0);
 	}
 
-	vmcs_writel(GUEST_RFLAGS, 0x02);
+	kvm_set_rflags(vcpu, X86_EFLAGS_FIXED);
 	kvm_rip_write(vcpu, 0xfff0);
 
 	vmcs_writel(GUEST_GDTR_BASE, 0);
