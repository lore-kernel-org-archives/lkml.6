Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751169AbeBQKuu (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 05:50:50 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:57678 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751036AbeBQKut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 05:50:49 -0500
Date: Sat, 17 Feb 2018 11:50:52 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>
cc: Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Wanpeng Li <kernellwp@gmail.com>, Mike Galbraith <efault@gmx.de>,
        Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH 4/6] sched/isolation: Offload residual 1Hz scheduler
 tick
In-Reply-To: <1518655694-8057-5-git-send-email-frederic@kernel.org>
Message-ID: <alpine.DEB.2.21.1802171138001.2087@nanos.tec.linutronix.de>
References: <1518655694-8057-1-git-send-email-frederic@kernel.org> <1518655694-8057-5-git-send-email-frederic@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Feb 2018, Frederic Weisbecker wrote:

> When a CPU runs in full dynticks mode, a 1Hz tick remains in order to
> keep the scheduler stats alive. However this residual tick is a burden
> for bare metal tasks that can't stand any interruption at all, or want
> to minimize them.
> 
> The usual boot parameters "nohz_full=" or "isolcpus=nohz" will now
> outsource these scheduler ticks to the global workqueue so that a
> housekeeping CPU handles those remotely. The sched_class::task_tick()
> implementations have been audited and look safe to be called remotely
> as the target runqueue and its current task are passed in parameter
> and don't seem to be accessed locally.

That scares me a bit. Not for the current state of affairs, but we want to
ensure that this still works in 2 years from now

So at least you want to add a comment to task_tick() which explains the
constraints which come with the remote tick.

Other than that this looks good!

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
