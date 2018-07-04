Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0E9C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CFEC20BEC
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:35:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CFEC20BEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933663AbeGDKfw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 06:35:52 -0400
Received: from mga11.intel.com ([192.55.52.93]:54342 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753048AbeGDKfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 06:35:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2018 03:35:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,306,1526367600"; 
   d="scan'208";a="62208992"
Received: from um.fi.intel.com (HELO um) ([10.237.72.212])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Jul 2018 03:35:45 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>, ast@kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-s390@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 5/6] perf/core: Use ioctl to communicate driver configuration to kernel
In-Reply-To: <CANLsYkw4w-zRczcb2uddO4UsxXrCCoXCSkPko2it-OJX2H0ecA@mail.gmail.com>
References: <1530570810-28929-1-git-send-email-mathieu.poirier@linaro.org> <1530570810-28929-6-git-send-email-mathieu.poirier@linaro.org> <20180703100348.fy43f4fosw3fdc6i@um.fi.intel.com> <20180703105652.psjq5cq4t7o2j6zk@um.fi.intel.com> <CANLsYkw4w-zRczcb2uddO4UsxXrCCoXCSkPko2it-OJX2H0ecA@mail.gmail.com>
User-Agent: Notmuch/0.27 (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Wed, 04 Jul 2018 13:34:41 +0300
Message-ID: <87fu0z70hq.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Poirier <mathieu.poirier@linaro.org> writes:

> On Tue, 3 Jul 2018 at 04:57, Alexander Shishkin
> <alexander.shishkin@linux.intel.com> wrote:
>>
>> On Tue, Jul 03, 2018 at 01:03:48PM +0300, Alexander Shishkin wrote:
>> > On Mon, Jul 02, 2018 at 04:33:29PM -0600, Mathieu Poirier wrote:
>> > > +/*
>> > > + * PMU driver configuration works the same way as filter management above,
>> > > + * but without the need to deal with memory mapping.  Driver configuration
>> > > + * arrives through the SET_DRV_CONFIG ioctl() where it is validated and applied
>> > > + * to the event.  When the PMU is ready it calls perf_event_drv_config_sync() to
>> > > + * bring the configuration information within reach of the PMU.
>> >
>> > Wait a second. The reason why we dance around with the generations of filters
>> > is the locking order of ctx::mutex vs mmap_sem. In an mmap path, where we're
>> > notified about mapping changes, we're called under the latter, and we'd need
>> > to grab the former to update the event configuration. In your case, the
>> > update comes in via perf_ioctl(), where we're already holding the ctx::mutex,
>> > so you can just kick the PMU right there, via an event_function_call() or
>> > perf_event_stop(restart=1). In the latter case, your pmu::start() would just
>> > grab the new configuration. Should also be about 90% less code. :)
>>
>> Also, since it affects the AUX buffer configuration, it is probably a one
>> time ioctl command that you issue before you mmap the buffer. If that's
>> the case, you don't even have to worry about stopping the event, as it
>> shouldn't be running, because without the buffer perf_aux_output_begin()
>> should fail and so should the pmu::add() iirc.
>>
>
> The idea behind the current approach was to make the SET_DRV_CONFIG
> ioctl() usable by other drivers where multiple ioctl() calls could be
> performed while a session in ongoing.  I also opted to introduce a
> _sync() function to let the PMU refresh its configuration at the time
> of its own choosing rather than having to interrupt the session.

Yes, but the times of PMU's own choosing would still be more or less
limited to ->start()/->stop().

You can also do an event_function_call(), which would call
->config_sync(), which would be free to decide what to do with the new
information, up to and including doing a ->stop()/->start() sequence. My
guess is that you'd want to do either of the following:
 * decide to apply the new configuration immediately, and do the
 start-stop thing,
 * decide to defer the new configuration until the next ->start().

Both should work via cross call directly from the ioctl() call.

> But all I need for coresight is to have available the sink information
> and PMU configuration (in an upcoming patchset) by the time
> setup_aux() is called.  You are correct, this is a one time
> configuration and since the event isn't running there is no need for
> locking - I should be able to access the PMU when the ioctl is called.
>
> If you are fine with this bare-bone scenario and don't care much about
> usability in different situation, I'll do a respin with minimal
> functionality that cover my needs.

It doesn't have to be bare-bones, what I'm saying is that you shouldn't
need the event->drv_config, as you can directly call
pmu::config(new_config) (or config_sync(), but I'm guessing the _sync
part is redundant if you don't keep the configuration in 2 parts) from
the ioctl() and it should cover all your bases.

Regards,
--
Alex
