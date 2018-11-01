Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73351C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 248492082E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="168F7c7D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 248492082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbeKBAYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 20:24:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:46130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728197AbeKBAYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 20:24:08 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3802E205F4;
        Thu,  1 Nov 2018 15:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541085644;
        bh=lNYBockCrAM/hLc1wichrNOE5bSTSWLbqDsp+qU2fkQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=168F7c7D2E4BEUKaecNYiSmrBXBbQ8j9PZ9IsGTwvJ8zWyYUHvaz0jBHhr7vmp0zM
         zhGmjdO2L2B4TtCx8sZUKtkJkL4MgJpo+GGHQv7UFnjTt4ZC5AXCCUclI+8iONfwWh
         F9am2EXOd+6BgWuaGB3y/1UainYQ3UgsjRiK1ESs=
Date:   Fri, 2 Nov 2018 00:20:39 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Brendan Gregg <bgregg@netflix.com>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <asarai@suse.de>, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 1/2] kretprobe: produce sane stack traces
Message-Id: <20181102002039.8f22c10fa47cae75fa709165@kernel.org>
In-Reply-To: <20181101083551.3805-2-cyphar@cyphar.com>
References: <20181101083551.3805-1-cyphar@cyphar.com>
        <20181101083551.3805-2-cyphar@cyphar.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aleksa,

On Thu,  1 Nov 2018 19:35:50 +1100
Aleksa Sarai <cyphar@cyphar.com> wrote:
[...]
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_stacktrace.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_stacktrace.tc

Please split the test case as an independent patch.

> new file mode 100644
> index 000000000000..03146c6a1a3c
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_stacktrace.tc
> @@ -0,0 +1,25 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0+
> +# description: Kretprobe dynamic event with a stacktrace
> +
> +[ -f kprobe_events ] || exit_unsupported # this is configurable
> +
> +echo 0 > events/enable
> +echo 1 > options/stacktrace
> +
> +echo 'r:teststackprobe sched_fork $retval' > kprobe_events
> +grep teststackprobe kprobe_events
> +test -d events/kprobes/teststackprobe

Hmm, what happen if we have 2 or more kretprobes on same stack?
It seems you just save stack in pre_handler, but that stack can already
includes another kretprobe's trampline address...

Thank you,

> +
> +clear_trace
> +echo 1 > events/kprobes/teststackprobe/enable
> +( echo "forked")
> +echo 0 > events/kprobes/teststackprobe/enable
> +
> +# Make sure we don't see kretprobe_trampoline and we see _do_fork.
> +! grep 'kretprobe' trace
> +grep '_do_fork' trace
> +
> +echo '-:teststackprobe' >> kprobe_events
> +clear_trace
> +test -d events/kprobes/teststackprobe && exit_fail || exit_pass
> -- 
> 2.19.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
