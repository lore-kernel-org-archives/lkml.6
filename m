Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CBFC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83DF521473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732660AbfA3R6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 12:58:44 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:48015 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfA3R6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 12:58:44 -0500
Received: from [2a01:598:b890:92b7:20d0:59ff:fe6e:bab9] (helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gou8F-00078F-7k; Wed, 30 Jan 2019 18:58:39 +0100
Date:   Wed, 30 Jan 2019 18:58:32 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Waiman Long <longman@redhat.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Daniel Colascione <dancol@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [patch 1/2] genriq: Avoid summation loops for /proc/stat
In-Reply-To: <00f361f9-b1ec-777b-b794-d7728a357034@redhat.com>
Message-ID: <alpine.DEB.2.21.1901301857350.1622@nanos.tec.linutronix.de>
References: <20190130123130.785636313@linutronix.de> <20190130123615.501708580@linutronix.de> <00f361f9-b1ec-777b-b794-d7728a357034@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2019, Waiman Long wrote:
> On 01/30/2019 07:31 AM, Thomas Gleixner wrote:
> > --- a/include/linux/irqdesc.h
> > +++ b/include/linux/irqdesc.h
> > @@ -65,9 +65,10 @@ struct irq_desc {
> >  	unsigned int		core_internal_state__do_not_mess_with_it;
> >  	unsigned int		depth;		/* nested irq disables */
> >  	unsigned int		wake_depth;	/* nested wake enables */
> > +	unsigned int		tot_count;
> >  	unsigned int		irq_count;	/* For detecting broken IRQs */
> > -	unsigned long		last_unhandled;	/* Aging timer for unhandled count */
> >  	unsigned int		irqs_unhandled;
> > +	unsigned long		last_unhandled;	/* Aging timer for unhandled count */
> >  	atomic_t		threads_handled;
> >  	int			threads_handled_last;
> >  	raw_spinlock_t		lock;
> 
> Just one minor nit. Why you want to move the last_unhandled down one
> slot? There were 5 int's before. Adding one more will just fill the
> padding hole. Moving down the last_unhandled will probably leave 4-byte
> holes in both above and below it assuming that raw_spinlock_t is 4 bytes.

Unintentional wreckage. Will undo. Thanks for spotting it.

Thanks,

	tglx
