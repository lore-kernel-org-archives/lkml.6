Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E30C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 04:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEF8C20870
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 04:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfBBEnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 23:43:45 -0500
Received: from trent.utfs.org ([94.185.90.103]:35326 "EHLO trent.utfs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbfBBEnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 23:43:45 -0500
X-Greylist: delayed 381 seconds by postgrey-1.27 at vger.kernel.org; Fri, 01 Feb 2019 23:43:44 EST
Received: from localhost (localhost [IPv6:::1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by trent.utfs.org (Postfix) with ESMTPS id 47DEE5FF0B;
        Sat,  2 Feb 2019 05:37:22 +0100 (CET)
Date:   Fri, 1 Feb 2019 20:37:22 -0800 (PST)
From:   Christian Kujau <lists@nerdbynature.de>
To:     linux-kernel@vger.kernel.org
cc:     Hans van Kranenburg <hans.van.kranenburg@mendix.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Subject: RIP: e030:move_page_tables+0xaa3/0xb80
Message-ID: <alpine.DEB.2.21.999.1902011935450.10507@trent.utfs.org>
User-Agent: Alpine 2.21.999 (DEB 277 2018-05-20)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm running an Ubuntu "mainline" kernel[0] as a Xen 4.11.1 DomU (PV) and 
ever since upgrading to Linux 5.0-rcX I get these WARNING messages shown 
below. Going back in my logs[1] I can see that I got a similar messages 
for v4.20 too, but with v5.0 they appear more often and upgrading from 
v5.0-rc3 to -rc4 made it even worse, now the messages show up quickly 
after boot and some commands (w, ps, top) become stuck and shutdown would 
hang too.

I found an email thread[2] from earlier this month (hence the CC list) 
about this, but could not find out if this issue has been concluded or 
even fixed. 

I've gone back to v4.20 now and the message hasn't appeared yet, but it 
probably will in a few days again. Let me know if you need more details, 
v5.0-rc4 should make it easier for me to reproduce.

Thanks,
Christian.

[0] https://kernel.ubuntu.com/~kernel-ppa/mainline
    https://wiki.ubuntu.com/Kernel/MainlineBuilds
[1] http://nerdbynature.de/bits/5.0.0-rc4/kern_msg.txt
[2] https://www.spinics.net/lists/stable/msg279001.html


WARNING: CPU: 1 PID: 386 at arch/x86/xen/multicalls.c:102 
xen_mc_flush+0x196/0x1f0
Modules linked in: rpcsec_gss_krb5 auth_rpcgss lz4 lz4_compress 
crct10dif_pclmul xen_kbdfront(-) ghash_clmulni_intel xen_fbfront 
fb_sys_fops syscopyarea sysfillrect sysimgblt aesni_intel aes_x86_64 
crypto_simd cryptd glue_helper intel_rapl_perf sch_fq_codel 
nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct 
nf_conntrack zram nf_defrag_ipv6 nf_defrag_ipv4 reiserfs nfsv4 nfs 
nf_tables_set lockd grace fscache dm_crypt sunrpc btrfs nf_tables 
nfnetlink zstd_compress ip_tables x_tables autofs4 raid10 raid456 
async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq 
libcrc32c raid1 raid0 multipath linear [last unloaded: mac_hid]
CPU: 1 PID: 386 Comm: systemd-udevd Not tainted 5.0.0-050000rc4-generic 
#201901272036
RIP: e030:xen_mc_flush+0x196/0x1f0
Code: 48 c1 e0 05 4d 8b 55 38 4d 8b 45 40 48 05 00 10 00 81 e8 5d ae dd 00 
49 89 45 18 48 c1 e8 3f 48 89 c6 85 f6 0f 84 05 ff ff ff <0f> 0b 65 8b 0d 
b1 92 fe 7e 41 8b 55 00 48 c7 c7 30 b0 2d 82 e8 f4
RSP: e02b:ffffc900410dbd00 EFLAGS: 00010002
RAX: ffff888175c946d8 RBX: 0000777f80000000 RCX: 0000000000000001
RDX: ffff888175c946d8 RSI: 0000000000000001 RDI: ffff888175c94310
RBP: ffffc900410dbd30 R08: 0000000000000001 R09: ffff88816fe5b000
R10: 0000000000007ff0 R11: 0000000000000011 R12: 000000000000000f
R13: ffff888175c94300 R14: 0000000000000200 R15: 0000000000000000
FS:  00007fca75421680(0000) GS:ffff888175c80000(0000) 
knlGS:0000000000000000
CS:  10000e030 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005606a0d8bfb8 CR3: 000000016d51a000 CR4: 0000000000042660
Call Trace:
 __xen_pgd_pin+0x10c/0x300
 xen_activate_mm+0x28/0x40
 xen_dup_mmap+0xe/0x10
 copy_process.part.37+0x1e7a/0x1f70
 _do_fork+0xe8/0x3a0
 __x64_sys_clone+0x27/0x30
 do_syscall_64+0x5a/0x110
 entry_SYSCALL_64_after_hwframe+0x44/0xa9



-- 
BOFH excuse #160:

non-redundant fan failure
