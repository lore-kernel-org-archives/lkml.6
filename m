Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C66C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 04:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA725208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 04:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/cqJOpE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA725208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731468AbeKTOhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 09:37:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:60816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727880AbeKTOhv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 09:37:51 -0500
Received: from localhost (lfbn-ncy-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC364206B2;
        Tue, 20 Nov 2018 04:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542687046;
        bh=eQ4S7S4+dURaMjQSsNhquss3rvCS2bN0w+K1346Oz9o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F/cqJOpEt6inIjT+Ha/m/g+W8AFc+JNJc7K5C1u7KqLCEFXoD4DIrzcWy9UibfISA
         H+kaGRwm5thhm6TILOjQc2L9m3rucHbPxBt7vzoILZg77pBQ9YuGbAiMspHSlqPWbb
         Jm+LliyBOc4hh0xQjUD4i91AnpFNH/3PEUmaSqmY=
Date:   Tue, 20 Nov 2018 05:10:43 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     syzbot <syzbot+999bca54de2ee169c021@syzkaller.appspotmail.com>
Cc:     fweisbec@gmail.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Subject: Re: KASAN: use-after-free Read in tick_sched_handle (3)
Message-ID: <20181120041041.GA3398@lerouge>
References: <0000000000007829c8057b0b58ed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000007829c8057b0b58ed@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 01:39:02PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    bae4e109837b mlxsw: spectrum: Expose discard counters via ..
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=11b5e77b400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d86f24333880b605
> dashboard link: https://syzkaller.appspot.com/bug?extid=999bca54de2ee169c021
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14b7d093400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1487a225400000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+999bca54de2ee169c021@syzkaller.appspotmail.com
> 
> IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
> IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
> 8021q: adding VLAN 0 to HW filter on device team0
> ==================================================================
> kasan: CONFIG_KASAN_INLINE enabled
> BUG: KASAN: use-after-free in tick_sched_handle+0x16c/0x180
> kernel/time/tick-sched.c:164

So tick_sched_timer() -> tick_sched_handle() is passed regs returned by
get_irq_regs() that seem to be junk.

Those regs should come from smp_apic_timer_interrupt().

Thoughts?
