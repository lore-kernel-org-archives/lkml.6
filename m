Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751421AbeEBOph (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 10:45:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39316 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750921AbeEBOpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 10:45:33 -0400
Subject: Re: [PATCH v10 00/25] Speculative page faults
To: Punit Agrawal <punit.agrawal@arm.com>
Cc: akpm@linux-foundation.org, mhocko@kernel.org, peterz@infradead.org,
        kirill@shutemov.name, ak@linux.intel.com, dave@stgolabs.net,
        jack@suse.cz, Matthew Wilcox <willy@infradead.org>,
        benh@kernel.crashing.org, mpe@ellerman.id.au, paulus@samba.org,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        hpa@zytor.com, Will Deacon <will.deacon@arm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>, kemi.wang@intel.com,
        sergey.senozhatsky.work@gmail.com,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Rientjes <rientjes@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Ganesh Mahendran <opensource.ganesh@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        haren@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com,
        npiggin@gmail.com, bsingharora@gmail.com, paulmck@linux.vnet.ibm.com,
        Tim Chen <tim.c.chen@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org
References: <1523975611-15978-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <87bmdynnv4.fsf@e105922-lin.cambridge.arm.com>
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Wed, 2 May 2018 16:45:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <87bmdynnv4.fsf@e105922-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18050214-0040-0000-0000-000004542C54
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050214-0041-0000-0000-000020F84D4E
Message-Id: <eef94f4f-800e-9994-d926-a71b80552ebc@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-02_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805020121
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/05/2018 16:17, Punit Agrawal wrote:
> Hi Laurent,
> 
> One query below -
> 
> Laurent Dufour <ldufour@linux.vnet.ibm.com> writes:
> 
> [...]
> 
>>
>> Ebizzy:
>> -------
>> The test is counting the number of records per second it can manage, the
>> higher is the best. I run it like this 'ebizzy -mTRp'. To get consistent
>> result I repeated the test 100 times and measure the average result. The
>> number is the record processes per second, the higher is the best.
>>
>>   		BASE		SPF		delta	
>> 16 CPUs x86 VM	12405.52	91104.52	634.39%
>> 80 CPUs P8 node 37880.01	76201.05	101.16%
> 
> How do you measure the number of records processed? Is there a specific
> version of ebizzy that reports this? I couldn't find a way to get this
> information with the ebizzy that's included in ltp.

I'm using the original one : http://ebizzy.sourceforge.net/

> 
>>
>> Here are the performance counter read during a run on a 16 CPUs x86 VM:
>>  Performance counter stats for './ebizzy -mRTp':
>>             860074      faults
>>             856866      spf
>>                285      pagefault:spf_pte_lock
>>               1506      pagefault:spf_vma_changed
>>                  0      pagefault:spf_vma_noanon
>>                 73      pagefault:spf_vma_notsup
>>                  0      pagefault:spf_vma_access
>>                  0      pagefault:spf_pmd_changed
>>
>> And the ones captured during a run on a 80 CPUs Power node:
>>  Performance counter stats for './ebizzy -mRTp':
>>             722695      faults
>>             699402      spf
>>              16048      pagefault:spf_pte_lock
>>               6838      pagefault:spf_vma_changed
>>                  0      pagefault:spf_vma_noanon
>>                277      pagefault:spf_vma_notsup
>>                  0      pagefault:spf_vma_access
>>                  0      pagefault:spf_pmd_changed
>>
>> In ebizzy's case most of the page fault were handled in a speculative way,
>> leading the ebizzy performance boost.
> 
> A trial run showed increased fault handling when SPF is enabled on an
> 8-core ARM64 system running 4.17-rc3. I am using a port of your x86
> patch to enable spf on arm64.
> 
> SPF
> ---
> 
> Performance counter stats for './ebizzy -vvvmTRp':
> 
>          1,322,736      faults                                                      
>          1,299,241      software/config=11/                                         
> 
>       10.005348034 seconds time elapsed
> 
> No SPF
> -----
> 
>  Performance counter stats for './ebizzy -vvvmTRp':
> 
>            708,916      faults
>                  0      software/config=11/
> 
>       10.005807432 seconds time elapsed

Thanks for sharing these good numbers !

> Thanks,
> Punit
> 
> [...]
> 
