Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC74C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74B752184D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbfBZPMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 10:12:44 -0500
Received: from foss.arm.com ([217.140.101.70]:49026 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbfBZPMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 10:12:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E654AEBD;
        Tue, 26 Feb 2019 07:12:42 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E48A3F575;
        Tue, 26 Feb 2019 07:12:41 -0800 (PST)
Subject: Re: [PATCH v2] mm/memory-hotplug: Add sysfs hot-remove trigger
To:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        akpm@linux-foundation.org, osalvador@suse.de
References: <49ef5e6c12f5ede189419d4dcced5dc04957c34d.1549906631.git.robin.murphy@arm.com>
 <20190212083310.GM15609@dhcp22.suse.cz>
 <faca65d7-6d4b-7e4f-5b36-4fdf3710b0e3@arm.com>
 <20190212151146.GA15609@dhcp22.suse.cz>
 <1ea6a40d-be86-6ccc-c728-fa8effbd5a8e@redhat.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <8793f49d-756f-960d-9b26-7eaedfccd90e@arm.com>
Date:   Tue, 26 Feb 2019 15:12:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1ea6a40d-be86-6ccc-c728-fa8effbd5a8e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/02/2019 21:14, David Hildenbrand wrote:
> On 12.02.19 16:11, Michal Hocko wrote:
>> On Tue 12-02-19 14:54:36, Robin Murphy wrote:
>>> On 12/02/2019 08:33, Michal Hocko wrote:
>>>> On Mon 11-02-19 17:50:46, Robin Murphy wrote:
>>>>> ARCH_MEMORY_PROBE is a useful thing for testing and debugging hotplug,
>>>>> but being able to exercise the (arguably trickier) hot-remove path would
>>>>> be even more useful. Extend the feature to allow removal of offline
>>>>> sections to be triggered manually to aid development.
>>>>>
>>>>> Since process dictates the new sysfs entry be documented, let's also
>>>>> document the existing probe entry to match - better 13-and-a-half years
>>>>> late than never, as they say...
>>>>
>>>> The probe sysfs is quite dubious already TBH. Apart from testing, is
>>>> anybody using it for something real? Do we need to keep an API for
>>>> something testing only? Why isn't a customer testing module enough for
>>>> such a purpose?
>>>
>>>  From the arm64 angle, beyond "conventional" servers where we can hopefully
>>> assume ACPI, I can imagine there being embedded/HPC setups (not all as
>>> esoteric as that distributed-memory dRedBox thing), as well as virtual
>>> machines, that are DT-based with minimal runtime firmware. I'm none too keen
>>> on the idea either, but if such systems want to support physical hotplug
>>> then driving it from userspace might be the only reasonable approach. I'm
>>> just loath to actually document it as anything other than a developer
>>> feature so as not to give the impression that I consider it anything other
>>> than a last resort for production use.
>>
>> This doesn't sound convicing to add an user API.
>>
>>> I do note that my x86 distro kernel
>>> has ARCH_MEMORY_PROBE enabled despite it being "for testing".
>>
>> Yeah, there have been mistakes done in the API land & hotplug in the
>> past.
>>
>>>> In other words, why do we have to add an API that has to be maintained
>>>> for ever for a testing only purpose?
>>>
>>> There's already half the API being maintained, though, so adding the
>>> corresponding other half alongside it doesn't seem like that great an
>>> overhead, regardless of how it ends up getting used.
>>
>> As already said above. The hotplug user API is not something to follow
>> for the future development. So no, we are half broken let's continue is
>> not a reasonable argument.
>>
>>> Ultimately, though,
>>> it's a patch I wrote because I needed it, and if everyone else is adamant
>>> that it's not useful enough then fair enough - it's at least in the list
>>> archives now so I can sleep happy that I've done my "contributing back" bit
>>> as best I could :)
>>
>> I am not saing this is not useful. It is. But I do not think we want to
>> make it an official api without a strong usecase. And then we should
>> think twice to make the api both useable and reasonable. A kernel module
>> for playing sounds like more than sufficient.
>>
> 
> I'm late for the party, I consider this very useful for testing, but I
> agree that this should not be an official API.
> 
> The memory API is already very messed up. We have the "removable"
> attribute which does not mean that memory is removable. It means that
> memory can be offlined and eventually "unplugged/removed" if the HW
> supports it (e.g. a DIMM, otherwise it will never go).
> 
> You would be introducing "remove", which would sometimes not work when
> "removable" indicates "true" (because your API only works if memory has
> already been offlined). I would much rather want to see some of the mess
> get cleaned up than new stuff getting added that might not be needed
> besides for testing. Yes, not your fault, but an API that keeps getting
> more confusing.

OK, I guess Andrew should probably drop this patch from -next - I'll add 
my own self-nack if it helps :)

The back of my mind is still ticking over trying to think up a really 
nice design for a self-contained debugfs or module-parameter interface 
completely independent of ARCH_MEMORY_PROBE - I'll probably keep using 
this hack locally to finish off the arm64 hot-remove stuff, but once 
that's done (or if inspiration strikes in the meantime) then I'll try to 
come back with a prototype of the developer interface that I'd find most 
useful.

> I am really starting to strongly dislike the "removable" attribute.

Yeah, I think in general we could do with a new term for boolean-like 
things which have values of "no" and "maybe" - or "yes" and "maybe" in 
the case of security vulnerabilities :)

Robin.
