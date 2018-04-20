Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752981AbeDTRVM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 13:21:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37720 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751159AbeDTRVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 13:21:11 -0400
Date: Fri, 20 Apr 2018 19:21:09 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Dan Carpenter <dan.carpenter@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: Smatch check for Spectre stuff
Message-ID: <20180420172108.GA29920@redhat.com>
References: <20180419051510.GA21898@mwanda>
 <alpine.DEB.2.21.1804201417110.1815@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1804201417110.1815@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/20, Thomas Gleixner wrote:
>
> > kernel/signal.c:3457 do_sigaction() warn: potential spectre issue 'p->sighand->action'
>
> This one is correctly detected

Not sure,

	k = &p->sighand->action[sig-1];

calculates the addr, although we do '*oact = *k' later. I dunno.

> > kernel/signal.c:65 sig_handler() warn: potential spectre issue 't->sighand->action'
>
> It's unclear from a quick look whether it's really possible to speculate
> all over the other things there, but we probably err out on the safe side

at least not in do_sigaction(). And in fact do_sigaction() doesn't need
sig_handler() at all, it could use act->sa.sa_handler instead.

Oleg.
