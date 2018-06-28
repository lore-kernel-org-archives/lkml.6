Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB64C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13C0B272FA
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:34:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13C0B272FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754097AbeF1Ped (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 11:34:33 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49514 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752408AbeF1Peb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 11:34:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5EB6B18A;
        Thu, 28 Jun 2018 08:34:31 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 491223F266;
        Thu, 28 Jun 2018 08:34:28 -0700 (PDT)
Date:   Thu, 28 Jun 2018 16:34:25 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Wei Xu <xuwei5@hisilicon.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        James Morse <james.morse@arm.com>, catalin.marinas@arm.com,
        Linuxarm <linuxarm@huawei.com>,
        Zhangyi ac <zhangyi.ac@huawei.com>, suzuki.poulose@arm.com,
        marc.zyngier@arm.com,
        "Xiongfanggou (James)" <james.xiong@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dave.martin@arm.com,
        "Liyuan (Larry, Turing Solution)" <Larry.T@huawei.com>,
        libeijian@hisilicon.com, zhangxiquan@hisilicon.com,
        wxf.wang@hisilicon.com, dingshuai1@huawei.com,
        Hanjun Guo <guohanjun@huawei.com>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>
Subject: Re: KVM guest sometimes failed to boot because of kernel stack
 overflow if KPTI is enabled on a hisilicon ARM64 platform.
Message-ID: <20180628153425.rm5fd6dxb53n226z@lakrids.cambridge.arm.com>
References: <5B2A7832.4010502@hisilicon.com>
 <ebfabb8f-dcd9-3fb4-3655-368a882d8f09@arm.com>
 <5B2A7FE1.5040607@hisilicon.com>
 <e701eaa8-dcb9-777c-2211-67ee27b43acb@arm.com>
 <5B2B6DEA.2090100@hisilicon.com>
 <5B3274FC.7000206@hisilicon.com>
 <20180626174746.GO23375@arm.com>
 <5B338F7B.9070500@hisilicon.com>
 <20180627132826.GB30631@arm.com>
 <5B34F5C0.9090001@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B34F5C0.9090001@hisilicon.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 03:50:40PM +0100, Wei Xu wrote:
> Hi Will,
> 
> On 2018/6/27 14:28, Will Deacon wrote:
> > On Wed, Jun 27, 2018 at 02:22:03PM +0100, Wei Xu wrote:
> >> On 2018/6/26 18:47, Will Deacon wrote:
> >>> If you look at the __idmap_kpti_put_pgtable_ent_ng asm macro, can you try
> >>> replacing:
> >>>
> >>> 	dc      civac, cur_\()\type\()p
> >>>
> >>> with:
> >>>
> >>> 	dc      ivac, cur_\()\type\()p
> >>>
> >>> please? Only do this for the guest kernel, not the host. KVM will upgrade
> >>> the clean to a clean+invalidate, so it's interesting to see if this has
> >>> an effect on the behaviour.
> >>
> >> Only changed the guest kernel, the guest still failed to boot and the log
> >> is same with the last mail.
> >>
> >> But if I changed to cvac as below for the guest, it is kind of stable.
> >> 	dc      cvac, cur_\()\type\()p
> >>
> >> I have synced with our SoC guys about this and hope we can find the reason.
> >> Do you have any more suggestion?
> > 
> > Unfortunately, not. It looks like somehow clean+invalidate is behaving
> > just as an invalidate, and we're corrupting the page table as a result.
> > 
> > Hopefully the SoC guys will figure it out.
> 
> After replaced the dmb with dsb in both __idmap_kpti_get_pgtable_ent and
> __idmap_kpti_put_pgtable_ent_ng, we tested 20 times and we can not reproduce
> the issue.
> Today we will continue to do the stress testing and will update the result tomorrow.
> 
> The dsb in __idmap_kpti_get_pgtable_ent is to make sure the dc has been done and
> the following ldr can get the latest data.
> 
> The dsb in __idmap_kpti_put_pgtable_ent_ng is to make sure the str will be done
> before dc. Although dmb can guarantee the order of the str and dc on the L2 cache,
> dmb can not guarantee the order on the bus.

The architecture mandates that a DMB must provide this ordering, so that
would be an erratum.

Per ARM DDI 0487C.a, page D3-2069, "Ordering and completion of data and instruction
cache instructions":

  All data cache instructions, other than DC ZVA, that specify an
  address:

  * Can execute in any order relative to loads or stores that access any
    address with the Device memory attribute,or with Normal memory with
    Inner Non-cacheable attribute unless a DMB or DSB is executed
    between the instructions.

Note that we rely on this ordering in head.S when creating the page
tables and setting up the boot mode. We also rely on this for the pmem
API.

Thanks,
Mark.
