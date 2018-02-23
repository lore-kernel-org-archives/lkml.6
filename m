Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751623AbeBWQ7X (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 11:59:23 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34812 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751534AbeBWQ7V (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 11:59:21 -0500
Date: Fri, 23 Feb 2018 17:59:17 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jin Yao <yao.jin@linux.intel.com>, jolsa@kernel.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf annotate: Support to display the LBR data in tui
 mode
Message-ID: <20180223165917.GX25181@hirez.programming.kicks-ass.net>
References: <1519396558-23397-1-git-send-email-yao.jin@linux.intel.com>
 <20180223082500.GT25181@hirez.programming.kicks-ass.net>
 <20180223152906.GA8805@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223152906.GA8805@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 12:29:06PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Feb 23, 2018 at 09:25:00AM +0100, Peter Zijlstra escreveu:
> > On Fri, Feb 23, 2018 at 10:35:58PM +0800, Jin Yao wrote:
> > > Unlike the perf report interactive annotate mode, the perf annotate
> > > doesn't display the LBR data.
> 
> > > perf record -b ...
> > > perf annotate function
> 
> > > It should show IPC/cycle, but it doesn't.
> 
> > There is far more than IPC/cycle for the LBR data, so this Changelog is
> > misleading.
> 
> > Also, I think that this patch goes the wrong way, we should reduce the
> > divergence of the various modes, not make it worse.
> 
> Right, Peter, what would you think if I made --stdio use the same
> routines used to format the TUI, i.e. stdio would be equal to the TUI
> modulo de navigation/jump arrows, etc.

Ideally we'd share the whole lot between stdio/TUI/GUI. That said, I
think stdio currently has a bunch of features that the other lack (my
fault).

> We would have switches to provide the TUI output options that make sense
> for non-interactive mode, like:
> 
>   J   Toggle showing number of jump sources on targets
>   o   Toggle disassembler output/simplified view
>   s   Toggle source code view
>   t   Circulate percent, total period, samples view 
>   k   Toggle line numbers

I really have no idea what you're talking about; this is because I've
just _never_ seen TUI mode. I exclusively use stdio.

> I think that this new mode with "dissassembler output" would be the same
> as the current --stdio, I'll check.

When I did the LBR coverage stuff I only did stdio; at the time we
talked about merging all this further, and IIRC you said you had
something like that on the TODO already so I left it there.

> This way there would never be any drift amongst the output modes and we
> would have less work to do when implementing new stuff like this LBR
> case.

Yes, I think that's the right direction, but I fear there's quite a bit
of work before we're at that point.

My only fear is that the resulting output code will be impenetrable,
there's a reason I only ever touch stdio output :/
