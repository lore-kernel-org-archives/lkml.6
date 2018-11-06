Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B225FC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 08:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C32B2085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 08:41:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C32B2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730077AbeKFSFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 13:05:45 -0500
Received: from outbound-smtp26.blacknight.com ([81.17.249.194]:44798 "EHLO
        outbound-smtp26.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729241AbeKFSFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 13:05:45 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp26.blacknight.com (Postfix) with ESMTPS id 10155B8945
        for <linux-kernel@vger.kernel.org>; Tue,  6 Nov 2018 08:41:36 +0000 (GMT)
Received: (qmail 22382 invoked from network); 6 Nov 2018 08:41:36 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.229.69])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 6 Nov 2018 08:41:35 -0000
Date:   Tue, 6 Nov 2018 08:41:34 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Subhra Mazumdar <subhra.mazumdar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        tglx@linutronix.de, dhaval.giani@oracle.com,
        steven.sistare@oracle.com, Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC PATCH v2 1/1] pipe: busy wait for pipe
Message-ID: <20181106084134.GJ23537@techsingularity.net>
References: <20180925233240.24451-1-subhra.mazumdar@oracle.com>
 <20180925233240.24451-2-subhra.mazumdar@oracle.com>
 <20181105100841.GG23537@techsingularity.net>
 <e750e230-a49b-de61-86f1-25dc47170d18@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <e750e230-a49b-de61-86f1-25dc47170d18@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 03:40:40PM -0800, Subhra Mazumdar wrote:
> 
> On 11/5/18 2:08 AM, Mel Gorman wrote:
> > Adding Al Viro as per get_maintainers.pl.
> > 
> > On Tue, Sep 25, 2018 at 04:32:40PM -0700, subhra mazumdar wrote:
> > > Introduce pipe_ll_usec field for pipes that indicates the amount of micro
> > > seconds a thread should spin if pipe is empty or full before sleeping. This
> > > is similar to network sockets.
> > Can you point to what pattern from network sockets you are duplicated
> > exactly? One would assume it's busy_loop_current_time and busy_loop_timeout
> > but it should be in the changelog because there are differences in polling
> > depending on where you are in the network subsystem (which I'm not very
> > familiar with).
> I was referring to the sk_busy_loop_timeout() that uses sk_ll_usec. By
> similar I meant having a similar mechanism for pipes to busy wait

Expand that in the changelog.

> > > Workloads like hackbench in pipe mode
> > > benefits significantly from this by avoiding the sleep and wakeup overhead.
> > > Other similar usecases can benefit. A tunable pipe_busy_poll is introduced
> > > to enable or disable busy waiting via /proc. The value of it specifies the
> > > amount of spin in microseconds. Default value is 0 indicating no spin.
> > > 
> > Your lead mail indicates the spin was set to a "suitable spin time". How
> > should an administrator select this spin time? What works for hackbench
> > might not be suitable for another workload. What if the spin time
> > selected happens to be just slightly longer than the time it takes the
> > reader to respond? In such a case, the result would be "all spin, no
> > gain". While networking potentially suffers the same problem, it appears
> > to be opt-in per socket so it's up to the application not to shoot
> > itself in the foot.
>
> Even for network, sk_ll_usec is assigned the value of the tunable
> sysctl_net_busy_read in sock_init_data() for all sockets initialized by
> default. There is way for per socket setting using sock_setsockopt(), for
> pipes that can be added later if needed in case of different apps running
> in one system. But there are cases where only one app runs (e.g big DBs)
> and one tunable will suffice. It can be set to a value that is tested to be
> beneficial under the operating conditions.

While sockets have an existing API to alter the polling interval, I don't
think pipes do and it's not clear what API should be used. fcntl would
be a candidate I guess but that would need careful review. If this is
in error, expand upon it in the changelog. Otherwise it'll have to be
considered what happens for applications that has a default setting for
one app that is detrimental to others.

