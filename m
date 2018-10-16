Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A581C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1984320869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:24:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1984320869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbeJPVPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 17:15:01 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58133 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbeJPVPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 17:15:00 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gCPKR-0005u6-47; Tue, 16 Oct 2018 15:24:07 +0200
Date:   Tue, 16 Oct 2018 15:24:06 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     syzbot <syzbot+385468161961cee80c31@syzkaller.appspotmail.com>
cc:     Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com,
        nstange@suse.de, syzkaller-bugs@googlegroups.com, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: INFO: rcu detected stall in do_idle
In-Reply-To: <000000000000a4ee200578172fde@google.com>
Message-ID: <alpine.DEB.2.21.1810161516430.7787@nanos.tec.linutronix.de>
References: <000000000000a4ee200578172fde@google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Oct 2018, syzbot wrote:
> syzbot found the following crash on:
> 
> HEAD commit:    6b3944e42e2e afs: Fix cell proc list
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1545a479400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=88e9a8a39dc0be2d
> dashboard link: https://syzkaller.appspot.com/bug?extid=385468161961cee80c31
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14825d5e400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=122cc531400000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+385468161961cee80c31@syzkaller.appspotmail.com
> 
> sshd (5193) used greatest stack depth: 15496 bytes left
> sched: DL replenish lagged too much
> hrtimer: interrupt took 417330 ns
> rcu: INFO: rcu_sched detected stalls on CPUs/tasks:

It does reproduce here but with a kworker stall. Looking at the reproducer:

  *(uint32_t*)0x20000000 = 0;
  *(uint32_t*)0x20000004 = 6;
  *(uint64_t*)0x20000008 = 0;
  *(uint32_t*)0x20000010 = 0;
  *(uint32_t*)0x20000014 = 0;
  *(uint64_t*)0x20000018 = 0x9917;
  *(uint64_t*)0x20000020 = 0xffff;
  *(uint64_t*)0x20000028 = 0;
  syscall(__NR_sched_setattr, 0, 0x20000000, 0);

which means:

  struct sched_attr {
  	 .size		= 0,
	 .policy	= 6,
	 .flags		= 0,
	 .nice		= 0,
	 .priority	= 0,
	 .deadline	= 0x9917,
	 .runtime	= 0xffff,
	 .period	= 0,
  }

policy 6 is SCHED_DEADLINE

That makes the thread hog the CPU and prevents all kind of stuff to run.

Peter, is that expected behaviour?

Thanks,

	tglx
