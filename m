Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933006AbeCJNMj (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 08:12:39 -0500
Received: from 9.mo173.mail-out.ovh.net ([46.105.72.44]:40688 "EHLO
        9.mo173.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932976AbeCJNMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 08:12:38 -0500
Date: Sat, 10 Mar 2018 13:32:45 +0100
From: Greg Kurz <groug@kaod.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>, Latchesar Ionkov <lucho@ionkov.net>,
        "David S. Miller" <davem@davemloft.net>,
        Yiwen Jiang <jiangyiwen@huawei.com>
Subject: Re: [PATCH] net/9p: avoid -ERESTARTSYS leak to userspace
Message-ID: <20180310133245.2fedabe6@bahia.lan>
In-Reply-To: <20180309141252.ee4aea14ec7c32226c480b23@linux-foundation.org>
References: <152062809886.10599.7361006774123053312.stgit@bahia.lan>
        <20180309141252.ee4aea14ec7c32226c480b23@linux-foundation.org>
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 15021756558728993267
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtfedrkeelgdefjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Thank you very much for taking care of this.

Please find my answers to your remarks below.

On Fri, 9 Mar 2018 14:12:52 -0800
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Fri, 09 Mar 2018 21:41:38 +0100 Greg Kurz <groug@kaod.org> wrote:
> 
> > If it was interrupted by a signal, the 9p client may need to send some
> > more requests to the server for cleanup before returning to userspace.
> > 
> > To avoid such a last minute request to be interrupted right away, the
> > client memorizes if a signal is pending, clears TIF_SIGPENDING, handles
> > the request and calls recalc_sigpending() before returning.
> > 
> > Unfortunately, if the transmission of this cleanup request fails for any
> > reason, the transport returns an error and the client propagates it right
> > away, without calling recalc_sigpending().
> > 
> > This ends up with -ERESTARTSYS from the initially interrupted request
> > crawling up to syscall exit, with TIF_SIGPENDING cleared by the cleanup
> > request. The specific signal handling code, which is responsible for
> > converting -ERESTARTSYS to -EINTR is not called, and userspace receives
> > the confusing errno value:
> > 
> > open: Unknown error 512 (512)
> > 
> > This is really hard to hit in real life. I discovered the issue while
> > working on hot-unplug of a virtio-9p-pci device with an instrumented
> > QEMU allowing to control request completion.
> > 
> > Both p9_client_zc_rpc() and p9_client_rpc() functions have this buggy
> > error path actually. Their code flow is a bit obscure and the best
> > thing to do would probably be a full rewrite: to really ensure this
> > situation of clearing TIF_SIGPENDING and returning -ERESTARTSYS can
> > never happen.
> > 
> > But given the general lack of interest for the 9p code, I won't risk
> > breaking more things. So this patch simply fixes the buggy paths in
> > both functions with a trivial label+goto.
> > 
> > Thanks to Laurent Dufour for his help and suggestions on how to find
> > the root cause and how to fix it.  
> 
> That's a fairly straightforward-looking bug.  However the code still
> looks a bit racy:
> 
> 
> : 	if (signal_pending(current)) {
> : 		sigpending = 1;
> : 		clear_thread_flag(TIF_SIGPENDING);
> : 	} else
> : 		sigpending = 0;
> : 
> 
> what happens if signal_pending(current) becomes true right here?
>

Depending on the transport c->trans_mod->request() could possibly
return -ERESTARTSYS, and we would then recalc_sigpending() and
propagate -ERESTARTSYS to the caller.

> : 	err = c->trans_mod->request(c, req);
> 
> 
> I'm surprised that the 9p client is mucking with signals at all. 
> Signals are a userspace IPC scheme and kernel code should instead be
> using the more powerful messaging mechanisms which we've developed. 
> Ones which don't disrupt userspace state.
> 
> Why is this happening?  Is there some userspace/kernel interoperation
> involved?
> 

Before commit 9523feac272ccad2ad8186ba4fcc89103754de52, we used to rely
on wait_event_interruptible() instead of wait_event_killable(). IIUC,
the purpose of all this sigpending tweaking was just to allow subsequent
cleanup related requests to be issued, without them being interrupted right
away because of the initial signal.

BTW the issue tentatively fixed by commit 9523feac272ccad2ad8186ba4fcc89103754de52
was more deeply investigated since then. It was caused by a bug in QEMU that got 
fixed, and will be available in the next release (2.12). And to cope with existing
buggy QEMUs, we can assume that a -EINTR response from the server necessarily means
the corresponding request has been successfully canceled.

Cheers,

--
Greg
