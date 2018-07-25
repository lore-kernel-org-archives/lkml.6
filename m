Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55667C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 069EB20882
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:27:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 069EB20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbeGYKif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 06:38:35 -0400
Received: from foss.arm.com ([217.140.101.70]:34854 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728222AbeGYKif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 06:38:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82C9480D;
        Wed, 25 Jul 2018 02:27:45 -0700 (PDT)
Received: from [10.37.10.30] (unknown [10.37.10.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B4B7E3F237;
        Wed, 25 Jul 2018 02:27:43 -0700 (PDT)
Subject: Re: [PATCH] arm64: Check for errata before evaluating cpu features
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Dirk Mueller <dmueller@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Alex Graf <agraf@suse.de>
References: <20180725083504.25836-1-dmueller@suse.com>
 <aea2daa9-40ef-2066-0da9-0770c3c50dfb@arm.com>
 <20180725085604.GB4240@e103592.cambridge.arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <3d26391a-afbe-621e-90d0-80c4dbc4e2f6@arm.com>
Date:   Wed, 25 Jul 2018 10:28:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180725085604.GB4240@e103592.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Dave,

On 07/25/2018 09:56 AM, Dave Martin wrote:
> On Wed, Jul 25, 2018 at 09:51:53AM +0100, Suzuki K Poulose wrote:
>> On 07/25/2018 09:35 AM, Dirk Mueller wrote:
>>> Since commit d3aec8a28be3b8 ("arm64: capabilities: Restrict KPTI
>>> detection to boot-time CPUs") we rely on errata flags being already
>>> populated during feature enumeration. The order of errata and
>>> features was flipped as part of commit ed478b3f9e4a ("arm64:
>>> capabilities: Group handling of features and errata workarounds").
>>>
>>> Return to the orginal order of errata and feature evaluation to
>>> ensure errata flags are present during feature evaluation.
>>>
>>> Fixes: d3aec8a28be3b8 ("arm64: capabilities: Restrict KPTI
>>> detection to boot-time CPUs")
>>> CC: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> CC: Marc Zyngier <marc.zyngier@arm.com>
>>> Signed-off-by: Dirk Mueller <dmueller@suse.com>
>>
>> It would be good to add "Fixes: ed478b3f9e4a" (instead), just to make
>> sure this gets fixed everywhere the original problem appears.
>>

> 
> I forget why these were originally reordered in ed478b3f9e4a.
> Was there any real reason for it?

No, there was no real reason for it. We have always detected the cpu
local errata first and all features were system wide. So that ensured
that the errata are detected before features. With the introduction
of cpu local features, it was a random order until we realised this
issue.

That said, this exposes a problem with the current infrastructure
where, if there are local capabilities that depend on other local
capabilities. On a heterogeneous system, there is no guarantee on the
order in which the CPUs turn up and thus detect the capabilities. In
this case, this patch wouldn't work if we were dealing with a
heterogeneous system.

The solution would be to use cpu local and system wide versions
of the same capability and use the cpu-local capabilities to
decide the system capability.

i.e, here KPTI needs two caps :

a) CPU_NEEDS_KPTI - Local CPU capability to detect the local CPU
which needs KPTRI

b) SYSTEM_NEEDS_KPTI - System wide capability, which can be turned
on iff we have CPU_NEEDS_KPTI && !CAVIUM_ERRATA.

> 
> I also notice in that commit that after the detection pass, we set
> things up (in update_cpu_capabilities(), enable_cpu_capabilities()) in
> the order errata, features.  Does this matter for anything?

None that I am aware of. But logically that sounds like a better option.


Suzuki
