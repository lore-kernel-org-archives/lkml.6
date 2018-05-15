Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753723AbeEOOzo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 10:55:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41116 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752585AbeEOOzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 10:55:42 -0400
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v5 06/13] KVM: s390: interfaces to manage guest's AP
 matrix
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com,
        berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
References: <1525705912-12815-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1525705912-12815-7-git-send-email-akrowiak@linux.vnet.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Tue, 15 May 2018 16:55:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1525705912-12815-7-git-send-email-akrowiak@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18051514-0044-0000-0000-00000552B4C3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051514-0045-0000-0000-000028941B40
Message-Id: <f2646170-1aaf-8447-4c02-0679909d754f@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-15_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805150152
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05/2018 17:11, Tony Krowiak wrote:
> Provides interfaces to manage the AP adapters, usage domains
> and control domains assigned to a KVM guest.
>
> The guest's SIE state description has a satellite structure called the
> Crypto Control Block (CRYCB) containing three bitmask fields
> identifying the adapters, queues (domains) and control domains
> assigned to the KVM guest:
>
> * The AP Adapter Mask (APM) field identifies the AP adapters assigned to
>    the KVM guest
>
> * The AP Queue Mask (AQM) field identifies the AP queues assigned to
>    the KVM guest. Each AP queue is connected to a usage domain within
>    an AP adapter.
>
> * The AP Domain Mask (ADM) field identifies the control domains
>    assigned to the KVM guest.
>
> Each adapter, queue (usage domain) and control domain are identified by
> a number from 0 to 255. The bits in each mask, from most significant to
> least significant bit, correspond to the numbers 0-255. When a bit is
> set, the corresponding adapter, queue (usage domain) or control domain
> is assigned to the KVM guest.
>
> This patch will set the bits in the APM, AQM and ADM fields of the
> CRYCB referenced by the KVM guest's SIE state description. The process
> used is:
>
> 1. Verify that the bits to be set do not exceed the maximum bit
>     number for the given mask.
>
> 2. Verify that the APQNs that can be derived from the cross product
>     of the bits set in the APM and AQM fields of the KVM guest's CRYCB
>     are not assigned to any other KVM guest running on the same linux
>     host.
>
> 3. Set the APM, AQM and ADM in the CRYCB according to the matrix
>     configured for the mediated matrix device via its sysfs
>     assign_adapter, assign_domain and assign_control domain attribute
>     files respectively.
>
> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> ---
>   arch/s390/include/asm/kvm-ap.h   |   52 ++++++++++++
>   arch/s390/include/asm/kvm_host.h |    1 +
>   arch/s390/kvm/kvm-ap.c           |  161 ++++++++++++++++++++++++++++++++++++++
>   3 files changed, 214 insertions(+), 0 deletions(-)
>
> diff --git a/arch/s390/include/asm/kvm-ap.h b/arch/s390/include/asm/kvm-ap.h
> index 6af1ff8..21fe9f2 100644
> --- a/arch/s390/include/asm/kvm-ap.h
> +++ b/arch/s390/include/asm/kvm-ap.h
> @@ -12,8 +12,33 @@
>
>   #include <linux/types.h>
>   #include <linux/kvm_host.h>
> +#include <linux/bitops.h>
>   #include <asm/ap.h>
>
> +#define KVM_AP_MASK_BYTES(n)	DIV_ROUND_UP(n, BITS_PER_BYTE)
> +
> +/**
> + * The AP matrix is comprised of three bit masks identifying the adapters,
> + * queues (domains) and control domains that belong to an AP matrix. The bits in
> + * each mask, from least significant to most significant bit, correspond to IDs
> + * 0 to 255. When a bit is set, the corresponding ID belongs to the matrix.
> + *
> + * @apm identifies the AP adapters in the matrix
> + * @apm_max: max adapter number in @apm
> + * @aqm identifies the AP queues (domains) in the matrix
> + * @aqm_max: max domain number in @aqm
> + * @adm identifies the AP control domains in the matrix
> + * @adm_max: max domain number in @adm
> + */
> +struct kvm_ap_matrix {
> +	unsigned long apm_max;
> +	DECLARE_BITMAP(apm, 256);
> +	unsigned long aqm_max;
> +	DECLARE_BITMAP(aqm, 256);
> +	unsigned long adm_max;
> +	DECLARE_BITMAP(adm, 256);

Just a possible performance impact:
you may have interest to put all bitmaps first to take adventage
of quadword handling (If bitmaps use it) and put unsigned longs
at the end.

> +};
> +
>   /**
>    * kvm_ap_apxa_installed
>    *
> @@ -57,4 +82,31 @@
>    */
>   bool kvm_ap_instructions_available(void);
>
> +/**
> + * kvm_ap_configure_matrix
> + *
> + * Configure the AP matrix for a KVM guest.
> + *
> + * @kvm:		 the KVM guest
> + * @matrix:		 the matrix configuration information
> + *
> + * Returns 0 if:
> + *	1. The AP instructions are installed on the guest
> + *	2. The APQNs derived from the intersection of the set of adapter
> + *	   IDs (APM) and queue indexes (AQM) in @matrix are not configured for
> + *	   any other KVM guest running on the same linux host.
> + * Otherwise returns an error code.
> + */
> +int kvm_ap_configure_matrix(struct kvm *kvm, struct kvm_ap_matrix *matrix);
> +
> +/**
> + * kvm_ap_deconfigure_matrix
> + *
> + * Deconfigure the AP matrix for a KVM guest. Clears all of the bits in the
> + * APM, AQM and ADM in the guest's CRYCB.
> + *
> + * @kvm: the KVM guest
> + */
> +void kvm_ap_deconfigure_matrix(struct kvm *kvm);
> +
>   #endif /* _ASM_KVM_AP */
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index ef4b237..8736cde 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -257,6 +257,7 @@ struct kvm_s390_sie_block {
>   	__u64	tecmc;			/* 0x00e8 */
>   	__u8	reservedf0[12];		/* 0x00f0 */
>   #define CRYCB_FORMAT_MASK 0x00000003
> +#define CRYCB_FORMAT0 0x00000000
>   #define CRYCB_FORMAT1 0x00000001
>   #define CRYCB_FORMAT2 0x00000003
>   	__u32	crycbd;			/* 0x00fc */
> diff --git a/arch/s390/kvm/kvm-ap.c b/arch/s390/kvm/kvm-ap.c
> index 00bcfb0..98b53c7 100644
> --- a/arch/s390/kvm/kvm-ap.c
> +++ b/arch/s390/kvm/kvm-ap.c
> @@ -7,6 +7,7 @@
>    * Author(s): Tony Krowiak <akrowia@linux.vnet.ibm.com>
>    */
>   #include <linux/kernel.h>
> +#include <linux/bitops.h>
>   #include <asm/kvm-ap.h>
>
>   #include "kvm-s390.h"
> @@ -81,3 +82,163 @@ int kvm_ap_apxa_installed(void)
>   	return 0;
>   }
>   EXPORT_SYMBOL(kvm_ap_apxa_installed);
> +
> +static inline void kvm_ap_clear_crycb_masks(struct kvm *kvm)
> +{
> +	memset(&kvm->arch.crypto.crycb->apcb0, 0,
> +	       sizeof(kvm->arch.crypto.crycb->apcb0));

Here you prefer to set both structure to 0 instead of testing which
structure to erase.

> +	memset(&kvm->arch.crypto.crycb->apcb1, 0,
> +	       sizeof(kvm->arch.crypto.crycb->apcb1));
> +}
> +

