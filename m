Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751080AbeEBGh5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 02:37:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51210 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750836AbeEBGhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 02:37:55 -0400
Subject: Re: [PATCH v10 17/25] mm: protect mm_rb tree with a rwlock
To: Punit Agrawal <punitagrawal@gmail.com>
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
 <1523975611-15978-18-git-send-email-ldufour@linux.vnet.ibm.com>
 <CAD4BONeTCmSZgzThatyY66xVx1a9nCgNO+LCory0h9ZpBkn_+w@mail.gmail.com>
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Wed, 2 May 2018 08:37:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAD4BONeTCmSZgzThatyY66xVx1a9nCgNO+LCory0h9ZpBkn_+w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18050206-0044-0000-0000-0000054E0147
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050206-0045-0000-0000-0000288F1F94
Message-Id: <ba549aef-a13e-8cb0-2788-247cad1e7ba6@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-02_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805020065
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Punit,

Thanks for reviewing this series.

On 30/04/2018 20:47, Punit Agrawal wrote:
> Hi Laurent,
> 
> One nitpick below.
> 
> On Tue, Apr 17, 2018 at 3:33 PM, Laurent Dufour
> <ldufour@linux.vnet.ibm.com> wrote:
>> This change is inspired by the Peter's proposal patch [1] which was
>> protecting the VMA using SRCU. Unfortunately, SRCU is not scaling well in
>> that particular case, and it is introducing major performance degradation
>> due to excessive scheduling operations.
>>
>> To allow access to the mm_rb tree without grabbing the mmap_sem, this patch
>> is protecting it access using a rwlock.  As the mm_rb tree is a O(log n)
>> search it is safe to protect it using such a lock.  The VMA cache is not
>> protected by the new rwlock and it should not be used without holding the
>> mmap_sem.
>>
>> To allow the picked VMA structure to be used once the rwlock is released, a
>> use count is added to the VMA structure. When the VMA is allocated it is
>> set to 1.  Each time the VMA is picked with the rwlock held its use count
>> is incremented. Each time the VMA is released it is decremented. When the
>> use count hits zero, this means that the VMA is no more used and should be
>> freed.
>>
>> This patch is preparing for 2 kind of VMA access :
>>  - as usual, under the control of the mmap_sem,
>>  - without holding the mmap_sem for the speculative page fault handler.
>>
>> Access done under the control the mmap_sem doesn't require to grab the
>> rwlock to protect read access to the mm_rb tree, but access in write must
>> be done under the protection of the rwlock too. This affects inserting and
>> removing of elements in the RB tree.
>>
>> The patch is introducing 2 new functions:
>>  - vma_get() to find a VMA based on an address by holding the new rwlock.
>>  - vma_put() to release the VMA when its no more used.
>> These services are designed to be used when access are made to the RB tree
>> without holding the mmap_sem.
>>
>> When a VMA is removed from the RB tree, its vma->vm_rb field is cleared and
>> we rely on the WMB done when releasing the rwlock to serialize the write
>> with the RMB done in a later patch to check for the VMA's validity.
>>
>> When free_vma is called, the file associated with the VMA is closed
>> immediately, but the policy and the file structure remained in used until
>> the VMA's use count reach 0, which may happens later when exiting an
>> in progress speculative page fault.
>>
>> [1] https://patchwork.kernel.org/patch/5108281/
>>
>> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
>> ---
>>  include/linux/mm.h       |   1 +
>>  include/linux/mm_types.h |   4 ++
>>  kernel/fork.c            |   3 ++
>>  mm/init-mm.c             |   3 ++
>>  mm/internal.h            |   6 +++
>>  mm/mmap.c                | 115 +++++++++++++++++++++++++++++++++++------------
>>  6 files changed, 104 insertions(+), 28 deletions(-)
>>
> 
> [...]
> 
>> diff --git a/mm/mmap.c b/mm/mmap.c
>> index 5601f1ef8bb9..a82950960f2e 100644
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
>> @@ -160,6 +160,27 @@ void unlink_file_vma(struct vm_area_struct *vma)
>>         }
>>  }
>>
>> +static void __free_vma(struct vm_area_struct *vma)
>> +{
>> +       if (vma->vm_file)
>> +               fput(vma->vm_file);
>> +       mpol_put(vma_policy(vma));
>> +       kmem_cache_free(vm_area_cachep, vma);
>> +}
>> +
>> +#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
>> +void put_vma(struct vm_area_struct *vma)
>> +{
>> +       if (atomic_dec_and_test(&vma->vm_ref_count))
>> +               __free_vma(vma);
>> +}
>> +#else
>> +static inline void put_vma(struct vm_area_struct *vma)
>> +{
>> +       return __free_vma(vma);
> 
> Please drop the "return".

Sure !
Thanks.

> 
> Thanks,
> Punit
> 
> [...]
> 
