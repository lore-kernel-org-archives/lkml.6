Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751923AbeBWP3O (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 10:29:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:34618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751731AbeBWP3L (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 10:29:11 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E65D8217A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Fri, 23 Feb 2018 12:29:06 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jin Yao <yao.jin@linux.intel.com>, jolsa@kernel.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf annotate: Support to display the LBR data in tui
 mode
Message-ID: <20180223152906.GA8805@kernel.org>
References: <1519396558-23397-1-git-send-email-yao.jin@linux.intel.com>
 <20180223082500.GT25181@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223082500.GT25181@hirez.programming.kicks-ass.net>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 23, 2018 at 09:25:00AM +0100, Peter Zijlstra escreveu:
> On Fri, Feb 23, 2018 at 10:35:58PM +0800, Jin Yao wrote:
> > Unlike the perf report interactive annotate mode, the perf annotate
> > doesn't display the LBR data.

> > perf record -b ...
> > perf annotate function

> > It should show IPC/cycle, but it doesn't.

> There is far more than IPC/cycle for the LBR data, so this Changelog is
> misleading.

> Also, I think that this patch goes the wrong way, we should reduce the
> divergence of the various modes, not make it worse.

Right, Peter, what would you think if I made --stdio use the same
routines used to format the TUI, i.e. stdio would be equal to the TUI
modulo de navigation/jump arrows, etc.

We would have switches to provide the TUI output options that make sense
for non-interactive mode, like:

  J   Toggle showing number of jump sources on targets
  o   Toggle disassembler output/simplified view
  s   Toggle source code view
  t   Circulate percent, total period, samples view 
  k   Toggle line numbers

And would still have e --stdio-classic (deprecated), that we would keep
for a while.

I think that this new mode with "dissassembler output" would be the same
as the current --stdio, I'll check.

To further clarify, this wouldn't use any ncurses/slang TUI code, just
plain printf with things formatted using what is used now for the TUI
mode.

This way there would never be any drift amongst the output modes and we
would have less work to do when implementing new stuff like this LBR
case.

What do you think?

- Arnaldo
