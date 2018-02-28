Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934886AbeB1VXj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 16:23:39 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49598 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933074AbeB1VXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 16:23:37 -0500
Subject: Re: [PATCH v2 01/15] KVM: s390: refactor crypto initialization
To: Cornelia Huck <cohuck@redhat.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
References: <1519741693-17440-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1519741693-17440-2-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180228183741.5276e3d3.cohuck@redhat.com>
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Wed, 28 Feb 2018 16:23:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180228183741.5276e3d3.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18022821-0024-0000-0000-0000032F0D08
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008604; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00996478; UDB=6.00506598; IPR=6.00775800;
 MB=3.00019784; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-28 21:23:34
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022821-0025-0000-0000-0000472E4645
Message-Id: <edab4611-2393-4b82-99af-7d3192b488bc@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-28_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802280259
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/28/2018 12:37 PM, Cornelia Huck wrote:
> On Tue, 27 Feb 2018 09:27:59 -0500
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>
>> The crypto control block designation (CRYCBD) is a 32-bit
>> field in the KVM guest's SIE state description. The
>> contents of bits 1-28 of this field, with three zero bits
>> appended on the right, designate the host real 31-bit
>> address of a crypto control block (CRYCB). Bits 30-31
>> specify the format of the CRYCB. In the current
>> implementation, the address of the CRYCB is stored in
>> the CRYCBD only if the Message-Security-Assist extension
>> 3 (MSA3) facility is installed. Virtualization of AP
>> facilities, however, requires that a CRYCB of the
>> appropriate format be made available to SIE regardless
>> of whether MSA3 is installed or not.
>>
>> This patch introduces a new compilation unit to provide
>> all interfaces related to configuration of AP facilities.
>> Let's start by moving the function for setting the CRYCB
>> format from arch/s390/kvm/kvm-s390 to this new AP
>> configuration interface.
> Hm, I would tweak this patch description a bit. First, you talk about
> what the crycbd is; then, what needs to be done for vfio-ap support;
> then you simply state that you move some interfaces to a new file. I'd
> like to see a connection between those parts :)
>
> [It sounds a bit like you'd just introduce a new file and move some
> functions, while you do have more changes in there.]
I'll try to wordsmith the patch description.
>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>> ---
>>   MAINTAINERS                      |   10 ++++++
>>   arch/s390/include/asm/kvm-ap.h   |   16 ++++++++++
>>   arch/s390/include/asm/kvm_host.h |    1 +
>>   arch/s390/kvm/Makefile           |    2 +-
>>   arch/s390/kvm/kvm-ap.c           |   47 ++++++++++++++++++++++++++++
>>   arch/s390/kvm/kvm-s390.c         |   62 +++++---------------------------------
>>   6 files changed, 83 insertions(+), 55 deletions(-)
>>   create mode 100644 arch/s390/include/asm/kvm-ap.h
>>   create mode 100644 arch/s390/kvm/kvm-ap.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 0ec5881..4acf7c2 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -11875,6 +11875,16 @@ W:	http://www.ibm.com/developerworks/linux/linux390/
>>   S:	Supported
>>   F:	drivers/s390/crypto/
>>   
>> +S390 VFIO AP DRIVER
>> +M:	Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>> +M:	Christian BornTraeger <borntraeger@de.ibm.com>
> Typo.
Will fix
>
>> +M:	Martin Schwidefsky <schwidefsky@de.ibm.com>
>> +L:	linux-s390@vger.kernel.org
>> +W:	http://www.ibm.com/developerworks/linux/linux390/
>> +S:	Supported
>> +F:	arch/s390/include/asm/kvm/kvm-ap.h
>> +F:	arch/s390/kvm/kvm-ap.c
>> +
>>   S390 ZFCP DRIVER
>>   M:	Steffen Maier <maier@linux.vnet.ibm.com>
>>   M:	Benjamin Block <bblock@linux.vnet.ibm.com>
> (...)
>
>> diff --git a/arch/s390/kvm/kvm-ap.c b/arch/s390/kvm/kvm-ap.c
>> new file mode 100644
>> index 0000000..5305f4c
>> --- /dev/null
>> +++ b/arch/s390/kvm/kvm-ap.c
>> @@ -0,0 +1,47 @@
>> +/*
>> + * Adjunct Processor (AP) configuration management for KVM guests
>> + *
>> + * Copyright IBM Corp. 2017
>> + *
>> + * Author(s): Tony Krowiak <akrowia@linux.vnet.ibm.com>
>> + */
>> +
>> +#include <asm/kvm-ap.h>
>> +#include <asm/ap.h>
>> +
>> +#include "kvm-s390.h"
>> +
>> +static int kvm_ap_apxa_installed(void)
>> +{
>> +	int ret;
>> +	struct ap_config_info config;
>> +
>> +	ret = ap_query_configuration(&config);
> Doesn't that introduce a dependency on CONFIG_ZCRYPT?
It does, but AFAIK zcrypt is built into the kernel. Or is that not what 
you are asking?
>
>> +	if (ret)
>> +		return 0;
>> +
>> +	return (config.apxa == 1);
>> +}
>> +KVM guest's use.
>> +/**
>> + * kvm_ap_set_crycb_format
>> + *
>> + * Set the CRYCB format in the CRYCBD for the KVM guest.
> Spell out "crypto control block" somewhere?
Done
>
>> + *
>> + * @kvm:	the KVM guest
>> + * @crycbd:	the CRYCB descriptor
>> + */
>> +void kvm_ap_set_crycb_format(struct kvm *kvm, __u32 *crycbd)
>> +{
>> +	*crycbd = (__u32)(unsigned long) kvm->arch.crypto.crycb;
>> +
>> +	*crycbd &= ~(CRYCB_FORMAT_MASK);
>> +
>> +	/* If the MSAX3 is installed */
> /* check whether MSAX3 is installed */ ?
Sure, why not
>
>> +	if (test_kvm_facility(kvm, 76)) {
>> +		if (kvm_ap_apxa_installed())
>> +			*crycbd |= CRYCB_FORMAT2;
>> +		else
>> +			*crycbd |= CRYCB_FORMAT1;
>> +	}
>> +}
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index 5f5a4cb..de1e299 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -1913,12 +1866,13 @@ static u64 kvm_s390_get_initial_cpuid(void)
>>   
>>   static void kvm_s390_crypto_init(struct kvm *kvm)
>>   {
>> +	kvm->arch.crypto.crycb = &kvm->arch.sie_page2->crycb;
>> +	kvm->arch.crypto.crycbd = (__u32)(unsigned long) kvm->arch.crypto.crycb;
>> +	kvm_ap_set_crycb_format(kvm, &kvm->arch.crypto.crycbd);
> Doesn't kvm_ap_set_crycb_format() already initialize its second
> parameter?
Yes it does. I'm going to have to rework this (see comment below)
>
> Would it make sense to do
>
> kvm->arch.crypto.crycbd = kvm_ap_build_crycbd(kvm);
>
> or so instead?
It would if this was the only place the function gets called. In patch 
2, this is called
from VSIE and it wouldn't make sense in that context. I like your idea, 
let me work on this
and figure out how best to make it happen.
>
>> +
>>   	if (!test_kvm_facility(kvm, 76))
>>   		return;
>>   
>> -	kvm->arch.crypto.crycb = &kvm->arch.sie_page2->crycb;
>> -	kvm_s390_set_crycb_format(kvm);
>> -
>>   	/* Enable AES/DEA protected key functions by default */
>>   	kvm->arch.crypto.aes_kw = 1;
>>   	kvm->arch.crypto.dea_kw = 1;
