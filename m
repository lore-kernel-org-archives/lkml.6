Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1480C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A824C2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:28:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A824C2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbeILUdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 16:33:02 -0400
Received: from foss.arm.com ([217.140.101.70]:33732 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726677AbeILUdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 16:33:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A99C7A9;
        Wed, 12 Sep 2018 08:28:01 -0700 (PDT)
Received: from [10.4.12.116] (e107155-lin.emea.arm.com [10.4.12.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 51B953F5C0;
        Wed, 12 Sep 2018 08:28:00 -0700 (PDT)
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        vkilari@codeaurora.org
Subject: Re: [PATCH] ACPI/PPTT: Handle architecturally unknown cache types
To:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Jeremy Linton <jeremy.linton@arm.com>, rjw@rjwysocki.net,
        linux-acpi@vger.kernel.org
References: <1536694334-5811-1-git-send-email-jhugo@codeaurora.org>
 <f62f22a6-2dd8-f254-dbaf-b9e224099afd@arm.com>
 <e74f2208-ac0d-6c45-8ddb-5b77d6a42fef@codeaurora.org>
 <c34452c2-d1e8-19d8-45c1-b48ecf14bbd7@arm.com>
 <98e2e6fa-7256-b5ac-7d2e-42c858c6e57c@codeaurora.org>
From:   Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <af280111-5dec-a4e1-7dfd-20f38a9fd8ab@arm.com>
Date:   Wed, 12 Sep 2018 16:27:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <98e2e6fa-7256-b5ac-7d2e-42c858c6e57c@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/09/18 15:41, Jeffrey Hugo wrote:
> On 9/11/2018 3:25 PM, Jeremy Linton wrote:
>> Hi,
>>
>> On 09/11/2018 03:38 PM, Jeffrey Hugo wrote:
>>> On 9/11/2018 2:16 PM, Jeremy Linton wrote:
>>>> Hi Jeffrey,
>>>>
>>>> (+Sudeep)
>>>>
>>>> On 09/11/2018 02:32 PM, Jeffrey Hugo wrote:
>>>>> The type of a cache might not be specified by architectural
>>>>> mechanisms (ie
>>>>> system registers), but its type might be specified in the PPTT.  In
>>>>> this
>>>>> case, following the PPTT specification, we should identify the
>>>>> cache as
>>>>> the type specified by PPTT.
>>>>>
>>>>> This fixes the following lscpu issue where only the cache type
>>>>> sysfs file
>>>>> is missing which results in no output providing a poor user
>>>>> experience in
>>>>> the above system configuration-
>>>>> lscpu: cannot open /sys/devices/system/cpu/cpu0/cache/index3/type:
>>>>> No such
>>>>> file or directory
>>>>>
>>>>> Fixes: 2bd00bcd73e5 (ACPI/PPTT: Add Processor Properties Topology
>>>>> Table parsing)
>>>>> Reported-by: Vijaya Kumar K <vkilari@codeaurora.org>
>>>>> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
>>>>> ---
>>>>>   drivers/acpi/pptt.c | 15 +++++++++++++++
>>>>>   1 file changed, 15 insertions(+)
>>>>>
>>>>> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
>>>>> index d1e26cb..3c6db09 100644
>>>>> --- a/drivers/acpi/pptt.c
>>>>> +++ b/drivers/acpi/pptt.c
>>>>> @@ -401,6 +401,21 @@ static void update_cache_properties(struct
>>>>> cacheinfo *this_leaf,
>>>>>               break;
>>>>>           }
>>>>>       }
>>>>> +    if ((this_leaf->type == CACHE_TYPE_NOCACHE) &&
>>>>> +        (found_cache->flags & ACPI_PPTT_CACHE_TYPE_VALID)) {
>>>>> +        switch (found_cache->attributes &
>>>>> ACPI_PPTT_MASK_CACHE_TYPE) {
>>>>> +        case ACPI_PPTT_CACHE_TYPE_DATA:
>>>>> +            this_leaf->type = CACHE_TYPE_DATA;
>>>>> +            break;
>>>>> +        case ACPI_PPTT_CACHE_TYPE_INSTR:
>>>>> +            this_leaf->type = CACHE_TYPE_INST;
>>>>> +            break;
>>>>> +        case ACPI_PPTT_CACHE_TYPE_UNIFIED:
>>>>> +        case ACPI_PPTT_CACHE_TYPE_UNIFIED_ALT:
>>>>> +            this_leaf->type = CACHE_TYPE_UNIFIED;
>>>>> +            break;
>>>>> +        }
>>>>> +    }
>>>>>       /*
>>>>>        * If the above flags are valid, and the cache type is NOCACHE
>>>>>        * update the cache type as well.
>>>>>
>>>>
>>>> If you look at the next line of code following this comment its
>>>> going to update the cache type for fully populated PPTT nodes.
>>>> Although with the suggested change its only going to activate if
>>>> someone completely fills out the node and fails to set the valid
>>>> flag on the cache type. 
>>>
>>> Yes, however that case doesn't apply to the scenario we are concerned
>>> about, doesn't seem to be fully following the PPTT spec, and seems
>>> odd that Linux just assumes that a "fully specified" cache is unified.
>>
>> Because, the architecturally specified ones won't be type NOCACHE?
> 
> Correct.  However, what if you have a NOCACHE (not architecturally
> specified), that is fully described in PPTT, as a non-unified cache
> (data only)?  Unlikely?  Maybe.  Still seem possible though, therefore I
> feel this assumption is suspect.
> 

Yes, we have other issues if the architecturally not specified cache is
not unified irrespective of what PPTT says. So we may need to review and
see if that assumption is removed everywhere.

Until then why can't a simple change fix the issue you have:

-->8

diff --git i/drivers/acpi/pptt.c w/drivers/acpi/pptt.c
index d1e26cb599bf..f74131201f5e 100644
--- i/drivers/acpi/pptt.c
+++ w/drivers/acpi/pptt.c
@@ -406,7 +406,8 @@ static void update_cache_properties(struct cacheinfo
*this_leaf,
         * update the cache type as well.
         */
        if (this_leaf->type == CACHE_TYPE_NOCACHE &&
-           valid_flags == PPTT_CHECKED_ATTRIBUTES)
+           (valid_flags == PPTT_CHECKED_ATTRIBUTES ||
+            found_cache->flags & ACPI_PPTT_CACHE_TYPE_VALID))
                this_leaf->type = CACHE_TYPE_UNIFIED;
 }