...snip...

> +/**
> + * kvm_ap_validate_queue_sharing
> + *
> + * Verifies that the APQNs derived from the cross product of the AP adapter IDs
> + * and AP queue indexes comprising the AP matrix are not configured for
> + * another guest. AP queue sharing is not allowed.
> + *
> + * @kvm: the KVM guest
> + * @matrix: the AP matrix
> + *
> + * Returns 0 if the APQNs are valid, otherwise; returns -EBUSY.
> + */
> +static int kvm_ap_validate_queue_sharing(struct kvm *kvm,
> +					 struct kvm_ap_matrix *matrix)
> +{
> +	struct kvm *vm;
> +	unsigned long *apm, *aqm;
> +	unsigned long apid, apqi;
> +
> +
> +	/* No other VM may share an AP Queue with the input VM */
> +	list_for_each_entry(vm, &vm_list, vm_list) {
> +		if (kvm == vm)
> +			continue;
> +
> +		apm = kvm_ap_get_crycb_apm(vm);
> +		if (!bitmap_and(apm, apm, matrix->apm, matrix->apm_max + 1))
> +			continue;
> +
> +		aqm = kvm_ap_get_crycb_aqm(vm);
> +		if (!bitmap_and(aqm, aqm, matrix->aqm, matrix->aqm_max + 1))
> +			continue;
> +
> +		for_each_set_bit_inv(apid, apm, matrix->apm_max + 1)
> +			for_each_set_bit_inv(apqi, aqm, matrix->aqm_max + 1)
> +				kvm_ap_log_sharing_err(vm, apid, apqi);
> +
> +		return -EBUSY;
> +	}
> +
> +	return 0;
> +}

This function (ap_validate_queue_sharing) only verifies that VM don't 
share queues.
What about the queues used by a host application?

I understand that you want to implement  these checks within KVM but this is
related to which queue devices are bound to the matrix and which one are 
not.

I think that this should be related somehow to the bounded queue devices and
therefor implemented inside the matrix driver.

Regards,

Pierre

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
