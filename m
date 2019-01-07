Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA4BC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BAC32173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sqn2MwUu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbfAGP6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 10:58:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58124 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727237AbfAGP6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 10:58:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=T/TCTiThUfcYYjxY+9m5Saw3iGYolZhNfHagKgM7EqU=; b=sqn2MwUuwC86K5XCjwh+rb0sT
        Uzjx7tifpyNgZoY8GbpHrRabXn+wk6n8plAk487DOOk83ZZ27DWE5OUZH24+/qRgwa0g1WOuMzML0
        VIoucPQelqTnGloNoK4+NAK7hT0+3l7u19ozoTF94mFLWa74bHf4HSFsSnGetj0GJ8cYAUR5VMV0Y
        /jKmHERtAZXBQ2BnYizU0IXfjTGIq8y6ac6HbbB691dJWlY7jIbq0gPFHic9+BWP/Fq3q+Yss/gd5
        WLHo9ZciAuA8ugUe8+m4iJM/WYZ/ecdmB7Bnqm/psXYpbL3RnnB1iNpZEekonfUo/UnBUPh6MY456
        /iX5v42Pg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ggXIX-0008OQ-1T; Mon, 07 Jan 2019 15:58:41 +0000
Date:   Mon, 7 Jan 2019 07:58:40 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Daniel Colascione <dancol@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 2/2] /proc/stat: Add sysctl parameter to control irq
 counts latency
Message-ID: <20190107155840.GY6310@bombadil.infradead.org>
References: <1546873978-27797-1-git-send-email-longman@redhat.com>
 <1546873978-27797-3-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546873978-27797-3-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 10:12:58AM -0500, Waiman Long wrote:
> Reading /proc/stat can be slow especially if there are many irqs and on
> systems with many CPUs as summation of all the percpu counts for each
> of the irqs is required. On some newer systems, there can be more than
> 1000 irqs per socket.
> 
> Applications that need to read /proc/stat many times per seconds will
> easily hit a bottleneck. In reality, the irq counts are seldom looked
> at. Even those applications that read them don't really need up-to-date
> information. One way to reduce the performance impact of irq counts
> computation is to do it less frequently.
> 
> A new "fs/proc-stat-irqs-latency-ms" sysctl parameter is now added to

No.  No, no, no, no, no.  No.

Stop adding new sysctls for this kind of thing.  It's just a way to shift
blame from us (who allegedly know what we're doing) to the sysadmin
(who probably has better things to be doing than keeping up with the
intricacies of development of every single piece of software running on
their system).

Let's figure out what this _should_ be.  As a strawman, I propose we
update these stats once a second.  That's easy to document and understand.

> @@ -98,7 +105,48 @@ static u64 compute_stat_irqs_sum(void)
>  static void show_stat_irqs(struct seq_file *p)
>  {
>  	int i;
> +#ifdef CONFIG_PROC_SYSCTL
> +	static char *irqs_buf;		   /* Buffer for irqs values */
> +	static int buflen;
> +	static unsigned long last_jiffies; /* Last buffer update jiffies */
> +	static DEFINE_MUTEX(irqs_mutex);
> +	unsigned int latency = proc_stat_irqs_latency_ms;
> +
> +	if (latency) {
> +		char *ptr;
> +
> +		latency = _msecs_to_jiffies(latency);
> +
> +		mutex_lock(&irqs_mutex);
> +		if (irqs_buf && time_before(jiffies, last_jiffies + latency))
> +			goto print_out;
> +
> +		/*
> +		 * Each irq value may require up to 11 bytes.
> +		 */
> +		if (!irqs_buf) {
> +			irqs_buf = kmalloc(nr_irqs * 11 + 32,
> +					   GFP_KERNEL | __GFP_ZERO);

Why are you caching the _output_ of calling sprintf(), rather than caching the
values of each interrupt?

