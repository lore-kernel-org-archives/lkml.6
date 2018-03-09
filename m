Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932240AbeCIQr1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 11:47:27 -0500
Received: from verein.lst.de ([213.95.11.211]:41572 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932162AbeCIQrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 11:47:25 -0500
Date: Fri, 9 Mar 2018 17:47:18 +0100
From: Torsten Duwe <duwe@lst.de>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Jiri Kosina <jkosina@suse.cz>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>, live-patching@vger.kernel.org
Subject: Re: [PATCH v2] On ppc64le we HAVE_RELIABLE_STACKTRACE
Message-ID: <20180309174718.2700b29e@blackhole.lan>
In-Reply-To: <20180308162616.yhbymodggnfzpskx@treble>
References: <20180305164928.GA17953@lst.de>
        <20180308162616.yhbymodggnfzpskx@treble>
Organization: LST e.V.
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Mar 2018 10:26:16 -0600
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> This doesn't seem to address some of my previous concerns:

You're right. That discussion quickly headed towards objtool
and I forgot about this one paragraph with the remarks.

> - Bailing on interrupt/exception frames

That is a good question. My current code keeps unwinding as long
as the trace looks sane. If the exception frame has a valid code
pointer in the LR slot it will continue. Couldn't there be cases
where this is desirable? Should this be configurable? Not that
I have an idea how this situation could occur for a thread
that is current or sleeping...

Michael, Balbir: is that possible? Any Idea how to reliably detect
an exception frame? My approach would be to look at the next return
address and compare it to the usual suspects (i.e. collect all 
"b ret" addresses in the EXCEPTION_COMMON macro, for BookS).

> - Function graph tracing return address conversion
> 
> - kretprobes return address conversion

You mean like in arch/x86/kernel/unwind_frame.c the call to
ftrace_graph_ret_addr ?

Forgive me my directness but I don't see why these should be handled in
arch-dependent code, other than maybe a hook, if inevitable, that calls
back into the graph tracer / kretprobes in order to get the proper
address, or simply call the trace unreliable in case it finds such a
return address.

I understand that x86 has a hard time with its multiple unwinders, but
there should be a simpler, generic solution for all other architectures.

	Torsten
