Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752442AbeEOW3i (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 18:29:38 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34059 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752047AbeEOW3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 18:29:37 -0400
Date: Wed, 16 May 2018 00:29:34 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@linux-foundation.org>
cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] kernel: sys: fix potential Spectre v1
In-Reply-To: <20180515150859.1bccbd8d4543848b30fea859@linux-foundation.org>
Message-ID: <alpine.DEB.2.21.1805160027260.1605@nanos.tec.linutronix.de>
References: <20180515030038.GA11822@embeddedor.com> <20180515150859.1bccbd8d4543848b30fea859@linux-foundation.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 May 2018, Andrew Morton wrote:
> On Mon, 14 May 2018 22:00:38 -0500 "Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:
> 
> > resource can be controlled by user-space, hence leading to a
> > potential exploitation of the Spectre variant 1 vulnerability.
> > 
> > This issue was detected with the help of Smatch:
> > 
> > kernel/sys.c:1474 __do_compat_sys_old_getrlimit() warn: potential
> > spectre issue 'get_current()->signal->rlim' (local cap)
> > kernel/sys.c:1455 __do_sys_old_getrlimit() warn: potential spectre issue
> > 'get_current()->signal->rlim' (local cap)
> > 
> > Fix this by sanitizing *resource* before using it to index
> > current->signal->rlim
> > 
> > Notice that given that speculation windows are large, the policy is
> > to kill the speculation on the first load and not worry if it can be
> > completed with a dependent load/store [1].
> 
> hm.  Not my area, but I'm always willing to learn ;)
> 
> > --- a/kernel/sys.c
> > +++ b/kernel/sys.c
> > @@ -69,6 +69,9 @@
> >  #include <asm/io.h>
> >  #include <asm/unistd.h>
> >  
> > +/* Hardening for Spectre-v1 */
> > +#include <linux/nospec.h>
> > +
> >  #include "uid16.h"
> >  
> >  #ifndef SET_UNALIGN_CTL
> > @@ -1451,6 +1454,7 @@ SYSCALL_DEFINE2(old_getrlimit, unsigned int, resource,
> >  	if (resource >= RLIM_NLIMITS)
> >  		return -EINVAL;
> >  
> > +	resource = array_index_nospec(resource, RLIM_NLIMITS);
> >  	task_lock(current->group_leader);
> >  	x = current->signal->rlim[resource];
> 
> Can the speculation proceed past the task_lock()?  Or is the policy to
> ignore such happy happenstances even if they are available?

Locks are not in the way of speculation. Speculation has almost no limits
except serializing instructions. At least they respect the magic AND
limitation in array_index_nospec().

Thanks,

	tglx
