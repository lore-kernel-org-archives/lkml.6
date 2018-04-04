Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752521AbeDDQEa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 12:04:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57890 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752472AbeDDQE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 12:04:29 -0400
Subject: Re: [PATCH v9 15/24] mm: Introduce __vm_normal_page()
To: David Rientjes <rientjes@google.com>
Cc: paulmck@linux.vnet.ibm.com, peterz@infradead.org,
        akpm@linux-foundation.org, kirill@shutemov.name, ak@linux.intel.com,
        mhocko@kernel.org, dave@stgolabs.net, jack@suse.cz,
        Matthew Wilcox <willy@infradead.org>, benh@kernel.crashing.org,
        mpe@ellerman.id.au, paulus@samba.org,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
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
 <1520963994-28477-16-git-send-email-ldufour@linux.vnet.ibm.com>
 <alpine.DEB.2.20.1804021616370.104195@chino.kir.corp.google.com>
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Wed, 4 Apr 2018 18:04:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1804021616370.104195@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18040416-0044-0000-0000-0000054373B0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040416-0045-0000-0000-000028838B65
Message-Id: <c3103568-41b8-ee54-8f4f-16d3e8c1984f@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-04_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804040161
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/2018 01:18, David Rientjes wrote:
> On Tue, 13 Mar 2018, Laurent Dufour wrote:
> 
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index a84ddc218bbd..73b8b99f482b 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -1263,8 +1263,11 @@ struct zap_details {
>>  	pgoff_t last_index;			/* Highest page->index to unmap */
>>  };
>>  
>> -struct page *_vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
>> -			     pte_t pte, bool with_public_device);
>> +struct page *__vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
>> +			      pte_t pte, bool with_public_device,
>> +			      unsigned long vma_flags);
>> +#define _vm_normal_page(vma, addr, pte, with_public_device) \
>> +	__vm_normal_page(vma, addr, pte, with_public_device, (vma)->vm_flags)
>>  #define vm_normal_page(vma, addr, pte) _vm_normal_page(vma, addr, pte, false)
>>  
>>  struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
> 
> If _vm_normal_page() is a static inline function does it break somehow?  
> It's nice to avoid the #define's.

No problem, I'll create it as a static inline function.

> 
>> diff --git a/mm/memory.c b/mm/memory.c
>> index af0338fbc34d..184a0d663a76 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -826,8 +826,9 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
>>  #else
>>  # define HAVE_PTE_SPECIAL 0
>>  #endif
>> -struct page *_vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
>> -			     pte_t pte, bool with_public_device)
>> +struct page *__vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
>> +			      pte_t pte, bool with_public_device,
>> +			      unsigned long vma_flags)
>>  {
>>  	unsigned long pfn = pte_pfn(pte);
>>  
> 
> Would it be possible to update the comment since the function itself is no 
> longer named vm_normal_page?

Sure.
