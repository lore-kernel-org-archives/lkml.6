Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2DDC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBBAB214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:28:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBBAB214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729476AbeLFK2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 05:28:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55896 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729025AbeLFK2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 05:28:03 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8CB4883F3E;
        Thu,  6 Dec 2018 10:28:03 +0000 (UTC)
Received: from krava (unknown [10.43.17.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4E72F17F37;
        Thu,  6 Dec 2018 10:27:57 +0000 (UTC)
Date:   Thu, 6 Dec 2018 11:27:56 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Luis Claudio R. Goncalves" <lclaudio@uudg.org>, ldv@altlinux.org,
        esyr@redhat.com, Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 1/8] perf: Allow to block process in syscall tracepoints
Message-ID: <20181206102756.GB27838@krava>
References: <20181205160509.1168-1-jolsa@kernel.org>
 <20181205160509.1168-2-jolsa@kernel.org>
 <20181206081707.GF4234@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206081707.GF4234@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 06 Dec 2018 10:28:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 09:17:07AM +0100, Peter Zijlstra wrote:
> On Wed, Dec 05, 2018 at 05:05:02PM +0100, Jiri Olsa wrote:
> > @@ -10461,6 +10484,19 @@ SYSCALL_DEFINE5(perf_event_open,
> >  			return -EINVAL;
> >  	}
> >  
> > +	if (attr.block) {
> > +		/*
> > +		 * Allow only syscall tracepoints, check for syscall class
> > +		 * is made in the tracepoint event_init callback.
> > +		 */
> > +		if (attr.type != PERF_TYPE_TRACEPOINT)
> > +			return -EINVAL;
> > +
> > +		/* Allow to block only if we attach to a process. */
> > +		if (pid == -1)
> > +			return -EINVAL;
> > +	}
> > +
> >  	/* Only privileged users can get physical addresses */
> >  	if ((attr.sample_type & PERF_SAMPLE_PHYS_ADDR) &&
> >  	    perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN))
> 
> That's fairly horrible and will, when copied, lead to a giant mess.
> 
> Please see the whole exclusion patch set here:
> 
>   https://lkml.kernel.org/r/1543230756-15319-1-git-send-email-andrew.murray@arm.com
> 
> PERF_PMU_CAP_BLOCK sounds like something you'd want here.

ok, that's better

jirka
