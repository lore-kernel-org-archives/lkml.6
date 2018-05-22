Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752133AbeEVDTQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 23:19:16 -0400
Received: from gate.crashing.org ([63.228.1.57]:50141 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751271AbeEVDTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 23:19:14 -0400
Message-ID: <00a60e88ed75601a69f6cf4b194ef9ee6b22056f.camel@kernel.crashing.org>
Subject: Lockdep complaint in jffs2
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linux-kernel@vger.kernel.org
Cc: David Woodhouse <dwmw2@infradead.org>, linux-mtd@lists.infradead.org,
        Al Viro <viro@ZenIV.linux.org.uk>
Date: Tue, 22 May 2018 13:17:20 +1000
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1 (3.28.1-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David !

I noticed this on my BMC when building OpenBMC with Lockdep...
something worth investigating/digging ?

Cheers,
Ben.

  24.068677] ======================================================
[   24.074871] WARNING: possible circular locking dependency detected
[   24.081065] 4.13.16-01426-gaa61047 #61 Not tainted
[   24.085858] ------------------------------------------------------
[   24.092039] systemd-tmpfile/616 is trying to acquire lock:
[   24.097524]  (&f->sem){+.+.+.}, at: [<802cc018>] jffs2_readpage+0x30/0x5c
[   24.104389] 
[   24.104389] but task is already holding lock:
[   24.110228]  (&mm->mmap_sem){++++++}, at: [<8010d274>] do_page_fault+0xa0/0x3c0
[   24.117588] 
[   24.117588] which lock already depends on the new lock.
[   24.117588] 
[   24.125769] 
[   24.125769] the existing dependency chain (in reverse order) is:
[   24.133246] 
[   24.133246] -> #1 (&mm->mmap_sem){++++++}:
[   24.138878]        __might_fault+0x8c/0xc0
[   24.143007]        filldir64+0x80/0x33c
[   24.146878]        jffs2_readdir+0xd8/0x1d4
[   24.151082]        iterate_dir+0x84/0x180
[   24.155108]        SyS_getdents64+0x94/0x1d8
[   24.159400]        ret_fast_syscall+0x0/0x1c
[   24.163677] 
[   24.163677] -> #0 (&f->sem){+.+.+.}:
[   24.168779]        lock_acquire+0xe8/0x208
[   24.172898]        __mutex_lock+0x90/0x660
[   24.177007]        mutex_lock_nested+0x2c/0x34
[   24.181472]        jffs2_readpage+0x30/0x5c
[   24.185678]        filemap_fault+0x4e8/0x614
[   24.189971]        __do_fault+0x28/0xd0
[   24.193823]        handle_mm_fault+0x948/0xfb0
[   24.198286]        do_page_fault+0x2d8/0x3c0
[   24.202573]        do_DataAbort+0x50/0xe8
[   24.206605]        __dabt_usr+0x44/0x60
[   24.210456]        0x76cf9b04
[   24.213432] 
[   24.213432] other info that might help us debug this:
[   24.213432] 
[   24.221439]  Possible unsafe locking scenario:
[   24.221439] 
[   24.227357]        CPU0                    CPU1
[   24.231891]        ----                    ----
[   24.236421]   lock(&mm->mmap_sem);
[   24.239837]                                lock(&f->sem);
[   24.245244]                                lock(&mm->mmap_sem);
[   24.251172]   lock(&f->sem);
[   24.254066] 
[   24.254066]  *** DEADLOCK ***
[   24.254066] 
[   24.259992] 1 lock held by systemd-tmpfile/616:
[   24.264518]  #0:  (&mm->mmap_sem){++++++}, at: [<8010d274>] do_page_fault+0xa0/0x3c0
[   24.272315] 
[   24.272315] stack backtrace:
[   24.276692] CPU: 0 PID: 616 Comm: systemd-tmpfile Not tainted 4.13.16-01426-gaa61047 #61
[   24.284776] Hardware name: Generic DT based system
[   24.289610] [<8010a494>] (unwind_backtrace) from [<80107510>] (show_stack+0x20/0x24)
[   24.297402] [<80107510>] (show_stack) from [<80612710>] (dump_stack+0x20/0x28)
[   24.304664] [<80612710>] (dump_stack) from [<80152be8>] (print_circular_bug+0x1bc/0x2fc)
[   24.312779] [<80152be8>] (print_circular_bug) from [<80156fcc>] (__lock_acquire+0x1674/0x18b8)
[   24.321415] [<80156fcc>] (__lock_acquire) from [<80157d5c>] (lock_acquire+0xe8/0x208)
[   24.329273] [<80157d5c>] (lock_acquire) from [<8062ba68>] (__mutex_lock+0x90/0x660)
[   24.336956] [<8062ba68>] (__mutex_lock) from [<8062cde4>] (mutex_lock_nested+0x2c/0x34)
[   24.345000] [<8062cde4>] (mutex_lock_nested) from [<802cc018>] (jffs2_readpage+0x30/0x5c)
[   24.353217] [<802cc018>] (jffs2_readpage) from [<801f81a4>] (filemap_fault+0x4e8/0x614)
[   24.361265] [<801f81a4>] (filemap_fault) from [<802279c4>] (__do_fault+0x28/0xd0)
[   24.368788] [<802279c4>] (__do_fault) from [<8022b198>] (handle_mm_fault+0x948/0xfb0)
[   24.376649] [<8022b198>] (handle_mm_fault) from [<8010d4ac>] (do_page_fault+0x2d8/0x3c0)
[   24.384764] [<8010d4ac>] (do_page_fault) from [<80101314>] (do_DataAbort+0x50/0xe8)
[   24.392461] [<80101314>] (do_DataAbort) from [<80108724>] (__dabt_usr+0x44/0x60)
[   24.399867] Exception stack(0x958e5fb0 to 0x958e5ff8)
[   24.404932] 5fa0:                                     02428220 76ff62d4 76ff6000 76cf9af4
[   24.413117] 5fc0: 02428220 76dccc8c 02428220 02427e18 0000000a 02427e18 00000000 00000000
[   24.421305] 5fe0: fbada489 7e89b1a8 76cfba2c 76cf9b04 80000010 ffffffff
