Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932081AbeCIObS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 09:31:18 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:33193 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751068AbeCIObR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 09:31:17 -0500
X-Google-Smtp-Source: AG47ELsO0tcGYOhX7Y6sx4Dduz5maQE5OQ8kyL39BQuBaE8OWzQzuSMFlT2HLqTVIvLwlVL+ByaAvA==
From: Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date: Fri, 9 Mar 2018 09:31:11 -0500 (EST)
X-X-Sender: vince@macbook-air
To: kan.liang@linux.intel.com, vincent.weaver@maine.edu,
        linux-kernel@vger.kernel.org, peterz@infradead.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, eranian@google.com, acme@redhat.com,
        hpa@zytor.com, alexander.shishkin@linux.intel.com, mingo@kernel.org,
        jolsa@redhat.com
cc: linux-tip-commits@vger.kernel.org
Subject: Re: [tip:perf/core] perf/x86/intel: Disable userspace RDPMC usage
 for large PEBS
In-Reply-To: <tip-1af22eba248efe2de25658041a80a3d40fb3e92e@git.kernel.org>
Message-ID: <alpine.DEB.2.21.1803090929380.4834@macbook-air>
References: <1518474035-21006-6-git-send-email-kan.liang@linux.intel.com> <tip-1af22eba248efe2de25658041a80a3d40fb3e92e@git.kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Mar 2018, tip-bot for Kan Liang wrote:

> Commit-ID:  1af22eba248efe2de25658041a80a3d40fb3e92e
> Gitweb:     https://git.kernel.org/tip/1af22eba248efe2de25658041a80a3d40fb3e92e
> Author:     Kan Liang <kan.liang@linux.intel.com>
> AuthorDate: Mon, 12 Feb 2018 14:20:35 -0800
> Committer:  Ingo Molnar <mingo@kernel.org>
> CommitDate: Fri, 9 Mar 2018 08:22:23 +0100
> 
> perf/x86/intel: Disable userspace RDPMC usage for large PEBS
> 


So this whole commit log is about disabling RDPMC usage for "large PEBS"
but the actual change disables RDPMC if "PERF_X86_EVENT_FREERUNNING"

Either the commit log is really misleading, or else a poor name was chosen 
for this feature.

Vince



> Userspace RDPMC cannot possibly work for large PEBS, which was introduced in:
> 
>   b8241d20699e ("perf/x86/intel: Implement batched PEBS interrupt handling (large PEBS interrupt threshold)")
> 
> When the PEBS interrupt threshold is larger than one, there is no way
> to get exact auto-reload times and value for userspace RDPMC.  Disable
> the userspace RDPMC usage when large PEBS is enabled.
> 
> The only exception is when the PEBS interrupt threshold is 1, in which
> case user-space RDPMC works well even with auto-reload events.
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Stephane Eranian <eranian@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Vince Weaver <vincent.weaver@maine.edu>
> Cc: acme@kernel.org
> Fixes: b8241d20699e ("perf/x86/intel: Implement batched PEBS interrupt handling (large PEBS interrupt threshold)")
> Link: http://lkml.kernel.org/r/1518474035-21006-6-git-send-email-kan.liang@linux.intel.com
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> ---
>  arch/x86/events/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 00a6251981d2..9c86e10f1196 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -2117,7 +2117,8 @@ static int x86_pmu_event_init(struct perf_event *event)
>  			event->destroy(event);
>  	}
>  
> -	if (READ_ONCE(x86_pmu.attr_rdpmc))
> +	if (READ_ONCE(x86_pmu.attr_rdpmc) &&
> +	    !(event->hw.flags & PERF_X86_EVENT_FREERUNNING))
>  		event->hw.flags |= PERF_X86_EVENT_RDPMC_ALLOWED;
>  
>  	return err;
> 
