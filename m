Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752591AbeEGODF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 10:03:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47786 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752322AbeEGODD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 10:03:03 -0400
Subject: Re: [PATCH v4 01/15] s390: zcrypt: externalize AP instructions
 available function
To: David Hildenbrand <david@redhat.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com,
        berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
References: <1523827345-11600-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1523827345-11600-2-git-send-email-akrowiak@linux.vnet.ibm.com>
 <7e537cfc-5d67-c188-2890-191608cb7b4f@redhat.com>
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Mon, 7 May 2018 10:02:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <7e537cfc-5d67-c188-2890-191608cb7b4f@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18050714-2213-0000-0000-000002A04E58
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008986; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000258; SDB=6.01028835; UDB=6.00525664; IPR=6.00807969;
 MB=3.00020970; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-07 14:02:55
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050714-2214-0000-0000-00005A07B61E
Message-Id: <6ece398b-49eb-c048-64c7-85acf3801103@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-07_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805070144
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/04/2018 03:19 AM, David Hildenbrand wrote:
> On 15.04.2018 23:22, Tony Krowiak wrote:
>> If the AP instructions are not available on the linux host, then
>> AP devices can not be interpreted by the SIE. The AP bus has a
> This statement is wrong. The instructions can be interpreted by SIE e.g.
> if there are no devices assigned to a guest. This is e.g. the case for
> !CONFIG_ZCRYPT.

While the statement is admittedly poorly worded, it is not wrong.
Without going into architectural details, If the AP instructions
are not available, they will not be interpreted for guest
level 1 - i.e., the linux host. If AP instructions are not interpreted
for guest level 1, then they will not be interpreted for guest
level 2 regardless of whether ECA_APIE is set for guest level 2 or
not. I don't see how CONFIG_ZCRYPT has anything to do with this.


>
> Also, doesn't this directly imply that the other execution control
> should also not be used ("intercept AP instuctions"). This would be bad.
> Just because !CONFIG_ZCRYPT does not imply that you can't emulate AP
> devices for a guest.

Setting CONFIG_ZCRYPT=n simply means that the AP bus will not be built
and therefore the AP bus interfaces will not be available to KVM.
As far as ECA_APIE goes, there are only two choices: Set the bit to
enable SIE interpretation of AP instructions; Clear the bit to use
interception. We are only supporting SIE interpretation of AP
instructions at this time, so we need a sure-fire way to determine
if the AP instructions are installed, which is the point of this patch.
Since there are no intercept handlers at this time, when the AP bus
module on the guest is initialized, the init function will fail and
the bus will not come up. There are protections built into userspace
(QEMU in this case) to ensure that a guest is not started if the CPU
model feature for AP instructions is not turned on for the guest. The
CPU model feature will be enabled by the KVM only if the AP instructions
are installed on the linux host. Again, that is reason for this
patch.

>
> Why isn't it sufficient to glue CONFIG_ZCRYPT to vfio-ap? This would
> make more sense in my opinion. You have no "host devices" that you can
> "pass through". But you can still emulate devices or emulate an empty bus.

As I commented above, we are supporting only pass through AP devices
at this time.

