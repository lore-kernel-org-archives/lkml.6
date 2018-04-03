Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932276AbeDCNSr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 09:18:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55278 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932151AbeDCNSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 09:18:46 -0400
Subject: Re: [PATCH v3 07/14] KVM: s390: interfaces to configure/deconfigure
 guest's AP matrix
To: Cornelia Huck <cohuck@redhat.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com,
        berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
References: <1521051954-25715-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1521051954-25715-8-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180403130758.43851026.cohuck@redhat.com>
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Tue, 3 Apr 2018 09:17:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180403130758.43851026.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18040313-0004-0000-0000-000013E57B20
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008795; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000255; SDB=6.01012515; UDB=6.00516034; IPR=6.00791779;
 MB=3.00020390; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-03 13:18:08
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040313-0005-0000-0000-000086BA07D1
Message-Id: <474b7d18-69ea-631f-214c-f9345119e537@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-03_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804030140
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/2018 07:07 AM, Cornelia Huck wrote:
> On Wed, 14 Mar 2018 14:25:47 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>
>> Provides interfaces to assign AP adapters, usage domains
>> and control domains to a KVM guest.
>>
>> A KVM guest is started by executing the Start Interpretive Execution (SIE)
>> instruction. The SIE state description is a control block that contains the
>> state information for a KVM guest and is supplied as input to the SIE
>> instruction. The SIE state description has a satellite structure called the
>> Crypto Control Block (CRYCB). The CRYCB contains three bitmask fields
>> identifying the adapters, queues (domains) and control domains assigned to
>> the KVM guest:
>>
>> * The AP Adapter Mask (APM) field identifies the AP adapters assigned to
>>    the KVM guest
>>
>> * The AP Queue Mask (AQM) field identifies the AP queues assigned to
>>    the KVM guest. Each AP queue is connected to a usage domain within
>>    an AP adapter.
>>
>> * The AP Domain Mask (ADM) field identifies the control domains
>>    assigned to the KVM guest.
>>
>> Each adapter, queue (usage domain) and control domain are identified by
>> a number from 0 to 255. The bits in each mask, from most significant to
>> least significant bit, correspond to the numbers 0-255. When a bit is
>> set, the corresponding adapter, queue (usage domain) or control domain
>> is assigned to the KVM guest.
>>
>> This patch will set the bits in the APM, AQM and ADM fields of the
>> CRYCB referenced by the KVM guest's SIE state description. The process
>> used is:
>>
>> 1. Verify that the bits to be set do not exceed the maximum bit
>>     number for the given mask.
>>
>> 2. Verify that the APQNs that can be derived from the intersection
>>     of the bits set in the APM and AQM fields of the KVM guest's CRYCB
>>     are not assigned to any other KVM guest running on the same linux
>>     host.
>>
>> 3. Set the APM, AQM and ADM in the CRYCB according to the matrix
>>     configured for the mediated matrix device via its sysfs
>>     adapter, domain and control domain attribute files respectively.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>> ---
>>   arch/s390/include/asm/kvm-ap.h        |   36 +++++
>>   arch/s390/kvm/kvm-ap.c                |  268 +++++++++++++++++++++++++++++++++
>>   drivers/s390/crypto/vfio_ap_ops.c     |   19 +++
>>   drivers/s390/crypto/vfio_ap_private.h |    4 +
>>   4 files changed, 327 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/s390/kvm/kvm-ap.c b/arch/s390/kvm/kvm-ap.c
>> index a2c6ad2..eb365e2 100644
>> --- a/arch/s390/kvm/kvm-ap.c
>> +++ b/arch/s390/kvm/kvm-ap.c
>> @@ -8,9 +8,129 @@
>>   
>>   #include <asm/kvm-ap.h>
>>   #include <asm/ap.h>
>> +#include <linux/bitops.h>
>>   
>>   #include "kvm-s390.h"
>>   
>> +static inline void kvm_ap_clear_crycb_masks(struct kvm *kvm)
>> +{
>> +	int crycb_fmt = kvm->arch.crypto.crycbd & CRYCB_FORMAT_MASK;
>> +
>> +	if (crycb_fmt == CRYCB_FORMAT2)
>> +		memset(&kvm->arch.crypto.crycb->apcb1, 0,
>> +		       sizeof(kvm->arch.crypto.crycb->apcb1));
>> +	else
>> +		memset(&kvm->arch.crypto.crycb->apcb0, 0,
>> +		       sizeof(kvm->arch.crypto.crycb->apcb0));
>> +}
> Should that rather be a switch/case? If there's a CRYCB_FORMAT3 in the
> future, I'd think that it's more likely that it uses apcb1 and not
> apcb0. Can't comment further without the architecture, obviously.
Maybe we should just clear both structures without regard to the CRYCB 
format.
>
> (...)
>
>> +static void kvm_ap_set_crycb_masks(struct kvm *kvm,
>> +				   struct kvm_ap_matrix *matrix)
>> +{
>> +	unsigned long *apm = kvm_ap_get_crycb_apm(kvm);
>> +	unsigned long *aqm = kvm_ap_get_crycb_aqm(kvm);
>> +	unsigned long *adm = kvm_ap_get_crycb_adm(kvm);
>> +
>> +	kvm_ap_clear_crycb_masks(kvm);
>> +	memcpy(apm, matrix->apm, KVM_AP_MASK_BYTES(matrix->apm_max));
>> +	memcpy(aqm, matrix->aqm, KVM_AP_MASK_BYTES(matrix->aqm_max));
>> +
>> +	/*
>> +	 * Merge the AQM and ADM since the ADM is a superset of the
>> +	 * AQM by architectural convention.
> Is this 'architectural convention' in the sense of 'there's a statement
> in the architecture that it always is like that', or in the sense of
> 'all real-life systems are like that'?
> [From my sketchy memory, this convention makes sense but is not
> enshrined; but I might misremember.]
The documentation states it is an agreed upon convention.
>
>> +	 */
>> +	bitmap_or(adm, adm, aqm, matrix->adm_max);
>> +}
