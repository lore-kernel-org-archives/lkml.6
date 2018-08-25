Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F66C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 02:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB6B21567
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 02:18:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAB6B21567
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbeHYFzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 01:55:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:59094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbeHYFzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 01:55:37 -0400
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B56A21567;
        Sat, 25 Aug 2018 02:18:24 +0000 (UTC)
Date:   Fri, 24 Aug 2018 22:18:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 30/32] selftests/ftrace: Add ftrace cpumask testcase
Message-ID: <20180824221822.3e0092c9@vmware.local.home>
In-Reply-To: <153443780039.23257.5243924038958174104.stgit@devbox>
References: <153443695002.23257.13628220023468200991.stgit@devbox>
        <153443780039.23257.5243924038958174104.stgit@devbox>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Aug 2018 01:43:20 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Add a testcase for tracing_cpumask with function tracer.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  .../selftests/ftrace/test.d/ftrace/func_cpumask.tc |   34 ++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/func_cpumask.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_cpumask.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_cpumask.tc
> new file mode 100644
> index 000000000000..37420e355445
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_cpumask.tc
> @@ -0,0 +1,34 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL2.0
> +# description: ftrace - function trace with cpumask
> +
> +NP=`grep "^processor" /proc/cpuinfo | wc -l`

A better way to find the number of CPUs is to either use "nproc" or
just look at /sys/devices/system/cpu/cpu[0-9]*. Because what I learned
from experience is that searching for strings in /proc/cpuinfo is not
cross arch compatible. For example, other archs don't use "processor"
in the stings and would come up with a box with 0 CPUs. Something we've
been working on for some time ;-)

-- Steve

> +
> +if [ $NP -eq 1 ] ;then
> +  echo "We can not test cpumask on UP environment"
> +  exit_unresolved
> +fi
> +
> +do_reset() {
> +  echo ffff > tracing_cpumask

Why ffff? Should we save what was in tracing_cpumask first and just
reuse it?

-- Steve


> +}
> +
> +echo 0 > tracing_on
> +echo > trace
> +: "Bitmask only record on CPU1"
> +echo 2 > tracing_cpumask
> +MASK=0x`cat tracing_cpumask`
> +test `printf "%d" $MASK` -eq 2 || do_reset
> +
> +echo function > current_tracer
> +echo 1 > tracing_on
> +(echo "forked")
> +echo 0 > tracing_on
> +
> +: "Check CPU1 events are recorded"
> +grep -q -e "\[001\]" trace || do_reset
> +
> +: "There should be No other cpu events"
> +! grep -qv -e "\[001\]" -e "^#" trace || do_reset
> +
> +do_reset

