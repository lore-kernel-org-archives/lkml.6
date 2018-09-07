Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A1FC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FA8E2075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:30:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FA8E2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbeIGXNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 19:13:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:55980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727607AbeIGXNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 19:13:04 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79E1D20652;
        Fri,  7 Sep 2018 18:30:53 +0000 (UTC)
Date:   Fri, 7 Sep 2018 14:30:52 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Vaibhav Nagarnaik <vnagarnaik@google.com>
Cc:     linux-kernel@vger.kernel.org, jbehmer@google.com
Subject: Re: [PATCH] ring-buffer: Allow for rescheduling when removing pages
Message-ID: <20180907143052.50ccfab6@gandalf.local.home>
In-Reply-To: <20180907182131.144514-1-vnagarnaik@google.com>
References: <20180907182131.144514-1-vnagarnaik@google.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  7 Sep 2018 11:21:31 -0700
Vaibhav Nagarnaik <vnagarnaik@google.com> wrote:

> When reducing ring buffer size, pages are removed by scheduling a work
> item on each CPU for the corresponding CPU ring buffer. After the pages
> are removed from ring buffer linked list, the pages are free()d in a
> tight loop. The loop does not give up CPU until all pages are removed.
> In a worst case behavior, when lot of pages are to be freed, it can
> cause system stall.
> 
> After the pages are removed from the list, the free() can happen while
> the work is rescheduled. Add a check for need_sched() within the loop
> to prevent the system hangup.
> 
> Reported-by: Jason Behmer <jbehmer@google.com>
> Signed-off-by: Vaibhav Nagarnaik <vnagarnaik@google.com>
> ---
>  kernel/trace/ring_buffer.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 1d92d4a982fd..bc1789df7c53 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -1546,6 +1546,9 @@ rb_remove_pages(struct ring_buffer_per_cpu *cpu_buffer, unsigned long nr_pages)
>  	tmp_iter_page = first_page;
>  
>  	do {
> +		if (need_resched())
> +			schedule();
> +

Hi, thanks for the patch, but the proper way to do this is to stick in:

		cond_resched();

And that should solve it for you. Want to send in another patch?

-- Steve

>  		to_remove_page = tmp_iter_page;
>  		rb_inc_page(cpu_buffer, &tmp_iter_page);
>  

