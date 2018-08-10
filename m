Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AFDC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 09:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE9C2223F6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 09:21:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE9C2223F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbeHJLum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 07:50:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48192 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727166AbeHJLum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 07:50:42 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0FFB38197038;
        Fri, 10 Aug 2018 09:21:40 +0000 (UTC)
Received: from krava (unknown [10.43.17.133])
        by smtp.corp.redhat.com (Postfix) with SMTP id E9AF92026D65;
        Fri, 10 Aug 2018 09:21:37 +0000 (UTC)
Date:   Fri, 10 Aug 2018 11:21:37 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Yordan Karadzhov <y.karadz@gmail.com>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Subject: Re: [RFC][PATCH 00/24] tools lib traceevent: Rename pevent to tep
 for preparation for library
Message-ID: <20180810092137.GB14485@krava>
References: <20180808155548.510187543@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180808155548.510187543@goodmis.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 10 Aug 2018 09:21:40 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 10 Aug 2018 09:21:40 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 11:55:48AM -0400, Steven Rostedt wrote:
> Having libtraceevent turn into a proper library has long been asked for.
> I never had time to do it before. Luckily, Tzvetomir was able to spend
> the time to start the preparation. The first thing that needs to be done
> is to handle namespace collisions. "pevent" was the prefix I chose, but
> many people were displeased by it, as it didn't express what the functions
> were used for. After discussing with many people at many conferences
> I've come up with "tep", which means "Trace Event Parser". Please don't
> question this. The bikeshed has been painted and I'm not changing the
> color.
> 
> This series changes all the function names and data structures from the
> "pevent_" prefix to the "tep_" prefix. Note, it does not change the
> names of local variables or even parameters. "pevent" variables and
> parameters still exist. We can change those later, but for now, I want
> all global references to "pevent" to be "tep_" instead.
> 
> This is not complete. It is only one of many preparations to make
> libtraceevent into a legitimate library. There's other naming conventions
> that will be made. But for now, I would like to hear thoughts about
> this change before we proceed further.

right, I can see more things that needs rename, like in print_arg*,
trace_* stuff and others

I'm also getting weird make error when compiling in libtraceevent dir:

  [jolsa@krava traceevent]$ make
    GEN      libtraceevent-dynamic-list
  Either missing one of [ plugin_jbd2.so plugin_hrtimer.so plugin_kmem.so plugin_kvm.so plugin_mac80211.so plugin_sched_switch.so plugin_function.so plugin_xen.so plugin_scsi.so plugin_cfg80211.so] or bad version of nm

but that seems to be there even without your patchset,
so probably something we should look into

other than that it looks ok to me

once this is done, we can move forward to put this
to kernel-tools-libs-devel rpm

thanks,
jirka
