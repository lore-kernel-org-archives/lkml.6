Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2F9C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 11:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EBAF21570
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 11:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wJmfEpRI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EBAF21570
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbeHUOdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 10:33:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:59978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726977AbeHUOdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 10:33:54 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4154E214D5;
        Tue, 21 Aug 2018 11:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534850049;
        bh=IYb761yyPLJTDCOV0i4CzgDG+2nnx6a0B6qgQudLvrE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=wJmfEpRITWRjR0oOqkcu5LR+1Jbn34k/+XjNez78OpeoI4i7u1L37uFy5CDCupSpn
         lvbT58v9TEhZj/PueDVvjGyz6vo/kAE9OnZP3mi9iWhTqw9z4vV+K0OmIuhjUZL9Lp
         bTOs34qQRw8JmT3856SKU9zgpDPaFgvj52oqcXF8=
Message-ID: <99fd03d3002d03f86b0d8a5b1ad4a2015383545e.camel@kernel.org>
Subject: Re: [BUG][BISECT] NFSv4 root failures after "fs/locks: allow a lock
 request to block other requests."
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.com>, Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
Date:   Tue, 21 Aug 2018 07:14:06 -0400
In-Reply-To: <87k1okpam2.fsf@notabene.neil.brown.name>
References: <CAJKOXPc2cb1OK3tmRCO2p+docdXY=PoU1MEBa-VDyEM4mG1eSw@mail.gmail.com>
         <8acb99be800a1842278f754986a17d6fc93af409.camel@kernel.org>
         <87o9e2anwg.fsf@notabene.neil.brown.name>
         <87k1okpam2.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-08-21 at 15:11 +1000, NeilBrown wrote:
