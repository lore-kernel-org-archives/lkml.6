Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB711C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E121213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E121213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbeLER4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:56:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39998 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727297AbeLER4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:56:48 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 837DA1E32B;
        Wed,  5 Dec 2018 17:56:48 +0000 (UTC)
Received: from krava (unknown [10.43.17.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id 25BC82AAA2;
        Wed,  5 Dec 2018 17:56:38 +0000 (UTC)
Date:   Wed, 5 Dec 2018 18:56:38 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Luis Claudio R. Goncalves" <lclaudio@uudg.org>, ldv@altlinux.org,
        esyr@redhat.com, Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 1/8] perf: Allow to block process in syscall tracepoints
Message-ID: <20181205175638.GD3836@krava>
References: <20181205160509.1168-1-jolsa@kernel.org>
 <20181205160509.1168-2-jolsa@kernel.org>
 <20181205123503.4b8e0484@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205123503.4b8e0484@vmware.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 05 Dec 2018 17:56:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 12:35:03PM -0500, Steven Rostedt wrote:
> On Wed,  5 Dec 2018 17:05:02 +0100
> Jiri Olsa <jolsa@kernel.org> wrote:
> 
> > diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
> > index 3b2490b81918..e55cf9169a03 100644
> > --- a/arch/x86/entry/common.c
> > +++ b/arch/x86/entry/common.c
> > @@ -60,6 +60,32 @@ static void do_audit_syscall_entry(struct pt_regs *regs, u32 arch)
> >  	}
> >  }
> >  
> > +static void trace_block_syscall(struct pt_regs *regs, bool enter)
> > +{
> > +	current->perf_blocked = true;
> > +
> > +	do {
> > +		schedule_timeout(100 * HZ);
> > +		current->perf_blocked_cnt = 0;
> > +
> > +		if (enter) {
> > +			/* perf syscalls:* enter */
> > +			perf_trace_syscall_enter(regs);
> > +
> > +			/* perf raw_syscalls:* enter */
> > +			perf_trace_sys_enter(&event_sys_enter, regs, regs->orig_ax);
> > +		} else {
> > +			/* perf syscalls:* enter */
> > +			perf_trace_syscall_exit(regs);
> > +
> > +			/* perf raw_syscalls:* enter */
> > +			perf_trace_sys_exit(&event_sys_exit, regs, regs->ax);
> > +		}
> > +	} while (current->perf_blocked_cnt);
> 
> I was thinking, if the process reading the perf buffer dies, how do we
> tell this task to continue on?

when the tracer process dies, its event will get uninstalled from the
trace_event_call::perf_events list, so the next iteration of above loop
won't get any blocked event and it will leave (assuming there's just
single event)

jirka
