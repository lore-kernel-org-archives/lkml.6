Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752290AbeC1IQi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 04:16:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33774 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751191AbeC1IQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 04:16:33 -0400
Subject: Re: [PATCH v9 05/24] mm: Introduce pte_spinlock for
 FAULT_FLAG_SPECULATIVE
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
 <1520963994-28477-6-git-send-email-ldufour@linux.vnet.ibm.com>
 <alpine.DEB.2.20.1803251446180.80485@chino.kir.corp.google.com>
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Wed, 28 Mar 2018 10:15:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1803251446180.80485@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18032808-0040-0000-0000-000004463BCC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032808-0041-0000-0000-000020EA49EB
Message-Id: <56b596fe-f235-7033-348b-b0d6c9481f2c@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-28_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803280084
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/2018 23:50, David Rientjes wrote:
> On Tue, 13 Mar 2018, Laurent Dufour wrote:
> 
>> When handling page fault without holding the mmap_sem the fetch of the
>> pte lock pointer and the locking will have to be done while ensuring
>> that the VMA is not touched in our back.
>>
>> So move the fetch and locking operations in a dedicated function.
>>
>> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
>> ---
>>  mm/memory.c | 15 +++++++++++----
>>  1 file changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 8ac241b9f370..21b1212a0892 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -2288,6 +2288,13 @@ int apply_to_page_range(struct mm_struct *mm, unsigned long addr,
>>  }
>>  EXPORT_SYMBOL_GPL(apply_to_page_range);
>>  
>> +static bool pte_spinlock(struct vm_fault *vmf)
> 
> inline?

You're right.
Indeed this was done in the patch 18 : "mm: Provide speculative fault
infrastructure", but this has to be done there too, I'll fix that.

> 
>> +{
>> +	vmf->ptl = pte_lockptr(vmf->vma->vm_mm, vmf->pmd);
>> +	spin_lock(vmf->ptl);
>> +	return true;
>> +}
>> +
>>  static bool pte_map_lock(struct vm_fault *vmf)
>>  {
>>  	vmf->pte = pte_offset_map_lock(vmf->vma->vm_mm, vmf->pmd,
> 
> Shouldn't pte_unmap_same() take struct vm_fault * and use the new 
> pte_spinlock()?

done in the next patch, but you already acked it..
