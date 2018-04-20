Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754794AbeDTM07 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 08:26:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42886 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754591AbeDTM05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 08:26:57 -0400
Subject: Re: [PATCH] KVM: s390: reset crypto attributes for all vcpus
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, pmorel@linux.vnet.ibm.com,
        pasic@linux.vnet.ibm.com, pbonzini@redhat.com, rkrcmar@redhat.com
References: <1524172432-26211-1-git-send-email-akrowiak@linux.vnet.ibm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <d7ed9844-0753-6d7a-ccd8-48e89992a34e@redhat.com>
Date: Fri, 20 Apr 2018 14:26:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1524172432-26211-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.04.2018 23:13, Tony Krowiak wrote:
> Introduces a new function to reset the crypto attributes for all
> vcpus whether they are running or not. Each vcpu in KVM will
> be removed from SIE prior to resetting the crypto attributes in its
> SIE state description. After all vcpus have had their crypto attributes
> reset the vcpus will be restored to SIE.
> 
> This function is incorporated into the kvm_s390_vm_set_crypto(kvm)
> function to fix a reported issue whereby the crypto key wrapping
> attributes could potentially get out of synch for running vcpus.
> 
> Reported-by: Halil Pasic <pasic@linux.vnet.ibm.com>

A reported-by for a code refactoring is strange.

> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> ---
>  arch/s390/kvm/kvm-s390.c |   18 ++++++++++++++----
>  arch/s390/kvm/kvm-s390.h |   13 +++++++++++++
>  2 files changed, 27 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index fa355a6..4fa3037 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -789,6 +789,19 @@ static int kvm_s390_set_mem_control(struct kvm *kvm, struct kvm_device_attr *att
>  	return ret;
>  }
>  
> +void kvm_s390_vcpu_crypto_reset_all(struct kvm *kvm)
> + {
> +	int i;
> +	struct kvm_vcpu *vcpu;
> +
> +	kvm_s390_vcpu_block_all(kvm);
> +
> +	kvm_for_each_vcpu(i, vcpu, kvm)
> +	        kvm_s390_vcpu_crypto_setup(vcpu);
> +
> +	kvm_s390_vcpu_unblock_all(kvm);

This code has to be protected by kvm->lock. Can that be guaranteed by
the caller?

> +}
> +
>  static void kvm_s390_vcpu_crypto_setup(struct kvm_vcpu *vcpu);
>  
>  static int kvm_s390_vm_set_crypto(struct kvm *kvm, struct kvm_device_attr *attr)
> @@ -832,10 +845,7 @@ static int kvm_s390_vm_set_crypto(struct kvm *kvm, struct kvm_device_attr *attr)
>  		return -ENXIO;
>  	}
>  
> -	kvm_for_each_vcpu(i, vcpu, kvm) {
> -		kvm_s390_vcpu_crypto_setup(vcpu);
> -		exit_sie(vcpu);
> -	}
> +	kvm_s390_vcpu_crypto_reset_all(kvm);
>  	mutex_unlock(&kvm->lock);
>  	return 0;
>  }
> diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
> index 1b5621f..981e3ba 100644
> --- a/arch/s390/kvm/kvm-s390.h
> +++ b/arch/s390/kvm/kvm-s390.h
> @@ -410,4 +410,17 @@ static inline int kvm_s390_use_sca_entries(void)
>  }
>  void kvm_s390_reinject_machine_check(struct kvm_vcpu *vcpu,
>  				     struct mcck_volatile_info *mcck_info);
> +
> +/**
> + * kvm_s390_vcpu_crypto_reset_all
> + *
> + * Reset the crypto attributes for each vcpu. This can be done while the vcpus
> + * are running as each vcpu will be removed from SIE before resetting the crypt
> + * attributes and restored to SIE afterward.
> + *
> + * Note: The kvm->lock must be held while calling this function
> + *
> + * @kvm: the KVM guest
> + */
> +void kvm_s390_vcpu_crypto_reset_all(struct kvm *kvm);
>  #endif
> 


-- 

Thanks,

David / dhildenb
