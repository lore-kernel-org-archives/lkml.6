Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C85CC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 08:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10AAA270FC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 08:46:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10AAA270FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752627AbeF1IqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 04:46:04 -0400
Received: from foss.arm.com ([217.140.101.70]:43100 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751107AbeF1IqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 04:46:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9009E7A9;
        Thu, 28 Jun 2018 01:46:00 -0700 (PDT)
Received: from [10.1.206.34] (melchizedek.cambridge.arm.com [10.1.206.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 20C4A3F5C0;
        Thu, 28 Jun 2018 01:45:57 -0700 (PDT)
Subject: Re: KVM guest sometimes failed to boot because of kernel stack
 overflow if KPTI is enabled on a hisilicon ARM64 platform.
To:     Wei Xu <xuwei5@hisilicon.com>
Cc:     Will Deacon <will.deacon@arm.com>, mark.rutland@arm.com,
        catalin.marinas@arm.com, Linuxarm <linuxarm@huawei.com>,
        Zhangyi ac <zhangyi.ac@huawei.com>, suzuki.poulose@arm.com,
        marc.zyngier@arm.com,
        "Xiongfanggou (James)" <james.xiong@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dave.martin@arm.com,
        "Liyuan (Larry, Turing Solution)" <Larry.T@huawei.com>,
        libeijian@hisilicon.com
References: <5B2A6218.3030201@hisilicon.com> <20180620144257.GB27776@arm.com>
 <5B2A7832.4010502@hisilicon.com>
 <ebfabb8f-dcd9-3fb4-3655-368a882d8f09@arm.com>
 <5B2A7FE1.5040607@hisilicon.com>
 <e701eaa8-dcb9-777c-2211-67ee27b43acb@arm.com>
 <5B2B6DEA.2090100@hisilicon.com> <5B3274FC.7000206@hisilicon.com>
 <20180626174746.GO23375@arm.com>
 <942e76b6-a46a-6c5e-5ec3-67daca636d43@arm.com>
 <5B339068.5020304@hisilicon.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <9549e15d-4ec6-8dd3-2237-b6c9b52fc816@arm.com>
Date:   Thu, 28 Jun 2018 09:45:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <5B339068.5020304@hisilicon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wei,

On 27/06/18 14:26, Wei Xu wrote:
> Sorry, I should highlight that I have only updated the default value
> of CONFIG_NR_CPUS by menuconfig in the previous mail.
> That is why it showed dirty.

(menuconfig changes don't show up like this)


More than 64 CPUs ... Is this system running more VMs than it has VMIDs? Too-few
VMIDs does work with KVM, its just going to trigger rollover frequently.

Just to check, what kernel version is the host running? Does it have commit
f0cf47d939d0 ("KVM: arm/arm64: Close VMID generation race")
(looks like that went in as a fix for v4.17-rc3)

Are you running (lots) of other VMs whenever this happens? Do they have multiple
vcpus? (I'm thinking of the scenario in that patch's description)

Is the host system otherwise idle when this happens?
(If not, can you reproduce the issue without exhausting the VMIDs?)


It may be that writing back the page-table entries with the MMU off, and
changing the cache maintenance are just changing the timing of something else.


Thanks,

James
