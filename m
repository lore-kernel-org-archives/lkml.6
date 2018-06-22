Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAEBC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D41FD24522
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:40:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D41FD24522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934220AbeFVPks (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 11:40:48 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37168 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933884AbeFVPkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 11:40:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 379B580D;
        Fri, 22 Jun 2018 08:40:41 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 053343F557;
        Fri, 22 Jun 2018 08:40:41 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 7DB681AE3719; Fri, 22 Jun 2018 16:41:17 +0100 (BST)
Date:   Fri, 22 Jun 2018 16:41:17 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Wei Xu <xuwei5@hisilicon.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>, catalin.marinas@arm.com,
        suzuki.poulose@arm.com, dave.martin@arm.com, marc.zyngier@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linuxarm <linuxarm@huawei.com>,
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
Message-ID: <20180622154117.GC1802@arm.com>
References: <20180621091850.GA22505@arm.com>
 <5B2B7A84.8090309@hisilicon.com>
 <20180621105404.GB22505@arm.com>
 <5B2CB440.8040705@hisilicon.com>
 <20180622092330.GD7601@arm.com>
 <5B2CD33B.9020702@hisilicon.com>
 <20180622111614.GA1150@arm.com>
 <5B2CF723.7010600@hisilicon.com>
 <20180622142851.g3r4em3kidx5p3wv@lakrids.cambridge.arm.com>
 <5B2D1595.6020000@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B2D1595.6020000@hisilicon.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 11:28:21PM +0800, Wei Xu wrote:
> On 2018/6/22 22:28, Mark Rutland wrote:
> >On Fri, Jun 22, 2018 at 09:18:27PM +0800, Wei Xu wrote:
> >>     [    0.227507] Mem abort info:
> >>     [    0.230390]   ESR = 0x96000006
> >>     [    0.233517]   Exception class = DABT (current EL), IL = 32 bits
> >>     [    0.239428]   SET = 0, FnV = 0
> >>     [    0.242555]   EA = 0, S1PTW = 0
> >>     [    0.245797] Data abort info:
> >>     [    0.248795]   ISV = 0, ISS = 0x00000006
> >>     [    0.252652]   CM = 0, WnR = 0
> >>     [    0.255769] swapper pgtable: 4k pages, 48-bit VAs, pgdp =
> >>(ptrval)
> >>     [    0.262645] [ffff0000093abce0] pgd=00000000411f8803,
> >>pud=00000000411f9803, pmd=0000000000000000
> >... and here the PMD for the task stack is all zeroes, so evidently
> >that's getting corrupted somehow.
> >
> >It appears that the overflow stack (which IIRC is embedded within the
> >kernel's data segment, as part of the image mapping), is fine.
> >
> >I wonder if there's some existing weirdness in the page tables for the
> >vmalloc area that causes things to go wrong. Can you please:
> >
> >* enable ARM64_PTDUMP_DEBUGFS
> >
> >* boot with kpti=off (with Will's patch to make this work)
> >
> >* as root, cat /sys/kernel/debug/kernel_page_tables
> >
> >... and dump the result here?
> Thanks!
> Can I do this later since Will's new patch works?

Yes, you should probably go to bed now! Please note that my patch still
isn't the right thing for mainline, since it avoids setting PTE_NG for
tables and therefore won't solve the boot-time issue with KASAN enabled.

We also don't understand why clean+invalidate is causing the issue on your
CPU, whereas clean does not. It looks like clean+invalidate somehow results
in page table entries being zeroed.

Have a good weekend,

Will
