Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3243AC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 21:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAD3B20664
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 21:46:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAD3B20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbeKXIck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 03:32:40 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:51248 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbeKXIck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 03:32:40 -0500
Received: from p4fea46ac.dip0.t-ipconnect.de ([79.234.70.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gQJHW-0007M0-8H; Fri, 23 Nov 2018 22:46:34 +0100
Date:   Fri, 23 Nov 2018 22:46:33 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Waiman Long <longman@redhat.com>
cc:     Qian Cai <cai@gmx.us>, akpm@linux-foundation.org,
        yang.shi@linux.alibaba.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] debugobjects: call debug_objects_mem_init eariler
In-Reply-To: <dfa544fc-18d8-f1bf-fadf-46fdbda8d624@redhat.com>
Message-ID: <alpine.DEB.2.21.1811232244140.1684@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1811222238270.1665@nanos.tec.linutronix.de> <20181123043117.992-1-cai@gmx.us> <dfa544fc-18d8-f1bf-fadf-46fdbda8d624@redhat.com>
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

On Thu, 22 Nov 2018, Waiman Long wrote:
> On 11/22/2018 11:31 PM, Qian Cai wrote:
> > The current value of the early boot static pool size, 1024 is not big
> > enough for systems with large number of CPUs with timer or/and workqueue
> > objects selected. As the results, systems have 60+ CPUs with both timer
> > and workqueue objects enabled could trigger "ODEBUG: Out of memory.
> > ODEBUG disabled".
> >
> > However, none of the things are actually used or required beofre

before

> > debug_objects_mem_init() is invoked.
> >
> > According to tglx,
> > "the reason why the call is at this place in start_kernel() is
> > historical. It's because back in the days when debugobjects were added
> > the memory allocator was enabled way later than today. So we can just
> > move the debug_objects_mem_init() call right before sched_init()."
> >
> > Afterwards, when calling debug_objects_mem_init(), interrupts have
> > already been disabled and lockdep_init() will only be called later, so
> > no need to worry about interrupts in
> > debug_objects_replace_static_objects().

Just out of curiosity. How many objects are allocated between early and mem
init?

> > diff --git a/lib/debugobjects.c b/lib/debugobjects.c
> > index 70935ed91125..cc5818ced652 100644
> > --- a/lib/debugobjects.c
> > +++ b/lib/debugobjects.c
> > @@ -1132,13 +1132,6 @@ static int __init debug_objects_replace_static_objects(void)
> >  		hlist_add_head(&obj->node, &objects);
> >  	}
> >  
> > -	/*
> > -	 * When debug_objects_mem_init() is called we know that only
> > -	 * one CPU is up, so disabling interrupts is enough
> > -	 * protection. This avoids the lockdep hell of lock ordering.
> > -	 */
> > -	local_irq_disable();
> 
> I think you should have a comment saying that debug_objects_mm_init() is
> called early with only one CPU up and interrupt disabled. So it is safe
> to replace static objects without any protection.

Yes please.
 
Thanks,

	tglx
