Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CC6C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 10:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3464121469
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 10:00:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3464121469
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754546AbeF2KAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 06:00:02 -0400
Received: from foss.arm.com ([217.140.101.70]:58994 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752599AbeF2KAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 06:00:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD89918A;
        Fri, 29 Jun 2018 03:00:00 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B8CE13F266;
        Fri, 29 Jun 2018 02:59:57 -0700 (PDT)
Date:   Fri, 29 Jun 2018 10:59:52 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Zhangxiquan <zhangxiquan@hisilicon.com>
Cc:     "Wangxuefeng (E)" <wxf.wang@hisilicon.com>,
        "xuwei (O)" <xuwei5@huawei.com>,
        "will.deacon" <will.deacon@arm.com>,
        "james.morse" <james.morse@arm.com>,
        "catalin.marinas" <catalin.marinas@arm.com>,
        Linuxarm <linuxarm@huawei.com>,
        Zhangyi ac <zhangyi.ac@huawei.com>,
        "suzuki.poulose" <suzuki.poulose@arm.com>,
        "marc.zyngier" <marc.zyngier@arm.com>,
        "Xiongfanggou (James)" <james.xiong@huawei.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "dave.martin" <dave.martin@arm.com>,
        "Liyuan (Larry, Turing Solution)" <Larry.T@huawei.com>,
        Libeijian <libeijian@hisilicon.com>,
        dingshuai <dingshuai1@huawei.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>
Subject: Re: KVM guest sometimes failed to boot because of kernel stack
 overflow if KPTI is enabled on a hisilicon ARM64 platform.
Message-ID: <20180629095952.eiyfz6a3vzw6te6u@lakrids.cambridge.arm.com>
References: <e701eaa8-dcb9-777c-2211-67ee27b43acb@arm.com>
 <5B2B6DEA.2090100@hisilicon.com>
 <5B3274FC.7000206@hisilicon.com>
 <20180626174746.GO23375@arm.com>
 <5B338F7B.9070500@hisilicon.com>
 <20180627132826.GB30631@arm.com>
 <5B34F5C0.9090001@hisilicon.com>
 <20180628153425.rm5fd6dxb53n226z@lakrids.cambridge.arm.com>
 <etPan.5b3507f7.914aa16.1d6b@localhost>
 <20180628162417.s4mcoaow3dgpodew@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 07:24:30PM +0000, Zhangxiquan wrote:
> Do you think this order guarantee (between DC and ldst)is applicable for
> cacheable only , or it is also applicable for device ？

This also applies for device memory.

As I quoted previously, from ARM DDI 0487C.a page D3-2069:

  All data cache instructions, other than DC ZVA , that specify an
  address:

  * Can execute in any order relative to loads or stores that access any
    address with the Device memory attribute, or with Normal memory with
    Inner Non-cacheable attribute unless a DMB or DSB is executed
    between the instructions.

i.e. a DMB is sufficient to provide order between DC and loads/stores
which access device memory.

Thanks,
Mark.
