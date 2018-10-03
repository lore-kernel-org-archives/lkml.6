Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C670C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0D852098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:34:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0D852098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbeJCUW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 16:22:26 -0400
Received: from foss.arm.com ([217.140.101.70]:51304 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbeJCUW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 16:22:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F0CE7A9;
        Wed,  3 Oct 2018 06:34:00 -0700 (PDT)
Received: from [10.4.12.81] (melchizedek.Emea.Arm.com [10.4.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CCD353F5B7;
        Wed,  3 Oct 2018 06:33:58 -0700 (PDT)
Subject: Re: [PATCH v5 0/6] Move swapper_pg_dir to rodata section.
To:     Mark Rutland <mark.rutland@arm.com>, catalin.marinas@arm.com
References: <20180917044333.30051-1-yaojun8558363@gmail.com>
 <20180924171936.q5bfvczzllmm5lpe@lakrids.cambridge.arm.com>
 <20180925095316.GA27420@toy>
 <20180925140624.7wovo2xtpyihyt3j@lakrids.cambridge.arm.com>
From:   James Morse <james.morse@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, will.deacon@arm.com,
        linux-kernel@vger.kernel.org
Message-ID: <0f9a3abc-4890-faf5-ee7e-18434641b858@arm.com>
Date:   Wed, 3 Oct 2018 14:33:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180925140624.7wovo2xtpyihyt3j@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin, Mark,

On 25/09/18 15:06, Mark Rutland wrote:
> On Tue, Sep 25, 2018 at 05:53:16PM +0800, Jun Yao wrote:
>> On Mon, Sep 24, 2018 at 06:19:36PM +0100, Mark Rutland wrote:
>>> I've pushed a branch with the cleanups I requested [1] folded in.
>>>
>>> I'm still a bit worried about the pgd lock, but otherwise I think this
>>> is sound. I intend to throw some testing at it, just in case.
>>>
>>> If you're happy with that branch, I'll ask Will and Catalin to consider
>>> picking it up.
>>
>> This branch looks great. Thank you for improving my patch.
> 
> Thanks for your patches!
> 
>> Is there anything I need to do? This is my first time to submit a patch,
>> so I am a bit overwhelmed. I think I should wait for other people to
>> review my patch. If there is a problem, I need to fix it.
> 
> Hopefully Catalin is happy to pick this up from my branch, and neither
> of us have to do anything. :)
> 
> Catalin, are you happy to pick the patches from:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm64/ro-swapper
> 
> ... that should be based on the arm64 for-next/core branch, and has
> James's R-B prior to my commit fixup notes.
> 
> I've given this some basic testing with defconfig, 48-bit/4k and
> 42-bit/64k (with lockdep on in both cases), and things seem fine.

Re-running my hacky tests for this series knocks for-next/core over:
| Unable to handle kernel write to read-only memory at virtual address
fffffc00092b0008
| Mem abort info:
|   ESR = 0x9600004f
|   Exception class = DABT (current EL), IL = 32 bits
|   SET = 0, FnV = 0
|   EA = 0, S1PTW = 0
| Data abort info:
|   ISV = 0, ISS = 0x0000004f
|   CM = 0, WnR = 1
| swapper pgtable: 64k pages, 42-bit VAs, pgdp = 00000000992f9c42
| [fffffc00092b0008] pgd=00000087ffff0803, pud=00000087ffff0803,
pmd=00000087ffff0803, pte=00e00080032b0f93
| Internal error: Oops: 9600004f [#1] PREEMPT SMP
| Modules linked in:
| CPU: 4 PID: 13938 Comm: hackbench Tainted: G        W
4.19.0-rc2-00063-gc219bc4e9205 #10628
| Hardware name: AMD Seattle (Rev.B0) Development Board (Overdrive) (DT)
| pstate: a0400005 (NzCv daif +PAN -UAO)
| pc : __pte_alloc_kernel+0x60/0xd8
| lr : __pte_alloc_kernel+0x44/0xd8

| Process hackbench (pid: 13938, stack limit = 0x000000007ca756ec)
| Call trace:
|  __pte_alloc_kernel+0x60/0xd8
|  vmap_page_range_noflush+0x1bc/0x1d8
|  map_vm_area+0x30/0x40
|  __vmalloc_node_range+0x1e4/0x2e8
|  copy_process.isra.3.part.4+0x1e8/0x1ae8
|  _do_fork+0xd0/0x7f0
|  __arm64_sys_clone+0x1c/0x28

|  el0_svc_handler+0x7c/0x130

|  el0_svc+0x8/0xc

| Code: 90007b60 f946e000 cb000273 b2400673 (f9000293)

|  ---[ end trace 7bf2d2ffce498c7a ]---

| Kernel panic - not syncing: Fatal exception


The below patch fixes it: I'll post it properly shortly...
-----------------------%<-----------------------
Author: James Morse <james.morse@arm.com>
Date:   Wed Oct 3 12:03:38 2018 +0100

    asm-generic/pgtable-nop?d.h: define folded with a value for use in C

    It turns out "if (__is_defined(__PAGETABLE_PMD_FOLDED))" isn't equivalent
    to "#ifdef __PAGETABLE_PMD_FOLDED". (who knew!)

    kconfig.h's __is_defined() expects a define of the form
    "#define CONFIG_BOOGER 1". But these nop?d headers just have
    "#define __PAGETABLE_PMD_FOLDED".

    This means ____is_defined()'s triplet passed to __take_second_arg() is
    'empty-string 1 0' in both cases, meaning these symbols can't be used
    from C. (they are always false).

    asm-generic gets away with this as its using the pre-processor's
    defined() macro on this, not the C __is_defined().

    Add the expected '1'.

    Signed-off-by: James Morse <james.morse@arm.com>

diff --git a/include/asm-generic/pgtable-nopmd.h
b/include/asm-generic/pgtable-nopmd.h
index f35f6e8149e4..fcb4769a075a 100644
--- a/include/asm-generic/pgtable-nopmd.h
+++ b/include/asm-generic/pgtable-nopmd.h
@@ -8,7 +8,7 @@

 struct mm_struct;

-#define __PAGETABLE_PMD_FOLDED
+#define __PAGETABLE_PMD_FOLDED 1

 /*
  * Having the pmd type consist of a pud gets the size right, and allows
diff --git a/include/asm-generic/pgtable-nopud.h
b/include/asm-generic/pgtable-nopud.h
index e950b9c50f34..d300dbcddaf3 100644
--- a/include/asm-generic/pgtable-nopud.h
+++ b/include/asm-generic/pgtable-nopud.h
@@ -9,7 +9,7 @@
 #else
 #include <asm-generic/pgtable-nop4d.h>

-#define __PAGETABLE_PUD_FOLDED
+#define __PAGETABLE_PUD_FOLDED 1

 /*
  * Having the pud type consist of a p4d gets the size right, and allows
-----------------------%<-----------------------


(and, while digging through this, I spotted:
| #define set_pmd_at(mm, addr, pmdp, pmd)	
|	set_pte_at(mm, addr, (pte_t *)pmdp, pmd_pte(pmd))
which may trip up too)


Thanks,

James
