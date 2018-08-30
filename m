Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C743DC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 07:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B24520645
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 07:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XfVf7zQ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B24520645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbeH3LNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 07:13:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:44714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727523AbeH3LNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 07:13:04 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A756C20645;
        Thu, 30 Aug 2018 07:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535613141;
        bh=PvACVW5tsoI/lM3pVw3q1vrdP8OBh0CrRantJ45jbcg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XfVf7zQ/E2xLAPZEO90nDF398EPfWiV9oRfWluWPeFEkkKESpdHk8LK9INaPNP4Qa
         hVYJAirm2M2RD+kjiC4KWX36MsbVOLKUzViSsauaDVXiZzolH3qw1fK4qXSJYpJjOz
         iATIl1SLHAU8uZVbgyejsg6R/cmpSznGLk/RQ5NQ=
Date:   Thu, 30 Aug 2018 16:12:18 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 22/32] selftests/ftrace: Add ringbuffer size changing
 testcase
Message-Id: <20180830161218.e46affa5a84abd47c9cf2a39@kernel.org>
In-Reply-To: <20180824191836.305ad740@gandalf.local.home>
References: <153443695002.23257.13628220023468200991.stgit@devbox>
        <153443757416.23257.9284862385646039929.stgit@devbox>
        <20180824191836.305ad740@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2018 19:18:36 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 17 Aug 2018 01:39:34 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Add a testcase for changing ringbuffer size. This tests
> > not only ringbuffer size but also tests the imbalance
> > per-cpu buffer size change too.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> I'm fine with this, but one day I need to port over some of my other
> tests. I have a test that stresses the ring buffer size (basically
> checks to see if it can cause an oom). I need to port that to
> selftests. But for now...

Hmm, such stress test is not good for kselftest, since it can cause
oom and kill some test process. Maybe we should have such stresstest
framework (which allows test to crash kernel)

> 
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> But, one more thing..
> 
> > ---
> >  .../ftrace/test.d/00basic/ringbuffer_size.tc       |   21 ++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >  create mode 100644 tools/testing/selftests/ftrace/test.d/00basic/ringbuffer_size.tc
> > 
> > diff --git a/tools/testing/selftests/ftrace/test.d/00basic/ringbuffer_size.tc b/tools/testing/selftests/ftrace/test.d/00basic/ringbuffer_size.tc
> > new file mode 100644
> > index 000000000000..9224f33b3194
> > --- /dev/null
> > +++ b/tools/testing/selftests/ftrace/test.d/00basic/ringbuffer_size.tc
> > @@ -0,0 +1,21 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0
> > +# description: Change the ringbuffer size
> 
> Should add:
> 
>  # flags: instance

OK, I'll add it.

Thank you!

> 
> As this works for instances as well.
> 
> -- Steve
> 
> > +
> > +rb_size_test() {
> > +ORIG=`cat buffer_size_kb`
> > +
> > +expr $ORIG / 2 > buffer_size_kb
> > +
> > +expr $ORIG \* 2 > buffer_size_kb
> > +
> > +echo $ORIG > buffer_size_kb
> > +}
> > +
> > +rb_size_test
> > +
> > +: "If per-cpu buffer is supported, imbalance it"
> > +if [ -d per_cpu/cpu0 ]; then
> > +  cd per_cpu/cpu0
> > +  rb_size_test
> > +fi
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
