Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA901C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 623A92083C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:42:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 623A92083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbeHaRti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 13:49:38 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58546 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728408AbeHaRti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 13:49:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B82247A9;
        Fri, 31 Aug 2018 06:42:04 -0700 (PDT)
Received: from [10.0.2.15] (unknown [10.37.12.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F4593F5BC;
        Fri, 31 Aug 2018 06:42:02 -0700 (PDT)
Subject: Re: [PATCH v2] perf: Support for Arm A32/T32 instruction sets in
 CoreSight trace
To:     Kim Phillips <kim.phillips@arm.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, mike.leach@linaro.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1535535863-1818-1-git-send-email-robert.walker@arm.com>
 <20180829084943.eca3716eb2a2141e5eb8e6ee@arm.com>
 <8ff74d1f-e211-7423-2ad4-35369444488e@arm.com>
 <20180829113214.8eb35081da54214c758434ff@arm.com>
From:   Robert Walker <robert.walker@arm.com>
Message-ID: <df383a27-d0e9-a1fc-8f36-868b2ca32117@arm.com>
Date:   Fri, 31 Aug 2018 14:42:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180829113214.8eb35081da54214c758434ff@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kim,

Generally, I agree with you about breaking backward compatibility, but 
in this case I don't think there is an actual problem.  As I understand 
it, you're worried that perf will break for people who are using an 
older version (0.8.x) of the OpenCSD library for CoreSight trace decode 
and this patch updates the requirement to a newer version (0.9.x) to 
enable support for trace of 32-bit applications.

There are only a few (4/5?) targets around with working support for 
CoreSight trace (and of these only Juno is the only platform with a 
devicetree in the mainline kernel), so only a few users of perf for Arm 
trace decode - most of these are people working those directly involved 
with Arm & Linaro or will be reading the coresight mailing list.  Anyone 
working with OpenCSD will have got it from github and compiled it 
themselves, so they can update and build a new version.  It's only been 
packaged for debian so far and testing already has the 0.9.x version 
(the 0.8.x version was only in debian for 8 days before being replaced 
by 0.9.x).

It would be possible to add conditional compilation flags to support 
compiling with 0.8.x, but I feel this would add too much mess to the 
code and I'd need some help in figuring out perf's feature detection 
system to generate the flags.  Given the likely small number of people 
affected and the easy upgrade path, I don't think this is worth it.


On 29/08/18 17:32, Kim Phillips wrote:
> On Wed, 29 Aug 2018 15:34:16 +0100
> Robert Walker <robert.walker@arm.com> wrote:
>
>> Hi Kim,
> Hi Robert,
>
>> On 29/08/18 14:49, Kim Phillips wrote:
>>> On Wed, 29 Aug 2018 10:44:23 +0100
>>> Robert Walker <robert.walker@arm.com> wrote:
>>>
>>>> This patch adds support for generating instruction samples from trace of
>>>> AArch32 programs using the A32 and T32 instruction sets.
>>>>
>>>> T32 has variable 2 or 4 byte instruction size, so the conversion between
>>>> addresses and instruction counts requires extra information from the trace
>>>> decoder, requiring version 0.9.1 of OpenCSD.  A check for the new struct
>>>> member has been added to the feature check for OpenCSD.
>>>>
>>>> Signed-off-by: Robert Walker <robert.walker@arm.com>
>>>> ---
>>> ...
>>>> +++ b/tools/build/feature/test-libopencsd.c
>>>> @@ -3,6 +3,13 @@
>>>>    
>>>>    int main(void)
>>>>    {
>>>> +	/*
>>>> +	 * Requires ocsd_generic_trace_elem.num_instr_range introduced in
>>>> +	 * OpenCSD 0.9
>>> 0.9 != 0.9.1 in the above commit text: which is it?
>> I'll change it to 0.9.1 if there's another version of the patch (it was
>> introduced in 0.9, but 0.9.1 has a necessary bug fix)
>>>> +	 */
>>>> +	ocsd_generic_trace_elem elem;
>>>> +	(void)elem.num_instr_range;
>>>> +
>>> This breaks building against older versions of OpenCSD, right?
>>>
>>>>    	(void)ocsd_get_version();
>>> Why don't we maintain building against older versions of the library,
>>> and use the version information to make the decision on whether to use
>>> the new feature being introduced in this patch?
>> The intention is to fail the feature detection check if the older
>> version is installed - perf will still compile, but without the
>> CoreSight trace support.
> It should still compile, and with CoreSight trace support, just
> not support for A32/T32 instruction sets.  The user shouldn't be denied
> CoreSight trace support if they don't care for A32/T32 ISA support.
>
>> OpenCSD is still in development, so new features like this are being
>> added and it would add a lot of #ifdef mess to the perf code to continue
>> to support any machines with the old library version installed - there
> Even adding #ifdefs, that won't survive taking one perf executable
> built on one machine and running it on another machine with a different
> version of the OpenCSD library: it'll break inconspicuously, not
> gracefully!

perf has a lot of other shared library dependencies (ELF , unwind 
libraries etc), so moving builds between systems is already fragile.

> There needs to be a run-time means of working with older versions of
> the library.
>
> Consider checking the sizeof some of the structs?  IIRC, some of the
> structs sizes changed in the library.  See e.g., the 'size' field of
> perf_event_attr:
>
> size
>       The size of the perf_event_attr structure for forward/backward
>       compatibility.  Set this using sizeof(struct perf_event_attr)
>       to allow the kernel to see the struct size at the time
>       of compilation.
>
> or, likely better, the 'version' and 'compat_version' of the
> perf_event_mmap_page structure:
>
>             struct perf_event_mmap_page {
>                 __u32 version;        /* version number of this structure */
>                 __u32 compat_version; /* lowest version this is compat with */
> 	       ...
>
>> will only be a handful of machines affected and it's trivial to upgrade
>> them (the new Debian packages are available).
> This is upstream linux, so I don't know how you know only a 'handful'
> of machines affected, and I wouldn't assume everyone's using Debian.
>
> For one, I'd hate to see a single user affected if it isn't necessary,
> as is in this case - not everyone wants A32/T32 ISA support, and
> library compatibility needn't be broken.
>
> This 'screw compatibility' mentality needs to be dropped *now* if
> CoreSight support is to have a successful future.
>
> Otherwise, I suggest keeping this feature in downstream trees for the
> 'handful', until the library and perf code are rewritten in a state
> where they properly interoperate, and do not break each other.
>
>> How long would we
>> continue to support such an older version?
> What do you mean such an older version?  The project's v0.9.0 commit
> was on 20 June 2018, the one that's usable - v0.9.1 - has a July 27
> 2018 commit date!  One month is *not* *old*!
I mean the 0.8.x version as the old version.
>>    I also don't see any
>> precedent for supporting multiple dependent library versions in perf.
> That's because perf doesn't have a precedent on depending on libraries
> that flat-out break their own users compatibility across versions ;)
This patch picks up a new feature that's been added - I notice the 
feature detection checks for other libraries check a number of features 
and emit warnings about required versions.

> Thanks,
>
> Kim

Regards

Rob