>
>> function it uses to determine if the AP instructions are
>> available. This patch provides a new function that wraps the
>> AP bus's function to externalize it for use by KVM.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>> Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
>> Reviewed-by: Harald Freudenberger <freude@linux.vnet.ibm.com>
>> ---
>>   arch/s390/include/asm/ap.h     |    7 +++++++
>>   arch/s390/include/asm/kvm-ap.h |   23 +++++++++++++++++++++++
>>   arch/s390/kvm/Makefile         |    2 +-
>>   arch/s390/kvm/kvm-ap.c         |   21 +++++++++++++++++++++
>>   drivers/s390/crypto/ap_bus.c   |    6 ++++++
>>   5 files changed, 58 insertions(+), 1 deletions(-)
>>   create mode 100644 arch/s390/include/asm/kvm-ap.h
>>   create mode 100644 arch/s390/kvm/kvm-ap.c
>>
>> diff --git a/arch/s390/include/asm/ap.h b/arch/s390/include/asm/ap.h
>> index c1bedb4..7773bfd 100644
>> --- a/arch/s390/include/asm/ap.h
>> +++ b/arch/s390/include/asm/ap.h
>> @@ -120,4 +120,11 @@ struct ap_queue_status ap_queue_irq_ctrl(ap_qid_t qid,
>>   					 struct ap_qirq_ctrl qirqctrl,
>>   					 void *ind);
>>   
>> +/**
>> + * ap_instructions_installed() - Tests whether AP instructions are installed
>> + *
>> + * Returns 1 if the AP instructions are installed, otherwise; returns 0
>> + */
>> +int ap_instructions_installed(void);
>> +
>>   #endif /* _ASM_S390_AP_H_ */
>> diff --git a/arch/s390/include/asm/kvm-ap.h b/arch/s390/include/asm/kvm-ap.h
>> new file mode 100644
>> index 0000000..84412a9
>> --- /dev/null
>> +++ b/arch/s390/include/asm/kvm-ap.h
>> @@ -0,0 +1,23 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Adjunct Processor (AP) configuration management for KVM guests
>> + *
>> + * Copyright IBM Corp. 2018
>> + *
>> + * Author(s): Tony Krowiak <akrowia@linux.vnet.ibm.com>
>> + */
>> +
>> +#ifndef _ASM_KVM_AP
>> +#define _ASM_KVM_AP
>> +
>> +/**
>> + * kvm_ap_instructions_installed()
>> + *
>> + * Tests whether AP instructions are installed on the linux host
>> + *
>> + * Returns 1 if the AP instructions are installed on the host, otherwise;
>> + * returns 0
>> + */
>> +int kvm_ap_instructions_installed(void);
>> +
>> +#endif /* _ASM_KVM_AP */
>> diff --git a/arch/s390/kvm/Makefile b/arch/s390/kvm/Makefile
>> index 05ee90a..1876bfe 100644
>> --- a/arch/s390/kvm/Makefile
>> +++ b/arch/s390/kvm/Makefile
>> @@ -9,6 +9,6 @@ common-objs = $(KVM)/kvm_main.o $(KVM)/eventfd.o  $(KVM)/async_pf.o $(KVM)/irqch
>>   ccflags-y := -Ivirt/kvm -Iarch/s390/kvm
>>   
>>   kvm-objs := $(common-objs) kvm-s390.o intercept.o interrupt.o priv.o sigp.o
>> -kvm-objs += diag.o gaccess.o guestdbg.o vsie.o
>> +kvm-objs += diag.o gaccess.o guestdbg.o vsie.o kvm-ap.o
>>   
>>   obj-$(CONFIG_KVM) += kvm.o
>> diff --git a/arch/s390/kvm/kvm-ap.c b/arch/s390/kvm/kvm-ap.c
>> new file mode 100644
>> index 0000000..1267588
>> --- /dev/null
>> +++ b/arch/s390/kvm/kvm-ap.c
>> @@ -0,0 +1,21 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Adjunct Processor (AP) configuration management for KVM guests
>> + *
>> + * Copyright IBM Corp. 2018
>> + *
>> + * Author(s): Tony Krowiak <akrowia@linux.vnet.ibm.com>
>> + */
>> +#include <linux/kernel.h>
>> +#include <asm/kvm-ap.h>
>> +#include <asm/ap.h>
>> +
>> +int kvm_ap_instructions_installed(void)
>> +{
>> +#ifdef CONFIG_ZCRYPT
>> +	return ap_instructions_installed();
>> +#else
>> +	return 0;
>> +#endif
>> +}
>> +EXPORT_SYMBOL(kvm_ap_instructions_installed);
>> diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
>> index 35a0c2b..9d108b6 100644
>> --- a/drivers/s390/crypto/ap_bus.c
>> +++ b/drivers/s390/crypto/ap_bus.c
>> @@ -210,6 +210,12 @@ int ap_query_configuration(struct ap_config_info *info)
>>   }
>>   EXPORT_SYMBOL(ap_query_configuration);
>>   
>> +int ap_instructions_installed(void)
>> +{
>> +	return (ap_instructions_available() == 0);
>> +}
>> +EXPORT_SYMBOL(ap_instructions_installed);
>> +
>>   /**
>>    * ap_init_configuration(): Allocate and query configuration array.
>>    */
>>
>
