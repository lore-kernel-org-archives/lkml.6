Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E56C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C79D7217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h4GOQt/J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbfBLNIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:08:19 -0500
Received: from merlin.infradead.org ([205.233.59.134]:57148 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728874AbfBLNIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 08:08:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1KBTgh75R8ZmoVHa3UQsb+FSiCPuk264Z8EPNlrraw8=; b=h4GOQt/J2rbw7FwyXz9wEmEuf
        A1BrnDMlBZCLKQUXI5R9tM8uZBwGQyUy7Q4G2rxE/gY356iji3mroEttZcgyP2h82fgmqhRwY7aKp
        nhD16d5RfNSvDWVVF8qK/B0Xe5BUaSQxj/G3uqYgZGaAgpiH3N2ZmHmO44EmJVmdyRHfl5Y1K4paQ
        Y6mnQ0NbNJyh3KkQjrxZQHcUlj761cREREKsTyPoUkkmM6JACZMbKSI0GnANdb7pINEGt+bNnR+2x
        TY1SOrcj3ye/1P6qbG6+gnmpsYo8LuHNvhcmf62OOwUO0qxyRAlvltEkWOM6y/6NucUh14DRu67bh
        xWWt12r/A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtXn4-0004YH-5Q; Tue, 12 Feb 2019 13:08:00 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5F54220D0C1D8; Tue, 12 Feb 2019 14:07:56 +0100 (CET)
Date:   Tue, 12 Feb 2019 14:07:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        julien.thierry@arm.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Jin, Yao" <yao.jin@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf/core: don't WARN for impossible rb sizes
Message-ID: <20190212130756.GH32494@hirez.programming.kicks-ass.net>
References: <20190110142745.25495-1-mark.rutland@arm.com>
 <1f71da66-4783-0108-668c-cdffca499719@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f71da66-4783-0108-668c-cdffca499719@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 10:42:38AM +0800, Jin, Yao wrote:
> > diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> > index 4a9937076331..309ef5a64af5 100644
> > --- a/kernel/events/ring_buffer.c
> > +++ b/kernel/events/ring_buffer.c
> > @@ -734,6 +734,9 @@ struct ring_buffer *rb_alloc(int nr_pages, long watermark, int cpu, int flags)
> >   	size = sizeof(struct ring_buffer);
> >   	size += nr_pages * sizeof(void *);
> > +	if (order_base_2(size) >= MAX_ORDER)
> > +		goto fail;
> > +
> >   	rb = kzalloc(size, GFP_KERNEL);

Yes, Boris also send the entire morning bisecting this.

The problem is that @size is in bytes and MAX_ORDER is in pages.

That should be:

  if (order_base_2(size) >= PAGE_SHIFT+MAX_ORDER)


