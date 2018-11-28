Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD402C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AC4B20645
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:28:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AC4B20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbeK2Eam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 23:30:42 -0500
Received: from foss.arm.com ([217.140.101.70]:46630 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728341AbeK2Eam (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 23:30:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8AD8165C;
        Wed, 28 Nov 2018 09:28:19 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 905063F59C;
        Wed, 28 Nov 2018 09:28:18 -0800 (PST)
Subject: Re: [PATCH 8/9] iommu: arm-smmu: make it explicitly non-modular
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Nate Watterson <nwatters@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org
References: <1543271498-28966-1-git-send-email-paul.gortmaker@windriver.com>
 <1543271498-28966-9-git-send-email-paul.gortmaker@windriver.com>
 <755c95d7-882c-0dec-207e-20bf8f22b159@arm.com>
 <20181128152445.GH14659@windriver.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <d952cb5e-b524-5eea-1729-4d579f637152@arm.com>
Date:   Wed, 28 Nov 2018 17:28:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181128152445.GH14659@windriver.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/2018 15:24, Paul Gortmaker wrote:
> [Re: [PATCH 8/9] iommu: arm-smmu: make it explicitly non-modular] On 28/11/2018 (Wed 12:42) Robin Murphy wrote:
> 
>> Hi Paul,
>>
>> On 26/11/2018 22:31, Paul Gortmaker wrote:
> 
> [...]
> 
>>> We add a moduleparam.h include since the file does actually declare
>>> some module parameters, and leaving them as such is the easiest way
>>> currently to remain backwards compatible with existing use cases.
> 
> [...]
> 
> 
>> Is it worth introducing builtin_param() and friends for this sort of thing,
>> to echo the *_platform_driver() helpers? It seems like that could be
>> justifiable under the motivation described in the cover letter.
> 
> I've definitely gone back and looked at this a few times when coming
> across the few corner cases like these, to remind myself why I didn't do
> it already.
> 
> We'd not want to replicate all the module_param stuff as an instance of
> builtin_param() because we already have setup() and setup_param() in
> init.h -- however they don't do the file name in the param - hence the
> reason it isn't a direct swap in replacement.
> 
> So, it would become some more complex refactoring of moduleparam.h into
> say bootparam.h - to reduce code/macro duplication, while at the same
> time being aware of existing setup_param stuff and making something like
> a new setup_param_named() that is consistent with existing setup fcns.
> 
> And based on past experience, there will be reviewers who don't see the
> value in the distinction and simply reply with two words "why bother?".
> 
> Not impossible, but not as simple as the builtin_platform_driver and
> similar wrappers that I've already added to mainline.  You've made we
> want to go have another look at it again, but in the meantime we can do
> what I've done here, and circle around later to update the few instances
> of moduleparam in non-modules once/if the refactoring I describe above
> works out and is accepted in mainline.

Sure, I definitely agree with doing a first pass like this to sweep up 
all the cruft and audit the module_param users at the same time, then 
considering a robust refactoring once we've got a clear idea of how many 
users actually need it.

TBH, at this point I was thinking along the lines of a simple:

#ifndef MODULE
#define builtin_param(name, type, perm)			\
	module_param(name, type, perm)
#define builtin_param_named(name, name, type, perrm)	\
	module_param_named(name, name, type, perm)
#endif

still in moduleparam.h, purely so that the intent can be made really 
clear in driver code and it's more searchable than just comments. But 
yeah, even that would probably be objectionable to many.

>> Otherwise, the changes look reasonable. I still hold out hope that one day
>> we'll be able to make IOMMU drivers modular (it can work with minimal hacks
>> today, but it's far from robust in general), but for now I agree this makes
>> sense (and it'll be easy enough to revert for playing with further hacks).
> 
> I totally agree - I've had similar discussions with the DMA maintainers,
> and if being modular can be made to work and has a use case - great!
> 
> But it should be a conscious decision, since nobody writes a new driver
> from scratch; they copy one that is "close" as a template and then go
> from there.  Which leads to a good percentage of drivers having hints
> of modular stuff when there is no intent of them ever being modular.
> 
>> With the title fixed up as Joerg asked,
>>
>> Acked-by: Robin Murphy <robin.murphy@arm.com>
> 
> Thanks for the feedback/review.  Will re-send with updated titles before
> the week is finished and a good chance for additional feedback has elapsed.

Great! There's probably some more subtleties that could be tidied up 
when the driver is truly non-removable, but I can take a look at that 
myself once this patch has gone in.

Cheers,
Robin.
