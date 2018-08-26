Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFD1C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 11:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A34FC204EC
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 11:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMorodtr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A34FC204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbeHZPCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 11:02:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:40676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbeHZPCj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 11:02:39 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38B06204EC;
        Sun, 26 Aug 2018 11:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535282422;
        bh=LbxUWGwtw2wD91VS+7MNe+HWGnFKKf1lhIiPGJ0ofLQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bMorodtrGUM1ZRkXPL6NljNvaM4SapTH3SXAzEIJ1OE1eyB1sV7DMQ36PFqAyRatg
         +eycn/pgUWKbCciHJs8Mfdk7y2Oy1LK+oE065mKN/dt81KloRsH482u0NdelR36kro
         sdW9fYRfCp/LQRlx8YiurOtBORhz7umsbHmVE2Lo=
Date:   Sun, 26 Aug 2018 20:20:04 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 23/32] selftests/ftrace: Add function profiling stat
 testcase
Message-Id: <20180826202004.dffa0d77a634feafc772854a@kernel.org>
In-Reply-To: <20180824192018.40b9b015@gandalf.local.home>
References: <153443695002.23257.13628220023468200991.stgit@devbox>
        <153443760252.23257.5752638886588410084.stgit@devbox>
        <20180824192018.40b9b015@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2018 19:20:18 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 17 Aug 2018 01:40:02 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Add a testcase for function profiling per-cpu statistics
> > interface. There is already func_profile.tc, but that is
> > mainly focusing on the combination of function-profiler
> > and function tracer. This testcase ensures trace_stat
> > per-cpu function statistics is correctly updated.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  .../ftrace/test.d/ftrace/func_profile_stat.tc      |   23 ++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >  create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/func_profile_stat.tc
> > 
> > diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_profile_stat.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_profile_stat.tc
> > new file mode 100644
> > index 000000000000..1d2440d80ec3
> > --- /dev/null
> > +++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_profile_stat.tc
> > @@ -0,0 +1,23 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0
> > +# description: ftrace - function profiling
> > +
> > +[ ! -f function_profile_enabled ] && exit_unsupported
> > +
> > +: "Enable function profile"
> > +echo 1 > function_profile_enabled
> > +
> > +: "Profile must be updated"
> > +cp trace_stat/function0 $TMPDIR/
> > +( echo "forked"; sleep 1 )
> > +: "diff returns 0 if there is no difference"
> > +! diff trace_stat/function0 $TMPDIR/function0
> > +
> > +echo 0 > function_profile_enabled
> > +
> > +: "Profile must NOT be updated"
> > +cp trace_stat/function0 $TMPDIR/
> > +( echo "forked"; sleep 1 )
> > +: "diff returns 0 if there is no difference"
> > +diff trace_stat/function0 $TMPDIR/function0
> 
> > +
> 
> Can remove the last empty line from the file.

Yes, thank you for pointing it out.

> 
> Other than that...
> 
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Thanks!

> 
> -- Steve
> 
> -- Steve


-- 
Masami Hiramatsu <mhiramat@kernel.org>
