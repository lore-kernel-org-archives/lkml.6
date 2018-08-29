Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E03BC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 16:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF802064A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 16:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CF802064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbeH2U36 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 16:29:58 -0400
Received: from foss.arm.com ([217.140.101.70]:57872 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727293AbeH2U36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 16:29:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E86B18A;
        Wed, 29 Aug 2018 09:32:15 -0700 (PDT)
Received: from dupont (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D9EF83F557;
        Wed, 29 Aug 2018 09:32:14 -0700 (PDT)
Date:   Wed, 29 Aug 2018 11:32:14 -0500
From:   Kim Phillips <kim.phillips@arm.com>
To:     Robert Walker <robert.walker@arm.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, <mike.leach@linaro.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] perf: Support for Arm A32/T32 instruction sets in
 CoreSight trace
Message-Id: <20180829113214.8eb35081da54214c758434ff@arm.com>
In-Reply-To: <8ff74d1f-e211-7423-2ad4-35369444488e@arm.com>
References: <1535535863-1818-1-git-send-email-robert.walker@arm.com>
        <20180829084943.eca3716eb2a2141e5eb8e6ee@arm.com>
        <8ff74d1f-e211-7423-2ad4-35369444488e@arm.com>
Organization: Arm
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Aug 2018 15:34:16 +0100
Robert Walker <robert.walker@arm.com> wrote:

> Hi Kim,

Hi Robert,

> On 29/08/18 14:49, Kim Phillips wrote:
> > On Wed, 29 Aug 2018 10:44:23 +0100
> > Robert Walker <robert.walker@arm.com> wrote:
> >
> >> This patch adds support for generating instruction samples from trace of
> >> AArch32 programs using the A32 and T32 instruction sets.
> >>
> >> T32 has variable 2 or 4 byte instruction size, so the conversion between
> >> addresses and instruction counts requires extra information from the trace
> >> decoder, requiring version 0.9.1 of OpenCSD.  A check for the new struct
> >> member has been added to the feature check for OpenCSD.
> >>
> >> Signed-off-by: Robert Walker <robert.walker@arm.com>
> >> ---
> > ...
> >> +++ b/tools/build/feature/test-libopencsd.c
> >> @@ -3,6 +3,13 @@
> >>   
> >>   int main(void)
> >>   {
> >> +	/*
> >> +	 * Requires ocsd_generic_trace_elem.num_instr_range introduced in
> >> +	 * OpenCSD 0.9
> > 0.9 != 0.9.1 in the above commit text: which is it?
> I'll change it to 0.9.1 if there's another version of the patch (it was 
> introduced in 0.9, but 0.9.1 has a necessary bug fix)
> >> +	 */
> >> +	ocsd_generic_trace_elem elem;
> >> +	(void)elem.num_instr_range;
> >> +
> > This breaks building against older versions of OpenCSD, right?
> >
> >>   	(void)ocsd_get_version();
> > Why don't we maintain building against older versions of the library,
> > and use the version information to make the decision on whether to use
> > the new feature being introduced in this patch?
> The intention is to fail the feature detection check if the older 
> version is installed - perf will still compile, but without the 
> CoreSight trace support.

It should still compile, and with CoreSight trace support, just
not support for A32/T32 instruction sets.  The user shouldn't be denied
CoreSight trace support if they don't care for A32/T32 ISA support.

> OpenCSD is still in development, so new features like this are being 
> added and it would add a lot of #ifdef mess to the perf code to continue 
> to support any machines with the old library version installed - there 

Even adding #ifdefs, that won't survive taking one perf executable
built on one machine and running it on another machine with a different
version of the OpenCSD library: it'll break inconspicuously, not
gracefully!

There needs to be a run-time means of working with older versions of
the library.

Consider checking the sizeof some of the structs?  IIRC, some of the
structs sizes changed in the library.  See e.g., the 'size' field of
perf_event_attr:

size
     The size of the perf_event_attr structure for forward/backward
     compatibility.  Set this using sizeof(struct perf_event_attr)
     to allow the kernel to see the struct size at the time
     of compilation.

or, likely better, the 'version' and 'compat_version' of the
perf_event_mmap_page structure:

           struct perf_event_mmap_page {
               __u32 version;        /* version number of this structure */
               __u32 compat_version; /* lowest version this is compat with */
	       ...

> will only be a handful of machines affected and it's trivial to upgrade 
> them (the new Debian packages are available).  

This is upstream linux, so I don't know how you know only a 'handful'
of machines affected, and I wouldn't assume everyone's using Debian.

For one, I'd hate to see a single user affected if it isn't necessary,
as is in this case - not everyone wants A32/T32 ISA support, and
library compatibility needn't be broken.

This 'screw compatibility' mentality needs to be dropped *now* if
CoreSight support is to have a successful future.

Otherwise, I suggest keeping this feature in downstream trees for the
'handful', until the library and perf code are rewritten in a state
where they properly interoperate, and do not break each other.

> How long would we 
> continue to support such an older version?

What do you mean such an older version?  The project's v0.9.0 commit
was on 20 June 2018, the one that's usable - v0.9.1 - has a July 27
2018 commit date!  One month is *not* *old*!

>  I also don't see any 
> precedent for supporting multiple dependent library versions in perf.

That's because perf doesn't have a precedent on depending on libraries
that flat-out break their own users compatibility across versions ;)

Thanks,

Kim
