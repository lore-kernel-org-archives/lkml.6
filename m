Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224Smv5a2NV6T2WrgGdD0XtISSg4oxcD0ZSloZvqg6lKYi267rlzTasiwjcpfni9becIJgji
ARC-Seal: i=1; a=rsa-sha256; t=1518709064; cv=none;
        d=google.com; s=arc-20160816;
        b=SONrvjWKy7sOoDunlqEbv9Uw6QvmHak9o8kKFtfNNdpdmCj32KwULWhoncTR3NHEgw
         xbNUinzeiKL0dp9KBiwHAwXs40DfIZumdsCWme+mijHtPMJA9/8hv0XdoM/ANUM/q22l
         DBj5v/FvO/hWc9GF6Px6RuxPSXLdnlaRY/xwGDt8MzhIA9HYDBWnk0ktHV7sfOuidW/d
         W3URpVd8fjTrsF8jqbDkIzJ5I0q8PNgmfSUreheu/MwzRPBfXx0zRsNit5V6s6onWQwS
         cBI3ioBkH9k5wvhqVNaOnfn43kAfnynK1in7KpHw+Ibz7z4VJQru/1BuvnfojgYyeCw0
         1eSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=uUbwWiY+RFsKyZUhUvJnPThsQZ/1zR4XVoJhAFgoXj8=;
        b=blfufMadYsCnYKDoBT9TkdKPHI3hPYirwze/dDWHM4zS4qG5Pt2B6uHJOP0QpnUm1u
         qXEJV3C8D80Oq/E8MOdOYdC/365MvUlXU5h28cMAaegDyKzIJ0ZxmXD/GdHMHVjgrSDp
         1UPalp2xLpk04qrNE+QD8Tgj8YDFydsQZokJG7gHmGiyU4jSwOzAY/35fDxD7dGpvZqh
         4whBvKVx/3Nen6GSZB2hTJcMQdUqyY95MrcpILt8CzdPr9h9dMyyfs2jqy4CFDFVJvnt
         HNtfRFc80jpbHmtnyl+AOJ6XDhxrhJ6Ydn8PPSfvkUnCjpiIXwRwvI6V/7welMLi/2IG
         hHUg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Yi Zhang <yi.zhang@redhat.com>,
	Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.14 178/195] blk-mq: quiesce queue before freeing queue
Date: Thu, 15 Feb 2018 16:17:49 +0100
Message-Id: <20180215151715.049621793@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481875628498399?=
X-GMAIL-MSGID: =?utf-8?q?1592481875628498399?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming Lei <ming.lei@redhat.com>

commit c2856ae2f315d754a0b6a268e4c6745b332b42e7 upstream.

After queue is frozen, dispatch still may happen, for example:

1) requests are submitted from several contexts
2) requests from all these contexts are inserted to queue, but may dispatch
to LLD in one of these paths, but other paths sill need to move on even all
these requests are completed(that means blk_mq_freeze_queue_wait() returns
at that time)
3) dispatch after queue freezing still moves on and causes use-after-free,
because request queue is freed

This patch quiesces queue after it is frozen, and makes sure all
in-progress dispatch are completed.

This patch fixes the following kernel crash when running heavy IOs vs.
deleting device:

