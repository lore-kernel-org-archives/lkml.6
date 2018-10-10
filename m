Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91EDC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 10:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F24320835
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 10:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F24320835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbeJJRxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 13:53:17 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50068 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726523AbeJJRxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 13:53:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43AED80D;
        Wed, 10 Oct 2018 03:31:46 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D788C3F5BC;
        Wed, 10 Oct 2018 03:31:44 -0700 (PDT)
Subject: Re: [PATCH] Doc: lockdep: add information about performance impact
To:     Lukasz Luba <l.luba@partner.samsung.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     corbet@lwn.net, b.zolnierkie@samsung.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        linux-arm-kernel@lists.infradead.org
References: <CGME20181009153935eucas1p2dec146575ed5fefd4a0b2b6cb9bac056@eucas1p2.samsung.com>
 <20181009153935eucas1p2dec146575ed5fefd4a0b2b6cb9bac056~b_ujkjRd31303013030eucas1p2C@eucas1p2.samsung.com>
 <20181009154359.GB5728@hirez.programming.kicks-ass.net>
 <20181009160633eucas1p1a597c95256e64bf01de32366afdc59dd~b-GGjOUFN2705527055eucas1p1b@eucas1p1.samsung.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <8a6bed3c-dac5-7031-eedd-2eb5bcc18478@arm.com>
Date:   Wed, 10 Oct 2018 11:31:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181009160633eucas1p1a597c95256e64bf01de32366afdc59dd~b-GGjOUFN2705527055eucas1p1b@eucas1p1.samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/18 17:06, Lukasz Luba wrote:
> Hi Peter,
> 
> On 10/09/2018 05:43 PM, Peter Zijlstra wrote:
>> On Tue, Oct 09, 2018 at 05:39:27PM +0200, Lukasz Luba wrote:
>>> This patch add some warning related to performance drop.
>>> It should be mentioned that this is not for free
>>> and the platfrom resources (cache, bus interconnect, etc.)
>>> will be used more frequently.
>>
>> To me this reads a bit like: water is wet.
>>
>> Is this really needed?
>>
>>
> Well, it would be good to know what is the performance drop
> (10% or 20% or x3 times) when you are enabling different debug options.
> I have spent some time analyzing these cache and bus strange behavior.
> Now the developers would know that LOCKDEP might cause constant trashing
> of your cache in some use cases.

Fair enough, but this is the wrong place for that. Anyone who's got as 
far as reading how the internals of lockdep work can probably already 
figure out that that brings a non-trivial overhead, whereas Joe 
Developer wondering why his kernel is slow seems unlikely to happen 
across this document by chance. And the people shipping devices with 
PROVE_LOCKING enabled because it happened to mask some tricky bug, well, 
they know what they did ;)

If you want to highlight to unwitting users that a tweaking a particular 
config knob has a significant performance hit, at least put the warning 
next to said knob, i.e. in the Kconfig help. For an example, DMA debug 
comes to mind.

Robin.
