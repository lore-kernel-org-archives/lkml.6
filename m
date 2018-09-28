Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EB7C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 20:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F042206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 20:49:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F042206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbeI2DPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 23:15:01 -0400
Received: from mga14.intel.com ([192.55.52.115]:37881 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbeI2DO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 23:14:59 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Sep 2018 13:49:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,316,1534834800"; 
   d="scan'208";a="90498389"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by fmsmga002.fm.intel.com with ESMTP; 28 Sep 2018 13:49:28 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 4749B300B51; Fri, 28 Sep 2018 13:49:30 -0700 (PDT)
Date:   Fri, 28 Sep 2018 13:49:30 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Tvrtko Ursulin <tursulin@ursulin.net>,
        LKML <linux-kernel@vger.kernel.org>,
        tvrtko.ursulin@linux.intel.com,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>
Subject: Re: [RFC 0/5] perf: Per PMU access controls (paranoid setting)
Message-ID: <20180928204930.GC32651@tassilo.jf.intel.com>
References: <20180919122751.12439-1-tvrtko.ursulin@linux.intel.com>
 <alpine.DEB.2.21.1809281151190.2004@nanos.tec.linutronix.de>
 <20180928164111.i6nba2j6mnegwslw@lakrids.cambridge.arm.com>
 <20180928172340.GA32651@tassilo.jf.intel.com>
 <20180928174016.i7d24puv7y3jwzf6@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180928174016.i7d24puv7y3jwzf6@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 06:40:17PM +0100, Mark Rutland wrote:
> On Fri, Sep 28, 2018 at 10:23:40AM -0700, Andi Kleen wrote:
> > > There's also been prior discussion on these feature in other contexts
> > > (e.g. android expoits resulting from out-of-tree drivers). It would be
> > > nice to see those considered.
> > > 
> > > IIRC The conclusion from prior discussions (e.g. [1]) was that we wanted
> > > finer granularity of control such that we could limit PMU access to
> > > specific users -- e.g. disallow arbitrary android apps from poking *any*
> > > PMU, while allowing some more trusted apps/users to uses *some* specific
> > > PMUs.
> > > 
> > > e.g. we could add /sys/bus/event_source/devices/${PMU}/device, protect
> > > this via the usual fs ACLs, and pass the fd to perf_event_open()
> > > somehow. A valid fd would act as a capability, taking precedence over
> > > perf_event_paranoid.
> > 
> > That sounds like an orthogonal feature. I don't think the original
> > patchkit would need to be hold up for this. It would be something
> > in addition.
> 
> I have to say that I disagree -- these controls will have to interact
> somehow, and the fewer of them we have, the less complexity we'll have
> to deal with longer-term.

You're proposing to completely redesign perf_event_open.

This new file descriptor argument doesn't exist today so it would
need to create a new system call with more arguments

(and BTW it would be more than the normal 6 argument limit
we have, so actually it couldn't even be a standard sycall)

Obviously we would need to keep the old system call around
for compability, so you would need to worry about this
interaction in any case!

So tying it together doesn't make any sense, because
the problem has to be solved separately anyways.

> 
> > BTW can't you already do that with the syscall filter? I assume
> > the Android sandboxes already use that. Just forbid perf_event_open
> > for the apps.
> 
> Note that this was about providing access to *some* PMUs in some cases.
> 
> IIUC, if that can be done today via a syscall filter, the same is true
> of per-pmu paranoid settings.

The difference is that the Android sandboxes likely already doing this
and have all the infrastructure, and it's just another rule.

Requiring syscall filters just to use the PMU on xn system
that otherwise doesn't need them would be very odd.

-Andi
