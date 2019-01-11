Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FFCC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA00E2184A
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387758AbfAKTTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 14:19:39 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:34521 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732943AbfAKTTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 14:19:39 -0500
Received: from p4fea4364.dip0.t-ipconnect.de ([79.234.67.100] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gi2L8-00021A-3V; Fri, 11 Jan 2019 20:19:34 +0100
Date:   Fri, 11 Jan 2019 20:19:33 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Waiman Long <longman@redhat.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Daniel Colascione <dancol@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 4/4] /proc/stat: Call kstat_irqs_usr() only for active
 IRQs
In-Reply-To: <alpine.DEB.2.21.1901111750280.4957@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1901112017000.1661@nanos.tec.linutronix.de>
References: <1547061648-16080-1-git-send-email-longman@redhat.com> <1547061648-16080-5-git-send-email-longman@redhat.com> <alpine.DEB.2.21.1901111750280.4957@nanos.tec.linutronix.de>
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

On Fri, 11 Jan 2019, Thomas Gleixner wrote:
> --- a/kernel/irq/internals.h
> +++ b/kernel/irq/internals.h
> @@ -246,6 +246,7 @@ static inline void kstat_incr_irqs_this_
>  {
>  	__this_cpu_inc(*desc->kstat_irqs);
>  	__this_cpu_inc(kstat.irqs_sum);
> +	desc->tot_count++;

There is one issue here. True percpu interrupts, like the timer interrupts
on ARM(64), will access that in parallel. But that's not rocket science to
fix.

Thanks,

	tglx


