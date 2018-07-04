Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AB8C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6502421A8F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:51:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6502421A8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933862AbeGDKva (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 06:51:30 -0400
Received: from mga05.intel.com ([192.55.52.43]:25702 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753300AbeGDKv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 06:51:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2018 03:51:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,306,1526367600"; 
   d="scan'208";a="72191011"
Received: from um.fi.intel.com (HELO um) ([10.237.72.212])
  by orsmga002.jf.intel.com with ESMTP; 04 Jul 2018 03:51:23 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>, ast@kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-s390@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 5/6] perf/core: Use ioctl to communicate driver configuration to kernel
In-Reply-To: <CANLsYkxpLyqN76KQ3VyLq8H27hLsHxLy+zZA1xRyUXGXwx42AA@mail.gmail.com>
References: <1530570810-28929-1-git-send-email-mathieu.poirier@linaro.org> <1530570810-28929-6-git-send-email-mathieu.poirier@linaro.org> <20180703100348.fy43f4fosw3fdc6i@um.fi.intel.com> <CANLsYkxpLyqN76KQ3VyLq8H27hLsHxLy+zZA1xRyUXGXwx42AA@mail.gmail.com>
User-Agent: Notmuch/0.27 (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Wed, 04 Jul 2018 13:51:22 +0300
Message-ID: <87bmbn6zpx.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Poirier <mathieu.poirier@linaro.org> writes:

> Hi Alex,

Hi Mathieu,

> On Tue, 3 Jul 2018 at 04:03, Alexander Shishkin
> <alexander.shishkin@linux.intel.com> wrote:
>>
>> On Mon, Jul 02, 2018 at 04:33:29PM -0600, Mathieu Poirier wrote:
>> > This patch follows what has been done for filters by adding an ioctl()
>> > option to communicate to the kernel arbitrary PMU specific configuration
>> > that don't fit in the conventional struct perf_event_attr to the kernel.
>>
>> Ok, so what *is* the PMU specific configuration that doesn't fit in the
>> attribute and needs to be re-configured by the driver using the generation
>> tracking?
>>
>
> In this patchset I'm am after the specification of sink information
> for each event, i.e what sink a CPU is supposed to use for the
> session.  I simply don't see putting something that PMU specific in
> the generic perf_event_attr structure.  I also intend to use the same
> ioctl mechanism to communicate complex tracer configuration for
> sequencers, counters and input events.  I don't see a nice way of
> doing that from the perf_event_attr, and that is even without thinking
> about the different flavours of tracers out there, all with their own
> features.

Yes, the sequencers and counters seem tricky. Here's a wild idea: can
the sequencer/counter configuration be expressed as an eBPF program? Or,
can an eBPF program be used to program those?

> I've looked around and the only clean way I found to support this is
> via an ioctl().  That way each tracer can easily identify the sink it
> should be using without smearing the perf_event_attr structure.  I
> would be happy to explore a different avenue should you think of
> something.

Yes, I also have something similar on my todo list and I was previously
thinking along the lines of pipe()/splice(). As in, you take the AUX
event file descriptor and feed it to the sink, at which point the trace
path is configured. I need to dig up the notes that I made back in the
day to continue this conversation in more concrete terms.

Regards,
--
Alex
