Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE88C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 11:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 364BE208E8
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 11:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2QIraWd0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 364BE208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbeHZPEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 11:04:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:41110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbeHZPET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 11:04:19 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB044208E8;
        Sun, 26 Aug 2018 11:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535282522;
        bh=822q5FL0+uG408H7LBHRhoOw7yzHT0AhBWAcKS7Iwok=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2QIraWd0IaqFIvVvqIZXnHykv9wTwzk5oRE47VcmRqe1YPvJc/C/KDesjEWPQkK3Z
         G+Quo+Qnr2rFnyARCmdrcMUzyo2e96FsRRhOeISUmtuJMIi/5YBIvFt3YsBg087LYV
         52X/vDr1qqJrlmVW1gJODFHkrh+QEMDprf0rBBAY=
Date:   Sun, 26 Aug 2018 20:22:00 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 29/32] selftests/ftrace: Add wakeup_rt tracer
 testcase
Message-Id: <20180826202200.c261c79f6667b267fd80fca5@kernel.org>
In-Reply-To: <20180824220949.2c8ee9a6@vmware.local.home>
References: <153443695002.23257.13628220023468200991.stgit@devbox>
        <153443777214.23257.14428652484801816908.stgit@devbox>
        <20180824220949.2c8ee9a6@vmware.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2018 22:09:49 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 17 Aug 2018 01:42:52 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Add a testcase for wakeup_rt tracer. This requires chrt
> > command to test.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  .../selftests/ftrace/test.d/tracer/wakeup_rt.tc    |   25 ++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >  create mode 100644 tools/testing/selftests/ftrace/test.d/tracer/wakeup_rt.tc
> > 
> > diff --git a/tools/testing/selftests/ftrace/test.d/tracer/wakeup_rt.tc b/tools/testing/selftests/ftrace/test.d/tracer/wakeup_rt.tc
> > new file mode 100644
> > index 000000000000..3f279072ec2d
> > --- /dev/null
> > +++ b/tools/testing/selftests/ftrace/test.d/tracer/wakeup_rt.tc
> > @@ -0,0 +1,25 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL2.0
> > +# description: Test wakeup RT tracer
> > +
> > +if ! which nice ; then
> > +  echo "chrt is not found. This test requires chrt command."
> > +  exit_unresolved
> > +fi
> > +
> > +if ! grep -wq "wakeup_rt" available_tracers ; then
> > +  echo "wakeup_rt tracer is not supported"
> > +  exit_unsupported
> > +fi
> > +
> > +echo wakeup > current_tracer
> 
> I think you meant "echo wakeup_rt" ;-)

Oops, that's my fault....

Thanks!

> 
> -- Steve
> 
> > +echo 1 > tracing_on
> > +echo 0 > tracing_max_latency
> > +
> > +: "Wakeup a realtime task"
> > +chrt -f 5 sleep 1
> > +
> > +echo 0 > tracing_on
> > +grep "+ \[[[:digit:]]*\]" trace
> > +grep "==> \[[[:digit:]]*\]" trace
> > +
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
