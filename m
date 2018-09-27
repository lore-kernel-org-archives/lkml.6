Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8853C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94E6D21722
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWEcV3o9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94E6D21722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbeI1FKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 01:10:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:49390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbeI1FKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 01:10:18 -0400
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCB7221722;
        Thu, 27 Sep 2018 22:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538088581;
        bh=JhUOJVQ+5hnN0S0QR/h86NwqFZDFJqzcPwxvHfsE2uI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TWEcV3o960mxLyuFUeKa5G21gSpEnAg9b+kowa8nJv8ZJSrfJ1FiIdeT75aN7vQ6C
         +ydNWJ/Gxza1qhadJRjFh5jDbPddwUS+cZxZiZts4PQDQt0MBotDC1DKUTliid30Tv
         vanJSO75ZVxWD5ioEvDvE3aDn095W9gfazCYCSAg=
Date:   Fri, 28 Sep 2018 07:49:38 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/28] selftests/ftrace: Improve ftracetest with
 coverage check
Message-Id: <20180928074938.bb89440c8e2b91fcb918d93a@kernel.org>
In-Reply-To: <9cf69344-5dfc-4961-163e-1e14bbe80647@kernel.org>
References: <153563834333.29700.11242968505215651399.stgit@devbox>
        <9cf69344-5dfc-4961-163e-1e14bbe80647@kernel.org>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Sep 2018 15:24:25 -0600
Shuah Khan <shuah@kernel.org> wrote:

> Hi Masami,
> 
> On 08/30/2018 08:12 AM, Masami Hiramatsu wrote:
> > Hi,
> > 
> > Here is the 3rd version of the series for improving ftracetest
> > testcase using gcov/lcov. In this version I just fixed some
> > reported issues and dropped some tests which is not needed.
> > I also dropped a testcase for blktrace from this version.
> > It will be discussed separated thread.
> > 
> > Previous version is here;
> > 
> > https://lkml.org/lkml/2018/8/16/393
> > 
> > GCOV_PROFILE_FTRACE has already been merged through tracing
> > tree.
> > 
> > Ftracetest framework improvements:
> >  - Add --stop-fail for detecting failure soon.
> >  - Add --console for interactively debugging a testcase by shell.
> >  - Add testcase-number prefix to logfile for finding log easier.
> >  - Improve general init function
> >  - Add SPDX license identifiers
> >  - Call general init function after all testcases.
> >  - Remove init/cleanup code from all testcase (since general init
> >    function will fixed it up)
> > 
> > Testcase fixes:
> >  - Fix to check $comm availability.
> >  - Make checkbashisms clean
> > 
> > Testcase improvements:
> >  - Use loopback address instead of localhost
> >  - Improve kprobe on module testcase to load/unload module
> >  - Improve kprobe testcase to check log data
> >  - Improve kretprobe testcase to check log data
> >  - Test kprobe-event argument with various bitsize
> >  - Check set_event_pid result
> > 
> > Adding testcases:
> >  - Add kprobe event with $comm argument testcase
> >  - Add kprobe profile testcase
> >  - Add kprobe-event with symbol argument testcase
> >  - Add trace_printk sample module testcase
> >  - Add ringbuffer size changing testcase
> >  - Add function profiling statistics testcase
> >  - Add max stack tracer testcase
> >  - Add function filter on module testcase
> >  - Add trace_pipe testcase
> >  - Add stacktrace ftrace filter command testcase
> >  - Add wakeup tracer testcase
> >  - Add wakeup_rt tracer testcase
> >  - Add ftrace cpumask testcase
> > 
> > TBD:
> > Following testcase improvements are remaining.
> >  - Checking of various supported types (like u8, u64 etc.)
> >    testcases
> > 
> > Tested on x86-64 qemu.
> > 
> > # of passed:  84
> > # of failed:  0
> > # of unresolved:  0
> > # of untested:  0
> > # of unsupported:  0
> > # of xfailed:  0
> > # of undefined(test bug):  0
> > 
> > Thank you,
> > 
> 
> Thanks for the patches. Sorry for the delay. I am applying the series to linux-kselftest
> next for 4.20 release

Thank you Shuah, I found it in your next branch :)


-- 
Masami Hiramatsu <mhiramat@kernel.org>
