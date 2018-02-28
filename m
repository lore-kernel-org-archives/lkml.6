Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933956AbeB1Tia (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 14:38:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39444 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933624AbeB1TiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 14:38:25 -0500
Subject: Re: [PATCH v2 07/15] KVM: s390: Interfaces to configure/deconfigure
 guest's AP matrix
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
References: <1519741693-17440-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1519741693-17440-8-git-send-email-akrowiak@linux.vnet.ibm.com>
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Wed, 28 Feb 2018 14:38:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <1519741693-17440-8-git-send-email-akrowiak@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18022819-2213-0000-0000-000002781E82
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008603; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00996443; UDB=6.00506577; IPR=6.00775765;
 MB=3.00019782; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-28 19:38:22
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022819-2214-0000-0000-00005944AE64
Message-Id: <dcdf8867-4ccb-d5d9-d782-2b1aec8418cd@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-28_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802280239
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/27/2018 09:28 AM, Tony Krowiak wrote:
> Provides interfaces to assign AP adapters, usage domains
> and control domains to a KVM guest.
>
> A KVM guest is started by executing the Start Interpretive Execution (SIE)
> instruction. The SIE state description is a control block that contains the
> state information for a KVM guest and is supplied as input to the SIE
> instruction. The SIE state description has a satellite structure called the
> Crypto Control Block (CRYCB). The CRYCB contains three bitmask fields
> identifying the adapters, queues (domains) and control domains assigned to
> the KVM guest:
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
> 2. Verify that the APQNs that can be derived from the intersection
>     of the bits set in the APM and AQM fields of the KVM guest's CRYCB
>     are not assigned to any other KVM guest running on the same linux
>     host.
>
> 3. Set the APM, AQM and ADM in the CRYCB according to the matrix
>     configured for the mediated matrix device via its sysfs
>     adapter, domain and control domain attribute files respectively.
>
> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> ---
>   arch/s390/include/asm/kvm-ap.h        |   36 +++++
>   arch/s390/kvm/kvm-ap.c                |  257 +++++++++++++++++++++++++++++++++
>   drivers/s390/crypto/vfio_ap_ops.c     |   19 +++
>   drivers/s390/crypto/vfio_ap_private.h |    4 +
>   4 files changed, 316 insertions(+), 0 deletions(-)
>
> diff --git a/arch/s390/include/asm/kvm-ap.h b/arch/s390/include/asm/kvm-ap.h
> index ef749e7..46e7c5b 100644
> --- a/arch/s390/include/asm/kvm-ap.h
> +++ b/arch/s390/include/asm/kvm-ap.h
> @@ -10,9 +10,45 @@
>   #define _ASM_KVM_AP
>   #include <linux/types.h>
>   #include <linux/kvm_host.h>
> +#include <linux/types.h>
> +#include <linux/kvm_host.h>
> +#include <linux/bitops.h>
> +
> +#define KVM_AP_MASK_BYTES(n)(n / BITS_PER_BYTE)
This macro is accurate only if (n % BITS_PER_BYTE) == 0.
There is a BITS_TO_BYTES macro in tools/include/linux/bitops.h that does 
the
job, but that header file is not available to kvm-ap.h. I'm going to steal
the concept and make the following change:

#define KVM_AP_MASK_BYTES(n)    DIV_ROUND_UP(n, BITS_PER_BYTE)
> +
> +/**
> + * The AP matrix is comprised of three bit masks identifying the adapters,
> + * queues (domains) and control domains that belong to an AP matrix. The bits in
> + * each mask, from least significant to most significant bit, correspond to IDs
> + * 0 to the maximum ID allowed for a given mask. When a bit is set, the
> + * corresponding ID belongs to the matrix.
> + *
> + * @apm_max: max number of bits in @apm
> + * @apm identifies the AP adapters in the matrix
> + * @aqm_max: max number of bits in @aqm
> + * @aqm identifies the AP queues (domains) in the matrix
> + * @adm_max: max number of bits in @adm
> + * @adm identifies the AP control domains in the matrix
> + */
> +struct kvm_ap_matrix {
> +	int apm_max;
> +	unsigned long *apm;
> +	int aqm_max;
> +	unsigned long *aqm;
> +	int adm_max;
> +	unsigned long *adm;
> +};
>
>   void kvm_ap_set_crycb_format(struct kvm *kvm, __u32 *crycbd);
>
>   int kvm_ap_get_crycb_format(struct kvm *kvm);
>
> +int kvm_ap_matrix_create(struct kvm_ap_matrix **ap_matrix);
> +
> +void kvm_ap_matrix_destroy(struct kvm_ap_matrix *ap_matrix);
> +
> +int kvm_ap_configure_matrix(struct kvm *kvm, struct kvm_ap_matrix *matrix);
> +
> +void kvm_ap_deconfigure_matrix(struct kvm *kvm);
> +
>   #endif /* _ASM_KVM_AP */
> diff --git a/arch/s390/kvm/kvm-ap.c b/arch/s390/kvm/kvm-ap.c
> index bafe63b..bb29045 100644
> --- a/arch/s390/kvm/kvm-ap.c
> +++ b/arch/s390/kvm/kvm-ap.c
> @@ -8,6 +8,7 @@
>
>   #include <asm/kvm-ap.h>
>   #include <asm/ap.h>
> +#include <linux/bitops.h>
>
>   #include "kvm-s390.h"
>
> @@ -16,6 +17,125 @@ int kvm_ap_get_crycb_format(struct kvm *kvm)
>   	return kvm->arch.crypto.crycbd & CRYCB_FORMAT_MASK;
>   }
>
> +static inline void kvm_ap_clear_crycb_masks(struct kvm *kvm)
> +{
> +	int crycb_fmt = kvm_ap_get_crycb_format(kvm);
> +
> +	if (crycb_fmt == CRYCB_FORMAT2)
> +		memset(&kvm->arch.crypto.crycb->apcb1, 0,
> +		       sizeof(kvm->arch.crypto.crycb->apcb1));
> +	else
> +		memset(&kvm->arch.crypto.crycb->apcb0, 0,
> +		       sizeof(kvm->arch.crypto.crycb->apcb0));
> +}
> +
> +static inline unsigned long *kvm_ap_get_crycb_apm(struct kvm *kvm)
> +{
> +	unsigned long *apm;
> +	int crycb_fmt = kvm_ap_get_crycb_format(kvm);
> +
> +	if (crycb_fmt == CRYCB_FORMAT2)
> +		apm = (unsigned long *)kvm->arch.crypto.crycb->apcb1.apm;
> +	else
> +		apm = (unsigned long *)kvm->arch.crypto.crycb->apcb0.apm;
> +
> +	return apm;
> +}
> +
> +static inline unsigned long *kvm_ap_get_crycb_aqm(struct kvm *kvm)
> +{
> +	unsigned long *aqm;
> +	int crycb_fmt = kvm_ap_get_crycb_format(kvm);
> +
> +	if (crycb_fmt == CRYCB_FORMAT2)
> +		aqm = (unsigned long *)kvm->arch.crypto.crycb->apcb1.aqm;
> +	else
> +		aqm = (unsigned long *)kvm->arch.crypto.crycb->apcb0.aqm;
> +
> +	return aqm;
> +}
> +
> +static inline unsigned long *kvm_ap_get_crycb_adm(struct kvm *kvm)
> +{
> +	unsigned long *adm;
> +	int crycb_fmt = kvm_ap_get_crycb_format(kvm);
> +
> +	if (crycb_fmt == CRYCB_FORMAT2)
> +		adm = (unsigned long *)kvm->arch.crypto.crycb->apcb1.adm;
> +	else
> +		adm = (unsigned long *)kvm->arch.crypto.crycb->apcb0.adm;
> +
> +	return adm;
> +}
> +
> +static void kvm_ap_set_crycb_masks(struct kvm *kvm,
> +				   struct kvm_ap_matrix *matrix)
> +{
> +	unsigned long *apm = kvm_ap_get_crycb_apm(kvm);
> +	unsigned long *aqm = kvm_ap_get_crycb_aqm(kvm);
> +	unsigned long *adm = kvm_ap_get_crycb_adm(kvm);
> +
> +	kvm_ap_clear_crycb_masks(kvm);
> +	memcpy(apm, matrix->apm, KVM_AP_MASK_BYTES(matrix->apm_max));
> +	memcpy(aqm, matrix->aqm, KVM_AP_MASK_BYTES(matrix->aqm_max));
> +
> +	/*
> +	 * Merge the AQM and ADM since the ADM is a superset of the
> +	 * AQM by architectural convention.
> +	 */
> +	bitmap_or(adm, adm, aqm, matrix->adm_max);
> +}
> +
> +static void kvm_ap_log_sharing_err(struct kvm *kvm, unsigned long apid,
> +				   unsigned long apqi)
> +{
> +	pr_err("%s: AP queue %02lx.%04lx is registered to guest %s", __func__,
> +	       apid, apqi, kvm->arch.dbf->name);
> +}
> +
> +/**
> + * kvm_ap_validate_queue_sharing
> + *
> + * Verifies that the APQNs derived from the intersection of the AP adapter IDs
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
> +		if (!bitmap_and(apm, apm, matrix->apm, matrix->apm_max))
> +			continue;
> +
> +		aqm = kvm_ap_get_crycb_aqm(vm);
> +		if (!bitmap_and(aqm, aqm, matrix->aqm, matrix->aqm_max))
> +			continue;
> +
> +		for_each_set_bit_inv(apid, apm, matrix->apm_max)
> +			for_each_set_bit_inv(apqi, aqm, matrix->aqm_max)
> +				kvm_ap_log_sharing_err(kvm, apid, apqi);
> +
> +		return -EBUSY;
> +	}
> +
> +	return 0;
> +}
> +
>   static int kvm_ap_apxa_installed(void)
>   {
>   	int ret;
> @@ -50,3 +170,140 @@ void kvm_ap_set_crycb_format(struct kvm *kvm, __u32 *crycbd)
>   			*crycbd |= CRYCB_FORMAT1;
>   	}
>   }
> +
> +static int kvm_ap_matrix_apm_create(struct kvm_ap_matrix *ap_matrix, int apxa)
> +{
> +	if (apxa)
> +		ap_matrix->apm_max = 256;
> +	else
> +		ap_matrix->apm_max = 64;
> +
> +	ap_matrix->apm = kzalloc(KVM_AP_MASK_BYTES(ap_matrix->apm_max),
> +				 GFP_KERNEL);
> +	if (!ap_matrix->apm)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +static int kvm_ap_matrix_aqm_create(struct kvm_ap_matrix *ap_matrix, int apxa)
> +{
> +	if (apxa)
> +		ap_matrix->aqm_max = 256;
> +	else
> +		ap_matrix->aqm_max = 16;
> +
> +	ap_matrix->aqm = kzalloc(KVM_AP_MASK_BYTES(ap_matrix->aqm_max),
> +				 GFP_KERNEL);
> +	if (!ap_matrix->aqm)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +static int kvm_ap_matrix_adm_create(struct kvm_ap_matrix *ap_matrix, int apxa)
> +{
> +	if (apxa)
> +		ap_matrix->adm_max = 256;
> +	else
> +		ap_matrix->adm_max = 16;
> +
> +	ap_matrix->adm = kzalloc(KVM_AP_MASK_BYTES(ap_matrix->adm_max),
> +				 GFP_KERNEL);
> +	if (!ap_matrix->adm)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +static void kvm_ap_matrix_masks_destroy(struct kvm_ap_matrix *ap_matrix)
> +{
> +	kfree(ap_matrix->apm);
> +	kfree(ap_matrix->aqm);
> +	kfree(ap_matrix->adm);
> +}
> +
> +int kvm_ap_matrix_create(struct kvm_ap_matrix **ap_matrix)
> +{
> +	int ret;
> +	int apxa = kvm_ap_apxa_installed();
> +	struct kvm_ap_matrix *matrix;
> +
> +	matrix = kzalloc(sizeof(*matrix), GFP_KERNEL);
> +	if (!matrix)
> +		return -ENOMEM;
> +
> +	ret = kvm_ap_matrix_apm_create(matrix, apxa);
> +	if (ret)
> +		goto mask_create_err;
> +
> +	ret = kvm_ap_matrix_aqm_create(matrix, apxa);
> +	if (ret)
> +		goto mask_create_err;
> +
> +	ret = kvm_ap_matrix_adm_create(matrix, apxa);
> +	if (ret)
> +		goto mask_create_err;
> +
> +	*ap_matrix = matrix;
> +
> +	return 0;
> +
> +mask_create_err:
> +	kvm_ap_matrix_masks_destroy(matrix);
> +	kfree(matrix);
> +	return ret;
> +}
> +EXPORT_SYMBOL(kvm_ap_matrix_create);
> +
> +void kvm_ap_matrix_destroy(struct kvm_ap_matrix *ap_matrix)
> +{
> +	kvm_ap_matrix_masks_destroy(ap_matrix);
> +	kfree(ap_matrix);
> +}
> +EXPORT_SYMBOL(kvm_ap_matrix_destroy);
> +
> +/**
> + * kvm_ap_configure_matrix
> + *
> + * Configure the AP matrix for a KVM guest.
> + *
> + * @kvm:		 the KVM guest
> + * @matrix:		 the matrix configuration information
> + *
> + * Returns 0 if the APQNs derived from the intersection of the set of adapter
> + * IDs (APM) and queue indexes (AQM) in @matrix are not configured for any
> + * other KVM guest running on the same linux host. Otherwise returns an error
> + * code.
> + */
> +int kvm_ap_configure_matrix(struct kvm *kvm, struct kvm_ap_matrix *matrix)
> +{
> +	int ret = 0;
> +
> +	mutex_lock(&kvm->lock);
> +
> +	ret = kvm_ap_validate_queue_sharing(kvm, matrix);
> +	if (ret)
> +		return ret;
> +
> +	kvm_ap_set_crycb_masks(kvm, matrix);
> +
> +	mutex_unlock(&kvm->lock);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(kvm_ap_configure_matrix);
> +
> +/**
> + * kvm_ap_deconfigure_matrix
> + *
> + * Deconfigure the AP matrix for a KVM guest. Clears all of the bits in the
> + * APM, AQM and ADM in the guest's CRYCB.
> + *
> + * @kvm: the KVM guest
> + */
> +void kvm_ap_deconfigure_matrix(struct kvm *kvm)
> +{
> +	kvm_ap_clear_crycb_masks(kvm);
> +}
> +EXPORT_SYMBOL(kvm_ap_deconfigure_matrix);
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index 4292a5e..4fda44e 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -10,6 +10,7 @@
>   #include <linux/device.h>
>   #include <linux/list.h>
>   #include <linux/ctype.h>
> +#include <asm/kvm-ap.h>
>
>   #include "vfio_ap_private.h"
>
> @@ -18,8 +19,23 @@
>
>   static int vfio_ap_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
>   {
> +	int ret;
> +	struct ap_matrix_mdev *matrix_mdev;
>   	struct ap_matrix *ap_matrix = to_ap_matrix(mdev_parent_dev(mdev));
> +	struct kvm_ap_matrix *matrix;
> +
> +	ret = kvm_ap_matrix_create(&matrix);
> +	if (ret)
> +		return ret;
> +
> +	matrix_mdev = kzalloc(sizeof(*matrix_mdev), GFP_KERNEL);
> +	if (!matrix_mdev) {
> +		kvm_ap_matrix_destroy(matrix);
> +		return -ENOMEM;
> +	}
>
> +	matrix_mdev->matrix = matrix;
> +	mdev_set_drvdata(mdev, matrix_mdev);
>   	ap_matrix->available_instances--;
>
>   	return 0;
> @@ -28,7 +44,10 @@ static int vfio_ap_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
>   static int vfio_ap_mdev_remove(struct mdev_device *mdev)
>   {
>   	struct ap_matrix *ap_matrix = to_ap_matrix(mdev_parent_dev(mdev));
> +	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>
> +	kvm_ap_matrix_destroy(matrix_mdev->matrix);
> +	kfree(matrix_mdev);
>   	ap_matrix->available_instances++;
>
>   	return 0;
> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
> index c264415..522564e 100644
> --- a/drivers/s390/crypto/vfio_ap_private.h
> +++ b/drivers/s390/crypto/vfio_ap_private.h
> @@ -27,6 +27,10 @@ struct ap_matrix {
>   	int available_instances;
>   };
>
> +struct ap_matrix_mdev {
> +	struct kvm_ap_matrix *matrix;
> +};
> +
>   static inline struct ap_matrix *to_ap_matrix(struct device *dev)
>   {
>   	return container_of(dev, struct ap_matrix, device);
