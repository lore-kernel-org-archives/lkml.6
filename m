Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754805AbeDTM1t (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 08:27:49 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45090 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754591AbeDTM1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 08:27:48 -0400
Date: Fri, 20 Apr 2018 14:25:37 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Dan Carpenter <dan.carpenter@oracle.com>
cc: LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: Smatch check for Spectre stuff
In-Reply-To: <20180419051510.GA21898@mwanda>
Message-ID: <alpine.DEB.2.21.1804201417110.1815@nanos.tec.linutronix.de>
References: <20180419051510.GA21898@mwanda>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Apr 2018, Dan Carpenter wrote:

> Several people have asked me to write this and I think one person was
> maybe working on writing it themselves...
> 
> The point of this check is to find place which might be vulnerable to
> the Spectre vulnerability.  In the kernel we have the array_index_nospec()
> macro which turns off speculation.  There are fewer than 10 places where
> it's used.  Meanwhile this check complains about 800 places where maybe
> it could be used.  Probably the 100x difference means there is something
> that I haven't understood...
> 
> What the test does is it looks at array accesses where the user controls
> the offset.  It asks "is this a read?" and have we used the
> array_index_nospec() macro?  If the answers are yes, and no respectively
> then print a warning.
> 
> http://repo.or.cz/smatch.git/blob/HEAD:/check_spectre.c

Cool stuff!

> The other thing is that speculation probably goes to 200 instructions
> ahead at most.  But the Smatch doesn't have any concept of CPU
> instructions.  I've marked the offsets which were recently compared to
> something as "local cap" because they were probably compared to the
> array limit.  Those are maybe more likely to be under the 200 CPU
> instruction count.
> 
> This obviously a first draft.
> 
> What would help me, is maybe people could tell me why there are so many
> false positives.  Saying "the lower level checks for that" is not
> helpful but if you could tell me the exact function name where the check
> is that helps a lot...

Actually checks in the lower level codepath are not helping because
speculation forgoes the checks. What would help is that something before
that array access limits the array index, which is unlikely. So we probably
need to go through all the places and have a look.

> kernel/signal.c:3457 do_sigaction() warn: potential spectre issue 'p->sighand->action'

This one is correctly detected

> kernel/signal.c:65 sig_handler() warn: potential spectre issue 't->sighand->action'

It's unclear from a quick look whether it's really possible to speculate
all over the other things there, but we probably err out on the safe side

Thanks,

	tglx
