Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753974AbeBPILd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 03:11:33 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47766 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753806AbeBPILc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 03:11:32 -0500
Date: Fri, 16 Feb 2018 09:11:27 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: arm64/v4.16-rc1: KASAN: use-after-free Read in finish_task_switch
Message-ID: <20180216081127.GE25181@hirez.programming.kicks-ass.net>
References: <20180214120254.qq4w4s42ecxio7lu@lakrids.cambridge.arm.com>
 <20180214150739.GH2992@arm.com>
 <20180214165131.o25r3hhrtrjk3ejq@lakrids.cambridge.arm.com>
 <254787533.21950.1518634424009.JavaMail.zimbra@efficios.com>
 <20180215142239.GF16623@arm.com>
 <20180215164754.GW25201@hirez.programming.kicks-ass.net>
 <20180215182154.GD15274@arm.com>
 <1144433342.22716.1518732536600.JavaMail.zimbra@efficios.com>
 <206116170.22740.1518739362681.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <206116170.22740.1518739362681.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Please trim..

On Fri, Feb 16, 2018 at 12:02:42AM +0000, Mathieu Desnoyers wrote:
> > My current theory: do_exit() gets preempted after having set current->mm
> > to NULL, and after having issued mmput(), which brings the mm_count down
> > to 0.

No it doesn't..

remember, the last thread of a process enters with:

  mm_count == 1 && mm_users == 1

exit_mm() then does mmgrab():

  mm_count == 2 && mm_users == 1

we then do mmput(), which results in:

  mm_count == 1 && mm_users == 0

That last mm_count is for ->active_mm, and will be dropped once we
schedule to a next user task.
