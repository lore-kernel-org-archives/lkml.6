Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C98C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB58D20657
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:40:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB58D20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbeI2AFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 20:05:12 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54188 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbeI2AFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 20:05:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71AAD18A;
        Fri, 28 Sep 2018 10:40:22 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AADB63F5BD;
        Fri, 28 Sep 2018 10:40:19 -0700 (PDT)
Date:   Fri, 28 Sep 2018 18:40:17 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Andi Kleen <ak@linux.intel.com>
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
Message-ID: <20180928174016.i7d24puv7y3jwzf6@lakrids.cambridge.arm.com>
References: <20180919122751.12439-1-tvrtko.ursulin@linux.intel.com>
 <alpine.DEB.2.21.1809281151190.2004@nanos.tec.linutronix.de>
 <20180928164111.i6nba2j6mnegwslw@lakrids.cambridge.arm.com>
 <20180928172340.GA32651@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180928172340.GA32651@tassilo.jf.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 10:23:40AM -0700, Andi Kleen wrote:
> > There's also been prior discussion on these feature in other contexts
> > (e.g. android expoits resulting from out-of-tree drivers). It would be
> > nice to see those considered.
> > 
> > IIRC The conclusion from prior discussions (e.g. [1]) was that we wanted
> > finer granularity of control such that we could limit PMU access to
> > specific users -- e.g. disallow arbitrary android apps from poking *any*
> > PMU, while allowing some more trusted apps/users to uses *some* specific
> > PMUs.
> > 
> > e.g. we could add /sys/bus/event_source/devices/${PMU}/device, protect
> > this via the usual fs ACLs, and pass the fd to perf_event_open()
> > somehow. A valid fd would act as a capability, taking precedence over
> > perf_event_paranoid.
> 
> That sounds like an orthogonal feature. I don't think the original
> patchkit would need to be hold up for this. It would be something
> in addition.

I have to say that I disagree -- these controls will have to interact
somehow, and the fewer of them we have, the less complexity we'll have
to deal with longer-term.

> BTW can't you already do that with the syscall filter? I assume
> the Android sandboxes already use that. Just forbid perf_event_open
> for the apps.

Note that this was about providing access to *some* PMUs in some cases.

IIUC, if that can be done today via a syscall filter, the same is true
of per-pmu paranoid settings.

Thanks,
Mark.
