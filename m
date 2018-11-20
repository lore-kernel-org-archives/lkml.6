Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB0AC32788
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 22:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B660620C01
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 22:19:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B660620C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbeKUIuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 03:50:25 -0500
Received: from mga07.intel.com ([134.134.136.100]:56487 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbeKUIuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 03:50:24 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2018 14:19:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,258,1539673200"; 
   d="scan'208";a="109807369"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by fmsmga001.fm.intel.com with ESMTP; 20 Nov 2018 14:19:01 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id B564C3018C4; Tue, 20 Nov 2018 14:19:01 -0800 (PST)
Date:   Tue, 20 Nov 2018 14:19:01 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Kyle Huey <me@kylehuey.com>
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Robert O'Callahan <robert@ocallahan.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>, acme@kernel.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [REGRESSION] x86, perf: counter freezing breaks rr
Message-ID: <20181120221901.GG13936@tassilo.jf.intel.com>
References: <CAP045Ap6Mm+r_44YmxNbz6HWtYArg3SAFgzk4Cm_K5HRJaRG7w@mail.gmail.com>
 <20181120194129.GC13936@tassilo.jf.intel.com>
 <CAP045ApoZamGdgVd=-MJE52rUU5hnOg=j95B1WV2x_bVtRQpWA@mail.gmail.com>
 <20181120201144.GD13936@tassilo.jf.intel.com>
 <CAP045AoF7-3VBjhaij8JrVLuw+1dUxmLAGthPJm7CsTyY7T9nA@mail.gmail.com>
 <20181120211803.GF13936@tassilo.jf.intel.com>
 <CAP045AprqsgphfBpUe37MjVFu4T9KTb_mYuMj=q0T+9-kbK0qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP045AprqsgphfBpUe37MjVFu4T9KTb_mYuMj=q0T+9-kbK0qw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 01:46:05PM -0800, Kyle Huey wrote:
> On Tue, Nov 20, 2018 at 1:18 PM Andi Kleen <ak@linux.intel.com> wrote:
> >
> > > I suppose that's fair that it's better for some use cases. The flip
> > > side is that it's no longer possible to get exactly accurate counts
> > > from user space if you're using the PMI (because any events between
> > > the overflow itself and the transition to the PMI handler are
> > > permanently lost) which is catastrophically bad for us :)
> >
> > Yes that's a fair point. For most usages it doesn't matter.
> >
> > I suspect that's a case for supporting opt-out for freezing
> > per perf event, and rr using that.
> 
> I don't see how you could easily opt-out on a per perf event basis. If
> I'm reading the SDM correctly the Freeze_PerfMon_On_PMI setting is
> global and affects all counters on that CPU. Even counters that don't
> use the PMI at all will still be frozen if another counter overflows
> and counter freezing is enabled. It would seem that a counter that
> wants to use counter freezing and a counter that wants the behavior we
> want would be mutually exclusive. I suppose the kernel could handle
> all of that but it's a bit involved.

Yes it's a per CPU setting.  You wouldn't be able to opt-in. If anyone opts
out on a CPU it would be disabled on that CPU while that event
is active.

-Andi
