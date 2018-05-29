Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967589AbeE2WI6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 18:08:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44000 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967058AbeE2WIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 18:08:55 -0400
Date: Tue, 29 May 2018 15:08:54 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>, stable@vger.kernel.org
Subject: Re: [PATCH] fs/binfmt_misc.c: do not allow offset overflow
Message-Id: <20180529150854.f87fa3d65b9cdc0386672b1d@linux-foundation.org>
In-Reply-To: <20180529135648.14254-1-cascardo@canonical.com>
References: <20180529135648.14254-1-cascardo@canonical.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 May 2018 10:56:48 -0300 Thadeu Lima de Souza Cascardo <cascardo@canonical.com> wrote:

> It's possible to overflow the offset to get a negative value, which might
> crash the system, or possibly leak kernel data.

I think the missing information here is "when registering a new
binfmt_misc binary type", yes?

> Here is a crash log when using 2500000000 as offset:
> 
> [ 6050.251552] BUG: unable to handle kernel paging request at ffff989cfd6edca0
> [ 6050.252053] IP: load_misc_binary+0x22b/0x470 [binfmt_misc]
> [ 6050.252053] PGD 1ef3e067 P4D 1ef3e067 PUD 0
> [ 6050.252053] Oops: 0000 [#1] SMP NOPTI
> [ 6050.252053] Modules linked in: binfmt_misc kvm_intel ppdev kvm irqbypass joydev input_leds serio_raw mac_hid parport_pc qemu_fw_cfg parpy
> [ 6050.252053] CPU: 0 PID: 2499 Comm: bash Not tainted 4.15.0-22-generic #24-Ubuntu
> [ 6050.252053] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.1-1 04/01/2014
> [ 6050.252053] RIP: 0010:load_misc_binary+0x22b/0x470 [binfmt_misc]
> [ 6050.252053] RSP: 0018:ffffb6e383017e18 EFLAGS: 00010202
> [ 6050.252053] RAX: 0000000000000003 RBX: ffff989d74a47100 RCX: ffff989cfd6edca0
> [ 6050.252053] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff989d7d2e95e5
> [ 6050.252053] RBP: ffffb6e383017e48 R08: 0000000000000001 R09: 0000000000000000
> [ 6050.252053] R10: 0000000000000000 R11: fefefefefefefeff R12: 0000000000000001
> [ 6050.252053] R13: ffff989d7d2e9580 R14: 0000000000000000 R15: ffffffffc0592160
> [ 6050.252053] FS:  00007fa424c89740(0000) GS:ffff989d7fc00000(0000) knlGS:0000000000000000
> [ 6050.252053] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 6050.252053] CR2: ffff989cfd6edca0 CR3: 000000003db08000 CR4: 00000000000006f0
> [ 6050.252053] Call Trace:
> [ 6050.252053]  search_binary_handler+0x97/0x1d0
> [ 6050.252053]  do_execveat_common.isra.34+0x667/0x810
> [ 6050.252053]  SyS_execve+0x31/0x40
> [ 6050.252053]  do_syscall_64+0x73/0x130
> [ 6050.252053]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
> 
> Use kstrtoint instead of simple_strtoul. It will work as the code already
> set the delimiter byte to '\0' and we only do it when the field is not
> empty.
> 
> Tested with offsets -1, 2500000000, UINT_MAX and INT_MAX. Also tested with
> examples documented at Documentation/admin-guide/binfmt-misc.rst and other
> registrations from packages on Ubuntu.
> 
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org

Registering a handler is a priveleged operation.  As such, I don't
think a -stable backport is needed?
