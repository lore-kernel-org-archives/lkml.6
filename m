Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84509C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 13:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47F1920869
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 13:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rx3Jhydt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47F1920869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbeJZWXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 18:23:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:47686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726113AbeJZWXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 18:23:24 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5021320868;
        Fri, 26 Oct 2018 13:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540561575;
        bh=lLmTommMuGWoywEN1rcrMZDtenzanbAqIg3xk09azI0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Rx3JhydtD3c+0T9apjijeFasKQXrmpTLZi6HLg/mVgwGm4khx+X/K7H+oaFdTBD+9
         5suQgsgl+VREWjffQ+C6D5BhVTODi+zVLmFYa7Z5nPYOXtNQku9kQ/0vRR5K9ouZSy
         oSKtSgZgvvTjDhxHj2S5KlnHL5FcyMCkwj3arzAo=
Message-ID: <41db4227fdc5deb7703c6425c2f36589b355a7ca.camel@kernel.org>
Subject: Re: [PATCH 0/9 v3] locks: avoid thundering-herd wake-ups
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Martin Wilck <mwilck@suse.de>, linux-fsdevel@vger.kernel.org,
        Frank Filz <ffilzlnx@mindspring.com>,
        linux-kernel@vger.kernel.org
Date:   Fri, 26 Oct 2018 09:46:12 -0400
In-Reply-To: <154033435272.29542.13985568983074440924.stgit@noble>
References: <154033435272.29542.13985568983074440924.stgit@noble>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-10-24 at 09:43 +1100, NeilBrown wrote:
> This took longer that I had wanted, due to various reasons - sorry.
> And I'm now posting it in a merge window, which is not ideal.  I don't
> expect it to be included in this merge window and I won't be at all
> impatient for review, but I didn't want to delay it further.
> 
> Testing found some problems, particularly the need to use
> locks_copy_lock in NFS.  And there was a small thinko in there that
> effectively removed all the speed gains :-(
> 
> But this version:
>  - shows excellent scalability with lots of threads on lots of CPUs
>    contending on a single file
>  - avoids the problems that Bruce found
>  - seems to work.
> 
> Thanks,
> NeilBrown
> 
> 
> ---
> 
> NeilBrown (9):
>       fs/locks: rename some lists and pointers.
>       fs/locks: split out __locks_wake_up_blocks().
>       NFS: use locks_copy_lock() to copy locks.
>       fs/locks: allow a lock request to block other requests.
>       fs/locks: always delete_block after waiting.
>       fs/locks: change all *_conflict() functions to return bool.
>       fs/locks: create a tree of dependent requests.
>       locks: merge posix_unblock_lock() and locks_delete_block()
>       VFS: locks: remove unnecessary white space.
> 
> 
>  fs/cifs/file.c                  |    4 -
>  fs/lockd/svclock.c              |    2 
>  fs/locks.c                      |  231 ++++++++++++++++++++++-----------------
>  fs/nfs/nfs4proc.c               |    6 +
>  fs/nfsd/nfs4state.c             |    6 +
>  include/linux/fs.h              |   11 +-
>  include/trace/events/filelock.h |   16 +--
>  7 files changed, 153 insertions(+), 123 deletions(-)
> 
> --
> Signature
> 


I built a kernel with these patches and ran the cthon04 lock tests and
got this on lock test 1 after a long hang (the test passed though):

[ 1694.787367] BUG: unable to handle kernel NULL pointer dereference at 000000000000002c
[ 1694.789546] PGD 118ff0067 P4D 118ff0067 PUD 135915067 PMD 0 
[ 1694.790772] Oops: 0000 [#1] SMP NOPTI
[ 1694.791749] CPU: 7 PID: 1514 Comm: tlocklfs Not tainted 4.19.0+ #56
[ 1694.792876] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20180531_142017-buildhw-08.phx2.fedoraproject.org-1.fc28 04/01/2014
[ 1694.795179] RIP: 0010:__locks_delete_block+0x14/0x90
[ 1694.796203] Code: 01 a1 e9 9f 4f d8 ff 0f 1f 44 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 8b 05 29 9d 58 01 55 53 48 89 fb 85 c0 75 5a <48> 8b 43 20 48 85 c0 74 20 48 8b 53 18 48 89 10 48 85 d2 74 04 48
[ 1694.799277] RSP: 0018:ffff9d21c1f63cb8 EFLAGS: 00010202
[ 1694.800374] RAX: 0000000000000001 RBX: 000000000000000c RCX: aaaaaaaaaaaaaaad
[ 1694.801682] RDX: 0000000000000001 RSI: ffffffff9f7b0c38 RDI: 0000000000000246
[ 1694.802996] RBP: 000000000000000c R08: 0000000000000000 R09: 0000000000000001
[ 1694.804317] R10: 0000000000000001 R11: ffffffffa0bdc188 R12: ffff9d21c1f63dd8
[ 1694.805633] R13: ffff9d21c1f63e00 R14: ffffffff9f3241a8 R15: ffff8d0b5aef72e0
[ 1694.806941] FS:  00007efc8699c740(0000) GS:ffff8d0b7ba00000(0000) knlGS:0000000000000000
[ 1694.808380] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1694.809550] CR2: 000000000000002c CR3: 000000011e0d8000 CR4: 00000000000006e0
[ 1694.810888] Call Trace:
[ 1694.811692]  __locks_wake_up_blocks+0x2d/0x80
[ 1694.812713]  locks_delete_block+0x1d/0x40
[ 1694.813691]  locks_lock_inode_wait+0x9c/0x1c0
[ 1694.814731]  nfs4_proc_lock+0x120/0x440 [nfsv4]
[ 1694.815786]  ? nfs_put_lock_context+0x25/0x80 [nfs]
[ 1694.816866]  ? do_unlk+0x98/0xe0 [nfs]
[ 1694.817818]  locks_remove_posix+0xba/0x1d0
[ 1694.818811]  ? _cond_resched+0x15/0x30
[ 1694.819768]  ? wait_on_commit+0x38/0xb0 [nfs]
[ 1694.820787]  ? process_echoes+0x60/0x60
[ 1694.821752]  ? __nfs_commit_inode+0xc2/0x1c0 [nfs]
[ 1694.822819]  filp_close+0x56/0x70
[ 1694.823712]  __x64_sys_close+0x1e/0x50
[ 1694.824661]  do_syscall_64+0x60/0x1f0
[ 1694.825599]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[ 1694.826731] RIP: 0033:0x7efc8616c0a4
[ 1694.827673] Code: eb 89 e8 af f6 01 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 8b 05 aa e7 2c 00 48 63 ff 85 c0 75 13 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 44 f3 c3 66 90 48 83 ec 18 48 89 7c 24 08 e8
[ 1694.830929] RSP: 002b:00007ffc70beb7b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
[ 1694.832371] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007efc8616c0a4
[ 1694.833784] RDX: 0000000000000000 RSI: 00007efc864378a0 RDI: 0000000000000009
[ 1694.835183] RBP: 00007ffc70beb7d0 R08: 00007efc864378a0 R09: 00007efc8699c740
[ 1694.836560] R10: 00000000000006b4 R11: 0000000000000246 R12: 0000000000401000
[ 1694.837941] R13: 00007ffc70beb990 R14: 0000000000000000 R15: 0000000000000000
[ 1694.839322] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver nfs fscache nfsd auth_rpcgss nfs_acl lockd grace ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 xt_conntrack ip_set nfnetlink ebtable_nat ebtable_broute bridge stp llc ip6table_nat nf_nat_ipv6 ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat_ipv4 nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw iptable_security ebtable_filter ebtables ip6table_filter ip6_tables sunrpc joydev virtio_balloon i2c_piix4 pcspkr edac_mce_amd xfs libcrc32c serio_raw virtio_blk qxl drm_kms_helper virtio_net ttm net_failover virtio_console failover drm ata_generic pata_acpi floppy qemu_fw_cfg
[ 1694.849736] CR2: 000000000000002c
[ 1694.850813] ---[ end trace da2f469c62deb564 ]---

-- 
Jeff Layton <jlayton@kernel.org>

