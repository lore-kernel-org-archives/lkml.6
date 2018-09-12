Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C2DC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77889206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:50:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77889206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbeILPx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 11:53:57 -0400
Received: from foss.arm.com ([217.140.101.70]:57488 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727047AbeILPx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 11:53:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E555C7A9;
        Wed, 12 Sep 2018 03:49:57 -0700 (PDT)
Received: from [10.4.12.116] (e107155-lin.emea.arm.com [10.4.12.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 706DA3F614;
        Wed, 12 Sep 2018 03:49:56 -0700 (PDT)
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        vkilari@codeaurora.org
Subject: Re: [PATCH] ACPI/PPTT: Handle architecturally unknown cache types
To:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Jeremy Linton <jeremy.linton@arm.com>, rjw@rjwysocki.net,
        linux-acpi@vger.kernel.org
References: <1536694334-5811-1-git-send-email-jhugo@codeaurora.org>
 <f62f22a6-2dd8-f254-dbaf-b9e224099afd@arm.com>
 <e74f2208-ac0d-6c45-8ddb-5b77d6a42fef@codeaurora.org>
From:   Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <f8dc2958-a7c7-a633-3a06-97fed7c3510b@arm.com>
Date:   Wed, 12 Sep 2018 11:49:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <e74f2208-ac0d-6c45-8ddb-5b77d6a42fef@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/09/18 21:38, Jeffrey Hugo wrote:
> On 9/11/2018 2:16 PM, Jeremy Linton wrote:
>> Hi Jeffrey,
>>
>> (+Sudeep)
>>

[..]

>>
>> If you look at the next line of code following this comment its going
>> to update the cache type for fully populated PPTT nodes. Although with
>> the suggested change its only going to activate if someone completely
>> fills out the node and fails to set the valid flag on the cache type. 
> 
> Yes, however that case doesn't apply to the scenario we are concerned
> about, doesn't seem to be fully following the PPTT spec, and seems odd
> that Linux just assumes that a "fully specified" cache is unified.
> 

Agreed, but adding code that will never get used is also not so good.
Do you have systems where this is needed ?

>> What I suspect is happening in the reported case is that the nodes in
>> the PPTT table are missing fields we consider to be important. Since
>> that data isn't being filled out anywhere else, so we leave the cache
>> type alone too. This has the effect of hiding sysfs nodes with
>> incomplete information.
>>
>> Also, the lack of the DATA/INST fields is based on the assumption that
>> the only nodes which need their type field updated are outside of the
>> CPU core itself so they are pretty much guaranteed to be UNIFIED. Are
>> you hitting this case?
>>
> 
> Yes.  Without this change, we hit the lscpu error in the commit message,
> and get zero output about the system.  We don't even get information
> about the caches which are architecturally specified or how many cpus
> are present.  With this change, we get what we expect out of lscpu (and
> also lstopo) including the cache(s) which are not architecturally
> specified.
> 

lscpu and lstopo are so broken. They just assume everything on CPU0.
If you hotplug them out, you start seeing issues. So reading and file
that doesn't exist and then bail out on other essential info though they
are present, hmmm ...

> I guess I still don't understand why its important for PPTT to list, for
> example, the sets/ways of a cache in all scenarios.  In the case of a
> "transparent" cache (implementation defined as not reported per section
> D3.4.2 of the ARM ARM where the cache cannot be managed by SW), there
> may not be valid values for sets/ways.  I would argue its better to not
> report that information, rather than provide bogus information just to
> make Linux happy, which may break other OSes and provide means for which
> a user to hang themselves.
> 

While I agree presenting wrong info is not good, but one of the reasons
the cache info is present is to provide those info for some applications
to do optimization based on that(I am told so and not sure if just type
and size will be good enough) and you seem to agree with that below.

> However, in the case of a transparent cache, the size/type/level/write
> policy/etc (whatever the firmware provider deems relevant) might be
> valuable information for the OS to make scheduling decisions, and is
> certainly valuable for user space utilities for cross-machine/data
> center level job scheduling.
> 

-- 
Regards,
Sudeep
