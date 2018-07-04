Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A597C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C979F208A1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:52:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C979F208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752973AbeGDMwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 08:52:11 -0400
Received: from foss.arm.com ([217.140.101.70]:36672 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751735AbeGDMwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 08:52:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B4EE7A9;
        Wed,  4 Jul 2018 05:52:10 -0700 (PDT)
Received: from [192.168.67.35] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A46C3F5BA;
        Wed,  4 Jul 2018 05:52:08 -0700 (PDT)
Subject: Re: [linux-sunxi] Re: [PATCH 0/2] Allwinner A64 timer workaround
To:     samuel@sholland.org, Marc Zyngier <marc.zyngier@arm.com>,
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
From:   Andre Przywara <andre.przywara@arm.com>
Message-ID: <2ccf60d0-9ea0-0631-ca89-6e67426173f2@arm.com>
Date:   Wed, 4 Jul 2018 13:52:13 +0100
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

Hi,

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
> had time to do any deeper investigation.

Looking at the FSL workaround, I see that they cover TVAL reads as well.
Not sure entirely why, but maybe it's worth to follow this lead?

Cheers,
Andre.

> I think this series is still beneficial
> even if it's not a complete solution, so I'll come back with another patch on
> top of this if/once I get it fully fixed.
> 
> I'll prepare a v2 with a bounded loop. Presumably, 3 * (max CPU Hz) / (24MHz
> timer) ≈ 150 should be a conservative iteration limit?
> 
> Also, does this make sense to CC to stable?
> 
> Thanks,
> Samuel
> 
