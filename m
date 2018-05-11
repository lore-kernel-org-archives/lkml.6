Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751907AbeEKQIO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 12:08:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36726 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751489AbeEKQIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 12:08:11 -0400
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
From: Halil Pasic <pasic@linux.ibm.com>
Date: Fri, 11 May 2018 18:08:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1525705912-12815-7-git-send-email-akrowiak@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18051116-0008-0000-0000-000004F59E09
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051116-0009-0000-0000-00001E89F173
Message-Id: <be2e8810-2a03-c67c-b1aa-41cf7c82980e@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-11_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805110151
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/07/2018 05:11 PM, Tony Krowiak wrote:
> Provides interfaces to manage the AP adapters, usage domains
> and control domains assigned to a KVM guest.
> 
> The guest's SIE state description has a satellite structure called the
> Crypto Control Block (CRYCB) containing three bitmask fields
> identifying the adapters, queues (domains) and control domains
> assigned to the KVM guest:

[..]

> index 00bcfb0..98b53c7 100644
> --- a/arch/s390/kvm/kvm-ap.c
> +++ b/arch/s390/kvm/kvm-ap.c
> @@ -7,6 +7,7 @@

[..]

> +
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
> +
> +int kvm_ap_configure_matrix(struct kvm *kvm, struct kvm_ap_matrix *matrix)
> +{
> +	int ret = 0;
> +
> +	mutex_lock(&kvm->lock);

You seem to take only kvm->lock, vm_list however (used in
kvm_ap_validate_queue_sharing()) seems to be protected by
kvm_lock.

Can you tell me why is this supposed to be safe?

What is supposed to prevent an execution like
vm1: call kvm_ap_configure_matrix(m1)
vm2: call kvm_ap_configure_matrix(m2)
vm1: call kvm_ap_validate_queue_sharing(m1)
vm2: call kvm_ap_validate_queue_sharing(m2)
vm1: call kvm_ap_set_crycb_masks(m1)
vm2: call kvm_ap_set_crycb_masks(m2)

where, let's say, m1 and m2 are equal in the sense that the
mask values are the same?

Regards,
Halil

> +
> +	ret = kvm_ap_validate_queue_sharing(kvm, matrix);
> +	if (ret)
> +		goto done;
> +
> +	kvm_ap_set_crycb_masks(kvm, matrix);
> +
> +done:
> +	mutex_unlock(&kvm->lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(kvm_ap_configure_matrix);
> +
