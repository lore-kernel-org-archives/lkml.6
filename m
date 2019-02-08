Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DE0C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 23:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38ACA20836
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 23:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfBHXVy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 18:21:54 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:38614 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfBHXVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 18:21:54 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 940EDC64B;
        Fri,  8 Feb 2019 23:21:52 +0000 (UTC)
Date:   Fri, 8 Feb 2019 15:21:51 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
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
Message-Id: <20190208152151.ed4cf0c52e5970fc7a7911f1@linux-foundation.org>
In-Reply-To: <c40b7b94-00e3-9b59-fd66-904b54fc69b4@redhat.com>
References: <20190208134802.218483159@linutronix.de>
        <20190208135020.925487496@linutronix.de>
        <20190208143255.9dec696b15f03bf00f4c60c2@linux-foundation.org>
        <c40b7b94-00e3-9b59-fd66-904b54fc69b4@redhat.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Feb 2019 17:46:39 -0500 Waiman Long <longman@redhat.com> wrote:

> On 02/08/2019 05:32 PM, Andrew Morton wrote:
> > On Fri, 08 Feb 2019 14:48:03 +0100 Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> >> Waiman reported that on large systems with a large amount of interrupts the
> >> readout of /proc/stat takes a long time to sum up the interrupt
> >> statistics. In principle this is not a problem. but for unknown reasons
> >> some enterprise quality software reads /proc/stat with a high frequency.
> >>
> >> The reason for this is that interrupt statistics are accounted per cpu. So
> >> the /proc/stat logic has to sum up the interrupt stats for each interrupt.
> >>
> >> This can be largely avoided for interrupts which are not marked as
> >> 'PER_CPU' interrupts by simply adding a per interrupt summation counter
> >> which is incremented along with the per interrupt per cpu counter.
> >>
> >> The PER_CPU interrupts need to avoid that and use only per cpu accounting
> >> because they share the interrupt number and the interrupt descriptor and
> >> concurrent updates would conflict or require unwanted synchronization.
> >>
> >> ...
> >>
> >> --- a/include/linux/irqdesc.h
> >> +++ b/include/linux/irqdesc.h
> >> @@ -65,6 +65,7 @@ struct irq_desc {
> >>  	unsigned int		core_internal_state__do_not_mess_with_it;
> >>  	unsigned int		depth;		/* nested irq disables */
> >>  	unsigned int		wake_depth;	/* nested wake enables */
> >> +	unsigned int		tot_count;
> > Confused.  Isn't this going to quickly overflow?
> >
> >
> All the current irq count computations for each individual irqs are
> using unsigned int type. Only the sum of all the irqs is u64. Yes, it is
> possible for an individual irq count to exceed 32 bits given sufficient
> uptime.  My PC has an uptime of 36 days and the highest irq count value
> is 79,227,699. Given the current rate, the overflow will happen after
> about 5 years. A larger server system may have an overflow in much
> shorter period. So maybe we should consider changing all the irq counts
> to unsigned long then.

It sounds like it.  A 10khz interrupt will overflow in 4 days...
