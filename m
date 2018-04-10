Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751896AbeDJQag (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 12:30:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44904 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751504AbeDJQac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 12:30:32 -0400
Subject: Re: [PATCH v9 16/24] mm: Introduce __page_add_new_anon_rmap()
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
 <1520963994-28477-17-git-send-email-ldufour@linux.vnet.ibm.com>
 <alpine.DEB.2.20.1804021655100.253461@chino.kir.corp.google.com>
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Tue, 10 Apr 2018 18:30:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1804021655100.253461@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18041016-0012-0000-0000-000005C93CA7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041016-0013-0000-0000-000019456923
Message-Id: <0a19747c-8516-d322-9c4f-b6ec41b4dea7@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-10_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804100157
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/2018 01:57, David Rientjes wrote:
> On Tue, 13 Mar 2018, Laurent Dufour wrote:
> 
>> When dealing with speculative page fault handler, we may race with VMA
>> being split or merged. In this case the vma->vm_start and vm->vm_end
>> fields may not match the address the page fault is occurring.
>>
>> This can only happens when the VMA is split but in that case, the
>> anon_vma pointer of the new VMA will be the same as the original one,
>> because in __split_vma the new->anon_vma is set to src->anon_vma when
>> *new = *vma.
>>
>> So even if the VMA boundaries are not correct, the anon_vma pointer is
>> still valid.
>>
>> If the VMA has been merged, then the VMA in which it has been merged
>> must have the same anon_vma pointer otherwise the merge can't be done.
>>
>> So in all the case we know that the anon_vma is valid, since we have
>> checked before starting the speculative page fault that the anon_vma
>> pointer is valid for this VMA and since there is an anon_vma this
>> means that at one time a page has been backed and that before the VMA
>> is cleaned, the page table lock would have to be grab to clean the
>> PTE, and the anon_vma field is checked once the PTE is locked.
>>
>> This patch introduce a new __page_add_new_anon_rmap() service which
>> doesn't check for the VMA boundaries, and create a new inline one
>> which do the check.
>>
>> When called from a page fault handler, if this is not a speculative one,
>> there is a guarantee that vm_start and vm_end match the faulting address,
>> so this check is useless. In the context of the speculative page fault
>> handler, this check may be wrong but anon_vma is still valid as explained
>> above.
>>
>> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> 
> I'm indifferent on this: it could be argued both sides that the new 
> function and its variant for a simple VM_BUG_ON() isn't worth it and it 
> would should rather be done in the callers of page_add_new_anon_rmap().  
> It feels like it would be better left to the caller and add a comment to 
> page_add_anon_rmap() itself in mm/rmap.c.

Well there are 11 calls to page_add_new_anon_rmap() which will need to be
impacted and future ones too.

By introducing __page_add_new_anon_rmap() my goal was to make clear that this
call is *special* and that calling it is not the usual way. This also implies
that most of the time the check is done (when build with the right config) and
that we will not miss some.