[...]

>>>
>>> Yes.  Without this change, we hit the lscpu error in the commit
>>> message, and get zero output about the system.  We don't even get
>>> information about the caches which are architecturally specified or
>>> how many cpus are present.

The above issues is purely lscpu to blame and nothing to do with kernel
change. If kernel doesn't report level 3 cache info and lscpu fails
to report level 1/2 cache info and kernel is to blame here ? That's unfair.

>>> With this change, we get what we expect
>>> out of lscpu (and also lstopo) including the cache(s) which are not
>>> architecturally specified.

Ofcourse, but we can't attribute that as kernel bug. I agree we should
not show incorrect info for cache type and that needs to be fixed but
disagree with lscpu issue as kernel issue. Kernel is not breaking any
ABI as cacheinfo itself is optional and the absence of it needs to be
dealt with.

>> I'm a bit surprised this changes the behavior of the architecturally
>> specified ones. As I mentioned above, those shouldn't be NOCACHE. We
>> use the level/type as a key for matching a PPTT node to an
>> architecturally described cache. If that is mismatched, something more
>> fundamental is happening. About the only case I can think of that can
>> cause this is if the CLIDR type fields are incorrect.
>>
>> In which case I might suggest we move your switch() for the INST/DATA
>> into the check below that comment.
> 
> This change was not intended to impact architecturally specified ones,
> however I can see how that is the case.  That would be the case if the
> architecturally specified type is X and PPTT indicates Y.  According to
> the PPTT spec, the cache should be treated as type Y then (ie the
> contents of the PPTT override the architectural mechanisms).
> 
> I can move my change below the current NOCACHE handling, which would be
> valid for my scenario, but it seems odd.  If I do that, then the current
> assumption will take priority.  IE, if a cache is "fully specified" in
> PPTT, but is NOCACHE, then it will be treated as unified, regardless of
> what PPTT says (maybe instruction, or data only).
> 

Yes it should be that way for above mentioned reasons. You need to fix
other things if you want to support separate data and inst cache for
architecturally unspecified cache.


[...]

> 
> However, its important that the user be able to "see" it, I'm not a
> marketing guy, but I assume its going to be listed on the "data sheet".
> 
> Therefore, the firmware is providing some information about the cache
> (via SMBIOS tables and PPTT).
> 
> The HW designers have indicated that there is no sane way to provide
> sets/ways information to software, even on an informational basis (ie
> not for cache maintenance, but for performance optimizations). Therefore
> the firmware will not provide this information because it will be wrong.
> 

Fair enough.

> So, therefore, we should still be able to tell the user that a cache
> exists at the relevant level, and what size it is.  On the concerned
> system, we cannot do that currently.
> 

Again agreed.

-- 
Regards,
Sudeep
