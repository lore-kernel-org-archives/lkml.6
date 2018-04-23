Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755714AbeDWPKo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 11:10:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51118 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755680AbeDWPKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 11:10:38 -0400
Subject: Re: [PATCH v10 01/25] mm: introduce CONFIG_SPECULATIVE_PAGE_FAULT
To: Minchan Kim <minchan@kernel.org>
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
 <1523975611-15978-2-git-send-email-ldufour@linux.vnet.ibm.com>
 <20180423055809.GA114098@rodete-desktop-imager.corp.google.com>
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Mon, 23 Apr 2018 17:10:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180423055809.GA114098@rodete-desktop-imager.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18042315-0040-0000-0000-00000450926A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042315-0041-0000-0000-000020F4FA75
Message-Id: <10b5f8da-9c53-f833-1212-7a1eb215d534@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-23_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804230152
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/04/2018 07:58, Minchan Kim wrote:
> Hi Laurent,
> 
> I guess it's good timing to review. Guess LSF/MM goes so might change
> a lot since then. :) Anyway, I grap a time to review.

Hi,

Thanks a lot for reviewing this series.

> On Tue, Apr 17, 2018 at 04:33:07PM +0200, Laurent Dufour wrote:
>> This configuration variable will be used to build the code needed to
>> handle speculative page fault.
>>
>> By default it is turned off, and activated depending on architecture
>> support, SMP and MMU.
> 
> Can we have description in here why it depends on architecture?

The reason is that the per architecture page fault code must handle the
speculative page fault. It is done in this series for x86 and ppc64.

I'll make it explicit here.

> 
>>
>> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
>> Suggested-by: David Rientjes <rientjes@google.com>
>> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
>> ---
>>  mm/Kconfig | 22 ++++++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>>
>> diff --git a/mm/Kconfig b/mm/Kconfig
>> index d5004d82a1d6..5484dca11199 100644
>> --- a/mm/Kconfig
>> +++ b/mm/Kconfig
>> @@ -752,3 +752,25 @@ config GUP_BENCHMARK
>>  	  performance of get_user_pages_fast().
>>  
>>  	  See tools/testing/selftests/vm/gup_benchmark.c
>> +
>> +config ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT
>> +       def_bool n
>> +
>> +config SPECULATIVE_PAGE_FAULT
>> +       bool "Speculative page faults"
>> +       default y
>> +       depends on ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT
>> +       depends on MMU && SMP
>> +       help
>> +         Try to handle user space page faults without holding the mmap_sem.
>> +
>> +	 This should allow better concurrency for massively threaded process
>> +	 since the page fault handler will not wait for other threads memory
>> +	 layout change to be done, assuming that this change is done in another
>> +	 part of the process's memory space. This type of page fault is named
>> +	 speculative page fault.
>> +
>> +	 If the speculative page fault fails because of a concurrency is
>> +	 detected or because underlying PMD or PTE tables are not yet
>> +	 allocating, it is failing its processing and a classic page fault
>> +	 is then tried.
>> -- 
>> 2.7.4
>>
> 
