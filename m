Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751424AbeBHKYa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 05:24:30 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57358 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750749AbeBHKY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 05:24:29 -0500
Subject: Re: [PATCH v2] KVM: X86: Fix SMRAM accessing even if VM is shutdown
To: Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <1518075165-5376-1-git-send-email-wanpengli@tencent.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <75e8bfd0-6133-aabf-e1d0-d2e256d62994@redhat.com>
Date: Thu, 8 Feb 2018 11:24:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1518075165-5376-1-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2018 08:32, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> Reported by syzkaller:
> 
>    WARNING: CPU: 6 PID: 2434 at arch/x86/kvm/vmx.c:6660 handle_ept_misconfig+0x54/0x1e0 [kvm_intel]
>    CPU: 6 PID: 2434 Comm: repro_test Not tainted 4.15.0+ #4
>    RIP: 0010:handle_ept_misconfig+0x54/0x1e0 [kvm_intel]
>    Call Trace:
>     vmx_handle_exit+0xbd/0xe20 [kvm_intel]
>     kvm_arch_vcpu_ioctl_run+0xdaf/0x1d50 [kvm]
>     kvm_vcpu_ioctl+0x3e9/0x720 [kvm]
>     do_vfs_ioctl+0xa4/0x6a0
>     SyS_ioctl+0x79/0x90
>     entry_SYSCALL_64_fastpath+0x25/0x9c
> 
> The syzkaller creates a former thread to issue KVM_SMI ioctl, and then creates
> a latter thread to mmap and operate on the same vCPU, rsm emulation will not be 
> executed since there is no something like seabios which implements smi handler 
> when running syzkaller directly. This triggers a race condition when running 
> the testcase with multiple threads. Sometimes one thread exit w/ SHUTDOWN 
> reason, another thread mmaps and operates on the same vCPU, it continues to 
> use CS=0x30000, IP=0x8000 to access the address of SMI handler which results 
> in the above ept misconfig. This patch fixes it by returning RET_PF_EMULATE
> in kvm_handle_bad_page() which would cause an emulation failure and then an 
> exit with KVM_EXIT_INTERNAL_ERROR, the VM will stop instead of resetting and 
> be taken advantage of.
> 
> Reported-by: syzbot+c1d9517cab094dae65e446c0c5b4de6c40f4dc58@syzkaller.appspotmail.com
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
> v1 -> v2:
>  * return RET_PF_EMULATE
> 
>  arch/x86/kvm/mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
> index 8eca1d0..6c5a82c 100644
> --- a/arch/x86/kvm/mmu.c
> +++ b/arch/x86/kvm/mmu.c
> @@ -3029,7 +3029,7 @@ static int kvm_handle_bad_page(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn)
>  		return RET_PF_RETRY;
>  	}
>  
> -	return -EFAULT;
> +	return RET_PF_EMULATE;
>  }
>  
>  static void transparent_hugepage_adjust(struct kvm_vcpu *vcpu,
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
