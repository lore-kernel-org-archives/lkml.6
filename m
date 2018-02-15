Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1883814-1518710378-2-16605781822852327202
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518710377; b=sy0OMf8MnOK6AahjaMBFWE7vl5k3fw8LOgYA87rf1lSGFHq
    l1EJxkigdY6jOhROqgKWdkB08mon4/mkk2Dg7+wi5X6Ug75ArtUPAXeqb/TcUgdf
    rjziM+zksEMV06aWaKas9IMmEbeMs4vyfFnFn9fosxWMcR/rGFxlz5Cs4fkVlWWG
    hcXY8yVTlo+sSMDCy7gpzq4f+PBAOh8kGPKICGL2lOWwmJgZZnkhBayrXHjmdArm
    UHeKAo98Y6ZDbDvZ7T0rmhogiAriYuz9/iP/LPl8X/Jwbr3K5CFhHliA6Pc6PDHE
    JkLnGz/UKnTnGMWGN1MV14yT3l0RXCV+g6K5z8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518710377; bh=n/YF/0tPzTXbBdPX2GjCyYAKVF
    GyK768i2qnKMmszuc=; b=S5iyEvGNHpKgDJLGGLST4VIDzdN8hlJt7cjUs2Mox0
    kcfLc20gonLsBO/MK/TfZfhzuQ+9aXXdR2IGZ0rI9cQP0XSoBe7hBG1QmCMoyWxS
    +/t6C9693ssj+0MibWECNlivKkYABpwYyFMohDk9aDfVPPwFu3rW1Dmlu2OkopI8
    +T7IjZd+6WNZ2J80hb3tpGtNMmzAHOEE1xlqMfwbKLhZeyiBGY1syqx665VRdUiN
    AAvZamV7n6MHmegkOIN4cUxOXHCXlFAxnbQKk0XFV174eiEky6w9SEBTQ+9Trv7X
    QiudbFvtvzdfuLWTUzqpDNsPw7yqJN8FbL2HqbvENPzg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424878AbeBOP6m (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:58:42 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36006 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424812AbeBOPrB (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:47:01 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Yi Zhang <yi.zhang@redhat.com>, Ming Lei <ming.lei@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.15 183/202] blk-mq: quiesce queue before freeing queue
Date: Thu, 15 Feb 2018 16:18:03 +0100
Message-Id: <20180215151722.419280949@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -699,6 +699,15 @@ void blk_cleanup_queue(struct request_qu
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
 
