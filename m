Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932944AbeEWNFW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 09:05:22 -0400
Received: from foss.arm.com ([217.140.101.70]:54874 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932089AbeEWNFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 09:05:21 -0400
Date: Wed, 23 May 2018 14:05:48 +0100
From: Will Deacon <will.deacon@arm.com>
To: Sodagudi Prasad <psodagud@codeaurora.org>
Cc: keescook@chromium.org, luto@amacapital.net, wad@chromium.org,
        akpm@linux-foundation.org, riel@redhat.com, tglx@linutronix.de,
        mingo@kernel.org, peterz@infradead.org, ebiggers@google.com,
        fweisbec@gmail.com, sherryy@android.com, vegard.nossum@oracle.com,
        cl@linux.com, aarcange@redhat.com, alexander.levin@verizon.com,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: write_lock_irq(&tasklist_lock)
Message-ID: <20180523130547.GF26965@arm.com>
References: <0879f797135033e05e8e9166a3c85628@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0879f797135033e05e8e9166a3c85628@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prasad,

On Tue, May 22, 2018 at 12:40:05PM -0700, Sodagudi Prasad wrote:
> When following test is executed on 4.14.41 stable kernel, observed that one
> of the core is waiting for tasklist_lock for long time with IRQs disabled.
> ./stress-ng-64 --get 8 -t 3h --times --metrics-brief
> 
> Every time when device is crashed, I observed that one the task stuck at
> fork system call and waiting for tasklist_lock as writer with irq disabled.
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/tree/kernel/fork.c?h=linux-4.14.y#n1843

Please use a newer kernel. We've addressed this in mainline by moving
arm64 over to the qrwlock implementation which (after some other changes)
guarantees forward progress for well-behaved readers and writers.

To give an example from locktorture with 2 writers and 8 readers, after
a few seconds I see:

rwlock:
	Writes:	Total: 6725	Max/Min: 0/0	Fail: 0
	Reads:	Total: 5103727	Max/Min: 0/0	Fail: 0

qrwlock:
	Writes:	Total: 155284	Max/Min: 0/0	Fail: 0
	Reads:	Total: 767703	Max/Min: 0/0	Fail: 0

so the ratio is closer to ~6:1 rather than ~191:1 for this case. The
total locking throughput has dropped, but that's expected for this type
of lock where maximum throughput would be achieved by favouring readers.

Will
