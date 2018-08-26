Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692E4C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 08:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E0532147D
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 08:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xKeWfvnv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E0532147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbeHZMZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 08:25:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:34622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbeHZMZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 08:25:26 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DD202147D;
        Sun, 26 Aug 2018 08:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535273013;
        bh=y7San/TK5HZZngwdKShf3Q39yP9twXxgHFztqsxwTBo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xKeWfvnvTxfZFnQH7kQ2a08K9zlPbYSCzKpowL2kpsZ7OYi99zeJrYo8Q0Ys56R7u
         NQNtFXsM+yqkIjFVV8fhAOma6UB1inxYk3e1dWlhkOnhIVaFHWKo1gWVQuHJVzVJGr
         fMRL6iyDsEB9gI5Ao+myPDD7MwuJk7Hwck+71i/s=
Date:   Sun, 26 Aug 2018 17:43:31 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 21/32] selftests/ftrace: Add trace_printk sample
 module test
Message-Id: <20180826174331.58be4a6211236e81c9099821@kernel.org>
In-Reply-To: <20180824190621.1683e34c@gandalf.local.home>
References: <153443695002.23257.13628220023468200991.stgit@devbox>
        <153443754593.23257.6968622935654299173.stgit@devbox>
        <20180824190621.1683e34c@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2018 19:06:21 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 17 Aug 2018 01:39:06 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Add trace_printk sample module test. This requires to
> > enable trace_printk.ko module for test.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  .../selftests/ftrace/test.d/event/trace_printk.tc  |   27 ++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> >  create mode 100644 tools/testing/selftests/ftrace/test.d/event/trace_printk.tc
> > 
> > diff --git a/tools/testing/selftests/ftrace/test.d/event/trace_printk.tc b/tools/testing/selftests/ftrace/test.d/event/trace_printk.tc
> > new file mode 100644
> > index 000000000000..4da4d739f03d
> > --- /dev/null
> > +++ b/tools/testing/selftests/ftrace/test.d/event/trace_printk.tc
> > @@ -0,0 +1,27 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0
> > +# description: Test trace_printk from module
> > +
> > +rmmod trace-printk ||:
> > +if ! modprobe trace-printk.ko ; then
> 
> "modprobe trace-printk.ko" doesn't work. You need to drop the ".ko"

Ah, I'm using busybox's modprobe, which acccepts .ko :(

I'll fix that.

Thanks!

> 
> -- Steve
> 
> > +  echo "No trace-printk sample module - please make CONFIG_SAMPLE_TRACE_PRINTK=m"
> > +  exit_unresolved;
> > +fi
> > +
> > +echo "Waiting for irq work"
> > +sleep 1
> > +
> > +grep -q ": This .* trace_bputs" trace
> > +grep -q ": This .* trace_puts" trace
> > +grep -q ": This .* trace_bprintk" trace
> > +grep -q ": This .* trace_printk" trace
> > +
> > +grep -q ": (irq) .* trace_bputs" trace
> > +grep -q ": (irq) .* trace_puts" trace
> > +grep -q ": (irq) .* trace_bprintk" trace
> > +grep -q ": (irq) .* trace_printk" trace
> > +
> > +grep -q "This is a %s that will use trace_bprintk" printk_formats
> > +grep -q "(irq) This is a static string that will use trace_bputs" printk_formats
> > +
> > +rmmod trace-printk ||:
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
