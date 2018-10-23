Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCA0C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 15:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAC0C207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 15:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUqUl2x/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAC0C207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbeJWX1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 19:27:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:47726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727359AbeJWX1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 19:27:33 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFE6620671;
        Tue, 23 Oct 2018 15:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540307025;
        bh=zZnFTlhP/IPmPEsdqVbFn3Y1YOrRl0xfCjanMkT0MtU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oUqUl2x/Q+RWDEwRdug9Y6orCiwuZXBkQG8wQn2fXJhT0PhGw57RwmWtG2/514yTr
         DCfekMyTu64W4rzTKtmDkTdi7AogtBo42gJYwFWUaPBALtEGcOripqn6+j2iipsYjN
         tRS7QwigblvJDv1dkZ0L60mXNhariot2LclFR6qs=
Date:   Wed, 24 Oct 2018 00:03:42 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        namhyung@kernel.org, vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v6 10/15] tracing: Add hist trigger snapshot() action
 test case
Message-Id: <20181024000342.d1e82a160a5efecdb9c0d4f5@kernel.org>
In-Reply-To: <75db4ded21471580e5ad8d57c74fd9c8923cd90a.1539288364.git.tom.zanussi@linux.intel.com>
References: <cover.1539288364.git.tom.zanussi@linux.intel.com>
        <75db4ded21471580e5ad8d57c74fd9c8923cd90a.1539288364.git.tom.zanussi@linux.intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Oct 2018 16:02:07 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> From: Tom Zanussi <tom.zanussi@linux.intel.com>
> 
> Add a test case verifying the basic functionality of the
> hist:snapshot() action.
> 

I think this is OK for current tracing tree, but for next kernel version
you may need to update it (against the kselftest tree)

> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> ---
>  .../inter-event/trigger-snapshot-action-hist.tc    | 55 ++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
> new file mode 100644
> index 000000000000..f427be989296
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
> @@ -0,0 +1,55 @@
> +#!/bin/sh
> +# description: event trigger - test inter-event histogram trigger snapshot action
> +
> +do_reset() {
> +    reset_trigger
> +    echo > set_event
> +    echo 0 > snapshot
> +    clear_trace
> +}
> +
> +fail() { #msg
> +    do_reset
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
> +grep "onchange(var)" README > /dev/null || exit_unsupported # version issue

grep -q will be better.

> +
> +grep "snapshot()" README > /dev/null || exit_unsupported # version issue

Ditto.

> +
> +reset_tracer
> +do_reset

Depends on the merge timing, but I already moved this kind of "reset 
before/after test" into initialize_ftrace(), so you don't need do_reset()
here. It is required only if you reset tracer in between tests.

> +
> +echo "Test snapshot action"
> +
> +echo 1 > /sys/kernel/debug/tracing/events/sched/enable
> +
> +echo 'hist:keys=comm:newprio=prio:onchange($newprio).save(comm,prio):onchange($newprio).snapshot() if comm=="ping"' >> /sys/kernel/debug/tracing/events/sched/sched_waking/trigger
> +
> +ping localhost -c 3
> +nice -n 1 ping localhost -c 3

Ditto. please use $LOCALHOST if you send this to the latest tree.

http://lkml.kernel.org/r/153563862993.29700.6436770573173736555.stgit@devbox

> +
> +echo 0 > /sys/kernel/debug/tracing/events/sched/enable
> +
> +if ! grep -q "changed:" events/sched/sched_waking/hist; then
> +    fail "Failed to create onchange action inter-event histogram"
> +fi
> +
> +if ! grep -q "comm=ping" snapshot; then
> +    fail "Failed to create snapshot action inter-event histogram"
> +fi
> +
> +do_reset

Also you don't need this.


BTW, are there no "expected fail" tests? (e.g. passing wrong snapshot command to trigger)

Thank you,

> +
> +exit 0
> -- 
> 2.14.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
