Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752721AbeBXBkF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 20:40:05 -0500
Received: from mga02.intel.com ([134.134.136.20]:7454 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751917AbeBXBkE (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 20:40:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,385,1515484800";
   d="scan'208";a="29393573"
Subject: Re: [PATCH] perf annotate: Support to display the LBR data in tui
 mode
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc: jolsa@kernel.org, mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com
References: <1519396558-23397-1-git-send-email-yao.jin@linux.intel.com>
 <20180223082500.GT25181@hirez.programming.kicks-ass.net>
 <20180223152906.GA8805@kernel.org>
From: "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <2a73ede7-a033-c601-3717-287ed5496c45@linux.intel.com>
Date: Sat, 24 Feb 2018 09:40:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180223152906.GA8805@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/23/2018 11:29 PM, Arnaldo Carvalho de Melo wrote:
> Em Fri, Feb 23, 2018 at 09:25:00AM +0100, Peter Zijlstra escreveu:
>> On Fri, Feb 23, 2018 at 10:35:58PM +0800, Jin Yao wrote:
>>> Unlike the perf report interactive annotate mode, the perf annotate
>>> doesn't display the LBR data.
> 
>>> perf record -b ...
>>> perf annotate function
> 
>>> It should show IPC/cycle, but it doesn't.
> 
>> There is far more than IPC/cycle for the LBR data, so this Changelog is
>> misleading.
> 
>> Also, I think that this patch goes the wrong way, we should reduce the
>> divergence of the various modes, not make it worse.
> 
> Right, Peter, what would you think if I made --stdio use the same
> routines used to format the TUI, i.e. stdio would be equal to the TUI
> modulo de navigation/jump arrows, etc.
> 
> We would have switches to provide the TUI output options that make sense
> for non-interactive mode, like:
> 
>    J   Toggle showing number of jump sources on targets
>    o   Toggle disassembler output/simplified view
>    s   Toggle source code view
>    t   Circulate percent, total period, samples view
>    k   Toggle line numbers
> 

Hi Arnaldo, looks your idea is very similar as my idea. In my 
understanding, for example, we may provide switch to tui routine like 
annotate_browser__write() and use fprintf() to replace 
ui_browser__printf()/ui_browser_write__xxx() if switch is on for stdio.

Is that your idea?

For this approach, I think, the benefit is we can reuse most of existing 
code but the disadvantage is we have to mix tui and stdio up.

Thanks
Jin Yao

> And would still have e --stdio-classic (deprecated), that we would keep
> for a while.
> 
> I think that this new mode with "dissassembler output" would be the same
> as the current --stdio, I'll check.
> 
> To further clarify, this wouldn't use any ncurses/slang TUI code, just
> plain printf with things formatted using what is used now for the TUI
> mode.
> 
> This way there would never be any drift amongst the output modes and we
> would have less work to do when implementing new stuff like this LBR
> case.
> 
> What do you think?
> 
> - Arnaldo
> 
