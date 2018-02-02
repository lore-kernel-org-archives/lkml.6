Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2261LE5ahtkNDx0a/2lVc4HROHde4JwZkISxfQvhftn+L2Y4eKGup0eJPHVG7FA/ifoam5nq
ARC-Seal: i=1; a=rsa-sha256; t=1517591059; cv=none;
        d=google.com; s=arc-20160816;
        b=e3gt47hGzM/3rZYo7WITseB9betKmp6O9cPVjW+wrRmEZTsOrFGEnexKhsS5mQHQi1
         RWc1RDgZZtR09CGrfGwjeh5YQvcHKWR5q0gFB2Hzp1fX2YQIO2dlaMsZ7oFSv9xE9J1e
         xX645fFiCduK4wURknf1AQIRvEej2xT/m10SlKrRSe2n/2ybUWGFNDVrkHUfMTkAE5mV
         djw7HnkUGGL2eCTK1nOnRrWeh6qbBZvmTTPyI7kgmhkeUw1b1AapBo1I2Td7YVkjSsTW
         duIZUhHpxRemXPD6THDu3BBAHJW1HUhcaTlcMscnUvYsrvbxxrOKZbz00+QD2669rCpz
         njiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=VxA9EAacwlpZXWWzbZCxI7p75iRcrxu2MU0KjBlMyWc=;
        b=bym7aLrgBtxV+qoE6ptuQh46heih3Bi3EAptTNyGGpwPbswVANk8yNp9L8u8ctAzeh
         Wh5KGwfRwXasd0zdVodPKRxjzcX334wH2e5lu/76OEQDmjHJfNlvkcnvciF7jyWSRmEX
         DeUDD/Vg3aRnDFHM2MOrK/Vp3XqDcfnxTEvxD2qRFbLUmSlONeg+WBbomvwwvgwVuffi
         HwLVr1bHyAOkqjN2fB6qed+P+emirlKtys+eXgtty7R5oOWKW76HNlsXcKxy574i6fV9
         +yrGnoc4DYjI/pKpf9I+JUajlMNAwWnBKtiwDcidcZAb8ZexhwVAprCa5RWpNc9F9E09
         YRtw==
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
Subject: [PATCH 4.9 37/86] KVM: VMX: Fix rflags cache during vCPU reset
Date: Fri,  2 Feb 2018 17:57:57 +0100
Message-Id: <20180202140825.916075600@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309345660400496?=
X-GMAIL-MSGID: =?utf-8?q?1591309562695021988?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -5194,7 +5194,7 @@ static void vmx_vcpu_reset(struct kvm_vc
 		vmcs_write64(GUEST_IA32_DEBUGCTL, 0);
 	}
 
-	vmcs_writel(GUEST_RFLAGS, 0x02);
+	kvm_set_rflags(vcpu, X86_EFLAGS_FIXED);
 	kvm_rip_write(vcpu, 0xfff0);
 
 	vmcs_writel(GUEST_GDTR_BASE, 0);