[   36.719251] BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
[   36.720318] IP: kyber_has_work+0x14/0x40
[   36.720847] PGD 254bf5067 P4D 254bf5067 PUD 255e6a067 PMD 0
[   36.721584] Oops: 0000 [#1] PREEMPT SMP
[   36.722105] Dumping ftrace buffer:
[   36.722570]    (ftrace buffer empty)
[   36.723057] Modules linked in: scsi_debug ebtable_filter ebtables ip6table_filter ip6_tables tcm_loop iscsi_target_mod target_core_file target_core_iblock target_core_pscsi target_core_mod xt_CHECKSUM iptable_mangle ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack libcrc32c bridge stp llc fuse iptable_filter ip_tables sd_mod sg btrfs xor zstd_decompress zstd_compress xxhash raid6_pq mptsas mptscsih bcache crc32c_intel ahci mptbase libahci serio_raw scsi_transport_sas nvme libata shpchp lpc_ich virtio_scsi nvme_core binfmt_misc dm_mod iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi null_blk configs
[   36.733438] CPU: 2 PID: 2374 Comm: fio Not tainted 4.15.0-rc2.blk_mq_quiesce+ #714
[   36.735143] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.9.3-1.fc25 04/01/2014
[   36.736688] RIP: 0010:kyber_has_work+0x14/0x40
[   36.737515] RSP: 0018:ffffc9000209bca0 EFLAGS: 00010202
[   36.738431] RAX: 0000000000000008 RBX: ffff88025578bfc8 RCX: ffff880257bf4ed0
[   36.739581] RDX: 0000000000000038 RSI: ffffffff81a98c6d RDI: ffff88025578bfc8
[   36.740730] RBP: ffff880253cebfc8 R08: ffffc9000209bda0 R09: ffff8802554f3480
[   36.741885] R10: ffffc9000209be60 R11: ffff880263f72538 R12: ffff88025573e9e8
[   36.743036] R13: ffff88025578bfd0 R14: 0000000000000001 R15: 0000000000000000
[   36.744189] FS:  00007f9b9bee67c0(0000) GS:ffff88027fc80000(0000) knlGS:0000000000000000
[   36.746617] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   36.748483] CR2: 0000000000000008 CR3: 0000000254bf4001 CR4: 00000000003606e0
[   36.750164] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   36.751455] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   36.752796] Call Trace:
[   36.753992]  blk_mq_do_dispatch_sched+0x7f/0xe0
[   36.755110]  blk_mq_sched_dispatch_requests+0x119/0x190
[   36.756179]  __blk_mq_run_hw_queue+0x83/0x90
[   36.757144]  __blk_mq_delay_run_hw_queue+0xaf/0x110
[   36.758046]  blk_mq_run_hw_queue+0x24/0x70
[   36.758845]  blk_mq_flush_plug_list+0x1e7/0x270
[   36.759676]  blk_flush_plug_list+0xd6/0x240
[   36.760463]  blk_finish_plug+0x27/0x40
[   36.761195]  do_io_submit+0x19b/0x780
[   36.761921]  ? entry_SYSCALL_64_fastpath+0x1a/0x7d
[   36.762788]  entry_SYSCALL_64_fastpath+0x1a/0x7d
[   36.763639] RIP: 0033:0x7f9b9699f697
[   36.764352] RSP: 002b:00007ffc10f991b8 EFLAGS: 00000206 ORIG_RAX: 00000000000000d1
[   36.765773] RAX: ffffffffffffffda RBX: 00000000008f6f00 RCX: 00007f9b9699f697
[   36.766965] RDX: 0000000000a5e6c0 RSI: 0000000000000001 RDI: 00007f9b8462a000
[   36.768377] RBP: 0000000000000000 R08: 0000000000000001 R09: 00000000008f6420
[   36.769649] R10: 00007f9b846e5000 R11: 0000000000000206 R12: 00007f9b795d6a70
[   36.770807] R13: 00007f9b795e4140 R14: 00007f9b795e3fe0 R15: 0000000100000000
[   36.771955] Code: 83 c7 10 e9 3f 68 d1 ff 0f 1f 44 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 8b 97 b0 00 00 00 48 8d 42 08 48 83 c2 38 <48> 3b 00 74 06 b8 01 00 00 00 c3 48 3b 40 08 75 f4 48 83 c0 10
[   36.775004] RIP: kyber_has_work+0x14/0x40 RSP: ffffc9000209bca0
[   36.776012] CR2: 0000000000000008
[   36.776690] ---[ end trace 4045cbce364ff2a4 ]---
[   36.777527] Kernel panic - not syncing: Fatal exception
[   36.778526] Dumping ftrace buffer:
[   36.779313]    (ftrace buffer empty)
[   36.780081] Kernel Offset: disabled
[   36.780877] ---[ end Kernel panic - not syncing: Fatal exception

Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/blk-core.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -660,6 +660,15 @@ void blk_cleanup_queue(struct request_qu
 	queue_flag_set(QUEUE_FLAG_DEAD, q);
 	spin_unlock_irq(lock);
 
+	/*
+	 * make sure all in-progress dispatch are completed because
+	 * blk_freeze_queue() can only complete all requests, and
+	 * dispatch may still be in-progress since we dispatch requests
+	 * from more than one contexts
+	 */
+	if (q->mq_ops)
+		blk_mq_quiesce_queue(q);
+
 	/* for synchronous bio-based driver finish in-flight integrity i/o */
 	blk_flush_integrity();
 
