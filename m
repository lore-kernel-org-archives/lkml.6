Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6044C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 13:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98A0826331
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 13:26:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98A0826331
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965477AbeF0N0T (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 09:26:19 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58292 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S965114AbeF0N0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 09:26:17 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3343FB72D4A79;
        Wed, 27 Jun 2018 21:26:14 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.42) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.382.0; Wed, 27 Jun 2018
 21:26:08 +0800
Subject: Re: KVM guest sometimes failed to boot because of kernel stack
 overflow if KPTI is enabled on a hisilicon ARM64 platform.
To:     James Morse <james.morse@arm.com>
References: <5B2A6218.3030201@hisilicon.com> <20180620144257.GB27776@arm.com>
 <5B2A7832.4010502@hisilicon.com>
 <ebfabb8f-dcd9-3fb4-3655-368a882d8f09@arm.com>
 <5B2A7FE1.5040607@hisilicon.com>
 <e701eaa8-dcb9-777c-2211-67ee27b43acb@arm.com>
 <5B2B6DEA.2090100@hisilicon.com> <5B3274FC.7000206@hisilicon.com>
 <20180626174746.GO23375@arm.com>
 <942e76b6-a46a-6c5e-5ec3-67daca636d43@arm.com>
CC:     Will Deacon <will.deacon@arm.com>, <mark.rutland@arm.com>,
        <catalin.marinas@arm.com>, Linuxarm <linuxarm@huawei.com>,
        Zhangyi ac <zhangyi.ac@huawei.com>, <suzuki.poulose@arm.com>,
        <marc.zyngier@arm.com>,
        "Xiongfanggou (James)" <james.xiong@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <dave.martin@arm.com>,
        "Liyuan (Larry, Turing Solution)" <Larry.T@huawei.com>,
        <libeijian@hisilicon.com>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5B339068.5020304@hisilicon.com>
Date:   Wed, 27 Jun 2018 14:26:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <942e76b6-a46a-6c5e-5ec3-67daca636d43@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 2018/6/27 9:39, James Morse wrote:
> Hi Wei,
> 
> On 26/06/18 18:47, Will Deacon wrote:
>> On Wed, Jun 27, 2018 at 01:16:44AM +0800, Wei Xu wrote:
>>>     [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x480fd010]
>>>     [    0.000000] Linux version 4.18.0-rc2-58583-g7daf201-dirty
>>
>> I'm still suspicious that this is 4.18-rc2 with "no change on top" ^^^ !
> 
> Some examples:
> 
> For comparison, when I boot v4.17 it looks like this:
> | Linux version 4.17.0 (morse@melchizedek) (gcc version 4.9.3 20141031
> | (prerelease) (Linaro GCC 2014.11)) #9886 SMP PREEMPT Thu Jun 21 10:30:55 BST
> | 2018
> 
> 
> If I apply some extra patches and make some uncommitted changes, it looks like this:
> | Linux version 4.17.0-00025-ga22ca2234824-dirty (morse@melchizedek) (gcc
> | version 4.9.3 20141031 (prerelease) (Linaro GCC 2014.11)) #9887 SMP PREEMPT
> | Thu Jun 21 10:46:22 BST 2018
> 
> 
> Hence we read your '4.17.0-45864-g29dcea8-dirty' line as v4.17 with extra
> patches and uncommited changes, and similar with this v4.18-rc2.
> 
> I agree 7daf201 is the head commit for v4.18-rc2, but something has gone wrong
> here. Could you try building from a fresh clone of Linus' tree?
> 
> (I suspect at some point you've applied a patch, and have then been merging
> upstream, instead of 'fast forwarding')
> 

Thanks for your kindly guidance!
Sorry, I should highlight that I have only updated the default value
of CONFIG_NR_CPUS by menuconfig in the previous mail.
That is why it showed dirty.

Best Regards,
Wei

> 
> 
> Thanks,
> 
> James
> 
> .
> 

