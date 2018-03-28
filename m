Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752677AbeC1LPm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 07:15:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51572 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750774AbeC1LPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 07:15:40 -0400
Subject: Re: [PATCH v9 01/24] mm: Introduce CONFIG_SPECULATIVE_PAGE_FAULT
To: David Rientjes <rientjes@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, paulmck@linux.vnet.ibm.com,
        peterz@infradead.org, akpm@linux-foundation.org, kirill@shutemov.name,
        ak@linux.intel.com, mhocko@kernel.org, dave@stgolabs.net, jack@suse.cz,
        Matthew Wilcox <willy@infradead.org>, benh@kernel.crashing.org,
        mpe@ellerman.id.au, paulus@samba.org, Ingo Molnar <mingo@redhat.com>,
        hpa@zytor.com, Will Deacon <will.deacon@arm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>, kemi.wang@intel.com,
        sergey.senozhatsky.work@gmail.com,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        haren@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com,
        npiggin@gmail.com, bsingharora@gmail.com,
        Tim Chen <tim.c.chen@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org
References: <1520963994-28477-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1520963994-28477-2-git-send-email-ldufour@linux.vnet.ibm.com>
 <alpine.DEB.2.20.1803251442090.80485@chino.kir.corp.google.com>
 <32c80b6a-28c6-bf63-ed7b-6a042ae18e8f@linux.vnet.ibm.com>
 <alpine.DEB.2.20.1803280310380.68839@chino.kir.corp.google.com>
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Wed, 28 Mar 2018 13:15:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1803280310380.68839@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18032811-0012-0000-0000-000005C422CD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032811-0013-0000-0000-00001940617D
Message-Id: <aa678038-9c5c-a8cb-0aed-ef19bde5d623@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-28_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803280123
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/03/2018 12:16, David Rientjes wrote:
> On Wed, 28 Mar 2018, Laurent Dufour wrote:
> 
>>>> This configuration variable will be used to build the code needed to
>>>> handle speculative page fault.
>>>>
>>>> By default it is turned off, and activated depending on architecture
>>>> support.
>>>>
>>>> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
>>>> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
>>>> ---
>>>>  mm/Kconfig | 3 +++
>>>>  1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/mm/Kconfig b/mm/Kconfig
>>>> index abefa573bcd8..07c566c88faf 100644
>>>> --- a/mm/Kconfig
>>>> +++ b/mm/Kconfig
>>>> @@ -759,3 +759,6 @@ config GUP_BENCHMARK
>>>>  	  performance of get_user_pages_fast().
>>>>  
>>>>  	  See tools/testing/selftests/vm/gup_benchmark.c
>>>> +
>>>> +config SPECULATIVE_PAGE_FAULT
>>>> +       bool
>>>
>>> Should this be configurable even if the arch supports it?
>>
>> Actually, this is not configurable unless by manually editing the .config file.
>>
>> I made it this way on the Thomas's request :
>> https://lkml.org/lkml/2018/1/15/969
>>
>> That sounds to be the smarter way to achieve that, isn't it ?
>>
> 
> Putting this in mm/Kconfig is definitely the right way to go about it 
> instead of any generic option in arch/*.
> 
> My question, though, was making this configurable by the user:
> 
> config SPECULATIVE_PAGE_FAULT
> 	bool "Speculative page faults"
> 	depends on X86_64 || PPC
> 	default y
> 	help
> 	  ..
> 
> It's a question about whether we want this always enabled on x86_64 and 
> power or whether the user should be able to disable it (right now they 
> can't).  With a large feature like this, you may want to offer something 
> simple (disable CONFIG_SPECULATIVE_PAGE_FAULT) if someone runs into 
> regressions.

I agree, but I think it would be important to get the per architecture
enablement to avoid complex check here. For instance in the case of powerPC
this is only supported for PPC_BOOK3S_64.

To avoid exposing such per architecture define here, what do you think about
having supporting architectures setting ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT
and the SPECULATIVE_PAGE_FAULT depends on this, like this:

In mm/Kconfig:
config SPECULATIVE_PAGE_FAULT
 	bool "Speculative page faults"
 	depends on ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT && SMP
 	default y
 	help
		...

In arch/powerpc/Kconfig:
config PPC
	...
	select ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT	if PPC_BOOK3S_64

In arch/x86/Kconfig:
config X86_64
	...
	select ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT
