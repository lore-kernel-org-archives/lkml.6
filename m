Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C643EECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7240820875
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dH3jcP/k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7240820875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388172AbeGWOQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 10:16:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:48694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388119AbeGWOQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 10:16:37 -0400
Received: from localhost (LFbn-NCY-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25C8820854;
        Mon, 23 Jul 2018 13:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532351725;
        bh=Q+4sVVvqvsi9t0x3445fz5WFnYmmWue39NfOP809zO4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dH3jcP/k/z+HPUmD6nvs3Au3lqHm/0z2c9O1kzabnTlvZVzMNSFJNLNbRyDoM3kwN
         gW/Kcuknc7oMXLPTeHvQ0z2xkvOxJ79amagjFiWVaCHQKviuons4rmMWyxNree86F5
         sAOkj022dTEII43DEUlIHL1866PlKICYypQX0IBg=
Date:   Mon, 23 Jul 2018 15:15:22 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Yury Norov <ynorov@caviumnetworks.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Goutham, Sunil" <Sunil.Goutham@cavium.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nohz: don't kick non-idle CPUs in
 tick_nohz_full_kick_cpu()
Message-ID: <20180723131521.GB1383@lerouge>
References: <20180712181922.23073-1-ynorov@caviumnetworks.com>
 <20180716153109.GA29270@lerouge>
 <20180719202200.GA17106@yury-thinkpad>
 <alpine.DEB.2.21.1807201916270.1694@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1807201916270.1694@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 07:24:00PM +0200, Thomas Gleixner wrote:
> On Thu, 19 Jul 2018, Yury Norov wrote:
> > While here. I just wonder, on my system IRQs are sent to nohz_full CPUs
> > at every incoming ssh connection. The trace is like this:
> > [  206.835533] Call trace:
> > [  206.848411] [<ffff00000889f984>] dump_stack+0x84/0xa8
> > [  206.853455] [<ffff0000081ea308>] _task_isolation_remote+0x130/0x140
> > [  206.859714] [<ffff0000081bf5ec>] irq_work_queue_on+0xcc/0xfc
> > [  206.865365] [<ffff0000081478ac>] tick_nohz_full_kick_cpu+0x88/0x94
> > [  206.871536] [<ffff000008147930>] tick_nohz_dep_set_all+0x78/0xa8
> > [  206.877533] [<ffff000008147b58>] tick_nohz_dep_set_signal+0x28/0x34
> > [  206.883792] [<ffff0000081421fc>] set_process_cpu_timer+0xd0/0x128
> > [  206.889876] [<ffff0000081422ac>] update_rlimit_cpu+0x58/0x7c
> > [  206.895528] [<ffff0000083aa3d0>] selinux_bprm_committing_creds+0x180/0x1fc
> > [  206.902394] [<ffff00000839e394>] security_bprm_committing_creds+0x40/0x5c
> > [  206.909173] [<ffff00000828c4a0>] install_exec_creds+0x20/0x6c
> > [  206.914911] [<ffff0000082e15b0>] load_elf_binary+0x368/0xbb8
> > [  206.920561] [<ffff00000828d09c>] search_binary_handler+0xb8/0x224
> > [  206.926645] [<ffff00000828d99c>] do_execveat_common+0x44c/0x5f0
> > [  206.932555] [<ffff00000828db78>] do_execve+0x38/0x44
> > [  206.937510] [<ffff00000828dd74>] SyS_execve+0x34/0x44
> > 
> > I suspect that scp, ssh tunneling and similar network activities will source 
> > ticks on nohz_full CPUs as well. On high-loaded server it may generate
> > significant interrupt traffic on nohz_full CPUs. Is it desirable behavior?
> 
> Supsicions and desirable are not really technical interesting aspects.
> 
> Just from looking at the stack trace it's obvious that there is a CPU TIME
> rlimit on that newly spawned sshd. That's nothing what the kernel
> imposes. That's what user space sets.
> 
> Now the actual mechanism which does that, i.e. set_process_cpu_timer() ends
> up IPI'ing _ALL_ nohz full CPUs for no real good reason. In the exec path
> this is really pointless because the new process is not running yet and it
> is single threaded. So forcing a IPI to all cpus is pretty pointless.
> 
> In fact the state of the task/process for which update_rlimit_cpu(() is
> called is known, so the IPI can really be either avoided completely or
> restricted to the CPUs on which this process can run or actually runs.
> 
> Fredric?

Indeed, so far the tick dependency code is lazy and IPIs everywhere when we
add either a thread or a process timer.

We want to make sure that any thread target, running somewhere without a tick,
sees the new tick dependency.

So in the case a single thread, I can easily fix that and IPI the CPU it's running
in if any. In the case of a thread group, I'm concerned about the performance
penalty to walk through each of them and IPI only those running. But probably we'll
have to come into that in the end.

Thanks.
