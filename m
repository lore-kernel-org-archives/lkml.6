Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id crioDfP/Gls5EwAAmS7hNA
	; Fri, 08 Jun 2018 22:15:15 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2573F607E7; Fri,  8 Jun 2018 22:15:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 927C4606FA;
	Fri,  8 Jun 2018 22:15:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 927C4606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753122AbeFHWPL (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 18:15:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43232 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752946AbeFHWPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 18:15:10 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 80BC62C;
        Fri,  8 Jun 2018 22:15:09 +0000 (UTC)
Date: Fri, 8 Jun 2018 15:15:08 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: mlen@mlen.pl
Cc: bugzilla-daemon@bugzilla.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [Bug 199965] New: Memory management: BUG in kernel_restart
Message-Id: <20180608151508.d0c250db2a0900d4ebb2b115@linux-foundation.org>
In-Reply-To: <bug-199965-27@https.bugzilla.kernel.org/>
References: <bug-199965-27@https.bugzilla.kernel.org/>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

On Thu, 07 Jun 2018 18:21:24 +0000 bugzilla-daemon@bugzilla.kernel.org wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=199965
> 
>             Bug ID: 199965
>            Summary: Memory management: BUG in kernel_restart
>            Product: Memory Management
>            Version: 2.5
>     Kernel Version: 4.17.0
>           Hardware: All
>                 OS: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Other
>           Assignee: akpm@linux-foundation.org
>           Reporter: mlen@mlen.pl
>         Regression: No
> 
> Reboot randomly fails on 4.17.0 due to memory management issues. Worked fine on
> 4.16.13

Oh gee, there isn't much to go on here.  Unknown kobject on
devices_kset() is in a crappy state during kernel restart.  Greg, is
there something we can do to make that kobject_get() warning more
informative?  Probably not.


> <4>[21100.397182] ------------[ cut here ]------------
> <4>[21100.397185] kobject: '(null)' (0000000047d32b91): is not initialized, yet
> kobject_get() is being called.
> <4>[21100.397209] WARNING: CPU: 1 PID: 25848 at lib/kobject.c:593
> kobject_get+0x21/0x32
> <4>[21100.397211] Modules linked in:
> <4>[21100.397215] CPU: 1 PID: 25848 Comm: reboot Not tainted 4.17.0-gentoo #2
> <4>[21100.397217] Hardware name: ASUSTeK COMPUTER INC. Z10PE-D16 WS/Z10PE-D16
> WS, BIOS 3407 03/10/2017
> <4>[21100.397219] RIP: 0010:kobject_get+0x21/0x32
> <4>[21100.397220] RSP: 0018:ffffa6c6cd9d3db0 EFLAGS: 00010296
> <4>[21100.397223] RAX: 0000000000000000 RBX: ffff8d6af5012da8 RCX:
> 0000000000000002
> <4>[21100.397225] RDX: 0000000000000003 RSI: 0000000000000003 RDI:
> 00000000ffffffff
> <4>[21100.397227] RBP: ffff8d6af3dc9800 R08: 0000baada7db872a R09:
> ffff8d69a1bc5cd8
> <4>[21100.397228] R10: ffffa6c6cd9d3ce8 R11: ffffffffa7264f7d R12:
> ffff8d6af50099a0
> <4>[21100.397230] R13: ffffffffa57dfb43 R14: ffff8d6af3dc8060 R15:
> 0000000000000000
> <4>[21100.397232] FS:  00007efef9e42500(0000) GS:ffff8d6afd800000(0000)
> knlGS:0000000000000000
> <4>[21100.397233] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> <4>[21100.397235] CR2: 0000561f1e29c4d8 CR3: 00000010277fc005 CR4:
> 00000000003606e0
> <4>[21100.397237] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> <4>[21100.397238] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> <4>[21100.397240] Call Trace:
> <4>[21100.397246]  get_device+0x16/0x1b
> <4>[21100.397249]  device_shutdown+0x48/0x1a3
> <4>[21100.397256]  kernel_restart+0xe/0x4d
> <4>[21100.397259]  __do_sys_reboot+0x168/0x1c5
> <4>[21100.397264]  ? sched_clock_cpu+0x10/0xb4
> <4>[21100.397266]  ? sched_clock_cpu+0x10/0xb4
> <4>[21100.397270]  ? cycles_2_ns+0x55/0x75
> <4>[21100.397276]  ? task_work_run+0x63/0x8a
> <4>[21100.397284]  ? _raw_spin_unlock_irq+0x2f/0x41
> <4>[21100.397287]  ? task_work_run+0x63/0x8a
> <4>[21100.397292]  do_syscall_64+0x5e/0x6c
> <4>[21100.397295]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> <4>[21100.397298] RIP: 0033:0x7efef99840f7
> <4>[21100.397299] RSP: 002b:00007fff75e04590 EFLAGS: 00000246 ORIG_RAX:
> 00000000000000a9
> <4>[21100.397303] RAX: ffffffffffffffda RBX: 0000561f1d0c8bf0 RCX:
> 00007efef99840f7
> <4>[21100.397305] RDX: 0000000001234567 RSI: 0000000028121969 RDI:
> 00000000fee1dead
> <4>[21100.397306] RBP: 00007fff75e046f8 R08: 00007efef9e42500 R09:
> 00007fff75e04439
> <4>[21100.397308] R10: 00000000000002f4 R11: 0000000000000246 R12:
> 0000000000000002
> <4>[21100.397310] R13: 0000000000000000 R14: 0000000000000000 R15:
> 0000000000000000
> <4>[21100.397319] Code: f0 0f b1 0a 75 d5 48 89 f8 c3 48 85 ff 53 48 89 fb 74
> 24 f6 47 3c 01 75 14 48 8b 37 48 89 fa 48 c7 c7 98 3f 85 a5 e8 a5 70 4e ff <0f>
> 0b f0 ff 43 38 0f 88 03 f6 00 00 48 89 d8 5b c3 e9 88 1f 64 
> <4>[21100.397399] ---[ end trace 734263fa4c996033 ]---
> <3>[21100.397402] INFO: trying to register non-static key.
> <3>[21100.398065] the code is fine but needs lockdep annotation.
> <3>[21100.399007] turning off the locking correctness validator.
> <4>[21100.399628] CPU: 1 PID: 25848 Comm: reboot Tainted: G        W        
> 4.17.0-gentoo #2
> <4>[21100.400270] Hardware name: ASUSTeK COMPUTER INC. Z10PE-D16 WS/Z10PE-D16
> WS, BIOS 3407 03/10/2017
> <4>[21100.400923] Call Trace:
> <4>[21100.401573]  dump_stack+0x46/0x59
> <4>[21100.402227]  register_lock_class+0x192/0x361
> <4>[21100.402886]  __lock_acquire.isra.32+0x97/0x595
> <4>[21100.403548]  lock_acquire+0x105/0x12e
> <4>[21100.404212]  ? device_shutdown+0x89/0x1a3
> <4>[21100.404879]  ? wake_up_klogd+0x4f/0x61
> <4>[21100.405546]  ? device_shutdown+0x89/0x1a3
> <4>[21100.406217]  __mutex_lock+0x78/0x3a9
> <4>[21100.406892]  ? device_shutdown+0x89/0x1a3
> <4>[21100.407571]  ? device_shutdown+0x78/0x1a3
> <4>[21100.408251]  ? device_shutdown+0x89/0x1a3
> <4>[21100.408928]  device_shutdown+0x89/0x1a3
> <4>[21100.409612]  kernel_restart+0xe/0x4d
> <4>[21100.410303]  __do_sys_reboot+0x168/0x1c5
> <4>[21100.410996]  ? sched_clock_cpu+0x10/0xb4
> <4>[21100.411707]  ? sched_clock_cpu+0x10/0xb4
> <4>[21100.412398]  ? cycles_2_ns+0x55/0x75
> <4>[21100.413127]  ? task_work_run+0x63/0x8a
> <4>[21100.413818]  ? _raw_spin_unlock_irq+0x2f/0x41
> <4>[21100.414510]  ? task_work_run+0x63/0x8a
> <4>[21100.415205]  do_syscall_64+0x5e/0x6c
> <4>[21100.415900]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> <4>[21100.416603] RIP: 0033:0x7efef99840f7
> <4>[21100.417307] RSP: 002b:00007fff75e04590 EFLAGS: 00000246 ORIG_RAX:
> 00000000000000a9
> <4>[21100.418033] RAX: ffffffffffffffda RBX: 0000561f1d0c8bf0 RCX:
> 00007efef99840f7
> <4>[21100.418769] RDX: 0000000001234567 RSI: 0000000028121969 RDI:
> 00000000fee1dead
> <4>[21100.419510] RBP: 00007fff75e046f8 R08: 00007efef9e42500 R09:
> 00007fff75e04439
> <4>[21100.420257] R10: 00000000000002f4 R11: 0000000000000246 R12:
> 0000000000000002
> <4>[21100.421015] R13: 0000000000000000 R14: 0000000000000000 R15:
> 0000000000000000
> <4>[21100.421789] ------------[ cut here ]------------
> <4>[21100.422564] kobject: '(null)' (0000000047d32b91): is not initialized, yet
> kobject_put() is being called.
> <4>[21100.423378] WARNING: CPU: 1 PID: 25848 at lib/kobject.c:688
> kobject_put+0x28/0x8f
> <4>[21100.424186] Modules linked in:
> <4>[21100.424995] CPU: 1 PID: 25848 Comm: reboot Tainted: G        W        
> 4.17.0-gentoo #2
> <4>[21100.425829] Hardware name: ASUSTeK COMPUTER INC. Z10PE-D16 WS/Z10PE-D16
> WS, BIOS 3407 03/10/2017
> <4>[21100.426683] RIP: 0010:kobject_put+0x28/0x8f
> <4>[21100.427536] RSP: 0018:ffffa6c6cd9d3da8 EFLAGS: 00010286
> <4>[21100.428399] RAX: 0000000000000000 RBX: ffff8d6af5012da8 RCX:
> 0000000000000001
> <4>[21100.429278] RDX: ffff8d69a1bc5400 RSI: 0000000000000001 RDI:
> 00000000ffffffff
> <4>[21100.430165] RBP: ffff8d6af3dc9800 R08: 0000000000000001 R09:
> 0000000000000000
> <4>[21100.431057] R10: ffff8d69a1bc5400 R11: ffffffffa52a2f40 R12:
> ffff8d6af5012d98
> <4>[21100.431961] R13: ffffffffa57dfb43 R14: ffff8d6af3dc9860 R15:
> 0000000000000000
> <4>[21100.432873] FS:  00007efef9e42500(0000) GS:ffff8d6afd800000(0000)
> knlGS:0000000000000000
> <4>[21100.433808] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> <4>[21100.434745] CR2: 0000561f1e29c4d8 CR3: 00000010277fc005 CR4:
> 00000000003606e0
> <4>[21100.435697] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> <4>[21100.436663] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> <4>[21100.437618] Call Trace:
> <4>[21100.438570]  device_shutdown+0x17d/0x1a3
> <4>[21100.439530]  kernel_restart+0xe/0x4d
> <4>[21100.440495]  __do_sys_reboot+0x168/0x1c5
> <4>[21100.441467]  ? sched_clock_cpu+0x10/0xb4
> <4>[21100.442495]  ? sched_clock_cpu+0x10/0xb4
> <4>[21100.443466]  ? cycles_2_ns+0x55/0x75
> <4>[21100.444436]  ? task_work_run+0x63/0x8a
> <4>[21100.445400]  ? _raw_spin_unlock_irq+0x2f/0x41
> <4>[21100.446357]  ? task_work_run+0x63/0x8a
> <4>[21100.447305]  do_syscall_64+0x5e/0x6c
> <4>[21100.448268]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> <4>[21100.449219] RIP: 0033:0x7efef99840f7
> <4>[21100.450171] RSP: 002b:00007fff75e04590 EFLAGS: 00000246 ORIG_RAX:
> 00000000000000a9
> <4>[21100.451143] RAX: ffffffffffffffda RBX: 0000561f1d0c8bf0 RCX:
> 00007efef99840f7
> <4>[21100.452126] RDX: 0000000001234567 RSI: 0000000028121969 RDI:
> 00000000fee1dead
> <4>[21100.453115] RBP: 00007fff75e046f8 R08: 00007efef9e42500 R09:
> 00007fff75e04439
> <4>[21100.454098] R10: 00000000000002f4 R11: 0000000000000246 R12:
> 0000000000000002
> <4>[21100.455076] R13: 0000000000000000 R14: 0000000000000000 R15:
> 0000000000000000
> <4>[21100.456056] Code: 41 5d c3 48 85 ff 0f 84 85 00 00 00 41 54 55 53 f6 47
> 3c 01 48 89 fb 75 14 48 8b 37 48 89 fa 48 c7 c7 f4 3f 85 a5 e8 f2 6f 4e ff <0f>
> 0b f0 ff 4b 38 0f 88 56 f5 00 00 75 53 8a 43 3c 4c 8b 63 28 
> <4>[21100.457169] ---[ end trace 734263fa4c996034 ]---
> <4>[21100.458244] ------------[ cut here ]------------
> <4>[21100.459316] kobject: '(null)' (00000000359a1c66): is not initialized, yet
> kobject_get() is being called.
> <4>[21100.460424] WARNING: CPU: 1 PID: 25848 at lib/kobject.c:593
> kobject_get+0x21/0x32
> <4>[21100.461532] Modules linked in:
> <4>[21100.462684] CPU: 1 PID: 25848 Comm: reboot Tainted: G        W        
> 4.17.0-gentoo #2
> <4>[21100.463826] Hardware name: ASUSTeK COMPUTER INC. Z10PE-D16 WS/Z10PE-D16
> WS, BIOS 3407 03/10/2017
> <4>[21100.464992] RIP: 0010:kobject_get+0x21/0x32
> <4>[21100.466188] RSP: 0018:ffffa6c6cd9d3db0 EFLAGS: 00010296
> <4>[21100.467349] RAX: 0000000000000000 RBX: ffff8d6af59e6da8 RCX:
> 0000000000000002
> <4>[21100.468531] RDX: ffff8d69a1bc5400 RSI: 0000000000000001 RDI:
> 00000000ffffffff
> <4>[21100.469724] RBP: ffff8d6af3dcc800 R08: 0000000000000001 R09:
> 0000000000000000
> <4>[21100.470921] R10: ffff8d69a1bc5400 R11: ffffffffa52a2f40 R12:
> ffff8d6af500c9a0
> <4>[21100.472116] R13: ffffffffa57dfb43 R14: ffff8d6af3dce860 R15:
> 0000000000000000
> <4>[21100.473316] FS:  00007efef9e42500(0000) GS:ffff8d6afd800000(0000)
> knlGS:0000000000000000
> <4>[21100.474519] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> <4>[21100.475723] CR2: 0000561f1e29c4d8 CR3: 00000010277fc005 CR4:
> 00000000003606e0
> <4>[21100.476927] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> <4>[21100.478130] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> <4>[21100.479331] Call Trace:
> <4>[21100.480514]  get_device+0x16/0x1b
> <4>[21100.481684]  device_shutdown+0x48/0x1a3
> <4>[21100.482844]  kernel_restart+0xe/0x4d
> <4>[21100.484003]  __do_sys_reboot+0x168/0x1c5
> <4>[21100.485173]  ? sched_clock_cpu+0x10/0xb4
> <4>[21100.486330]  ? sched_clock_cpu+0x10/0xb4
> <4>[21100.487480]  ? cycles_2_ns+0x55/0x75
> <4>[21100.488629]  ? task_work_run+0x63/0x8a
> <4>[21100.489779]  ? _raw_spin_unlock_irq+0x2f/0x41
> <4>[21100.490929]  ? task_work_run+0x63/0x8a
> <4>[21100.492078]  do_syscall_64+0x5e/0x6c
> <4>[21100.493228]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> <4>[21100.494389] RIP: 0033:0x7efef99840f7
> <4>[21100.495554] RSP: 002b:00007fff75e04590 EFLAGS: 00000246 ORIG_RAX:
> 00000000000000a9
> <4>[21100.496741] RAX: ffffffffffffffda RBX: 0000561f1d0c8bf0 RCX:
> 00007efef99840f7
> <4>[21100.497935] RDX: 0000000001234567 RSI: 0000000028121969 RDI:
> 00000000fee1dead
> <4>[21100.499136] RBP: 00007fff75e046f8 R08: 00007efef9e42500 R09:
> 00007fff75e04439
> <4>[21100.500340] R10: 00000000000002f4 R11: 0000000000000246 R12:
> 0000000000000002
> <4>[21100.501553] R13: 0000000000000000 R14: 0000000000000000 R15:
> 0000000000000000
> <4>[21100.502767] Code: f0 0f b1 0a 75 d5 48 89 f8 c3 48 85 ff 53 48 89 fb 74
> 24 f6 47 3c 01 75 14 48 8b 37 48 89 fa 48 c7 c7 98 3f 85 a5 e8 a5 70 4e ff <0f>
> 0b f0 ff 43 38 0f 88 03 f6 00 00 48 89 d8 5b c3 e9 88 1f 64 
> <4>[21100.504102] ---[ end trace 734263fa4c996035 ]---
> <4>[21100.505453] ------------[ cut here ]------------
> <4>[21100.506738] kobject: '(null)' (00000000359a1c66): is not initialized, yet
> kobject_put() is being called.
> <4>[21100.508059] WARNING: CPU: 1 PID: 25848 at lib/kobject.c:688
> kobject_put+0x28/0x8f
> <4>[21100.509373] Modules linked in:
> <4>[21100.510680] CPU: 1 PID: 25848 Comm: reboot Tainted: G        W        
> 4.17.0-gentoo #2
> <4>[21100.512002] Hardware name: ASUSTeK COMPUTER INC. Z10PE-D16 WS/Z10PE-D16
> WS, BIOS 3407 03/10/2017
> <4>[21100.513331] RIP: 0010:kobject_put+0x28/0x8f
> <4>[21100.514651] RSP: 0018:ffffa6c6cd9d3da8 EFLAGS: 00010286
> <4>[21100.515977] RAX: 0000000000000000 RBX: ffff8d6af59e6da8 RCX:
> 0000000000000001
> <4>[21100.517310] RDX: ffff8d69a1bc5400 RSI: 0000000000000001 RDI:
> 00000000ffffffff
> <4>[21100.518650] RBP: ffff8d6af3dcc800 R08: 0000000000000001 R09:
> 0000000000000000
> <4>[21100.519981] R10: ffff8d69a1bc5400 R11: ffffffffa52a2f40 R12:
> ffff8d6af59e6d98
> <4>[21100.521302] R13: ffffffffa57dfb43 R14: ffff8d6af3dcc860 R15:
> 0000000000000000
> <4>[21100.522612] FS:  00007efef9e42500(0000) GS:ffff8d6afd800000(0000)
> knlGS:0000000000000000
> <4>[21100.524028] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> <4>[21100.525337] CR2: 0000561f1e29c4d8 CR3: 00000010277fc005 CR4:
> 00000000003606e0
> <4>[21100.526642] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> <4>[21100.527938] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> <4>[21100.529229] Call Trace:
> <4>[21100.530507]  device_shutdown+0x17d/0x1a3
> <4>[21100.531787]  kernel_restart+0xe/0x4d
> <4>[21100.533066]  __do_sys_reboot+0x168/0x1c5
> <4>[21100.534341]  ? sched_clock_cpu+0x10/0xb4
> <4>[21100.535612]  ? sched_clock_cpu+0x10/0xb4
> <4>[21100.536866]  ? cycles_2_ns+0x55/0x75
> <4>[21100.538111]  ? task_work_run+0x63/0x8a
> <4>[21100.539350]  ? _raw_spin_unlock_irq+0x2f/0x41
> <4>[21100.540590]  ? task_work_run+0x63/0x8a
> <4>[21100.541833]  do_syscall_64+0x5e/0x6c
> <4>[21100.543066]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> <4>[21100.544359] RIP: 0033:0x7efef99840f7
> <4>[21100.545597] RSP: 002b:00007fff75e04590 EFLAGS: 00000246 ORIG_RAX:
> 00000000000000a9
> <4>[21100.546853] RAX: ffffffffffffffda RBX: 0000561f1d0c8bf0 RCX:
> 00007efef99840f7
> <4>[21100.548163] RDX: 0000000001234567 RSI: 0000000028121969 RDI:
> 00000000fee1dead
> <4>[21100.549435] RBP: 00007fff75e046f8 R08: 00007efef9e42500 R09:
> 00007fff75e04439
> <4>[21100.550711] R10: 00000000000002f4 R11: 0000000000000246 R12:
> 0000000000000002
> <4>[21100.552044] R13: 0000000000000000 R14: 0000000000000000 R15:
> 0000000000000000
> <4>[21100.553324] Code: 41 5d c3 48 85 ff 0f 84 85 00 00 00 41 54 55 53 f6 47
> 3c 01 48 89 fb 75 14 48 8b 37 48 89 fa 48 c7 c7 f4 3f 85 a5 e8 f2 6f 4e ff <0f>
> 0b f0 ff 4b 38 0f 88 56 f5 00 00 75 53 8a 43 3c 4c 8b 63 28 
> <4>[21100.554724] ---[ end trace 734263fa4c996036 ]---
> <5>[21100.556701] sd 5:0:0:0: [sdc] Synchronizing SCSI cache
> <5>[21100.558348] sd 4:0:0:0: [sdb] Synchronizing SCSI cache
> <5>[21100.560204] sd 2:0:0:0: [sda] Synchronizing SCSI cache
> <6>[21100.563419] mlx4_core 0000:81:00.0: mlx4_shutdown was called
> <7>[21100.566483] mlx4_en: enp129s0: Close port called
> <4>[21102.258970] ------------[ cut here ]------------
> <4>[21102.260698] kobject: '(null)' (0000000047d32b91): is not initialized, yet
> kobject_get() is being called.
> <4>[21102.262150] WARNING: CPU: 2 PID: 25848 at lib/kobject.c:593
> kobject_get+0x21/0x32
> <4>[21102.263588] Modules linked in:
> <4>[21102.264977] CPU: 2 PID: 25848 Comm: reboot Tainted: G        W        
> 4.17.0-gentoo #2
> <4>[21102.266344] Hardware name: ASUSTeK COMPUTER INC. Z10PE-D16 WS/Z10PE-D16
> WS, BIOS 3407 03/10/2017
> <4>[21102.267785] RIP: 0010:kobject_get+0x21/0x32
> <4>[21102.269148] RSP: 0018:ffffa6c6cd9d3db0 EFLAGS: 00010296
> <4>[21102.270503] RAX: 0000000000000000 RBX: ffff8d6af5012da8 RCX:
> 0000000000000002
> <4>[21102.271868] RDX: ffff8d69a1bc5400 RSI: 0000000000000001 RDI:
> 00000000ffffffff
> <4>[21102.273211] RBP: ffff8d6af5012d98 R08: 0000000000000001 R09:
> 0000000000000000
> <4>[21102.274541] R10: ffff8d69a1bc5400 R11: ffffffffa52a2f40 R12:
> 0000000000000000
> <4>[21102.275862] R13: ffffffffa57dfb43 R14: ffff8d6af5009a00 R15:
> 0000000000000000
> <4>[21102.277179] FS:  00007efef9e42500(0000) GS:ffff8d6afda00000(0000)
> knlGS:0000000000000000
> <4>[21102.278502] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> <4>[21102.279821] CR2: 00007fbd98235f68 CR3: 00000010277fc001 CR4:
> 00000000003606e0
> <4>[21102.281171] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> <4>[21102.282492] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> <4>[21102.283808] Call Trace:
> <4>[21102.285111]  get_device+0x16/0x1b
> <4>[21102.286403]  device_shutdown+0x53/0x1a3
> <4>[21102.287688]  kernel_restart+0xe/0x4d
> <4>[21102.288970]  __do_sys_reboot+0x168/0x1c5
> <4>[21102.290255]  ? sched_clock_cpu+0x10/0xb4
> <4>[21102.291543]  ? sched_clock_cpu+0x10/0xb4
> <4>[21102.292806]  ? cycles_2_ns+0x55/0x75
> <4>[21102.294069]  ? task_work_run+0x63/0x8a
> <4>[21102.295334]  ? _raw_spin_unlock_irq+0x2f/0x41
> <4>[21102.296598]  ? task_work_run+0x63/0x8a
> <4>[21102.297862]  do_syscall_64+0x5e/0x6c
> <4>[21102.299132]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> <4>[21102.300408] RIP: 0033:0x7efef99840f7
> <4>[21102.301698] RSP: 002b:00007fff75e04590 EFLAGS: 00000246 ORIG_RAX:
> 00000000000000a9
> <4>[21102.302988] RAX: ffffffffffffffda RBX: 0000561f1d0c8bf0 RCX:
> 00007efef99840f7
> <4>[21102.304285] RDX: 0000000001234567 RSI: 0000000028121969 RDI:
> 00000000fee1dead
> <4>[21102.305587] RBP: 00007fff75e046f8 R08: 00007efef9e42500 R09:
> 00007fff75e04439
> <4>[21102.306890] R10: 00000000000002f4 R11: 0000000000000246 R12:
> 0000000000000002
> <4>[21102.308199] R13: 0000000000000000 R14: 0000000000000000 R15:
> 0000000000000000
> <4>[21102.309497] Code: f0 0f b1 0a 75 d5 48 89 f8 c3 48 85 ff 53 48 89 fb 74
> 24 f6 47 3c 01 75 14 48 8b 37 48 89 fa 48 c7 c7 98 3f 85 a5 e8 a5 70 4e ff <0f>
> 0b f0 ff 43 38 0f 88 03 f6 00 00 48 89 d8 5b c3 e9 88 1f 64 
> <4>[21102.310932] ---[ end trace 734263fa4c996037 ]---
> <1>[21102.312296] BUG: unable to handle kernel NULL pointer dereference at
> 0000000000000000
> <6>[21102.313668] PGD 0 P4D 0 
> <4>[21102.315026] Oops: 0002 [#1] PREEMPT SMP PTI
> <4>[21102.316392] Modules linked in:
> <4>[21102.317714] CPU: 2 PID: 25848 Comm: reboot Tainted: G        W        
> 4.17.0-gentoo #2
> <4>[21102.319022] Hardware name: ASUSTeK COMPUTER INC. Z10PE-D16 WS/Z10PE-D16
> WS, BIOS 3407 03/10/2017
> <4>[21102.320341] RIP: 0010:device_shutdown+0x5e/0x1a3
> <4>[21102.321658] RSP: 0018:ffffa6c6cd9d3dc8 EFLAGS: 00010282
> <4>[21102.322950] RAX: 0000000000000000 RBX: ffff8d6af5012db0 RCX:
> 0000000000000002
> <4>[21102.324242] RDX: ffff8d6af95b8d80 RSI: 0000000000000001 RDI:
> 00000000ffffffff
> <4>[21102.325531] RBP: ffff8d6af5012d98 R08: 0000000000000001 R09:
> 0000000000000000
> <4>[21102.326807] R10: ffff8d69a1bc5400 R11: ffffffffa52a2f40 R12:
> 0000000000000000
> <4>[21102.328071] R13: ffffffffa57dfb43 R14: ffff8d6af5009a00 R15:
> 0000000000000000
> <4>[21102.329335] FS:  00007efef9e42500(0000) GS:ffff8d6afda00000(0000)
> knlGS:0000000000000000
> <4>[21102.330631] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> <4>[21102.331909] CR2: 0000000000000000 CR3: 00000010277fc001 CR4:
> 00000000003606e0
> <4>[21102.333233] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> <4>[21102.334503] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> <4>[21102.335765] Call Trace:
> <4>[21102.337012]  kernel_restart+0xe/0x4d
> <4>[21102.338253]  __do_sys_reboot+0x168/0x1c5
> <4>[21102.339489]  ? sched_clock_cpu+0x10/0xb4
> <4>[21102.340719]  ? sched_clock_cpu+0x10/0xb4
> <4>[21102.341961]  ? cycles_2_ns+0x55/0x75
> <4>[21102.343176]  ? task_work_run+0x63/0x8a
> <4>[21102.344392]  ? _raw_spin_unlock_irq+0x2f/0x41
> <4>[21102.345617]  ? task_work_run+0x63/0x8a
> <4>[21102.346835]  do_syscall_64+0x5e/0x6c
> <4>[21102.348061]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> <4>[21102.349290] RIP: 0033:0x7efef99840f7
> <4>[21102.350515] RSP: 002b:00007fff75e04590 EFLAGS: 00000246 ORIG_RAX:
> 00000000000000a9
> <4>[21102.351779] RAX: ffffffffffffffda RBX: 0000561f1d0c8bf0 RCX:
> 00007efef99840f7
> <4>[21102.353031] RDX: 0000000001234567 RSI: 0000000028121969 RDI:
> 00000000fee1dead
> <4>[21102.354287] RBP: 00007fff75e046f8 R08: 00007efef9e42500 R09:
> 00007fff75e04439
> <4>[21102.355547] R10: 00000000000002f4 R11: 0000000000000246 R12:
> 0000000000000002
> <4>[21102.356808] R13: 0000000000000000 R14: 0000000000000000 R15:
> 0000000000000000
> <4>[21102.358066] Code: 5b 01 00 00 48 8b 5f 08 48 8b 7b e8 48 8d 6b e8 e8 01
> d7 ff ff 48 89 ef 49 89 c4 e8 f6 d6 ff ff 48 8b 43 08 48 8b 13 48 89 42 08 <48>
> 89 10 48 89 1b 48 8b 05 0e 0d bd 02 48 89 5b 08 48 8d 78 10 
> <1>[21102.359437] RIP: device_shutdown+0x5e/0x1a3 RSP: ffffa6c6cd9d3dc8
> <4>[21102.360749] CR2: 0000000000000000
> <4>[21102.362070] ---[ end trace 734263fa4c996038 ]---
> 
> -- 
> You are receiving this mail because:
> You are the assignee for the bug.
