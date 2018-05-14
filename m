Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932499AbeENOrz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 10:47:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46212 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753760AbeENOrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 10:47:53 -0400
Subject: Re: [PATCH v10 02/25] x86/mm: define
 ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT
To: Punit Agrawal <punit.agrawal@arm.com>, akpm@linux-foundation.org
Cc: mhocko@kernel.org, peterz@infradead.org, kirill@shutemov.name,
        ak@linux.intel.com, dave@stgolabs.net, jack@suse.cz,
        Matthew Wilcox <willy@infradead.org>, benh@kernel.crashing.org,
        mpe@ellerman.id.au, paulus@samba.org,
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
 <1523975611-15978-3-git-send-email-ldufour@linux.vnet.ibm.com>
 <87sh72jtmn.fsf@e105922-lin.cambridge.arm.com>
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Mon, 14 May 2018 16:47:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <87sh72jtmn.fsf@e105922-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18051414-0008-0000-0000-000004F65D93
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051414-0009-0000-0000-00001E8ABD96
Message-Id: <c289a58f-8afa-34c7-2624-c7bd2f6fcf48@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-14_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805140152
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/2018 13:04, Punit Agrawal wrote:
> Hi Laurent,
> 
> Laurent Dufour <ldufour@linux.vnet.ibm.com> writes:
> 
>> Set ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT which turns on the
>> Speculative Page Fault handler when building for 64bit.
>>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
>> ---
>>  arch/x86/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index d8983df5a2bc..ebdeb48e4a4a 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -30,6 +30,7 @@ config X86_64
>>  	select MODULES_USE_ELF_RELA
>>  	select X86_DEV_DMA_OPS
>>  	select ARCH_HAS_SYSCALL_WRAPPER
>> +	select ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT
> 
> I'd suggest merging this patch with the one making changes to the
> architectural fault handler towards the end of the series.
> 
> The Kconfig change is closely tied to the architectural support for SPF
> and makes sense to be in a single patch.
> 
> If there's a good reason to keep them as separate patches, please move
> the architecture Kconfig changes after the patch adding fault handler
> changes.
> 
> It's better to enable the feature once the core infrastructure is merged
> rather than at the beginning of the series to avoid potential bad
> fallout from incomplete functionality during bisection.

Indeed bisection was the reason why Andrew asked me to push the configuration
enablement on top of the series (https://lkml.org/lkml/2017/10/10/1229).

I also think it would be better to have the architecture enablement in on patch
but that would mean that the code will not be build when bisecting without the
latest patch adding the per architecture code.

I'm fine with the both options.

Andrew, what do you think would be the best here ?

Thanks,
Laurent.

> 
> All the comments here definitely hold for the arm64 patches that you
> plan to include with the next update.
> 
> Thanks,
> Punit
> 
>>  
>>  #
>>  # Arch settings
> 
