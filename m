Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752617AbeBSL0V (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 06:26:21 -0500
Received: from foss.arm.com ([217.140.101.70]:57624 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752528AbeBSL0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 06:26:20 -0500
Date: Mon, 19 Feb 2018 11:26:16 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will.deacon@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: arm64/v4.16-rc1: KASAN: use-after-free Read in finish_task_switch
Message-ID: <20180219112615.qresrsvi5qdlw6y3@armageddon.cambridge.arm.com>
References: <20180214120254.qq4w4s42ecxio7lu@lakrids.cambridge.arm.com>
 <20180214150739.GH2992@arm.com>
 <20180214165131.o25r3hhrtrjk3ejq@lakrids.cambridge.arm.com>
 <254787533.21950.1518634424009.JavaMail.zimbra@efficios.com>
 <20180215142239.GF16623@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215142239.GF16623@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 02:22:39PM +0000, Will Deacon wrote:
> Instead, we've come up with a more plausible sequence that can in theory
> happen on a single CPU:
> 
> <task foo calls exit()>
> 
> do_exit
> 	exit_mm
> 		mmgrab(mm);			// foo's mm has count +1
> 		BUG_ON(mm != current->active_mm);
> 		task_lock(current);
> 		current->mm = NULL;
> 		task_unlock(current);
> 
> <irq and ctxsw to kthread>

[...]

> mmdrop(mm);					// foo's mm has count -1
> 
> At this point, we've got an imbalanced count on the mm and could free it
> prematurely as seen in the KASAN log. A subsequent context-switch away
> from foo would therefore result in a use-after-free.

Peter already dismissed an algorithm issue here but I thought I'd give
model checking a go (it only deals with mm_users/mm_count; also added a
heavily simplified exec_mmap() in the loop):

https://git.kernel.org/pub/scm/linux/kernel/git/cmarinas/kernel-tla.git/tree/ctxsw.tla

As expected, it didn't show any problems (though it does not take memory
ordering into account).

Now, there are lots of other mmget/mmput and mmgrab/mmdrop throughout
the kernel and finding an imbalanced call needs more work.

-- 
Catalin
