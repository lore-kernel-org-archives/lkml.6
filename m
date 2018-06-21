Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015CBC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 10:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9AF9208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 10:53:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9AF9208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754333AbeFUKxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 06:53:31 -0400
Received: from foss.arm.com ([217.140.101.70]:48342 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754018AbeFUKxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 06:53:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83C241435;
        Thu, 21 Jun 2018 03:53:29 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 52D8D3F246;
        Thu, 21 Jun 2018 03:53:29 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 6A2CC1AE2E48; Thu, 21 Jun 2018 11:54:05 +0100 (BST)
Date:   Thu, 21 Jun 2018 11:54:05 +0100
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
        libeijian@hisilicon.com
Subject: Re: KVM guest sometimes failed to boot because of kernel stack
 overflow if KPTI is enabled on a hisilicon ARM64 platform.
Message-ID: <20180621105404.GB22505@arm.com>
References: <5B2A6218.3030201@hisilicon.com>
 <20180620144257.GB27776@arm.com>
 <5B2A7832.4010502@hisilicon.com>
 <ebfabb8f-dcd9-3fb4-3655-368a882d8f09@arm.com>
 <5B2A7FE1.5040607@hisilicon.com>
 <e701eaa8-dcb9-777c-2211-67ee27b43acb@arm.com>
 <20180621091850.GA22505@arm.com>
 <5B2B7A84.8090309@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B2B7A84.8090309@hisilicon.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wei,

On Thu, Jun 21, 2018 at 11:14:28AM +0100, Wei Xu wrote:
> On 2018/6/21 10:18, Will Deacon wrote:
> > On Thu, Jun 21, 2018 at 09:38:53AM +0100, James Morse wrote:
> >> On 20/06/18 17:25, Wei Xu wrote:
> >>>     [    0.042421] Insufficient stack space to handle exception!
> >>>     [    0.042423] ESR: 0x96000046 -- DABT (current EL)
> >>>     [    0.043730] FAR: 0xffff0000093a80e0
> >>>     [    0.044714] Task stack: [0xffff0000093a8000..0xffff0000093ac000]
> >>
> >> This was a level 2 translation fault on a write, to an address that is within
> >> the stack....
> >>
> >>
> >>>     [    0.051113] IRQ stack: [0xffff000008000000..0xffff000008004000]
> >>>     [    0.057610] Overflow stack: [0xffff80003efce2f0..0xffff80003efcf2f0]
> >>>     [    0.064003] CPU: 0 PID: 12 Comm: migration/0 Not tainted
> >>> 4.17.0-45865-g2b31fe7-dirty #10
> >>>     [    0.072201] Hardware name: linux,dummy-virt (DT)
> >>
> >>>     [    0.076797] pstate: 604003c5 (nZCv DAIF +PAN -UAO)
> >>>     [    0.081727] pc : el1_sync+0x0/0xb0
> >>
> >> ... from the vectors.
> >>
> >>
> >>>     [    0.085217] lr : kpti_install_ng_mappings+0x120/0x214
> >>
> >> What I think is happening is: we come out of the kpti idmap with the stack
> >> unmapped. Shortly after we access the stack, which faults. el1_sync faults as
> >> well when it tries to push the registers to the stack, and we keep going until
> >> we overflow the stack.
> >>
> >> I can't reproduce this with kvmtool or qemu in the model.
> > 
> > Hmm, one thing that occurs to me is that the kpti_install_ng_mappings()
> > code leaves the nG bit set in table entries, which is actually IGNORED in
> > the architecture.
> > 
> > Wei -- does the diff below help at all? Make sure you disable CONFIG_KASAN,
> > otherwise your kernel will take an age to boot.
> 
> Yes, amazing! This patch resolved the issue.

Great...

> I have tested 50 times and can not reproduce the issue any more.
> Could you please tell more why this patch works?

You might need to ask your CPU design team ;)

Without this patch, the code in idmap_kpti_install_ng_mappings() sets
bit 11 in table descriptors so that we can keep track of which parts of
the page table we've visited. With this patch, we don't bother tracking
and potentially rewalk parts of the page table (which takes a very long
time if KASAN is enabled).

The architecture documents I've looked at are clear that bit 11 is IGNORED
by the CPU, which:

  "Indicates that the architecture guarantees that the bit or field is not
   interpreted or modified by hardware."

Please can you double-check that your CPU is indeed ignoring bit 11 in
non-leaf (table) descriptors?

Thanks,

Will
