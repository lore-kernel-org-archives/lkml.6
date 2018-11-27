Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708F8C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 18:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 191752081B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 18:44:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 191752081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730410AbeK1FnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 00:43:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:58856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726166AbeK1FnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 00:43:04 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4A7E21104;
        Tue, 27 Nov 2018 18:44:14 +0000 (UTC)
Date:   Tue, 27 Nov 2018 13:44:12 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] tracing: Fix an off by one in __next()
Message-ID: <20181127134412.6f2141d4@gandalf.local.home>
In-Reply-To: <20180620110758.crunhd5bfep7zuiz@kili.mountain>
References: <20180620110758.crunhd5bfep7zuiz@kili.mountain>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Doing the sweep of my INBOX, I came across this patch (it was sent
while I was in the Alps :-)


On Wed, 20 Jun 2018 14:08:00 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> The > should be >= to prevent an off by one bug.

Well, not really.

> 
> >From reviewing the code, it seems possible for  
> stack_trace_max.nr_entries to be set to .max_entries and in that case we
> would be reading one element beyond the end of the stack_dump_trace[]
> array.  If it's not set to .max_entries then the bug doesn't affect
> runtime.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
> index 4237eba4ef20..6e3edd745c68 100644
> --- a/kernel/trace/trace_stack.c
> +++ b/kernel/trace/trace_stack.c
> @@ -286,7 +286,7 @@ __next(struct seq_file *m, loff_t *pos)
>  {
>  	long n = *pos - 1;
>  
> -	if (n > stack_trace_max.nr_entries || stack_dump_trace[n] == ULONG_MAX)
> +	if (n >= stack_trace_max.nr_entries || stack_dump_trace[n] == ULONG_MAX)

We have:

static unsigned long stack_dump_trace[STACK_TRACE_ENTRIES+1] =
	 { [0 ... (STACK_TRACE_ENTRIES)] = ULONG_MAX };

 And

struct stack_trace stack_trace_max = {
	.max_entries		= STACK_TRACE_ENTRIES - 1,
	.entries		= &stack_dump_trace[0],
};


And nr_entries is set as this, and we have after that this:

	stack_trace_max.nr_entries = x;
	for (; x < i; x++)
		stack_dump_trace[x] = ULONG_MAX;

Where we set stack_dump_trace[nr_entries] to ULONG_MAX.

Thus, nr_entries will not go pass the size of stack_dump_trace.

That said, if n == nr_entries, the second part of that if will always
be true. And this is a bit subtle, so I will apply the patch. But it is
not an off by one bug ;-)

Thanks!

-- Steve


>  		return NULL;
>  
>  	m->private = (void *)n;

