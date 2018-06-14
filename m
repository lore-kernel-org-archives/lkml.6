Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B7CA6C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A43D208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:47:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A43D208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755402AbeFNNrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 09:47:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:40518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754967AbeFNNru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 09:47:50 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C302220020;
        Thu, 14 Jun 2018 13:47:48 +0000 (UTC)
Date:   Thu, 14 Jun 2018 09:47:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v4 1/5] sched/topology: Add check to backup comment
 about hotplug lock
Message-ID: <20180614094747.390357ec@gandalf.local.home>
In-Reply-To: <20180614134234.GC12032@localhost.localdomain>
References: <20180613121711.5018-1-juri.lelli@redhat.com>
        <20180613121711.5018-2-juri.lelli@redhat.com>
        <20180614093324.7ea45448@gandalf.local.home>
        <20180614134234.GC12032@localhost.localdomain>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jun 2018 15:42:34 +0200
Juri Lelli <juri.lelli@redhat.com> wrote:

> On 14/06/18 09:33, Steven Rostedt wrote:
> > On Wed, 13 Jun 2018 14:17:07 +0200
> > Juri Lelli <juri.lelli@redhat.com> wrote:
> >   
> > > From: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > 
> > > The comment above function partition_sched_domains() clearly state that
> > > the cpu_hotplug_lock should be held but doesn't mandate one to abide to
> > > it.
> > > 
> > > Add an explicit check backing that comment, so to make it impossible
> > > for anyone to miss the requirement.
> > > 
> > > Suggested-by: Juri Lelli <juri.lelli@redhat.com>
> > > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > [modified changelog]
> > > Signed-off-by: Juri Lelli <juri.lelli@redhat.com>  
> > 
> > Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > 
> > -- Steve
> >   
> > > ---
> > >  kernel/sched/topology.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > > index 61a1125c1ae4..96eee22fafe8 100644
> > > --- a/kernel/sched/topology.c
> > > +++ b/kernel/sched/topology.c
> > > @@ -1858,6 +1858,7 @@ void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
> > >  	int i, j, n;
> > >  	int new_topology;
> > >  
> > > +	lockdep_assert_cpus_held();
> > >  	mutex_lock(&sched_domains_mutex);
> > >  
> > >  	/* Always unregister in case we don't destroy any domains: */  
> 
> Thanks for reviewing Steve. I thought this should be fine (also looking
> at the comment before the function), but then got this from 0day
> 
> [    2.206129] .................................... done.
> [    2.206662] Using IPI No-Shortcut mode
> [    2.207084] sched_clock: Marking stable (2200014216, 0)->(2435550722, -235536506)
> [    2.208792] registered taskstats version 1
> [    2.209251] page_owner is disabled
> [    2.290164] WARNING: CPU: 0 PID: 13 at kernel/cpu.c:311 lockdep_assert_cpus_held+0x22/0x26
> [    2.291253] Modules linked in:
> [    2.291589] CPU: 0 PID: 13 Comm: cpuhp/0 Not tainted 4.17.0-rc6-00217-gebf44b4 #2
> [    2.292367] EIP: lockdep_assert_cpus_held+0x22/0x26
> [    2.292882] EFLAGS: 00210246 CPU: 0
> [    2.293255] EAX: 00000000 EBX: 00000000 ECX: c1b1fd98 EDX: 00200286
> [    2.293915] ESI: 00000000 EDI: c1b1fcb4 EBP: dd8a3e60 ESP: dd8a3e60
> [    2.294578]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
> [    2.295128] CR0: 80050033 CR2: 00000000 CR3: 01c9d000 CR4: 000006d0
> [    2.295770] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> [    2.296409] DR6: fffe0ff0 DR7: 00000400
> [    2.296802] Call Trace:
> [    2.297066]  partition_sched_domains+0x1b/0x29f
> [    2.297557]  ? dl_cpu_busy+0x1b5/0x1c6
> [    2.297955]  sched_cpu_deactivate+0x8b/0xb6
> [    2.298403]  ? call_rcu_bh+0x17/0x17
> [    2.298786]  ? call_rcu_bh+0x17/0x17
> [    2.299170]  ? rcu_read_lock_bh_held+0x55/0x55
> [    2.299648]  ? sched_cpu_activate+0xcc/0xcc
> [    2.300076]  cpuhp_invoke_callback+0x19d/0x978
> [    2.300537]  cpuhp_thread_fun+0x125/0x16b
> [    2.300949]  smpboot_thread_fn+0x192/0x1a6
> [    2.301377]  kthread+0xfc/0x101
> [    2.301703]  ? sort_range+0x1d/0x1d
> [    2.302062]  ? kthread_flush_work_fn+0x12/0x12
> [    2.302524]  ret_from_fork+0x2e/0x40
> [    2.302891] Code: ff 83 c4 10 5b 5e 5f 5d c3 55 89 e5 e8 ca dc fe ff 83 3d 20 bc b4 c1 00 74 13 83 ca ff b8 98 fd b1 c1 e8 e2 4b 04 00 85 c0 75 02 <0f> 0b 5d c3 55 89 e5 56 53 e8 a2 dc fe ff 89 c6 3b 05 8c 40 bd 
> [    2.304975] irq event stamp: 308
> [    2.305335] hardirqs last  enabled at (307): [<c179d83c>] _raw_spin_unlock_irqrestore+0x4a/0x68
> [    2.306195] hardirqs last disabled at (308): [<c179ed38>] common_exception+0x46/0x6e
> [    2.306969] softirqs last  enabled at (0): [<c10448e6>] copy_process+0x582/0x16c5
> [    2.307720] softirqs last disabled at (0): [<00000000>]   (null)
> [    2.308328] ---[ end trace 7197acb79221f1b9 ]---
> 
> Guess early boot is "special"? :-/

I'm guessing the comment is wrong. I just added the first three patches
and was going to try to trigger the first "bug" I had before. Let me
check if I have lockdep enabled and see if I see the same thing.

-- Steve

