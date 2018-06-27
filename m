Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC64C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 08:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6018D265F2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 08:39:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6018D265F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933402AbeF0Ijm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 04:39:42 -0400
Received: from foss.arm.com ([217.140.101.70]:56550 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932234AbeF0Ijk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 04:39:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10C4B18A;
        Wed, 27 Jun 2018 01:39:40 -0700 (PDT)
Received: from [10.1.206.34] (melchizedek.cambridge.arm.com [10.1.206.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B432B3F5AD;
        Wed, 27 Jun 2018 01:39:37 -0700 (PDT)
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
From:   James Morse <james.morse@arm.com>
Message-ID: <942e76b6-a46a-6c5e-5ec3-67daca636d43@arm.com>
Date:   Wed, 27 Jun 2018 09:39:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180626174746.GO23375@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wei,

On 26/06/18 18:47, Will Deacon wrote:
> On Wed, Jun 27, 2018 at 01:16:44AM +0800, Wei Xu wrote:
>>     [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x480fd010]
>>     [    0.000000] Linux version 4.18.0-rc2-58583-g7daf201-dirty
> 
> I'm still suspicious that this is 4.18-rc2 with "no change on top" ^^^ !

Some examples:

For comparison, when I boot v4.17 it looks like this:
| Linux version 4.17.0 (morse@melchizedek) (gcc version 4.9.3 20141031
| (prerelease) (Linaro GCC 2014.11)) #9886 SMP PREEMPT Thu Jun 21 10:30:55 BST
| 2018


If I apply some extra patches and make some uncommitted changes, it looks like this:
| Linux version 4.17.0-00025-ga22ca2234824-dirty (morse@melchizedek) (gcc
| version 4.9.3 20141031 (prerelease) (Linaro GCC 2014.11)) #9887 SMP PREEMPT
| Thu Jun 21 10:46:22 BST 2018


Hence we read your '4.17.0-45864-g29dcea8-dirty' line as v4.17 with extra
patches and uncommited changes, and similar with this v4.18-rc2.

I agree 7daf201 is the head commit for v4.18-rc2, but something has gone wrong
here. Could you try building from a fresh clone of Linus' tree?

(I suspect at some point you've applied a patch, and have then been merging
upstream, instead of 'fast forwarding')



Thanks,

James
