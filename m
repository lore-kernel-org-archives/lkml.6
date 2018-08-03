Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8E9C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 549EF2172D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uHfumjzg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 549EF2172D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732994AbeHCJSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:18:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:54496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732559AbeHCJSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:18:41 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3623C215F9;
        Fri,  3 Aug 2018 07:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533281024;
        bh=f6D/nS9X2/GFZcrBCIfxyEWNutgF29W9/Ja/UA8Gfmo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uHfumjzgU0TTpoZxZi6N5hSDNVhmltHAB7eG14ys8jLGoXxTg6YTf4qJ22DyuWZsJ
         NX0vz9ajQqG9VM8xxhLLvdASvZvwNNosWIF/GsA6gUO9zqT+GKMN2yBHV1oQ5IHzks
         0Wot+Fj0rhbO5Bph4x04ZlBjktv0u7MlPxE/kyuw=
Date:   Fri, 3 Aug 2018 16:23:40 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Joel Fernandes <joelaf@google.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v12 0/3] tracing: Centralize preemptirq tracepoints and
 unify their usage
Message-Id: <20180803162340.32b4b3fde55a4f5a5c28b425@kernel.org>
In-Reply-To: <CAJWu+opoT6Ky-pwAwBbjDkyt0Y_UF1QUnDshu-_vLTU5K87_HQ@mail.gmail.com>
References: <20180730222423.196630-1-joel@joelfernandes.org>
        <20180802235527.ddb0d1837154e3f98571b3b0@kernel.org>
        <CAJWu+opoT6Ky-pwAwBbjDkyt0Y_UF1QUnDshu-_vLTU5K87_HQ@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel,

Thank you for trying to fix that.

On Thu, 2 Aug 2018 19:57:09 -0700
Joel Fernandes <joelaf@google.com> wrote:

> Hi Masami,
> 
> On Thu, Aug 2, 2018 at 7:55 AM, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > Hi Joel,
> >
> > I found this caused several issues when testing ftrace.
> >
> > #1) ftrace boottest (FTRACE_STARTUP_TEST) fails
> 
> This sadly appears to be a real issue. The startup test for
> "preemptirqsoff" tracer fails, however it passes for only preemptoff
> or only irqsoff. I tested only the last 2 tracers, not the first one,
> that's why I didn't catch it. I need to debug this more.
> 
> > #2) mmiotrace reports "IRQs not enabled as expected" error
> > #3) lock subsystem event boottest causes "IRQs not disabled as expected" error (sometimes)
> 
> Could you try the below patch and let me know if you still see the
> issue? In the v11 I removed the lockdep_recursing() check since it
> seemed unnecessary. But I'd like to rule out that there's still some
> issue lurking there. Thanks and I appreciate your help, diff is
> attached to this email.

I tried the attached patch. But unfortunately I still see #1 and #2.
(#3 does not always occurred, I'll continue to test)

> > #4) ftracetest test.d/event/toplevel-enable.tc causes "suspicious RCU usage" warning
> 
> I sent a patch fixing this with you on CC. I tested that it fixes the
> issue you're reporting.

OK, I'll check it.

Thanks!

-- 
Masami Hiramatsu <mhiramat@kernel.org>