> > > @@ -106,6 +108,7 @@ void pipe_double_lock(struct pipe_inode_info *pipe1,
> > >   void pipe_wait(struct pipe_inode_info *pipe)
> > >   {
> > >   	DEFINE_WAIT(wait);
> > > +	u64 start;
> > >   	/*
> > >   	 * Pipes are system-local resources, so sleeping on them
> > > @@ -113,6 +116,10 @@ void pipe_wait(struct pipe_inode_info *pipe)
> > >   	 */
> > >   	prepare_to_wait(&pipe->wait, &wait, TASK_INTERRUPTIBLE);
> > >   	pipe_unlock(pipe);
> > > +	start = local_clock();
> > > +	while (current->state != TASK_RUNNING &&
> > > +	       ((local_clock() - start) >> 10) < pipe->pipe_ll_usec)
> > > +		cpu_relax();
> > >   	schedule();
> > >   	finish_wait(&pipe->wait, &wait);
> > >   	pipe_lock(pipe);
>
> > Networking breaks this out better in terms of options instead of
> > hard-coding. This does not handle need_resched or signal delivery
> > properly where as networking does for example.
>
> I don't disable preemption, so don't think checking need_resched is needed.

With either preemption disabled in the config or a preemption point,
this can loop when it should be rescheduling. While it's unlikely to
trigger a soft lockup unless the spin interval is set to a stupidly high
value, it still should be accounted for.

> Can you point to what you mean by handling signal delivery in case of
> networking? Not sure what I am missing. My initial version broke it out
> like networking but after Peter's suggestion I clubbed it. I don't feel
> strongly either way.

It's checked in sk_can_busy_loop(). Again, may or may not be relevant
but it should be explained why signal delivery and the need for
scheduling is not checked in either the changelog or the comments.

> > 
> > > @@ -825,6 +832,7 @@ static int do_pipe2(int __user *fildes, int flags)
> > >   	struct file *files[2];
> > >   	int fd[2];
> > >   	int error;
> > > +	struct pipe_inode_info *pipe;
> > >   	error = __do_pipe_flags(fd, files, flags);
> > >   	if (!error) {
> > > @@ -838,6 +846,10 @@ static int do_pipe2(int __user *fildes, int flags)
> > >   			fd_install(fd[0], files[0]);
> > >   			fd_install(fd[1], files[1]);
> > >   		}
> > > +		pipe = files[0]->private_data;
> > > +		pipe->pipe_ll_usec = pipe_busy_poll;
> > > +		pipe = files[1]->private_data;
> > > +		pipe->pipe_ll_usec = pipe_busy_poll;
> > >   	}
> > >   	return error;
> > >   }
> > You add a pipe field but the value in always based on the sysctl
> > so the information is redundantu (barring a race condition on one
> > pipe write per sysctl update which is an irrelevant corner case). In
> > comparison, the network subsystem appears to be explicitly opt-in via
> > setsockopt(SO_BUSY_POLL) from a glance and the value appears to be tunable
> > on a per-socket basis (I didn't check for sure, this is based on a glance
> > at what networking does). It's not clear what a sensible way of replicating
> > that for pipe file descriptors would be but it's possible that the only
> > way would be to define the system-wide tunable as a max spin time and try
> > detect the optimal spin time on a per-fd basis (not entirely dissimilar
> > to how cpuidle menu guesses how long it'll be in an idle state for).
>
> As I said above even networking assigns the global tunable value to each
> socket during initialization.

But it's an invariant in your pipe patch so why carry it now when it
can't be changed from userspace?

> Trying to detect an optimal spin time will
> be extremely difficult, I had tried a lot of heuristics but doesn't quite
> work under all workloads/utilization level. This change also doesn't
> preclude such work in future. In mean time some workloads can benefit from
> straight forward constant tunable setting.

It would be preferred if there was some guideline on how and when it
should be used. As the patch stands, there isn't even documentation on
the existance of the tunable, let alone how or when it should be used.

> > It's not really my area but I feel that this patch is a benchmark-specific
> > hack and that tuning it on a system-wide basis will be a game of "win
> > some, lose some" that is never used in practice. Worse, it might end up
> > in a tuning guide as "always set this sysctl" without considering the
> > capabilities of the machine or the workload and falls victim to cargo
> > cult tuning.
> > 
> It is 0 by default so no spin.

Which also means that it's dead code by default and given its
undocumented nature, it's hard to see whether anyone would even notice.

> Workloads that do set this should know what
> they are doing and if it's beneficial. I will try DB OLTP workload to see
> any benefits.
> 

This should be a given because if this is aimed at DB OLTP workloads,
then there should at least be one example showing that DB OLTP workloads
even benefit and are bound to the performance of pipe and not the more
obvious candidate -- sockets.

Thanks!

-- 
Mel Gorman
SUSE Labs
