Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5D9C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F24C20837
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:16:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F24C20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934157AbeGDIQm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 04:16:42 -0400
Received: from foss.arm.com ([217.140.101.70]:32916 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934099AbeGDIQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 04:16:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF88B7A9;
        Wed,  4 Jul 2018 01:16:35 -0700 (PDT)
Received: from [10.1.206.75] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F1E893F5BA;
        Wed,  4 Jul 2018 01:16:33 -0700 (PDT)
Subject: Re: [PATCH 0/2] Allwinner A64 timer workaround
To:     Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Mark Rutland <Mark.Rutland@arm.com>
References: <20180511022751.9096-1-samuel@sholland.org>
 <2c16d5ab-38f7-8f3e-875c-19e8032f440a@arm.com>
 <bdfb1a31-2c4a-d258-7bf6-aaab8cee4663@sholland.org>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <5283f98e-6443-db7a-fe51-6379ed19002c@arm.com>
Date:   Wed, 4 Jul 2018 09:16:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <bdfb1a31-2c4a-d258-7bf6-aaab8cee4663@sholland.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/18 19:42, Samuel Holland wrote:
> On 07/03/18 10:09, Marc Zyngier wrote:
>> On 11/05/18 03:27, Samuel Holland wrote:
>>> Hello,
>>>
>>> Several people (including me) have experienced extremely large system
>>> clock jumps on their A64-based devices, apparently due to the architectural
>>> timer going backward, which is interpreted by Linux as the timer wrapping
>>> around after 2^56 cycles.
>>>
>>> Investigation led to discovery of some obvious problems with this SoC's 
>>> architectural timer, and this patch series introduces what I believe is
>>> the simplest workaround. More details are in the commit message for patch
>>> 1. Patch 2 simply enables the workaround in the device tree.
>>
>> What's the deal with this series? There was a couple of nits to address, and 
>> I was more or less expecting a v2.
> 
> I got reports that people were still occasionally having clock jumps after
> applying this series, so I wanted to attempt a more complete fix, but I haven't
> had time to do any deeper investigation. I think this series is still beneficial
> even if it's not a complete solution, so I'll come back with another patch on
> top of this if/once I get it fully fixed.
> 
> I'll prepare a v2 with a bounded loop. Presumably, 3 * (max CPU Hz) / (24MHz
> timer) ≈ 150 should be a conservative iteration limit?

Should be OK.

Maxime: How do you want to deal with the documentation aspect? We need
an erratum number, but AFAIU the concept hasn't made it into the silicom
vendor's brain yet. Any chance you could come up with something that
uniquely identifies this?

> Also, does this make sense to CC to stable?

Probably not, as the HW never worked, so it is not a regression.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
