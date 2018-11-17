Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7819C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 14:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77F772080F
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 14:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VWoeA2/x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77F772080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbeKRBJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 20:09:46 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:35012 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbeKRBJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 20:09:45 -0500
Received: by mail-io1-f68.google.com with SMTP id u19so15036193ioc.2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Nov 2018 06:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l765Y4fHr/Clv6uQpIgoZWfg1D99hPbIf3LJUuaU2p4=;
        b=VWoeA2/xYagMcGxEp6ScHUUt7Jb77hbFBqRhbeMqFsy2cSKjp+hdMtZvS7XTzu3gDG
         jSvROZ2bztxaUPe41DDDnXXN/OM/xQ/vD9PP2bmatCJZkwTukGCDdcqheqNxJscaAUtE
         PvW0RfjSsghp56zklk3ee7XY6yvqowj3FMpCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l765Y4fHr/Clv6uQpIgoZWfg1D99hPbIf3LJUuaU2p4=;
        b=icc9nE4DMJSjsqaVUvGeI0M2xmeJIPxd35J/699xzch1Io3CmbsSgSNm9/v3mG3TSK
         f3FroMoAbgXAvvOTrvUTlfDLnAOETOPlFmxDTEEmaI07hr7j/R7GTUAOymWjl/iQ7c2p
         HbQR33BPPomWgVeDRUMlkxKMaMio517JqAqEg0SZ7nb8fyvW2zS9ZIPSB2o3kBNWBuTc
         t3y8bgO2YGkM0yDAQhWwf13jAOgUENkwb5k76eGeg91yDVtuVpmxeOnFjZgVia0QK+bI
         7PenTnXK3XgKtPjWHv4bfclFxxw+Aqxck056JQfF2xuOG/Kr5n7Pq3d6G24Fu4m1HsMt
         RPFg==
X-Gm-Message-State: AGRZ1gK2NRZElaT6UJHs2KwGfnuZssrvN/oifsuM+rRYjqm3e2l56akP
        3JYjgoEBNJAhlxo9GGRPfYdWUkMyOVdF46m1k0Z5JA==
X-Google-Smtp-Source: AFSGD/UIrPIM0+cRbhsEQhYdZ2mK8ZJWM8i9mo0SV73aokqUXy3vullhoscVp21chcR4xS7cMSthjwDQpOA7rVIRVtI=
X-Received: by 2002:a6b:37c2:: with SMTP id e185-v6mr12296466ioa.173.1542466370265;
 Sat, 17 Nov 2018 06:52:50 -0800 (PST)
MIME-Version: 1.0
References: <000000000000710037057ad9551e@google.com>
In-Reply-To: <000000000000710037057ad9551e@google.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 17 Nov 2018 06:52:38 -0800
Message-ID: <CAKv+Gu8tJZUgL7q0R2KvGdyK+_y1U7KHQNDMpCmM7ZGprkKajg@mail.gmail.com>
Subject: Re: WARNING in static_key_disable_cpuslocked
To:     syzbot+6cffdef928852907751c@syzkaller.appspotmail.com,
        pabeni@redhat.com, "David S. Miller" <davem@davemloft.net>
Cc:     Borislav Petkov <bp@suse.de>, Jason Baron <jbaron@akamai.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(+ Paolo, Dave)

On Sat, 17 Nov 2018 at 01:59, syzbot
<syzbot+6cffdef928852907751c@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    442b8cea2477 Add linux-next specific files for 20181109
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=11f1dc25400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2f72bdb11df9fbe8
> dashboard link: https://syzkaller.appspot.com/bug?extid=6cffdef928852907751c
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10126533400000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+6cffdef928852907751c@syzkaller.appspotmail.com
>
> IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
> IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
> 8021q: adding VLAN 0 to HW filter on device team0
> 8021q: adding VLAN 0 to HW filter on device team0
> hrtimer: interrupt took 32101 ns
> WARNING: CPU: 0 PID: 7564 at kernel/jump_label.c:188
> static_key_disable_cpuslocked+0x2bb/0x310 kernel/jump_label.c:188
> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 0 PID: 7564 Comm: syz-executor2 Not tainted 4.20.0-rc1-next-20181109+
> #110
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x244/0x39d lib/dump_stack.c:113
>   panic+0x2ad/0x55c kernel/panic.c:188
>   __warn.cold.8+0x20/0x45 kernel/panic.c:540
>   report_bug+0x254/0x2d0 lib/bug.c:186
>   fixup_bug arch/x86/kernel/traps.c:178 [inline]
>   do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
>   do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:290
>   invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:969
> RIP: 0010:static_key_disable_cpuslocked+0x2bb/0x310 kernel/jump_label.c:188
> Code: ff eb db e8 07 da e3 ff 48 89 da 48 c7 c6 00 bf 31 88 48 c7 c7 e0 bb
> 31 88 e8 71 0d ad ff 0f 0b e9 0e fe ff ff e8 e5 d9 e3 ff <0f> 0b e9 2b ff
> ff ff 4c 89 f7 e8 56 32 27 00 e9 5e fe ff ff 48 89
> RSP: 0018:ffff8801ba2b7928 EFLAGS: 00010293
> RAX: ffff8801bb558340 RBX: 00000000ffffffff RCX: ffffffff819bcdf5
> RDX: 0000000000000000 RSI: ffffffff819bcecb RDI: 0000000000000005
> RBP: ffff8801ba2b79f0 R08: ffff8801bb558340 R09: fffffbfff17885c4
> R10: fffffbfff17885c4 R11: ffffffff8bc42e23 R12: 1ffff10037456f25
> R13: 1ffff10037456f31 R14: dffffc0000000000 R15: ffff8801ba2b79c8
>   static_key_disable+0x1a/0x30 kernel/jump_label.c:202
>   udpv6_destroy_sock+0x1e3/0x220 net/ipv6/udp.c:1492
>   sk_common_release+0x6d/0x320 net/core/sock.c:3001
>   udp_lib_close+0x15/0x20 include/net/udp.h:206
>   inet_release+0x104/0x1f0 net/ipv4/af_inet.c:428
>   inet6_release+0x50/0x70 net/ipv6/af_inet6.c:458
>   __sock_release+0xd7/0x250 net/socket.c:580
>   sock_close+0x19/0x20 net/socket.c:1142
>   __fput+0x3bc/0xa70 fs/file_table.c:279
>   ____fput+0x15/0x20 fs/file_table.c:312
>   task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
>   tracehook_notify_resume include/linux/tracehook.h:188 [inline]
>   exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
>   prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
>   syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
>   do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x411021
> Code: 75 14 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 34 19 00 00 c3 48
> 83 ec 08 e8 0a fc ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b 3c 24 48
> 89 c2 e8 53 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
> RSP: 002b:00007ffeb03ec0a0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
> RAX: 0000000000000000 RBX: 0000000000000004 RCX: 0000000000411021
> RDX: 0000000000000001 RSI: 0000000000731ce8 RDI: 0000000000000003
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 00007ffeb03ebfd0 R11: 0000000000000293 R12: 0000000000000000
> R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000002
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
> syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
