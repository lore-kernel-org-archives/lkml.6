Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440D8C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 23:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F181D20A8B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 23:06:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F181D20A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbeHYCnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 22:43:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:58386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbeHYCnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 22:43:04 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D30FC2098B;
        Fri, 24 Aug 2018 23:06:22 +0000 (UTC)
Date:   Fri, 24 Aug 2018 19:06:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 21/32] selftests/ftrace: Add trace_printk sample
 module test
Message-ID: <20180824190621.1683e34c@gandalf.local.home>
In-Reply-To: <153443754593.23257.6968622935654299173.stgit@devbox>
References: <153443695002.23257.13628220023468200991.stgit@devbox>
        <153443754593.23257.6968622935654299173.stgit@devbox>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Aug 2018 01:39:06 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Add trace_printk sample module test. This requires to
> enable trace_printk.ko module for test.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  .../selftests/ftrace/test.d/event/trace_printk.tc  |   27 ++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/event/trace_printk.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/event/trace_printk.tc b/tools/testing/selftests/ftrace/test.d/event/trace_printk.tc
> new file mode 100644
> index 000000000000..4da4d739f03d
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/event/trace_printk.tc
> @@ -0,0 +1,27 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: Test trace_printk from module
> +
> +rmmod trace-printk ||:
> +if ! modprobe trace-printk.ko ; then

"modprobe trace-printk.ko" doesn't work. You need to drop the ".ko"

-- Steve

> +  echo "No trace-printk sample module - please make CONFIG_SAMPLE_TRACE_PRINTK=m"
> +  exit_unresolved;
> +fi
> +
> +echo "Waiting for irq work"
> +sleep 1
> +
> +grep -q ": This .* trace_bputs" trace
> +grep -q ": This .* trace_puts" trace
> +grep -q ": This .* trace_bprintk" trace
> +grep -q ": This .* trace_printk" trace
> +
> +grep -q ": (irq) .* trace_bputs" trace
> +grep -q ": (irq) .* trace_puts" trace
> +grep -q ": (irq) .* trace_bprintk" trace
> +grep -q ": (irq) .* trace_printk" trace
> +
> +grep -q "This is a %s that will use trace_bprintk" printk_formats
> +grep -q "(irq) This is a static string that will use trace_bputs" printk_formats
> +
> +rmmod trace-printk ||:

