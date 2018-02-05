Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224TUjW923MlkwT/ywUB4Pm+qGN7J72UBXbN28SeNMvzdKQ1tJysCCEAFS8vgdVblw5uqYq5
ARC-Seal: i=1; a=rsa-sha256; t=1517855175; cv=none;
        d=google.com; s=arc-20160816;
        b=ynTien2wnuBBLLWwfRIVX/deCB28FlLcab8j6AuvqPhl2tnbw2aSRdPMT7Slt5GcdZ
         AeIdNhKqvLmcUZbMoH7u39YUQzZg+W/Q7dygCHDsBfRpcMeF5WFDT9swnTUC8Nk/LP0+
         r6vfgoK4bzr2lLphsnxeDcQLDbtQMAdmqQRcSAirHB4Jyl6zo92MfDHMKX/Df/MHgaM9
         ttBMgTrmOq+g0JSg6Aza4Q1rblWmI2iTQWeRj/51SGWx4Ydc55lHwmNehJ3zK17wR1CT
         +RvhqNRDH5WHyVvOFklh3oJ7gCRz39mlUOsyulCUnph1bhEqfcFQCGOyimz8Btj4fj51
         iRvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=pBCp7yP4DP9lON1sn9LGGO5NDGaC0wQbd6QkdkrLCvk=;
        b=UIZ4UFd5/UpLiEqFie62hNEjENfcIOA7cwSleOT53yzebBCKsXrBODHAQnJ11FmBi9
         TDIIGBQqI0tI+F+RPRojpXXsGP4YPpQKjYDDd6Tef2qet0mO6KRxS6DOUpp3zc/zau8y
         jMQa9UW7Ha1fTnN0kudlS0TYSl0MT+OlBWxvGBw1fAz8wkmoqnUUNucDRhWxD2mZts9m
         dHsVy2jpSsbUYy9Vjrxf8UYBvtESiA1CnKtPXSC87hDyKkvOLEzci5OsN9H424hSP+Y9
         BNYfU8K9GU0D93rN/CKKdKHREMJSTQNb0c839LByKjztemg6DwrZQfZAudsMBtbbHOU+
         olJA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
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
Subject: [PATCH 3.18 14/36] KVM: VMX: Fix rflags cache during vCPU reset
Date: Mon,  5 Feb 2018 10:23:42 -0800
Message-Id: <20180205182352.360835097@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182351.774761393@linuxfoundation.org>
References: <20180205182351.774761393@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586509002098278?=
X-GMAIL-MSGID: =?utf-8?q?1591586509002098278?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4569,7 +4569,7 @@ static void vmx_vcpu_reset(struct kvm_vc
 	vmcs_writel(GUEST_SYSENTER_ESP, 0);
 	vmcs_writel(GUEST_SYSENTER_EIP, 0);
 
-	vmcs_writel(GUEST_RFLAGS, 0x02);
+	kvm_set_rflags(vcpu, X86_EFLAGS_FIXED);
 	kvm_rip_write(vcpu, 0xfff0);
 
 	vmcs_writel(GUEST_GDTR_BASE, 0);
