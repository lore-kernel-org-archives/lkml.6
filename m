Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A8EC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8534243E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:43:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8534243E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933569AbeFVOnW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 10:43:22 -0400
Received: from foss.arm.com ([217.140.101.70]:36150 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932752AbeFVOnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 10:43:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C61C680D;
        Fri, 22 Jun 2018 07:43:10 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9291F3F2EA;
        Fri, 22 Jun 2018 07:43:10 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 0C7331AE311D; Fri, 22 Jun 2018 15:43:46 +0100 (BST)
Date:   Fri, 22 Jun 2018 15:43:46 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Wei Xu <xuwei5@hisilicon.com>
Cc:     James Morse <james.morse@arm.com>, catalin.marinas@arm.com,
        suzuki.poulose@arm.com, dave.martin@arm.com, mark.rutland@arm.com,
        marc.zyngier@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linuxarm <linuxarm@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>, xiexiuqi@huawei.com,
        huangdaode <huangdaode@hisilicon.com>,
        "Chenxin (Charles)" <charles.chenxin@huawei.com>,
        "Xiongfanggou (James)" <james.xiong@huawei.com>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
        Zhangyi ac <zhangyi.ac@huawei.com>,
        jonathan.cameron@huawei.com,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        John Garry <john.garry@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Shiju Jose <shiju.jose@huawei.com>,
        "Zhuangyuzeng (Yisen)" <yisen.zhuang@huawei.com>,
        "Wangzhou (B)" <wangzhou1@hisilicon.com>,
        "kongxinwei (A)" <kong.kongxinwei@hisilicon.com>,
        "Liyuan (Larry, Turing Solution)" <Larry.T@huawei.com>,
        libeijian@hisilicon.com, zhangbin011@hisilicon.com
Subject: Re: KVM guest sometimes failed to boot because of kernel stack
 overflow if KPTI is enabled on a hisilicon ARM64 platform.
Message-ID: <20180622144346.GB1802@arm.com>
References: <20180621091850.GA22505@arm.com>
 <5B2B7A84.8090309@hisilicon.com>
 <20180621105404.GB22505@arm.com>
 <5B2CB440.8040705@hisilicon.com>
 <20180622092330.GD7601@arm.com>
 <5B2CD33B.9020702@hisilicon.com>
 <20180622111614.GA1150@arm.com>
 <5B2CF723.7010600@hisilicon.com>
 <20180622133133.GA1802@arm.com>
 <5B2CFDCD.6040207@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B2CFDCD.6040207@hisilicon.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 09:46:53PM +0800, Wei Xu wrote:
> On 2018/6/22 21:31, Will Deacon wrote:
> >On Fri, Jun 22, 2018 at 09:18:27PM +0800, Wei Xu wrote:
> >>On 2018/6/22 19:16, Will Deacon wrote:
> >>>On Fri, Jun 22, 2018 at 06:45:15PM +0800, Wei Xu wrote:
> >>>>On 2018/6/22 17:23, Will Deacon wrote:
> >>>>>Perhaps just writing back the table entries is enough to cause the issue,
> >>>>>although I really can't understand why that would be the case. Can you try
> >>>>>the diff below (without my previous change), please?
> >>>>Thanks!
> >>>>But it does not resolve the issue(only apply this patch based on 4.17.0).
> >>>Thanks, that's a useful data point. It means that it still crashes even if
> >>>we write back the same table entries, so it's the fact that we're writing
> >>>them at all which causes the problem, not the value that we write.
> >>>
> >>>Whilst looking at the code, we noticed a missing DMB. On the off-chance
> >>>that it helps, can you try this instead please?
> >>Thanks!
> >>Only apply below patch based on 4.17.0, we still got the crash.
> >Oh well, it was worth a shot (and that's still a fix worth having). Please
> >can you provide the complete disassembly for kpti_install_ng_mappings()
> >(I'm referring to the C function in cpufeature.c) along with a corresponding
> >crash log so that we can correlate the instruction stream with the crash?
> Just let me know if you need more information.

Thanks; the disassembly and log are really helpful.

I have another patch for you to try below. Please can you let me know how
you get on, and sorry for the back-and-forth on this.

Will

--->8

diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 5f9a73a4452c..26c5c3fabca8 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -216,9 +216,14 @@ ENDPROC(idmap_cpu_replace_ttbr1)
 	.endm
 
 	.macro __idmap_kpti_put_pgtable_ent_ng, type
-	orr	\type, \type, #PTE_NG		// Same bit for blocks and pages
+	eor	\type, \type, #PTE_NG		// Same bit for blocks and pages
 	str	\type, [cur_\()\type\()p]	// Update the entry and ensure it
+	tbz	\type, #11, 1234f
 	dc	civac, cur_\()\type\()p		// is visible to all CPUs.
+	b	1235f
+	1234:
+	dc	cvac, cur_\()\type\()p
+	1235:
 	.endm
 
 /*
@@ -298,6 +303,7 @@ skip_pgd:
 	/* PUD */
 walk_puds:
 	.if CONFIG_PGTABLE_LEVELS > 3
+	eor	pgd, pgd, #PTE_NG
 	pte_to_phys	cur_pudp, pgd
 	add	end_pudp, cur_pudp, #(PTRS_PER_PUD * 8)
 do_pud:	__idmap_kpti_get_pgtable_ent	pud
@@ -319,6 +325,7 @@ next_pud:
 	/* PMD */
 walk_pmds:
 	.if CONFIG_PGTABLE_LEVELS > 2
+	eor	pud, pud, #PTE_NG
 	pte_to_phys	cur_pmdp, pud
 	add	end_pmdp, cur_pmdp, #(PTRS_PER_PMD * 8)
 do_pmd:	__idmap_kpti_get_pgtable_ent	pmd
@@ -339,6 +346,7 @@ next_pmd:
 
 	/* PTE */
 walk_ptes:
+	eor	pmd, pmd, #PTE_NG
 	pte_to_phys	cur_ptep, pmd
 	add	end_ptep, cur_ptep, #(PTRS_PER_PTE * 8)
 do_pte:	__idmap_kpti_get_pgtable_ent	pte
