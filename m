Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196C5C04E87
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC39E206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:41:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC39E206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbeI1XFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 19:05:53 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53428 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728451AbeI1XFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 19:05:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EFFF7A9;
        Fri, 28 Sep 2018 09:41:17 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 480BA3F5BD;
        Fri, 28 Sep 2018 09:41:14 -0700 (PDT)
Date:   Fri, 28 Sep 2018 17:41:11 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Tvrtko Ursulin <tursulin@ursulin.net>,
        LKML <linux-kernel@vger.kernel.org>,
        tvrtko.ursulin@linux.intel.com,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>
Subject: Re: [RFC 0/5] perf: Per PMU access controls (paranoid setting)
Message-ID: <20180928164111.i6nba2j6mnegwslw@lakrids.cambridge.arm.com>
References: <20180919122751.12439-1-tvrtko.ursulin@linux.intel.com>
 <alpine.DEB.2.21.1809281151190.2004@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1809281151190.2004@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 12:26:52PM +0200, Thomas Gleixner wrote:
> On Wed, 19 Sep 2018, Tvrtko Ursulin wrote:
> 
> It would be very helpful if you cc all involved people on the cover letter
> instead of just cc'ing your own pile of email addresses. CC'ed now.
> 
> > For situations where sysadmins might want to allow different level of
> > access control for different PMUs, we start creating per-PMU
> > perf_event_paranoid controls in sysfs.
> > 
> > These work in equivalent fashion as the existing perf_event_paranoid
> > sysctl, which now becomes the parent control for each PMU.
> > 
> > On PMU registration the global/parent value will be inherited by each PMU,
> > as it will be propagated to all registered PMUs when the sysctl is
> > updated.
> > 
> > At any later point individual PMU access controls, located in
> > <sysfs>/device/<pmu-name>/perf_event_paranoid, can be adjusted to achieve
> > fine grained access control.
> > 
> > Discussion from previous posting:
> > https://lkml.org/lkml/2018/5/21/156
> 
> This is really not helpful. The cover letter and the change logs should
> contain a summary of that discussion and a proper justification of the
> proposed change. Just saying 'sysadmins might want to allow' is not useful
> at all, it's yet another 'I want a pony' thing.
> 
> I read through the previous thread and there was a clear request to involve
> security people into this. Especially those who are deeply involved with
> hardware side channels. I don't see anyone Cc'ed on the whole series.
> 
> For the record, I'm not buying the handwavy 'more noise' argument at
> all. It wants a proper analysis and we need to come up with criteria which
> PMUs can be exposed at all.
> 
> All of this want's a proper documentation clearly explaining the risks and
> scope of these knobs per PMU. Just throwing magic knobs at sysadmins and
> then saying 'its their problem to figure it out' is not acceptable.

There's also been prior discussion on these feature in other contexts
(e.g. android expoits resulting from out-of-tree drivers). It would be
nice to see those considered.

IIRC The conclusion from prior discussions (e.g. [1]) was that we wanted
finer granularity of control such that we could limit PMU access to
specific users -- e.g. disallow arbitrary android apps from poking *any*
PMU, while allowing some more trusted apps/users to uses *some* specific
PMUs.

e.g. we could add /sys/bus/event_source/devices/${PMU}/device, protect
this via the usual fs ACLs, and pass the fd to perf_event_open()
somehow. A valid fd would act as a capability, taking precedence over
perf_event_paranoid.

Thanks,
Mark.

[1] https://patchwork.kernel.org/patch/9249919/
