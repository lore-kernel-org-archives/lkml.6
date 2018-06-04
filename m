Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751927AbeFDIYV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 04:24:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54628 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751242AbeFDIYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 04:24:20 -0400
Date: Mon, 4 Jun 2018 10:24:14 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: David Arcari <darcari@redhat.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Donald Zickus <dzickus@redhat.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: Re: [PATCH] perf/x86: read the FREEZE_WHILE_SMM bit during boot
Message-ID: <20180604082414.GO12217@hirez.programming.kicks-ass.net>
References: <1528050223-144925-1-git-send-email-darcari@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528050223-144925-1-git-send-email-darcari@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 03, 2018 at 02:23:43PM -0400, David Arcari wrote:
> On some systems pressing the external NMI button is now failing to inject
> an NMI 5-10% of the time.  This causes confusion for a user that expects
> the NMI to dump the system.
> 
> Commit 6089327f5424 ("perf/x86: Add sysfs entry to freeze counters on SMI")
> does not read the firmware setting of the FREEZE_WHILE_SMM bit and will
> always clear it when the PMU is initialized.  As a result the performance
> counters will always run and that greatly expands the race in which
> external NMI will not be processed if a local NMI is already being
> processed.
> 
> One option is to change default_do_nmi().  The code snippet below shows the
> relevant portion of a patch that resolves the issue, but it is problematic
> from a performance perspective and was dismissed.
> 
> -345,7 +345,17 @@ static void default_do_nmi(struct pt_regs *regs)
>  		 */
>  		if (handled > 1)
>  			__this_cpu_write(swallow_nmi, true);
> -		return;
> +
> +		/*
> +		 * Unfortunately, there is a race condition which can
> +		 * result in a missing an external NMI.  Typically, an
> +		 * external NMI is processed on cpu 0.  Therefore, on
> +		 * cpu 0 check for an external NMI before returning.
> +		 */
> +		if (smp_processor_id() ||
> +		    (x86_platform.get_nmi_reason() & NMI_REASON_MASK) == 0) {
> +			return;
> +		}
>  	}
> 
> Ultimately, the issue can be resolved by storing the default firmware
> setting of FREEZE_WHILE_SMM before initializing the PMU.

I'm sorry, I know it's Monday morning, but what?! I really don't
understand anything you write there.

Maybe if you explain the race and how your proposed fix closes it things
will make sense. The above refers to too many things not here.
