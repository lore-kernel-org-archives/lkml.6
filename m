Date: Mon, 30 Apr 2018 11:17:22 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH 4.4 12/50] KVM: s390: wire up bpb feature
Message-ID: <20180430181722.GB12118@kroah.com>
References: <20180427135655.623669681@linuxfoundation.org>
 <20180427135656.428437126@linuxfoundation.org>
 <2764478b-8acb-653b-779f-1fb51d9a5931@de.ibm.com>
 <20180427151715.GA3876@kroah.com>
 <20180427154650.GA15121@kroah.com>
 <f8e1244f-d5b8-1eb9-4e71-fb4b0dd7d610@de.ibm.com>
 <20180429095127.59f76a1e@mschwideX1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180429095127.59f76a1e@mschwideX1>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 29, 2018 at 09:51:27AM +0200, Martin Schwidefsky wrote:
> On Fri, 27 Apr 2018 17:53:46 +0200
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
> > On 04/27/2018 05:46 PM, Greg Kroah-Hartman wrote:
> > > On Fri, Apr 27, 2018 at 05:17:15PM +0200, Greg Kroah-Hartman wrote:  
> > >> On Fri, Apr 27, 2018 at 05:10:04PM +0200, Christian Borntraeger wrote:  
> > >>>
> > >>>
> > >>> On 04/27/2018 03:58 PM, Greg Kroah-Hartman wrote:  
> > >>>> 4.4-stable review patch.  If anyone has any objections, please let me know.
> > >>>>
> > >>>> ------------------
> > >>>>
> > >>>> From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > >>>>
> > >>>>
> > >>>> From: Christian Borntraeger <borntraeger@de.ibm.com>  
> > >>
> > >> Ick, that is wrong right there, my scripts messed up, this should not
> > >> have 2 author lines :(
> > >>
> > >> I'll go look at all of these, odds are it made the same error
> > >> everywhere...  
> > > 
> > > Yes, I've now fixed that up in the queue.  
> > 
> > As this patch backport was also functionally incorrect and Martin is already away
> > do you want me to send an updated version?
> 
> Checked my 4.4 backport git branch and indeed the hunk is misplaced.
> Sometime I wonder about the patch tool and the hickups it can produce.
> 
> My take on the replacement patch looks as follows:
> 
> ---
> >From 82f20b6237a8d04378c8f4a1614bf32a6c8d8a8b Mon Sep 17 00:00:00 2001
> From: Christian Borntraeger <borntraeger@de.ibm.com>
> Date: Wed, 17 Jan 2018 14:44:34 +0100
> Subject: [PATCH 03/18] KVM: s390: wire up bpb feature
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> [ Upstream commit 35b3fde6203b932b2b1a5b53b3d8808abc9c4f60 ]
> 
> The new firmware interfaces for branch prediction behaviour changes
> are transparently available for the guest. Nevertheless, there is
> new state attached that should be migrated and properly resetted.
> Provide a mechanism for handling reset, migration and VSIE.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> [Changed capability number to 152. - Radim]
> Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h |  3 ++-
>  arch/s390/include/uapi/asm/kvm.h |  3 +++
>  arch/s390/kvm/kvm-s390.c         | 12 ++++++++++++
>  include/uapi/linux/kvm.h         |  1 +
>  4 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index e9a983f40a24..7d9c5917da2b 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -136,7 +136,8 @@ struct kvm_s390_sie_block {
>  	__u16	ipa;			/* 0x0056 */
>  	__u32	ipb;			/* 0x0058 */
>  	__u32	scaoh;			/* 0x005c */
> -	__u8	reserved60;		/* 0x0060 */
> +#define FPF_BPBC 	0x20
> +	__u8	fpf;			/* 0x0060 */
>  	__u8	ecb;			/* 0x0061 */
>  	__u8    ecb2;                   /* 0x0062 */
>  #define ECB3_AES 0x04
> diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
> index ef1a5fcc6c66..3aec52253c04 100644
> --- a/arch/s390/include/uapi/asm/kvm.h
> +++ b/arch/s390/include/uapi/asm/kvm.h
> @@ -151,6 +151,7 @@ struct kvm_guest_debug_arch {
>  #define KVM_SYNC_ARCH0  (1UL << 4)
>  #define KVM_SYNC_PFAULT (1UL << 5)
>  #define KVM_SYNC_VRS    (1UL << 6)
> +#define KVM_SYNC_BPBC	(1UL << 10)
>  /* definition of registers in kvm_run */
>  struct kvm_sync_regs {
>  	__u64 prefix;	/* prefix register */
> @@ -168,6 +169,8 @@ struct kvm_sync_regs {
>  	__u64 vrs[32][2];	/* vector registers */
>  	__u8  reserved[512];	/* for future vector expansion */
>  	__u32 fpc;	/* only valid with vector registers */
> +	__u8 bpbc : 1;		/* bp mode */
> +	__u8 reserved2 : 7;
>  };
>  
>  #define KVM_REG_S390_TODPR	(KVM_REG_S390 | KVM_REG_SIZE_U32 | 0x1)
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 23e3f5d77a24..ca03c847127a 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -257,6 +257,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  	case KVM_CAP_S390_VECTOR_REGISTERS:
>  		r = MACHINE_HAS_VX;
>  		break;
> +	case KVM_CAP_S390_BPB:
> +		r = test_facility(82);
> +		break;
>  	default:
>  		r = 0;
>  	}
> @@ -1262,6 +1265,8 @@ int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
>  				    KVM_SYNC_CRS |
>  				    KVM_SYNC_ARCH0 |
>  				    KVM_SYNC_PFAULT;
> +	if (test_kvm_facility(vcpu->kvm, 82))
> +		vcpu->run->kvm_valid_regs |= KVM_SYNC_BPBC;
>  	if (test_kvm_facility(vcpu->kvm, 129))
>  		vcpu->run->kvm_valid_regs |= KVM_SYNC_VRS;
>  
> @@ -1327,6 +1332,7 @@ static void kvm_s390_vcpu_initial_reset(struct kvm_vcpu *vcpu)
>  	current->thread.fpu.fpc = 0;
>  	vcpu->arch.sie_block->gbea = 1;
>  	vcpu->arch.sie_block->pp = 0;
> +	vcpu->arch.sie_block->fpf &= ~FPF_BPBC;
>  	vcpu->arch.pfault_token = KVM_S390_PFAULT_TOKEN_INVALID;
>  	kvm_clear_async_pf_completion_queue(vcpu);
>  	if (!kvm_s390_user_cpu_state_ctrl(vcpu->kvm))
> @@ -2145,6 +2151,11 @@ static void sync_regs(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
>  		if (vcpu->arch.pfault_token == KVM_S390_PFAULT_TOKEN_INVALID)
>  			kvm_clear_async_pf_completion_queue(vcpu);
>  	}
> +	if ((kvm_run->kvm_dirty_regs & KVM_SYNC_BPBC) &&
> +	    test_kvm_facility(vcpu->kvm, 82)) {
> +		vcpu->arch.sie_block->fpf &= ~FPF_BPBC;
> +		vcpu->arch.sie_block->fpf |= kvm_run->s.regs.bpbc ? FPF_BPBC : 0;
> +	}
>  	kvm_run->kvm_dirty_regs = 0;
>  }
>  
> @@ -2162,6 +2173,7 @@ static void store_regs(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
>  	kvm_run->s.regs.pft = vcpu->arch.pfault_token;
>  	kvm_run->s.regs.pfs = vcpu->arch.pfault_select;
>  	kvm_run->s.regs.pfc = vcpu->arch.pfault_compare;
> +	kvm_run->s.regs.bpbc = (vcpu->arch.sie_block->fpf & FPF_BPBC) == FPF_BPBC;
>  }
>  
>  int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 03f3618612aa..376d0ab5b9f2 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -831,6 +831,7 @@ struct kvm_ppc_smmu_info {
>  #define KVM_CAP_GUEST_DEBUG_HW_WPS 120
>  #define KVM_CAP_SPLIT_IRQCHIP 121
>  #define KVM_CAP_IOEVENTFD_ANY_LENGTH 122
> +#define KVM_CAP_S390_BPB 152
>  
>  #ifdef KVM_CAP_IRQ_ROUTING
>  

Did I include the correct version in the latest release, or do I need to
do a revert and add this one in?

thanks,

greg k-h
