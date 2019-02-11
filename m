Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C392C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A971218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbfBKQh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:37:26 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53774 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727247AbfBKQh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 11:37:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA88F80D;
        Mon, 11 Feb 2019 08:37:25 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A0BA3F675;
        Mon, 11 Feb 2019 08:37:24 -0800 (PST)
Subject: Re: [PATCH] arm64/io: Don't use WZR in writel
To:     Marc Zyngier <marc.zyngier@arm.com>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org
References: <68b71c15f32341468a868f6418e4fcb375bc49ba.camel@gmail.com>
 <20190211105755.GB30880@fuggles.cambridge.arm.com>
 <38d8965a-cd41-17cf-1b95-8dd58c079be4@arm.com>
 <874c702b8af760aa8fae38d478c79e3ecba00515.camel@gmail.com>
 <235d20ef-3054-69d9-975d-25aebf32aad3@arm.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <0dcc636d-236f-6211-4bf4-5c20f2aeefc2@arm.com>
Date:   Mon, 11 Feb 2019 16:37:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <235d20ef-3054-69d9-975d-25aebf32aad3@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/02/2019 14:59, Marc Zyngier wrote:
> On 11/02/2019 14:29, AngeloGioacchino Del Regno wrote:
> 
> [...]
> 
>> Also, just one more thing: yes this thing is going ARM64-wide and
>> - from my findings - it's targeting certain Qualcomm SoCs, but...
>> I'm not sure that only QC is affected by that, others may as well
>> have the same stupid bug.
>>
> 
> At the moment, only QC SoCs seem to be affected, probably because
> everyone else has debugged their hypervisor (or most likely doesn't
> bother with shipping one).
> 
> In all honesty, we need some information from QC here: which SoCs are
> affected, what is the exact nature of the bug, can it be triggered from
> EL0. Randomly papering over symptoms is not something I really like
> doing, and is likely to generate problems on unaffected systems.

And even if we *were* to just try papering over the observed extent of 
the issue, I'd still be inclined to confine it to arm-smmu.c where the 
impact is finite and minimal - of the 4 instances of writel(0) there, 3 
of them don't care what the data is (so could just reuse the base 
register or similar) and the other one already has a zero in a GPR to 
hand by construction.

Robin.
