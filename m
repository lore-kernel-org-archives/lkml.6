Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D73C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 13:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D343D26592
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 13:27:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D343D26592
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965519AbeF0N1u (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 09:27:50 -0400
Received: from foss.arm.com ([217.140.101.70]:59902 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964914AbeF0N1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 09:27:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63B997A9;
        Wed, 27 Jun 2018 06:27:49 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 32FAA3F5AD;
        Wed, 27 Jun 2018 06:27:49 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 156BC1AE2F78; Wed, 27 Jun 2018 14:28:27 +0100 (BST)
Date:   Wed, 27 Jun 2018 14:28:27 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Wei Xu <xuwei5@hisilicon.com>
Cc:     James Morse <james.morse@arm.com>, mark.rutland@arm.com,
        catalin.marinas@arm.com, Linuxarm <linuxarm@huawei.com>,
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
Message-ID: <20180627132826.GB30631@arm.com>
References: <5B2A6218.3030201@hisilicon.com>
 <20180620144257.GB27776@arm.com>
 <5B2A7832.4010502@hisilicon.com>
 <ebfabb8f-dcd9-3fb4-3655-368a882d8f09@arm.com>
 <5B2A7FE1.5040607@hisilicon.com>
 <e701eaa8-dcb9-777c-2211-67ee27b43acb@arm.com>
 <5B2B6DEA.2090100@hisilicon.com>
 <5B3274FC.7000206@hisilicon.com>
 <20180626174746.GO23375@arm.com>
 <5B338F7B.9070500@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B338F7B.9070500@hisilicon.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 02:22:03PM +0100, Wei Xu wrote:
> On 2018/6/26 18:47, Will Deacon wrote:
> > If you look at the __idmap_kpti_put_pgtable_ent_ng asm macro, can you try
> > replacing:
> > 
> > 	dc      civac, cur_\()\type\()p
> > 
> > with:
> > 
> > 	dc      ivac, cur_\()\type\()p
> > 
> > please? Only do this for the guest kernel, not the host. KVM will upgrade
> > the clean to a clean+invalidate, so it's interesting to see if this has
> > an effect on the behaviour.
> 
> Only changed the guest kernel, the guest still failed to boot and the log
> is same with the last mail.
> 
> But if I changed to cvac as below for the guest, it is kind of stable.
> 	dc      cvac, cur_\()\type\()p
> 
> I have synced with our SoC guys about this and hope we can find the reason.
> Do you have any more suggestion?

Unfortunately, not. It looks like somehow clean+invalidate is behaving
just as an invalidate, and we're corrupting the page table as a result.

Hopefully the SoC guys will figure it out.

Will
