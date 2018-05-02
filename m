Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751111AbeEBJIY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 05:08:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53570 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750920AbeEBJHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 05:07:16 -0400
Subject: Re: [PATCH 2/2] arm64/mm: add speculative page fault
To: Ganesh Mahendran <opensource.ganesh@gmail.com>,
        catalin.marinas@arm.com, will.deacon@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Punit Agrawal <punitagrawal@gmail.com>
References: <1525247672-2165-1-git-send-email-opensource.ganesh@gmail.com>
 <1525247672-2165-2-git-send-email-opensource.ganesh@gmail.com>
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Wed, 2 May 2018 11:07:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1525247672-2165-2-git-send-email-opensource.ganesh@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18050209-0012-0000-0000-000005D10CB8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050209-0013-0000-0000-0000194E2C2F
Message-Id: <9e7ab02c-a9af-71ed-afda-108e3b26b2ef@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-02_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805020074
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/2018 09:54, Ganesh Mahendran wrote:
> This patch enables the speculative page fault on the arm64
> architecture.
> 
> I completed spf porting in 4.9. From the test result,
> we can see app launching time improved by about 10% in average.
> For the apps which have more than 50 threads, 15% or even more
> improvement can be got.

Thanks Ganesh,

That's a great improvement, could you please provide details about the apps and
the hardware you used ?

> 
> Signed-off-by: Ganesh Mahendran <opensource.ganesh@gmail.com>
> ---
> This patch is on top of Laurent's v10 spf
> ---
>  arch/arm64/mm/fault.c | 38 +++++++++++++++++++++++++++++++++++---
>  1 file changed, 35 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 4165485..e7992a3 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -322,11 +322,13 @@ static void do_bad_area(unsigned long addr, unsigned int esr, struct pt_regs *re
> 
>  static int __do_page_fault(struct mm_struct *mm, unsigned long addr,
>  			   unsigned int mm_flags, unsigned long vm_flags,
> -			   struct task_struct *tsk)
> +			   struct task_struct *tsk, struct vm_area_struct *vma)
>  {
> -	struct vm_area_struct *vma;
>  	int fault;
> 
> +	if (!vma || !can_reuse_spf_vma(vma, addr))
> +		vma = find_vma(mm, addr);
> +
>  	vma = find_vma(mm, addr);
>  	fault = VM_FAULT_BADMAP;
>  	if (unlikely(!vma))
> @@ -371,6 +373,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
>  	int fault, major = 0;
>  	unsigned long vm_flags = VM_READ | VM_WRITE;
>  	unsigned int mm_flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
> +	struct vm_area_struct *vma;
> 
>  	if (notify_page_fault(regs, esr))
>  		return 0;
> @@ -409,6 +412,25 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
> 
>  	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
> 
> +	if (IS_ENABLED(CONFIG_SPECULATIVE_PAGE_FAULT)) {

As suggested by Punit in his v10's review, the test on
CONFIG_SPECULATIVE_PAGE_FAULT is not needed as handle_speculative_fault() is
defined to return VM_FAULT_RETRY is the config is not set.

> +		fault = handle_speculative_fault(mm, addr, mm_flags, &vma);
> +		/*
> +		 * Page fault is done if VM_FAULT_RETRY is not returned.
> +		 * But if the memory protection keys are active, we don't know
> +		 * if the fault is due to key mistmatch or due to a
> +		 * classic protection check.
> +		 * To differentiate that, we will need the VMA we no
> +		 * more have, so let's retry with the mmap_sem held.
> +		 */

The check of VM_FAULT_SIGSEGV was needed on ppc64 because of the memory
protection key support, but as far as I know, this is not the case on arm64.
Isn't it ?

> +		if (fault != VM_FAULT_RETRY &&
> +			 fault != VM_FAULT_SIGSEGV) {
> +			perf_sw_event(PERF_COUNT_SW_SPF, 1, regs, addr);
> +			goto done;
> +		}
> +	} else {
> +		vma = NULL;
> +	}
> +
>  	/*
>  	 * As per x86, we may deadlock here. However, since the kernel only
>  	 * validly references user space from well defined areas of the code,
> @@ -431,7 +453,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
>  #endif
>  	}
> 
> -	fault = __do_page_fault(mm, addr, mm_flags, vm_flags, tsk);
> +	fault = __do_page_fault(mm, addr, mm_flags, vm_flags, tsk, vma);
>  	major |= fault & VM_FAULT_MAJOR;
> 
>  	if (fault & VM_FAULT_RETRY) {
> @@ -454,11 +476,21 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
>  		if (mm_flags & FAULT_FLAG_ALLOW_RETRY) {
>  			mm_flags &= ~FAULT_FLAG_ALLOW_RETRY;
>  			mm_flags |= FAULT_FLAG_TRIED;
> +
> +			/*
> +			 * Do not try to reuse this vma and fetch it
> +			 * again since we will release the mmap_sem.
> +			 */
> +			if (IS_ENABLED(CONFIG_SPECULATIVE_PAGE_FAULT))
> +				vma = NULL;
> +
>  			goto retry;
>  		}
>  	}
>  	up_read(&mm->mmap_sem);
> 
> +done:
> +
>  	/*
>  	 * Handle the "normal" (no error) case first.
>  	 */
> 
