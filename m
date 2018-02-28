Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752454AbeB1Jsa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 04:48:30 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41802 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752066AbeB1Js2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 04:48:28 -0500
Subject: Re: [PATCH v2 04/15] KVM: s390: CPU model support for AP
 virtualization
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
References: <1519741693-17440-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1519741693-17440-5-git-send-email-akrowiak@linux.vnet.ibm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <38deecae-53b4-c5cb-3dba-24bdfab3d9d0@redhat.com>
Date: Wed, 28 Feb 2018 10:48:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1519741693-17440-5-git-send-email-akrowiak@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.02.2018 15:28, Tony Krowiak wrote:
> Introduces a new CPU model feature and two CPU model
> facilities to support AP virtualization for KVM guests.
> 
> CPU model feature:
> 
> The KVM_S390_VM_CPU_FEAT_AP feature indicates that the
> AP facilities are installed on the KVM guest. This
> feature will be enabled by the kernel only if the AP
> facilities are installed on the linux host. This feature
> must be specifically turned on for the KVM guest from
> userspace to allow guest access to AP devices installed
> on the linux host.
> 
> CPU model facilities:
> 
> 1. AP Query Configuration Information (QCI) facility is installed.
> 
>    This is indicated by setting facilities bit 12 for
>    the guest. The kernel will not enable this facility
>    for the guest if it is not set on the host. This facility
>    must not be set by userspace if the KVM_S390_VM_CPU_FEAT_AP
>    feature is not installed.
> 
> 2. AP Facilities Test facility (APFT) is installed.
> 
>    This is indicated by setting facilities bit 15 for
>    the guest. The kernel will not enable this facility for
>    the guest if it is not set on the host. This facility
>    must not be set by userspace if the KVM_S390_VM_CPU_FEAT_AP
>    feature is not installed.
> 
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> ---
>  arch/s390/include/uapi/asm/kvm.h |    1 +
>  arch/s390/kvm/kvm-s390.c         |    4 ++++
>  arch/s390/tools/gen_facilities.c |    2 ++
>  3 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
> index 4cdaa55..a580dec 100644
> --- a/arch/s390/include/uapi/asm/kvm.h
> +++ b/arch/s390/include/uapi/asm/kvm.h
> @@ -130,6 +130,7 @@ struct kvm_s390_vm_cpu_machine {
>  #define KVM_S390_VM_CPU_FEAT_PFMFI	11
>  #define KVM_S390_VM_CPU_FEAT_SIGPIF	12
>  #define KVM_S390_VM_CPU_FEAT_KSS	13
> +#define KVM_S390_VM_CPU_FEAT_AP		14
>  struct kvm_s390_vm_cpu_feat {
>  	__u64 feat[16];
>  };
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index de1e299..c68ca86 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -347,6 +347,10 @@ static void kvm_s390_cpu_feat_init(void)
>  
>  	if (MACHINE_HAS_ESOP)
>  		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_ESOP);
> +
> +	if (ap_instructions_installed()) /* AP instructions installed on host */
> +		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_AP);

Don't we have a SIE specific AP feature? So is it true, that once we
have AP instructions, we are allowed to use them for SIE? Isn't there a
"AP interpretation facility" or anything like that? (that unlocks ECA_APIE)

> +
>  	/*
>  	 * We need SIE support, ESOP (PROT_READ protection for gmap_shadow),
>  	 * 64bit SCAO (SCA passthrough) and IDTE (for gmap_shadow unshadowing).
> diff --git a/arch/s390/tools/gen_facilities.c b/arch/s390/tools/gen_facilities.c
> index 90a8c9e..a52290b 100644
> --- a/arch/s390/tools/gen_facilities.c
> +++ b/arch/s390/tools/gen_facilities.c
> @@ -106,6 +106,8 @@ struct facility_def {
>  
>  		.name = "FACILITIES_KVM_CPUMODEL",
>  		.bits = (int[]){
> +			12, /* AP Query Configuration Information */
> +			15, /* AP Facilities Test */
>  			-1  /* END */
>  		}
>  	},
> 

So only if this feature is enabled, we later on allow to
kvm_ap_enable_ie_mode, right?

So basically, without this feature:

1. We will never set the execution control ECA_APIE.
2. The masks will always be 0.

Which also results in VSIE never having masks set.


-- 

Thanks,

David / dhildenb
