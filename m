Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752612AbeCNQCW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 12:02:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46184 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752096AbeCNQCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 12:02:21 -0400
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
 <edab4611-2393-4b82-99af-7d3192b488bc@linux.vnet.ibm.com>
 <20180301105915.5c871524.cohuck@redhat.com>
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Wed, 14 Mar 2018 12:02:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180301105915.5c871524.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18031416-2213-0000-0000-0000027F731A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008673; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01002977; UDB=6.00510395; IPR=6.00782307;
 MB=3.00020033; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-14 16:02:11
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031416-2214-0000-0000-000059697F63
Message-Id: <de105d1d-576f-e416-2c55-81f5d46098e0@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-14_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803140181
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/2018 04:59 AM, Cornelia Huck wrote:
> On Wed, 28 Feb 2018 16:23:29 -0500
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>
>> On 02/28/2018 12:37 PM, Cornelia Huck wrote:
>>> On Tue, 27 Feb 2018 09:27:59 -0500
>>> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>>>> diff --git a/arch/s390/kvm/kvm-ap.c b/arch/s390/kvm/kvm-ap.c
>>>> new file mode 100644
>>>> index 0000000..5305f4c
>>>> --- /dev/null
>>>> +++ b/arch/s390/kvm/kvm-ap.c
>>>> @@ -0,0 +1,47 @@
>>>> +/*
>>>> + * Adjunct Processor (AP) configuration management for KVM guests
>>>> + *
>>>> + * Copyright IBM Corp. 2017
>>>> + *
>>>> + * Author(s): Tony Krowiak <akrowia@linux.vnet.ibm.com>
>>>> + */
>>>> +
>>>> +#include <asm/kvm-ap.h>
>>>> +#include <asm/ap.h>
>>>> +
>>>> +#include "kvm-s390.h"
>>>> +
>>>> +static int kvm_ap_apxa_installed(void)
>>>> +{
>>>> +	int ret;
>>>> +	struct ap_config_info config;
>>>> +
>>>> +	ret = ap_query_configuration(&config);
>>> Doesn't that introduce a dependency on CONFIG_ZCRYPT?
>> It does, but AFAIK zcrypt is built into the kernel. Or is that not what
>> you are asking?
> It is built into the kernel (and not into a module) if CONFIG_ZCRYPT is
> set. When I compile a kernel with CONFIG_KVM set and CONFIG_ZCRYPT
> unset, with this patch applied I get
>
> arch/s390/kvm/kvm-ap.o: In function `kvm_ap_apxa_installed':
> /home/cohuck/git/linux/arch/s390/kvm/kvm-ap.c:19: undefined reference to `ap_query_configuration'
>
> So I'm afraid you cannot use ap_query_configuration() in base s390 kvm
> code unless you move that function to a place where it is always built
> (or at least always built if either CONFIG_KVM or CONFIG_ZCRYPT are
> set).
I was able to get around this by inserting the following into 
arch/s390/kvm/Kconfig:

config KVM
     def_tristate y
     prompt "Kernel-based Virtual Machine (KVM) support"
     depends on HAVE_KVM
     select PREEMPT_NOTIFIERS
...
     select ZCRYPT

If this is a problem, we can discuss it in the v3 which is forthcoming 
very shortly
>
