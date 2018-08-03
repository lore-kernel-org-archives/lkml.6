Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB27C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E54D02172B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AuO6g59F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E54D02172B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732230AbeHCJ37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:29:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:58116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727101AbeHCJ37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:29:59 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C0DE2170A;
        Fri,  3 Aug 2018 07:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533281699;
        bh=BYxlrVfCro8D/VK0IdCPrJFDEYv/HJGa8yRGUnaV37c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AuO6g59Ff0jqK6jdnYZPjs8lKMBB1TXtCn/lvMirCa+4olTy+mSmSlZGTnBR/6SEa
         Bk/AQte40XmFVLvS1RTyMy9rQhOLKUw2/BRznNqPppturqpLtYb3k7P9jijRECuYtp
         cX/TyJPjz6Vc6La2tqvdFvFZloPt814B+mIFLQZ0=
Date:   Fri, 3 Aug 2018 16:34:55 +0900
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
Message-Id: <20180803163455.9c846c2a674819564517de59@kernel.org>
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

I found that this does not always happen, but 4 out of 5 it happens.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
