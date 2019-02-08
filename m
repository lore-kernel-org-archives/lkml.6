Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1821DC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 22:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9C0A2075C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 22:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfBHWc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 17:32:57 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36912 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfBHWc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 17:32:57 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3AF65C36C;
        Fri,  8 Feb 2019 22:32:56 +0000 (UTC)
Date:   Fri, 8 Feb 2019 14:32:55 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Waiman Long <longman@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Daniel Colascione <dancol@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [patch V2 1/2] genriq: Avoid summation loops for /proc/stat
Message-Id: <20190208143255.9dec696b15f03bf00f4c60c2@linux-foundation.org>
In-Reply-To: <20190208135020.925487496@linutronix.de>
References: <20190208134802.218483159@linutronix.de>
        <20190208135020.925487496@linutronix.de>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Feb 2019 14:48:03 +0100 Thomas Gleixner <tglx@linutronix.de> wrote:

> Waiman reported that on large systems with a large amount of interrupts the
> readout of /proc/stat takes a long time to sum up the interrupt
> statistics. In principle this is not a problem. but for unknown reasons
> some enterprise quality software reads /proc/stat with a high frequency.
> 
> The reason for this is that interrupt statistics are accounted per cpu. So
> the /proc/stat logic has to sum up the interrupt stats for each interrupt.
> 
> This can be largely avoided for interrupts which are not marked as
> 'PER_CPU' interrupts by simply adding a per interrupt summation counter
> which is incremented along with the per interrupt per cpu counter.
> 
> The PER_CPU interrupts need to avoid that and use only per cpu accounting
> because they share the interrupt number and the interrupt descriptor and
> concurrent updates would conflict or require unwanted synchronization.
> 
> ...
>
> --- a/include/linux/irqdesc.h
> +++ b/include/linux/irqdesc.h
> @@ -65,6 +65,7 @@ struct irq_desc {
>  	unsigned int		core_internal_state__do_not_mess_with_it;
>  	unsigned int		depth;		/* nested irq disables */
>  	unsigned int		wake_depth;	/* nested wake enables */
> +	unsigned int		tot_count;

Confused.  Isn't this going to quickly overflow?


