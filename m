Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753072AbeBBRdj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 12:33:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36658 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753872AbeBBRWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 12:22:45 -0500
Date: Fri, 2 Feb 2018 18:22:28 +0100
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        KVM <kvm@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: linux-next: manual merge of the kvm tree with Linus' tree
Message-ID: <20180202172228.GB27896@flask>
References: <20180201125512.7bc96674@canb.auug.org.au>
 <20180201104707.GA21802@cbox>
 <20180202002227.36db3356@canb.auug.org.au>
 <f49453f2-223e-abe0-912a-7288183a1671@redhat.com>
 <20180201152244.GC31080@flask>
 <20180202112029.0f4aa558@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180202112029.0f4aa558@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-02 11:20+1100, Stephen Rothwell:
> Hi Radim,
> 
> On Thu, 1 Feb 2018 16:22:44 +0100 Radim Krčmář <rkrcmar@redhat.com> wrote:
> >
> > I wasn't sure if the pti top branch is final, so I pulled hyper-v topic
> > branch that also also contains v4.15.  This and the SEV feature
> > conflicts should be gone now,
> 
> That merge would have been a good place to add the following merge
> resolution fix patch I have been carrying:

Yes, should have been there ... I've slapped the patch on top, thanks
for noticing.

> From: Eric Biggers <ebiggers@google.com>
> Subject: KVM: x86: don't forget vcpu_put() in kvm_arch_vcpu_ioctl_set_sregs()
> Date: Thu, 21 Dec 2017 01:30:30 +0100
> 
> Due to a bad merge resolution between commit f29810335965 ("KVM/x86:
> Check input paging mode when cs.l is set") and commit b4ef9d4e8cb8
> ("KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_set_sregs"),
> there is a case in kvm_arch_vcpu_ioctl_set_sregs() where vcpu_put() is
> not called after vcpu_get().  Fix it.
> 
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  arch/x86/kvm/x86.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index ea3a98196753..f4e8b5089b28 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -7624,7 +7624,7 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
>  		goto out;
>  
>  	if (kvm_valid_sregs(vcpu, sregs))
> -		return -EINVAL;
> +		goto out;
>  
>  	apic_base_msr.data = sregs->apic_base;
>  	apic_base_msr.host_initiated = true;
> 
> -- 
> Cheers,
> Stephen Rothwell