> On Thu, Aug 16 2018, NeilBrown wrote:
> 
> > On Wed, Aug 15 2018, Jeff Layton wrote:
> > 
> > > On Wed, 2018-08-15 at 14:28 +0200, Krzysztof Kozlowski wrote:
> > > > Hi,
> > > > 
> > > > Bisect pointed commit ce3147990450a68b3f549088b30f087742a08b5d
> > > > ("fs/locks: allow a lock request to block other requests.") to failure
> > > > boot of NFSv4 with root on several boards.
> > > > 
> > > > Log is here:
> > > > https://krzk.eu/#/builders/21/builds/836/steps/12/logs/serial0
> > > > 
> > > > With several errors:
> > > > kernel BUG at ../fs/locks.c:336!
> > > > Unable to handle kernel NULL pointer dereference at virtual address 00000004
> > > > 
> > > > Configuration:
> > > > 1. exynos_defconfig
> > > > 2. Arch ARM Linux
> > > > 3. Boards:
> > > > a. Odroid family (ARMv7, octa-core (Cortex-A7+A15), Exynos5422 SoC)
> > > > b. Toradex Colibri VF50 (ARMv7, UP, Cortex-A5)
> > > > 4. Systemd: v236, 238
> > > > 5. All boards boot from TFTP with NFS root (NFSv4)
> > > > 
> > > > On Colibri VF50 I got slightly different errors:
> > > > [   11.663204] Internal error: Oops - undefined instruction: 0 [#1] ARM
> > > > [   12.455273] Unable to handle kernel NULL pointer dereference at
> > > > virtual address 00000004
> > > > and only with some specific GCC (v6.3) or with other conditions which
> > > > I did not bisect yet. Maybe Colibri's failure is unrelated to that
> > > > commit.
> > > > 
> > > > Best regards,
> > > > Krzysztof
> > 
> > Thanks a lot for the report Krzysztof!!
> > 
> > > 
> > > The BUG is due to a lock being freed when the fl_blocked list wasn't
> > > empty (implying that there were still blocked locks waiting on it).
> > > 
> > > There are a number of calls to locks_delete_lock_ctx in posix_lock_inode
> > > and I don't think the fl_blocked list is being handled properly with all
> > > of them. It only transplants the blocked locks to a new lock when there
> > > are surviving locks on the list, and that may not be the case when the
> > > whole file is being unlocked.
> > 
> > locks_delete_lock_ctx() calls locks_unlink_lock_ctx() which calls
> > locks_wake_up_block() which doesn't only wake_up the blocks, but also
> > detached them. When that function completes, ->fl_blocked must be empty.
> > 
> > The trace shows the locks_free_lock() call at the end of fcntl_setlk64()
> > as the problematic call.
> > This suggests that do_lock_file_wait() exited with ->fl_blocked
> > non-empty, which it shouldn't.
> > 
> > I think we need to insert a call to locks_wake_up_block() in
> > do_lock_file_wait() before it returns.
> > I cannot find a sequence that would make this necessary, but
> > it isn't surprising that there might be one.
> > 
> > I'll dig through the code a bit more later and make sure I understand
> > what is happening.
> > 
> 
> I think this problem if fixed by the following.  It is probably
> triggered when the owner already has a lock for part of the requested
> range.  After waiting for some other lock, the pending request gets
> merged with the existing lock, and blocked requests aren't moved across
> in that case.
> 
> I still haven't done more testing, so this is just FYI, not a
> submission.
> 
> Thanks,
> NeilBrown
> 
> From: NeilBrown <neilb@suse.com>
> Date: Tue, 21 Aug 2018 15:09:06 +1000
> Subject: [PATCH] fs/locks: always delete_block after waiting.
> 
> Now that requests can block other requests, we
> need to be careful to always clean up those blocked
> requests.
> Any time that we wait for a request, we might have
> other requests attached, and when we stop waiting,
> we much clean them up.
> If the lock was granted, the requests might have been
> moved to the new lock, though when merged with a
> pre-exiting lock, this might not happen.
> No all cases we don't want blocked locks to remain
> attached, so we remove them to be safe.
> 
> Signed-off-by: NeilBrown <neilb@suse.com>
> ---
>  fs/locks.c | 24 +++++++++---------------
>  1 file changed, 9 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/locks.c b/fs/locks.c
> index de38bafb7f7b..6b310112cf3b 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -1276,12 +1276,10 @@ static int posix_lock_inode_wait(struct inode *inode, struct file_lock *fl)
>  		if (error != FILE_LOCK_DEFERRED)
>  			break;
>  		error = wait_event_interruptible(fl->fl_wait, !fl->fl_blocker);
> -		if (!error)
> -			continue;
> -
> -		locks_delete_block(fl);
> -		break;
> +		if (error)
> +			break;
>  	}
> +	locks_delete_block(fl);
>  	return error;
>  }
>  
> @@ -1971,12 +1969,10 @@ static int flock_lock_inode_wait(struct inode *inode, struct file_lock *fl)
>  		if (error != FILE_LOCK_DEFERRED)
>  			break;
>  		error = wait_event_interruptible(fl->fl_wait, !fl->fl_blocker);
> -		if (!error)
> -			continue;
> -
> -		locks_delete_block(fl);
> -		break;
> +		if (error)
> +			break;
>  	}
> +	locks_delete_block(fl);
>  	return error;
>  }
>  
> @@ -2250,12 +2246,10 @@ static int do_lock_file_wait(struct file *filp, unsigned int cmd,
>  		if (error != FILE_LOCK_DEFERRED)
>  			break;
>  		error = wait_event_interruptible(fl->fl_wait, !fl->fl_blocker);
> -		if (!error)
> -			continue;
> -
> -		locks_delete_block(fl);
> -		break;
> +		if (error)
> +			break;
>  	}
> +	locks_delete_block(fl);
>  
>  	return error;
>  }

Thanks Neil.

FWIW, I was able to reproduce something that looked a lot like what
Krzysztof reported by running the cthon04 lock tests on a client running
the kernel with the original set.

