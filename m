Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932953AbeE2KlH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 06:41:07 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33510 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932629AbeE2KlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 06:41:02 -0400
Date: Tue, 29 May 2018 12:40:50 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Paul Burton <paul.burton@mips.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 2/2] sched: Warn if we fail to migrate a task
Message-ID: <20180529104050.GY12180@hirez.programming.kicks-ass.net>
References: <20180526154648.11635-1-paul.burton@mips.com>
 <20180526154648.11635-3-paul.burton@mips.com>
 <20180528150656.GF12217@hirez.programming.kicks-ass.net>
 <20180528155932.rcyipmxc5kshjvsy@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180528155932.rcyipmxc5kshjvsy@pburton-laptop>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 08:59:32AM -0700, Paul Burton wrote:

> I agree userspace shouldn't need to care about this but in my case
> (using the test program I linked from the previous patch) this triggers
> whilst the CPU is being brought online, not taken offline. That means
> migrate_tasks() is not involved, and we actually just return from here
> back out from a sched_setaffinity syscall & continue running the user
> task on a CPU that is no longer present in the task's cpus_allowed.
> 
> I can't think of a good qualifier to limit the warning to only trigger
> in that scenario though, so in reality perhaps we're best to just trust
> that with patch 1 applied the problem will go away.

Yeah, I'm struggling too.. re-taking task_rq_lock and testing if
task_cpu(p) is inside it's own cpus_allowed (which at that time might be
different from new_mask) might be the best we can do, but it is fairly
expensive for a sanity check.
