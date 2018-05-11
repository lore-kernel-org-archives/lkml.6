Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752129AbeEKCXU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 22:23:20 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36975 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750798AbeEKCXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 22:23:18 -0400
X-Google-Smtp-Source: AB8JxZrldiw0NqebDTwEfMmLS+2COw3CinmI/F0s5yVdGUFWgmO5NP9tQDmUxYav+sf8E4h/F0ayIA==
Date: Fri, 11 May 2018 11:23:14 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Joe Perches <joe@perches.com>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/18] printk: Convert pr_fmt from blank define to
 KBUILD_MODNAME
Message-ID: <20180511022314.GA491@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180511015140.GB895@jagdpanzerIV>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (05/11/18 10:51), Sergey Senozhatsky wrote:
> In general, the idea looks OK to me, so FWIW
> Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

Looking at dmesg,

Base:
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[...]
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 00E0000000 mask 7FE0000000 uncachable
[    0.000000]   1 disabled
[    0.000000]   2 disabled
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[..]

Patched:
[    0.000000] common: KERNEL supported cpus:
[    0.000000] common:   Intel GenuineIntel
[...]
[    0.000000] generic: MTRR default type: write-back
[    0.000000] generic: MTRR fixed ranges enabled:
[    0.000000] generic:   00000-9FFFF write-back
[    0.000000] generic:   A0000-BFFFF uncachable
[    0.000000] generic:   C0000-FFFFF write-protect
[    0.000000] generic: MTRR variable ranges enabled:
[    0.000000] generic:   0 base 00E0000000 mask 7FE0000000 uncachable
[    0.000000] generic:   1 disabled
[    0.000000] generic:   2 disabled
[    0.000000] generic:   3 disabled
[    0.000000] generic:   4 disabled
[..]

Is it correct that WARN_ON() from "generic: " will now also be prefixed?
In other words, we will have something like this

[   28.420519] generic: RSP: 0018:ffffa01dc062bda8 EFLAGS: 00010282
[   28.420522] generic: RAX: ffffffff8317612f RBX: ffffffffffffffea RCX: ffffa01dc062bdc8
[   28.420523] generic: RDX: 000055a6a3f03110 RSI: 0000000000000001 RDI: ffffffff83e31540
[   28.420525] generic: RBP: 0000000000000001 R08: ffffa01dc062bec0 R09: 0000000000000004
[   28.420526] generic: R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000001
[   28.420528] generic: R13: ffffffff83e31540 R14: ffffa01dc062bec0 R15: 0000000000000002
[   28.420547] generic: ? rcu_read_lock_sched_held+0x5d/0x63
[   28.420549] generic: ? rcu_sync_lockdep_assert+0x2e/0x54
[   28.420551] generic: ? __sb_start_write+0xeb/0x1a3

Correct?

	-ss
