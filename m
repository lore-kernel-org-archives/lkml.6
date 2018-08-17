Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBB0C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 06:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C11E2208A3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 06:56:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C11E2208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nerdbynature.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbeHQJ6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 05:58:25 -0400
Received: from trent.utfs.org ([94.185.90.103]:53286 "EHLO trent.utfs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726226AbeHQJ6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 05:58:25 -0400
Received: from localhost (localhost [IPv6:::1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by trent.utfs.org (Postfix) with ESMTPS id 85B855FF73;
        Fri, 17 Aug 2018 08:56:10 +0200 (CEST)
Date:   Thu, 16 Aug 2018 23:56:10 -0700 (PDT)
From:   Christian Kujau <lists@nerdbynature.de>
To:     Kees Cook <keescook@chromium.org>
cc:     linux-kernel@vger.kernel.org, Bart Massey <bart.massey@gmail.com>,
        jfs-discussion@lists.sourceforge.net,
        David Windsor <dave@nullcore.net>,
        Dave Kleikamp <shaggy@kernel.org>
Subject: Re: [Jfs-discussion] [PATCH] jfs: Expand usercopy whitelist for
 inline inode data
In-Reply-To: <20180803200551.GA47157@beast>
Message-ID: <alpine.DEB.2.21.999.1808162319420.3196@trent.utfs.org>
References: <20180803200551.GA47157@beast>
User-Agent: Alpine 2.21.999 (DEB 277 2018-05-20)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Aug 2018, Kees Cook via Jfs-discussion wrote:
> Bart Massey reported what turned out to be a usercopy whitelist false
> positive in JFS when symlink contents exceeded 128 bytes. The inline
> inode data (i_inline) is actually designed to overflow into the "extended

So, this may be a stupid question, but: is there a way to disable this 
hardened usercopy thing with a boot option maybe?

Apparently, CONFIG_HARDENED_USERCOPY_FALLBACK was disabled in Debian's 
4.16.0-0.bpo.2-amd64 (4.16.16) kernels[0] and I have a VMware guest here 
that prints a BUG message (below) whenever a certain directory is being 
accesses. ls(1) is fine, but "ls -l" (i.e. with stat()) produces the splat 
below. And indeed, the target of one of the symlinks inside is 129 
characters long, and every attempt to stat it prints the splat below.

Going back to 4.16.0-0.bpo.1-amd64 (4.16.5) helps, but I was wondering if 
there was a magic boot option to disable it while I wait for 4.18 to land 
in Debian? I booted with hardened_usercopy=off, but it doesn't seem to 
have an effect and the directory is still inaccessible.

Thanks,
Christian.

[0] https://salsa.debian.org/kernel-team/linux/tree/stretch-backports/debian/config/


---[ end trace dbb1a6dfa1411526 ]---
usercopy: Kernel memory exposure attempt detected from SLUB object 
'jfs_ip' (offset 288, size 129)!
------------[ cut here ]------------
kernel BUG at /build/linux-hvYKKE/linux-4.17.8/mm/usercopy.c:100!
invalid opcode: 0000 [#2] SMP PTI
Modules linked in: xt_tcpudp iptable_filter binfmt_misc zram zsmalloc 
vmw_vsock_vmci_transport vsock ip_tables x_tables xts twofish_x86_64_3way 
twofish_x86_64 twofish_common lrw jfs glue_helper gf128mul dm_crypt dm_mod 
sd_mod evdev vmxnet3 mptsas scsi_transport_sas mptscsih mptbase vmw_vmci 
ata_piix libata scsi_mod button
CPU: 0 PID: 1349 Comm: ls Tainted: G      D           4.17.0-0.bpo.1-amd64 
#1 Debian 4.17.8-1~bpo9+1
Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop 
Reference Platform, BIOS 6.00 09/21/2015
RIP: 0010:usercopy_abort+0x69/0x80
RSP: 0018:ffffb84e40e2fe18 EFLAGS: 00010286
RAX: 0000000000000063 RBX: 0000000000000081 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffff9786ffc16738 RDI: ffff9786ffc16738
RBP: 0000000000000081 R08: 0000000000000000 R09: 000000000000042e
R10: ffffffff9c68af71 R11: 323120657a697320 R12: 0000000000000001
R13: ffff9786f93146a1 R14: 0000000000000082 R15: 0000559dd2edb170
FS:  00007fe8f13733c0(0000) GS:ffff9786ffc00000(0000) 
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000559dd2edb088 CR3: 000000003d104002 CR4: 00000000003606f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __check_heap_object+0xeb/0x120
 __check_object_size+0xb8/0x1a0
 readlink_copy+0x3e/0x60
 vfs_readlink+0x60/0x120
 do_readlinkat+0xf9/0x120
 __x64_sys_readlink+0x1b/0x20
 do_syscall_64+0x55/0x110
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7fe8f0c6fe47
RSP: 002b:00007ffe94d04528 EFLAGS: 00000202 ORIG_RAX: 0000000000000059
RAX: ffffffffffffffda RBX: 0000000000000082 RCX: 00007fe8f0c6fe47
RDX: 0000000000000082 RSI: 0000559dd2edb170 RDI: 00007ffe94d04570
RBP: 0000559dd2edb170 R08: 0000000000000003 R09: 0000000000000090
R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffe94d04570
R13: 00007ffe94d04570 R14: 3fffffffffffffff R15: 7ffffffffffffffe
Code: 0f 44 d0 53 48 c7 c0 58 05 65 9c 51 48 c7 c6 12 f9 63 9c 41 53 48 89 
f9 48 0f 45 f0 4c 89 d2 48 c7 c7 40 06 65 9c e8 05 97 e9 ff <0f> 0b 49 c7 
c1 03 09 66 9c 4d 89 cb 4d 89 c8 eb a5 66 0f 1f 44 
RIP: usercopy_abort+0x69/0x80 RSP: ffffb84e40e2fe18
---[ end trace dbb1a6dfa1411527 ]---


-- 
BOFH excuse #404:

Sysadmin accidentally destroyed pager with a large hammer.
