Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752247AbeEVTK1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 15:10:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54178 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751533AbeEVTK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 15:10:26 -0400
From: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Luiz Capitulino <lcapitulino@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Thomas Gleixner <tglx@linutronix.de>, Christoph Lameter <cl@linux.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Wanpeng Li <kernellwp@gmail.com>, Mike Galbraith <efault@gmx.de>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [GIT PULL] isolation: 1Hz residual tick offloading v4
References: <1516320140-13189-1-git-send-email-frederic@kernel.org>
        <20180124104608.038fb212@redhat.com> <20180129011024.GA2942@lerouge>
Date: Tue, 22 May 2018 22:10:19 +0300
In-Reply-To: <20180129011024.GA2942@lerouge> (Frederic Weisbecker's message of
        "Mon, 29 Jan 2018 02:10:26 +0100")
Message-ID: <xunyvabfjylg.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Frederic!

>>>>> On Mon, 29 Jan 2018 02:10:26 +0100, Frederic Weisbecker  wrote:
 > On Wed, Jan 24, 2018 at 10:46:08AM -0500, Luiz Capitulino wrote:

[...]

 >> Since the 1Hz tick offload worked for you, I must be missing
 >> a way to disable this timer or the kernel is thinking my CPU
 >> has unstable TSC (which it doesn't AFAIK).

 > It's beyond the scope of this patchset but indeed that's
 > right, I run my kernels with tsc=reliable because my CPUs
 > don't have the TSC_RELIABLE flag.  That's the only way I found
 > to shutdown the tick completely on my test machine, otherwise
 > I keep having that clocksource watchdog.

[...]

Thanks, it helps. But I have accounting problem:

if I run user busy loop on the nohz cpu, the task accounting works
correctly (top shows the task takes 100% cpu), but cpu accounting is
wrong (cpu is 100% idle, in the per-core view as well).

If I understand correctly, the stats are updated by account_user_time()
-> task_group_account_field() but there is no call for it in case of
offloading (it is called from irqtime_account_process_tick,
account_process_tick, vtime_user_exit).

Moreover, task_group_account_field() uses __this_cpu_add() which will be
wrong for offloading.

For testing I used kcpustat_cpu(task_cpu(p)) in
task_group_account_field() and added call account_user_time(curr, delta)
to the sched_tick_remote() what fixes it for me, but what would be the
proper fix?

-- 
WBR,
Yauheni Kaliuta
