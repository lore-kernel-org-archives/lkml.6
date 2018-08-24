Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88ABC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 23:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E28D20A8B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 23:25:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E28D20A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbeHYDBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 23:01:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:33592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726770AbeHYDBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 23:01:54 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6ADA42064A;
        Fri, 24 Aug 2018 23:25:09 +0000 (UTC)
Date:   Fri, 24 Aug 2018 19:25:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 25/32] selftests/ftrace: Add function filter on
 module testcase
Message-ID: <20180824192507.3066a18a@gandalf.local.home>
In-Reply-To: <153443765894.23257.13622063956539869338.stgit@devbox>
References: <153443695002.23257.13628220023468200991.stgit@devbox>
        <153443765894.23257.13622063956539869338.stgit@devbox>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Aug 2018 01:40:59 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Add a testcase for function filter on module.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  .../ftrace/test.d/ftrace/func_mod_trace.tc         |   24 ++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/func_mod_trace.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_mod_trace.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_mod_trace.tc
> new file mode 100644
> index 000000000000..359380c3834f
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_mod_trace.tc
> @@ -0,0 +1,24 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: ftrace - function trace on module
> +
> +[ ! -f set_ftrace_filter ] && exit_unsupported
> +
> +: "mod: allows to filter a non exist function"
> +echo 'non_exist_func:mod:non_exist_module' > set_ftrace_filter
> +grep -q "non_exist_func" set_ftrace_filter
> +
> +: "mod: on exist module"
> +echo '*:mod:trace_printk' > set_ftrace_filter
> +if ! modprobe trace-printk.ko ; then

Need to remove the '.ko'

-- Steve

> +  echo "No trace-printk sample module - please make CONFIG_SAMPLE_TRACE_PRINTK=
> +m"
> +  exit_unresolved;
> +fi
> +
> +: "Wildcard should be resolved after loading module"
> +grep -q "trace_printk_irq_work" set_ftrace_filter
> +
> +: "After removing the filter becomes empty"
> +rmmod trace_printk
> +test `cat set_ftrace_filter | wc -l` -eq 0

