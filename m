Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E8AC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 09:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98408204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 09:18:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98408204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932993AbeFUJSZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 05:18:25 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47554 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932940AbeFUJSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 05:18:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54C5180D;
        Thu, 21 Jun 2018 02:18:15 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 235CA3F246;
        Thu, 21 Jun 2018 02:18:15 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 3F25F1AE101A; Thu, 21 Jun 2018 10:18:51 +0100 (BST)
Date:   Thu, 21 Jun 2018 10:18:51 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     James Morse <james.morse@arm.com>
Cc:     Wei Xu <xuwei5@hisilicon.com>, catalin.marinas@arm.com,
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
        libeijian@hisilicon.com
Subject: Re: KVM guest sometimes failed to boot because of kernel stack
 overflow if KPTI is enabled on a hisilicon ARM64 platform.
Message-ID: <20180621091850.GA22505@arm.com>
References: <5B2A6218.3030201@hisilicon.com>
 <20180620144257.GB27776@arm.com>
 <5B2A7832.4010502@hisilicon.com>
 <ebfabb8f-dcd9-3fb4-3655-368a882d8f09@arm.com>
 <5B2A7FE1.5040607@hisilicon.com>
 <e701eaa8-dcb9-777c-2211-67ee27b43acb@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e701eaa8-dcb9-777c-2211-67ee27b43acb@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 09:38:53AM +0100, James Morse wrote:
> On 20/06/18 17:25, Wei Xu wrote:
> >     [    0.042421] Insufficient stack space to handle exception!
> >     [    0.042423] ESR: 0x96000046 -- DABT (current EL)
> >     [    0.043730] FAR: 0xffff0000093a80e0
> >     [    0.044714] Task stack: [0xffff0000093a8000..0xffff0000093ac000]
> 
> This was a level 2 translation fault on a write, to an address that is within
> the stack....
> 
> 
> >     [    0.051113] IRQ stack: [0xffff000008000000..0xffff000008004000]
> >     [    0.057610] Overflow stack: [0xffff80003efce2f0..0xffff80003efcf2f0]
> >     [    0.064003] CPU: 0 PID: 12 Comm: migration/0 Not tainted
> > 4.17.0-45865-g2b31fe7-dirty #10
> >     [    0.072201] Hardware name: linux,dummy-virt (DT)
> 
> >     [    0.076797] pstate: 604003c5 (nZCv DAIF +PAN -UAO)
> >     [    0.081727] pc : el1_sync+0x0/0xb0
> 
> ... from the vectors.
> 
> 
> >     [    0.085217] lr : kpti_install_ng_mappings+0x120/0x214
> 
> What I think is happening is: we come out of the kpti idmap with the stack
> unmapped. Shortly after we access the stack, which faults. el1_sync faults as
> well when it tries to push the registers to the stack, and we keep going until
> we overflow the stack.
> 
> I can't reproduce this with kvmtool or qemu in the model.

Hmm, one thing that occurs to me is that the kpti_install_ng_mappings()
code leaves the nG bit set in table entries, which is actually IGNORED in
the architecture.

Wei -- does the diff below help at all? Make sure you disable CONFIG_KASAN,
otherwise your kernel will take an age to boot.

Will

--->8

diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 5f9a73a4452c..70d9e98467ca 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -272,8 +272,8 @@ ENTRY(idmap_kpti_install_ng_mappings)
 	add	end_pgdp, cur_pgdp, #(PTRS_PER_PGD * 8)
 do_pgd:	__idmap_kpti_get_pgtable_ent	pgd
 	tbnz	pgd, #1, walk_puds
-next_pgd:
 	__idmap_kpti_put_pgtable_ent_ng	pgd
+next_pgd:
 skip_pgd:
 	add	cur_pgdp, cur_pgdp, #8
 	cmp	cur_pgdp, end_pgdp
@@ -302,8 +302,8 @@ walk_puds:
 	add	end_pudp, cur_pudp, #(PTRS_PER_PUD * 8)
 do_pud:	__idmap_kpti_get_pgtable_ent	pud
 	tbnz	pud, #1, walk_pmds
-next_pud:
 	__idmap_kpti_put_pgtable_ent_ng	pud
+next_pud:
 skip_pud:
 	add	cur_pudp, cur_pudp, 8
 	cmp	cur_pudp, end_pudp
@@ -323,8 +323,8 @@ walk_pmds:
 	add	end_pmdp, cur_pmdp, #(PTRS_PER_PMD * 8)
 do_pmd:	__idmap_kpti_get_pgtable_ent	pmd
 	tbnz	pmd, #1, walk_ptes
-next_pmd:
 	__idmap_kpti_put_pgtable_ent_ng	pmd
+next_pmd:
 skip_pmd:
 	add	cur_pmdp, cur_pmdp, #8
 	cmp	cur_pmdp, end_pmdp
