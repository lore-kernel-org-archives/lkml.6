Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70028ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E0E320647
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:24:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E0E320647
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388065AbeGTSN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 14:13:26 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:37543 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731556AbeGTSNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 14:13:25 -0400
Received: from p4fea5a5a.dip0.t-ipconnect.de ([79.234.90.90] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fgZ8P-0008D2-0s; Fri, 20 Jul 2018 19:24:05 +0200
Date:   Fri, 20 Jul 2018 19:24:00 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Yury Norov <ynorov@caviumnetworks.com>
cc:     Frederic Weisbecker <frederic@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Goutham, Sunil" <Sunil.Goutham@cavium.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nohz: don't kick non-idle CPUs in
 tick_nohz_full_kick_cpu()
In-Reply-To: <20180719202200.GA17106@yury-thinkpad>
Message-ID: <alpine.DEB.2.21.1807201916270.1694@nanos.tec.linutronix.de>
References: <20180712181922.23073-1-ynorov@caviumnetworks.com> <20180716153109.GA29270@lerouge> <20180719202200.GA17106@yury-thinkpad>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jul 2018, Yury Norov wrote:
> While here. I just wonder, on my system IRQs are sent to nohz_full CPUs
> at every incoming ssh connection. The trace is like this:
> [  206.835533] Call trace:
> [  206.848411] [<ffff00000889f984>] dump_stack+0x84/0xa8
> [  206.853455] [<ffff0000081ea308>] _task_isolation_remote+0x130/0x140
> [  206.859714] [<ffff0000081bf5ec>] irq_work_queue_on+0xcc/0xfc
> [  206.865365] [<ffff0000081478ac>] tick_nohz_full_kick_cpu+0x88/0x94
> [  206.871536] [<ffff000008147930>] tick_nohz_dep_set_all+0x78/0xa8
> [  206.877533] [<ffff000008147b58>] tick_nohz_dep_set_signal+0x28/0x34
> [  206.883792] [<ffff0000081421fc>] set_process_cpu_timer+0xd0/0x128
> [  206.889876] [<ffff0000081422ac>] update_rlimit_cpu+0x58/0x7c
> [  206.895528] [<ffff0000083aa3d0>] selinux_bprm_committing_creds+0x180/0x1fc
> [  206.902394] [<ffff00000839e394>] security_bprm_committing_creds+0x40/0x5c
> [  206.909173] [<ffff00000828c4a0>] install_exec_creds+0x20/0x6c
> [  206.914911] [<ffff0000082e15b0>] load_elf_binary+0x368/0xbb8
> [  206.920561] [<ffff00000828d09c>] search_binary_handler+0xb8/0x224
> [  206.926645] [<ffff00000828d99c>] do_execveat_common+0x44c/0x5f0
> [  206.932555] [<ffff00000828db78>] do_execve+0x38/0x44
> [  206.937510] [<ffff00000828dd74>] SyS_execve+0x34/0x44
> 
> I suspect that scp, ssh tunneling and similar network activities will source 
> ticks on nohz_full CPUs as well. On high-loaded server it may generate
> significant interrupt traffic on nohz_full CPUs. Is it desirable behavior?

Supsicions and desirable are not really technical interesting aspects.

Just from looking at the stack trace it's obvious that there is a CPU TIME
rlimit on that newly spawned sshd. That's nothing what the kernel
imposes. That's what user space sets.

Now the actual mechanism which does that, i.e. set_process_cpu_timer() ends
up IPI'ing _ALL_ nohz full CPUs for no real good reason. In the exec path
this is really pointless because the new process is not running yet and it
is single threaded. So forcing a IPI to all cpus is pretty pointless.

In fact the state of the task/process for which update_rlimit_cpu(() is
called is known, so the IPI can really be either avoided completely or
restricted to the CPUs on which this process can run or actually runs.

Fredric?

Thanks,

	tglx
