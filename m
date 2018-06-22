Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27048C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 11:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEAFF24108
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 11:15:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEAFF24108
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751315AbeFVLPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 07:15:40 -0400
Received: from foss.arm.com ([217.140.101.70]:33570 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751086AbeFVLPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 07:15:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3E5114;
        Fri, 22 Jun 2018 04:15:38 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B30F53F557;
        Fri, 22 Jun 2018 04:15:38 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 2B8761AE0C58; Fri, 22 Jun 2018 12:16:15 +0100 (BST)
Date:   Fri, 22 Jun 2018 12:16:15 +0100
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
Message-ID: <20180622111614.GA1150@arm.com>
References: <5B2A7832.4010502@hisilicon.com>
 <ebfabb8f-dcd9-3fb4-3655-368a882d8f09@arm.com>
 <5B2A7FE1.5040607@hisilicon.com>
 <e701eaa8-dcb9-777c-2211-67ee27b43acb@arm.com>
 <20180621091850.GA22505@arm.com>
 <5B2B7A84.8090309@hisilicon.com>
 <20180621105404.GB22505@arm.com>
 <5B2CB440.8040705@hisilicon.com>
 <20180622092330.GD7601@arm.com>
 <5B2CD33B.9020702@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B2CD33B.9020702@hisilicon.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wei,

Thanks for giving that a spin.

On Fri, Jun 22, 2018 at 06:45:15PM +0800, Wei Xu wrote:
> On 2018/6/22 17:23, Will Deacon wrote:
> >On Fri, Jun 22, 2018 at 09:33:04AM +0100, Wei Xu wrote:
> >>On 2018/6/21 11:54, Will Deacon wrote:
> >>>On Thu, Jun 21, 2018 at 11:14:28AM +0100, Wei Xu wrote:
> >>>>On 2018/6/21 10:18, Will Deacon wrote:
> >>>>>Wei -- does the diff below help at all? Make sure you disable CONFIG_KASAN,
> >>>>>otherwise your kernel will take an age to boot.
> >>>>Yes, amazing! This patch resolved the issue.
> >>>Great...
> >>>
> >>>>I have tested 50 times and can not reproduce the issue any more.
> >>>>Could you please tell more why this patch works?
> >>>You might need to ask your CPU design team ;)
> >>>
> >>>Without this patch, the code in idmap_kpti_install_ng_mappings() sets
> >>>bit 11 in table descriptors so that we can keep track of which parts of
> >>>the page table we've visited. With this patch, we don't bother tracking
> >>>and potentially rewalk parts of the page table (which takes a very long
> >>>time if KASAN is enabled).
> >>Got it. Thanks!
> >>
> >>>The architecture documents I've looked at are clear that bit 11 is IGNORED
> >>>by the CPU, which:
> >>>
> >>>   "Indicates that the architecture guarantees that the bit or field is not
> >>>    interpreted or modified by hardware."
> >>>
> >>>Please can you double-check that your CPU is indeed ignoring bit 11 in
> >>>non-leaf (table) descriptors?
> >>Do the non-leaf(table) descriptors mean the table descriptors
> >>of the section D4.3.1 "VMSAv8-64 translation table level 0, level 1, and level 2 descriptor formats"
> >>in the ARM Architecture Reference Manual ARMv8 for ARMv8-A(DDI0487C_a_armv8_arm.pdf)?
> >>
> >>If yes, our hardware does ignore it(not interpret or modify).
> >Ok, thanks for checking.
> >
> >>Is there any other possible reason cause this?
> >Perhaps just writing back the table entries is enough to cause the issue,
> >although I really can't understand why that would be the case. Can you try
> >the diff below (without my previous change), please?
> 
> Thanks!
> But it does not resolve the issue(only apply this patch based on 4.17.0).

Thanks, that's a useful data point. It means that it still crashes even if
we write back the same table entries, so it's the fact that we're writing
them at all which causes the problem, not the value that we write.

Whilst looking at the code, we noticed a missing DMB. On the off-chance
that it helps, can you try this instead please?

Will

--->8

diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 5f9a73a4452c..03646e6a2ef4 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -217,8 +217,9 @@ ENDPROC(idmap_cpu_replace_ttbr1)
 
 	.macro __idmap_kpti_put_pgtable_ent_ng, type
 	orr	\type, \type, #PTE_NG		// Same bit for blocks and pages
-	str	\type, [cur_\()\type\()p]	// Update the entry and ensure it
-	dc	civac, cur_\()\type\()p		// is visible to all CPUs.
+	str	\type, [cur_\()\type\()p]	// Update the entry and ensure
+	dmb	sy				// that it is visible to all
+	dc	civac, cur_\()\type\()p		// CPUs.
 	.endm
 
 /*
