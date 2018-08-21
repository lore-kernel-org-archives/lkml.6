Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42395C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00CC2216C4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:42:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00CC2216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbeHURDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 13:03:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:50384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727046AbeHURDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 13:03:04 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03DAB214D5;
        Tue, 21 Aug 2018 13:42:50 +0000 (UTC)
Date:   Tue, 21 Aug 2018 09:42:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Francis Deslauriers <francis.deslauriers@efficios.com>,
        peterz@infradead.org, mathieu.desnoyers@efficios.com,
        linux-kernel@vger.kernel.org, Michael Rodin <michael@rodin.online>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [BUGFIX PATCH] tracing/kprobes: Fix to check notrace function
 with correct range
Message-ID: <20180821094249.3fea76bb@gandalf.local.home>
In-Reply-To: <153485669706.16611.17726752296213785504.stgit@devbox>
References: <20180821212448.d20ea26fa998b206adf4ece6@kernel.org>
        <153485669706.16611.17726752296213785504.stgit@devbox>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Aug 2018 22:04:57 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Fix within_notrace_func() to check notrace function correctly.
> 
> Since the ftrace_location_range(start, end) function checks
> the range inclusively (start <= ftrace-loc <= end), the end
> address must not include the entry address of next function.
> 
> However, within_notrace_func() uses kallsyms_lookup_size_offset()
> to get the function size and calculate the end address from
> adding the size to the entry address. This means the end address
> is the entry address of the next function.
> 
> In the result, within_notrace_func() fails to find notrace
> function if the next function of the target function is
> ftraced.
> 
> Let's subtract 1 from the end address so that ftrace_location_range()
> can check it correctly.
> 
> Fixes: commit 45408c4f9250 ("tracing: kprobes: Prohibit probing on notrace function")
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Reported-by: Michael Rodin <michael@rodin.online>
> ---
>

Applied. Thanks Masami! I'll start testing this and send it upstream
when it's finished.

-- Steve
