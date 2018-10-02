Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE614C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDB3D205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:00:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDB3D205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730868AbeJBUn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:43:56 -0400
Received: from mga02.intel.com ([134.134.136.20]:61129 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729477AbeJBUn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:43:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Oct 2018 07:00:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,332,1534834800"; 
   d="scan'208";a="77847848"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.212])
  by orsmga007.jf.intel.com with ESMTP; 02 Oct 2018 07:00:05 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org, jolsa@redhat.com
Subject: Re: [PATCH v1 4/6] perf: Allow using AUX data in perf samples
In-Reply-To: <20180621201632.GE27616@hirez.programming.kicks-ass.net>
References: <20180612075117.65420-1-alexander.shishkin@linux.intel.com> <20180612075117.65420-5-alexander.shishkin@linux.intel.com> <20180614202022.GC12217@hirez.programming.kicks-ass.net> <20180619104725.bqvs7uwzhb4ihyxy@um.fi.intel.com> <20180621201632.GE27616@hirez.programming.kicks-ass.net>
Date:   Tue, 02 Oct 2018 17:00:05 +0300
Message-ID: <87k1n078ka.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Tue, Jun 19, 2018 at 01:47:25PM +0300, Alexander Shishkin wrote:
>> On Thu, Jun 14, 2018 at 10:20:22PM +0200, Peter Zijlstra wrote:
>
>> > More yuck...
>> > 
>> > You rreally should not be calling these pmu::methods, they're meant to
>> > be used from _interrupt_ not NMI context. Using them like this is asking
>> > for tons of trouble.
>> 
>> Right, the SW stuff may then race with event_function_call() stuff. Hmm.
>> For the HW stuff, I'm hoping that some kind of a sleight of hand may
>> suffice. Let me think some more.
>
> I currently don't see how the SW driven snapshot can ever work, see my
> comment on the last patch.

Unless we explicitly break clone when PERF_SAMPLE_AUX is set. Basically,
if you're asking for AUX samples, full perf context switch is not your
biggest performance penalty.

>> > Why can't you just snapshot the current location and let the thing
>> > 'run' ?
>> 
>> Because the buffer will overwrite itself and the location will be useless.
>
> Not if it's large enough ;-)
>
>> We don't write the AUX data out in this 'mode' at all, only the samples,
>> which allows for much less data in the resulting perf.data, less work for
>> the consumer, less IO bandwidth etc, and as a bonus, no AUX-related
>> interrupts.
>> 
>> But actually, even to snapshot the location we need to stop the event.
>
> Maybe new methods that should only be called from NMI context? 

True. Ideally, the existing ->start()/->stop()/interrupt should already
do all necessary internal bookkeeping.

Regards,
--
Alex
