Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756688AbeDFOZD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 10:25:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34322 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1756730AbeDFOXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 10:23:32 -0400
Subject: Re: [PATCH v9 17/24] mm: Protect mm_rb tree with a rwlock
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
 <1520963994-28477-18-git-send-email-ldufour@linux.vnet.ibm.com>
 <alpine.DEB.2.20.1804021711090.34466@chino.kir.corp.google.com>
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Fri, 6 Apr 2018 16:23:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1804021711090.34466@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18040614-0044-0000-0000-00000544474A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040614-0045-0000-0000-0000288469DD
Message-Id: <dd22fde2-ea3d-5492-9f1d-4f39c72b2a68@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-06_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804060147
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/04/2018 02:11, David Rientjes wrote:
> On Tue, 13 Mar 2018, Laurent Dufour wrote:
> 
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
> 
> Can __free_vma() be generalized for mm/nommu.c's delete_vma() and 
> do_mmap()?

To be honest I didn't look at mm/nommu.c assuming that such architecture would
probably be monothreaded. Am I wrong ?
