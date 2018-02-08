Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752318AbeBHROS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 12:14:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57202 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751988AbeBHROQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 12:14:16 -0500
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: Re: [PATCH v7 04/24] mm: Dont assume page-table invariance during
 faults
To: Matthew Wilcox <willy@infradead.org>
Cc: paulmck@linux.vnet.ibm.com, peterz@infradead.org,
        akpm@linux-foundation.org, kirill@shutemov.name, ak@linux.intel.com,
        mhocko@kernel.org, dave@stgolabs.net, jack@suse.cz,
        benh@kernel.crashing.org, mpe@ellerman.id.au, paulus@samba.org,
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
References: <1517935810-31177-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1517935810-31177-5-git-send-email-ldufour@linux.vnet.ibm.com>
 <20180206202831.GB16511@bombadil.infradead.org>
 <484242d8-e632-9e39-5c99-2e1b4b3b69a5@linux.vnet.ibm.com>
 <20180208150025.GD15846@bombadil.infradead.org>
Date: Thu, 8 Feb 2018 18:14:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180208150025.GD15846@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18020817-0008-0000-0000-000004CAD980
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020817-0009-0000-0000-00001E5E8E41
Message-Id: <79917740-7068-2328-2c02-1532054f357e@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-08_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802080200
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/02/2018 16:00, Matthew Wilcox wrote:
> On Thu, Feb 08, 2018 at 03:35:58PM +0100, Laurent Dufour wrote:
>> I reviewed that part of code, and I think I could now change the way
>> pte_unmap_safe() is checking for the pte's value. Since we now have all the
>> needed details in the vm_fault structure, I will pass it to
>> pte_unamp_same() and deal with the VMA checks when locking for the pte as
>> it is done in the other part of the page fault handler by calling
>> pte_spinlock().
> 
> This does indeed look much better!  Thank you!
> 
>> This means that this patch will be dropped, and pte_unmap_same() will become :
>>
>> static inline int pte_unmap_same(struct vm_fault *vmf, int *same)
>> {
>> 	int ret = 0;
>>
>> 	*same = 1;
>> #if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT)
>> 	if (sizeof(pte_t) > sizeof(unsigned long)) {
>> 		if (pte_spinlock(vmf)) {
>> 			*same = pte_same(*vmf->pte, vmf->orig_pte);
>> 			spin_unlock(vmf->ptl);
>> 		}
>> 		else
>> 			ret = VM_FAULT_RETRY;
>> 	}
>> #endif
>> 	pte_unmap(vmf->pte);
>> 	return ret;
>> }
> 
> I'm not a huge fan of auxiliary return values.  Perhaps we could do this
> instead:
> 
> 	ret = pte_unmap_same(vmf);
> 	if (ret != VM_FAULT_NOTSAME) {
> 		if (page)
> 			put_page(page);
> 		goto out;
> 	}
> 	ret = 0;
> 
> (we have a lot of unused bits in VM_FAULT_, so adding a new one shouldn't
> be a big deal)

I do agree, using an auxiliary return value is not a good idea.

What about the following changes based on your suggestion ?

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7de4323b9e89..0cd31a37bb3d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1212,6 +1212,7 @@ static inline void clear_page_pfmemalloc(struct page *page)
 #define VM_FAULT_NEEDDSYNC  0x2000     /* ->fault did not modify page tables
                                         * and needs fsync() to complete (for
                                         * synchronous page faults in DAX) */
+#define VM_FAULT_PTNOTSAME 0x4000      /* Page table entries have changed */
 
 #define VM_FAULT_ERROR (VM_FAULT_OOM | VM_FAULT_SIGBUS | VM_FAULT_SIGSEGV | \
                         VM_FAULT_HWPOISON | VM_FAULT_HWPOISON_LARGE | \
diff --git a/mm/memory.c b/mm/memory.c
index b7da99c74fef..c9b419f8e4c5 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2433,21 +2433,30 @@ static inline bool pte_map_lock(struct vm_fault *vmf)
  * parts, do_swap_page must check under lock before unmapping the pte and
  * proceeding (but do_wp_page is only called after already making such a check;
  * and do_anonymous_page can safely check later on).
+ *
+ * pte_unmap_same() returns:
+ *     0                       if the PTE are the same
+ *     VM_FAULT_PTNOTSAME      if the PTE are different
+ *     VM_FAULT_RETRY          if the VMA has changed in our back during
+ *                             a speculative page fault handling.
  */
-static inline int pte_unmap_same(struct mm_struct *mm, pmd_t *pmd,
-                               pte_t *page_table, pte_t orig_pte)
+static inline int pte_unmap_same(struct vm_fault *vmf)
 {
-       int same = 1;
+       int ret = 0;
+
 #if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT)
        if (sizeof(pte_t) > sizeof(unsigned long)) {
-               spinlock_t *ptl = pte_lockptr(mm, pmd);
-               spin_lock(ptl);
-               same = pte_same(*page_table, orig_pte);
-               spin_unlock(ptl);
+               if (pte_spinlock(vmf)) {
+                       if (!pte_same(*vmf->pte, vmf->orig_pte))
+                               ret = VM_FAULT_PTNOTSAME;
+                       spin_unlock(vmf->ptl);
+               }
+               else
+                       ret = VM_FAULT_RETRY;
        }
 #endif
-       pte_unmap(page_table);
-       return same;
+       pte_unmap(vmf->pte);
+       return ret;
 }
 
 static inline void cow_user_page(struct page *dst, struct page *src, unsigned long va, struct vm_area_struct *vma)
@@ -3037,7 +3046,7 @@ int do_swap_page(struct vm_fault *vmf)
        pte_t pte;
        int locked;
        int exclusive = 0;
-       int ret = 0;
+       int ret;
        bool vma_readahead = swap_use_vma_readahead();
 
        if (vma_readahead) {
@@ -3045,9 +3054,16 @@ int do_swap_page(struct vm_fault *vmf)
                swapcache = page;
        }
 
-       if (!pte_unmap_same(vma->vm_mm, vmf->pmd, vmf->pte, vmf->orig_pte)) {
+       ret = pte_unmap_same(vmf);
+       if (ret) {
                if (page)
                        put_page(page);
+               /*
+                * In the case the PTE are different, meaning that the
+                * page has already been processed by another CPU, we return 0.
+                */
+               if (ret == VM_FAULT_PTNOTSAME)
+                       ret = 0;
                goto out;
        }

Thanks,
Laurent.
