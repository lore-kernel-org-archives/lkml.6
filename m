Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2A0C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 13:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E6320865
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 13:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5cLNSAU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59E6320865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbeKZX5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 18:57:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:58916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbeKZX5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 18:57:40 -0500
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BB7620862;
        Mon, 26 Nov 2018 13:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543237415;
        bh=Bt0bRKTFQlqjH66B9Sk/V/nGQ9oZpD2854KWFOjXHD0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=I5cLNSAUzPwOp7QvGQf5tkhfbMtWD2vBWicAEB0vfUmRy3T5sD/auUNWQuaJsVDnt
         o4sGuaVWVFQ+R1XCDyBg2Wv6i2MjKrgabo1HaOwpg7wD1tyTkG4LVq7CauzvjvxVq7
         M7P8JqX+QJNZ+V1INrxCWv0h3kg13+D3vZ1hJIk8=
Date:   Mon, 26 Nov 2018 22:03:32 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        namhyung@kernel.org, vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v7 09/16] tracing: Add hist trigger snapshot() action
 test case
Message-Id: <20181126220332.215b461779d1d57f37b46e20@kernel.org>
In-Reply-To: <a40dadf6ffa267a1a573b62bb1c9b4db9d91f744.1542221863.git.tom.zanussi@linux.intel.com>
References: <cover.1542221862.git.tom.zanussi@linux.intel.com>
        <a40dadf6ffa267a1a573b62bb1c9b4db9d91f744.1542221863.git.tom.zanussi@linux.intel.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Nov 2018 14:18:06 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> From: Tom Zanussi <tom.zanussi@linux.intel.com>
> 
> Add a test case verifying the basic functionality of the
> hist:snapshot() action.
> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> ---
>  .../inter-event/trigger-snapshot-action-hist.tc    | 43 ++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
> new file mode 100644
> index 000000000000..a0a51e6a6a0c
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
> @@ -0,0 +1,43 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: event trigger - test inter-event histogram trigger snapshot action
> +
> +fail() { #msg
> +    echo $1
> +    exit_fail
> +}
> +
> +if [ ! -f set_event ]; then
> +    echo "event tracing is not supported"
> +    exit_unsupported
> +fi
> +
> +if [ ! -f snapshot ]; then
> +    echo "snapshot is not supported"
> +    exit_unsupported
> +fi
> +
> +grep -q "onchange(var)" README > /dev/null || exit_unsupported # version issue
> +
> +grep -q "snapshot()" README > /dev/null || exit_unsupported # version issue

"grep -q ... > /dev/null" is redundant, since -q doesn't show anything.
please drop "> /dev/null" redirection.

> +
> +echo "Test snapshot action"
> +
> +echo 1 > /sys/kernel/debug/tracing/events/sched/enable
> +
> +echo 'hist:keys=comm:newprio=prio:onchange($newprio).save(comm,prio):onchange($newprio).snapshot() if comm=="ping"' >> /sys/kernel/debug/tracing/events/sched/sched_waking/trigger

This tests onchange().snapshot(), but document change only describes onmax().snapshot().
Maybe we should improve document too.

> +
> +ping $LOCALHOST -c 3
> +nice -n 1 ping $LOCALHOST -c 3
> +
> +echo 0 > /sys/kernel/debug/tracing/events/sched/enable

Shouldn't we stop tracing instead of disabling the event?

Thank you,

> +
> +if ! grep -q "changed:" events/sched/sched_waking/hist; then
> +    fail "Failed to create onchange action inter-event histogram"
> +fi
> +
> +if ! grep -q "comm=ping" snapshot; then
> +    fail "Failed to create snapshot action inter-event histogram"
> +fi
> +
> +exit 0
> -- 
> 2.14.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