I applied the above patch on top of that set, reran the test and got a
different BUG (list corruption):

[   85.117307] ------------[ cut here ]------------
[   85.118130] kernel BUG at lib/list_debug.c:53!
[   85.118684] invalid opcode: 0000 [#1] SMP NOPTI
[   85.119800] CPU: 5 PID: 92 Comm: kworker/u16:1 Not tainted 4.18.0+ #46
[   85.120845] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20180531_142017-buildhw-08.phx2.fedoraproject.org-1.fc28 04/01/2014
[   85.122350] Workqueue: rpciod rpc_async_schedule [sunrpc]
[   85.123242] RIP: 0010:__list_del_entry_valid.cold.1+0x34/0x4c
[   85.124116] Code: 03 10 9b e8 08 07 ca ff 0f 0b 48 c7 c7 c8 03 10 9b e8 fa 06 ca ff 0f 0b 48 89 f2 48 89 fe 48 c7 c7 88 03 10 9b e8 e6 06 ca ff <0f> 0b 48 89 fe 48 c7 c7 50 03 10 9b e8 d5 06 ca ff 0f 0b 90 90 90
[   85.126704] RSP: 0018:ffffa0fe0133bd90 EFLAGS: 00010246
[   85.127382] RAX: 0000000000000054 RBX: ffff92bcf3a46ad8 RCX: 0000000000000000
[   85.128322] RDX: 0000000000000000 RSI: ffff92bcffd56828 RDI: ffff92bcffd56828
[   85.129251] RBP: ffff92bcf3a46b10 R08: 0000000000000000 R09: 0000000000aaaaaa
[   85.130250] R10: 0000000000000000 R11: 0000000000000001 R12: ffff92bce2588618
[   85.131230] R13: ffff92bcf3a45800 R14: ffffffffc06f9f60 R15: ffffffffc06f9f60
[   85.132191] FS:  0000000000000000(0000) GS:ffff92bcffd40000(0000) knlGS:0000000000000000
[   85.133296] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   85.134088] CR2: 00007f16c1292008 CR3: 0000000138588000 CR4: 00000000000006e0
[   85.134926] Call Trace:
[   85.135251]  __locks_delete_block+0x3f/0x70
[   85.135751]  locks_delete_block+0x25/0x30
[   85.136259]  locks_lock_inode_wait+0x63/0x150
[   85.136841]  ? nfs41_release_slot+0x98/0xd0 [nfsv4]
[   85.137556]  nfs4_lock_done+0x1a2/0x1c0 [nfsv4]
[   85.138272]  rpc_exit_task+0x2d/0x80 [sunrpc]
[   85.138994]  __rpc_execute+0x7f/0x340 [sunrpc]
[   85.139953]  process_one_work+0x1a1/0x350
[   85.140678]  worker_thread+0x30/0x380
[   85.141800]  ? wq_update_unbound_numa+0x1a0/0x1a0
[   85.142904]  kthread+0x112/0x130
[   85.143445]  ? kthread_create_worker_on_cpu+0x70/0x70
[   85.144273]  ret_from_fork+0x22/0x40
[   85.144859] Modules linked in: rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace fscache xt_conntrack nf_conntrack ip_set nfnetlink ebtable_nat ebtable_broute bridge stp llc ip6table_mangle ip6table_raw ip6table_security iptable_mangle iptable_raw iptable_security ebtable_filter ebtables ip6table_filter ip6_tables sunrpc i2c_piix4 edac_mce_amd joydev pcspkr virtio_balloon xfs libcrc32c virtio_net net_failover virtio_console failover virtio_blk floppy qxl serio_raw drm_kms_helper ttm qemu_fw_cfg drm virtio_pci ata_generic pata_acpi virtio_rng virtio_ring virtio
[   85.153426] ---[ end trace 63df06139208ee23 ]---

-- 
Jeff Layton <jlayton@kernel.org>

