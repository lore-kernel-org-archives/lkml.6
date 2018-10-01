Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41DCC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 13:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A3A213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 13:49:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68A3A213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbeJAU12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 16:27:28 -0400
Received: from mga02.intel.com ([134.134.136.20]:24322 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729291AbeJAU12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 16:27:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2018 06:49:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,327,1534834800"; 
   d="scan'208";a="77544806"
Received: from rchan-mobl1.amr.corp.intel.com ([10.252.138.92])
  by orsmga007.jf.intel.com with ESMTP; 01 Oct 2018 06:49:24 -0700
Message-ID: <f360d9c67bb9bc3418fad290399b8f27cb61c80f.camel@linux.intel.com>
Subject: Re: [RFC PATCH 0/5] tracing: Unifying dynamic event interface
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date:   Mon, 01 Oct 2018 08:49:24 -0500
In-Reply-To: <153806391326.18458.3927382953014694981.stgit@devbox>
References: <153806391326.18458.3927382953014694981.stgit@devbox>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On Fri, 2018-09-28 at 00:58 +0900, Masami Hiramatsu wrote:
> Hi,
> 
> This is an RFC series of unifying dynamic event interface on ftrace.
> Currently ftrace has 3 dynamic event interfaces, kprobes, uprobes
> and synthetic. This series unifies kprobes and uprobes event
> interface on "dynamic_events". This enables us to add new dynamic
> events easily on same interface, e.g. function events.

This seems like a nice idea to me and I don't see any problems with the
patches themselves, so consider it

Acked-by: Tom Zanussi <tom.zanussi@linux.intel.com>

> The older interfaces are left on the tracefs for backward
> compatibility at this moment.
> 
> dynamic_events syntax has no different from kprobe_events and
> uprobe_events. You can use same syntax for dynamic_events interface.
> 
> I think we can integrate synthetic events to this dynamic_events
> interface but it will requires new syntax. e.g.
> 
> echo "s:<event-name> <args>" >> dynamic_events
> 

So that's just the existing syntax, prefaced by s: , right?

> If it is OK, I'll add it in next version.
> 

Makes sense to me.

> BTW, since this dynamic_events interface derived from *probe_events,
> it inherits "all clear when truncate file open" behavior. But if you
> think this is too aggressive, I can drop it. (even in that case,
> kprobe_events/uprobe_events behavior is not changed)
> 
> I also introduced a widely used way to erase entries in other
> interfaces of ftrace, that is '!'. So you can now use '!event-name'
> or '!group/event' to erase an entry in dynamic_events.
> (Wait... it has to be '!p:event' as others do??)
> 

I'd think the full form should always be accepted, but would only be
necessary in cases requiring disambiguation.

Thanks,

Tom

> Any thought?
> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (5):
>       tracing/uprobes: Add busy check when cleanup all uprobes
>       tracing: Add a unified dynamic event framework
>       tracing/kprobes: Use dyn_event framework for kprobe events
>       tracing/uprobes: Use dyn_event framework for uprobe events
>       tracing: Add generic event-name based remove event method
> 
> 
>  Documentation/trace/kprobetrace.rst  |    3 +
>  Documentation/trace/uprobetracer.rst |    4 +
>  kernel/trace/Kconfig                 |    4 +
>  kernel/trace/Makefile                |    1 
>  kernel/trace/trace.c                 |    4 +
>  kernel/trace/trace_dynevent.c        |  183
> +++++++++++++++++++++++++++++++++
>  kernel/trace/trace_dynevent.h        |   89 ++++++++++++++++
>  kernel/trace/trace_kprobe.c          |  191 +++++++++++++++++++++++-
> ----------
>  kernel/trace/trace_uprobe.c          |  175 +++++++++++++++++++++++-
> -------
>  9 files changed, 547 insertions(+), 107 deletions(-)
>  create mode 100644 kernel/trace/trace_dynevent.c
>  create mode 100644 kernel/trace/trace_dynevent.h
> 
> --
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>

