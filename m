Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AB8JxZpaAwvgwoHF68VfpDrquxbAcfgKgdIjtmIX7J443BDGTqoV6r+4vMLMdPYnXrMyQFWJknD2
ARC-Seal: i=1; a=rsa-sha256; t=1524652921; cv=none;
        d=google.com; s=arc-20160816;
        b=Q1fTcCALmoJxS3aWNmnokFmopdDe3a3mLlr9KDhc3hCEEbEYLbb1kfnURK3JkINHUF
         jReDBe0z+Fpy5WrY1fn1ZPrNpicsJPbzlLLD1LCt0UY8x2hAWdNqy55PDUZkjVWMO+FI
         KsKxvwGPpHsOG2IHRoCvM3HNOMGr7A+wSNRFcO6nAy5K4ckRWkM5YWhssmI3+Pke2wKY
         CFbEBHIEJT4E+B273dria2+Z+OCXhig2bXzePiVysPTX5YcKPDasayyJTGUaw0D3X6Su
         YxiaYTNc/5MvfwGeKWTXbUl5nF8oPTta5yXORMI8nSP9KEmTCBWfxaqo720zxrO00ZoJ
         +rPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=AO5WVkmlQoTOdW4CpTP87PDP/EgNxV4QduiZHp7RhEE=;
        b=KS6QKolDFniTIhUVssglxhYSJKAXbQ4sqbquVC6Vv6TIV4n95pMMZ82jH5ep9wD6q1
         fz03EMUCmKoIMpqkR6g5HtrUU//5ueb3vN5r1zcTxGHd/X66ftSrhkQhnywt5pIhoc9r
         7qh/wmKbj/x7g1ZPKdcFqYE2+OWJ/xzhAjjLcT5uLm5vEj8vFWaicCSfUfz5d9h6ewNK
         g7DKbiLO23c3VlH2awuAFCweHdfzHL29F+VJgYw29XzY57ZM1xVBqh6ufPKE3e7KMl4v
         GTNfOAesfzG+wNFh0nneh/yVTX8NxRIDkjr1dRtsB38MRu9m2Z79qbSidBq1t6XrnB5V
         5m2w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 119/183] blk-mq: fix discard merge with scheduler attached
Date: Wed, 25 Apr 2018 12:35:39 +0200
Message-Id: <20180425103247.217048813@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714461312582731?=
X-GMAIL-MSGID: =?utf-8?q?1598714461312582731?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jens Axboe <axboe@kernel.dk>


[ Upstream commit 445251d0f4d329aa061f323546cd6388a3bb7ab5 ]

I ran into an issue on my laptop that triggered a bug on the
discard path:

WARNING: CPU: 2 PID: 207 at drivers/nvme/host/core.c:527 nvme_setup_cmd+0x3d3/0x430
 Modules linked in: rfcomm fuse ctr ccm bnep arc4 binfmt_misc snd_hda_codec_hdmi nls_iso8859_1 nls_cp437 vfat snd_hda_codec_conexant fat snd_hda_codec_generic iwlmvm snd_hda_intel snd_hda_codec snd_hwdep mac80211 snd_hda_core snd_pcm snd_seq_midi snd_seq_midi_event snd_rawmidi snd_seq x86_pkg_temp_thermal intel_powerclamp kvm_intel uvcvideo iwlwifi btusb snd_seq_device videobuf2_vmalloc btintel videobuf2_memops kvm snd_timer videobuf2_v4l2 bluetooth irqbypass videobuf2_core aesni_intel aes_x86_64 crypto_simd cryptd snd glue_helper videodev cfg80211 ecdh_generic soundcore hid_generic usbhid hid i915 psmouse e1000e ptp pps_core xhci_pci xhci_hcd intel_gtt
 CPU: 2 PID: 207 Comm: jbd2/nvme0n1p7- Tainted: G     U           4.15.0+ #176
 Hardware name: LENOVO 20FBCTO1WW/20FBCTO1WW, BIOS N1FET59W (1.33 ) 12/19/2017
 RIP: 0010:nvme_setup_cmd+0x3d3/0x430
 RSP: 0018:ffff880423e9f838 EFLAGS: 00010217
 RAX: 0000000000000000 RBX: ffff880423e9f8c8 RCX: 0000000000010000
 RDX: ffff88022b200010 RSI: 0000000000000002 RDI: 00000000327f0000
 RBP: ffff880421251400 R08: ffff88022b200000 R09: 0000000000000009
 R10: 0000000000000000 R11: 0000000000000000 R12: 000000000000ffff
 R13: ffff88042341e280 R14: 000000000000ffff R15: ffff880421251440
 FS:  0000000000000000(0000) GS:ffff880441500000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 000055b684795030 CR3: 0000000002e09006 CR4: 00000000001606e0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  nvme_queue_rq+0x40/0xa00
  ? __sbitmap_queue_get+0x24/0x90
  ? blk_mq_get_tag+0xa3/0x250
  ? wait_woken+0x80/0x80
  ? blk_mq_get_driver_tag+0x97/0xf0
  blk_mq_dispatch_rq_list+0x7b/0x4a0
  ? deadline_remove_request+0x49/0xb0
  blk_mq_do_dispatch_sched+0x4f/0xc0
  blk_mq_sched_dispatch_requests+0x106/0x170
  __blk_mq_run_hw_queue+0x53/0xa0
  __blk_mq_delay_run_hw_queue+0x83/0xa0
  blk_mq_run_hw_queue+0x6c/0xd0
  blk_mq_sched_insert_request+0x96/0x140
  __blk_mq_try_issue_directly+0x3d/0x190
  blk_mq_try_issue_directly+0x30/0x70
  blk_mq_make_request+0x1a4/0x6a0
  generic_make_request+0xfd/0x2f0
  ? submit_bio+0x5c/0x110
  submit_bio+0x5c/0x110
  ? __blkdev_issue_discard+0x152/0x200
  submit_bio_wait+0x43/0x60
  ext4_process_freed_data+0x1cd/0x440
  ? account_page_dirtied+0xe2/0x1a0
  ext4_journal_commit_callback+0x4a/0xc0
  jbd2_journal_commit_transaction+0x17e2/0x19e0
  ? kjournald2+0xb0/0x250
  kjournald2+0xb0/0x250
  ? wait_woken+0x80/0x80
  ? commit_timeout+0x10/0x10
  kthread+0x111/0x130
  ? kthread_create_worker_on_cpu+0x50/0x50
  ? do_group_exit+0x3a/0xa0
  ret_from_fork+0x1f/0x30
 Code: 73 89 c1 83 ce 10 c1 e1 10 09 ca 83 f8 04 0f 87 0f ff ff ff 8b 4d 20 48 8b 7d 00 c1 e9 09 48 01 8c c7 00 08 00 00 e9 f8 fe ff ff <0f> ff 4c 89 c7 41 bc 0a 00 00 00 e8 0d 78 d6 ff e9 a1 fc ff ff
 ---[ end trace 50d361cc444506c8 ]---
 print_req_error: I/O error, dev nvme0n1, sector 847167488

Decoding the assembly, the request claims to have 0xffff segments,
while nvme counts two. This turns out to be because we don't check
for a data carrying request on the mq scheduler path, and since
blk_phys_contig_segment() returns true for a non-data request,
we decrement the initial segment count of 0 and end up with
0xffff in the unsigned short.

There are a few issues here:

1) We should initialize the segment count for a discard to 1.
2) The discard merging is currently using the data limits for
   segments and sectors.

Fix this up by having attempt_merge() correctly identify the
request, and by initializing the segment count correctly
for discards.

This can only be triggered with mq-deadline on discard capable
devices right now, which isn't a common configuration.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/blk-core.c  |    2 ++
 block/blk-merge.c |   29 ++++++++++++++++++++++++++---
 2 files changed, 28 insertions(+), 3 deletions(-)

--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -3065,6 +3065,8 @@ void blk_rq_bio_prep(struct request_queu
 {
 	if (bio_has_data(bio))
 		rq->nr_phys_segments = bio_phys_segments(q, bio);
+	else if (bio_op(bio) == REQ_OP_DISCARD)
+		rq->nr_phys_segments = 1;
 
 	rq->__data_len = bio->bi_iter.bi_size;
 	rq->bio = rq->biotail = bio;
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -551,6 +551,24 @@ static bool req_no_special_merge(struct
 	return !q->mq_ops && req->special;
 }
 
+static bool req_attempt_discard_merge(struct request_queue *q, struct request *req,
+		struct request *next)
+{
+	unsigned short segments = blk_rq_nr_discard_segments(req);
+
+	if (segments >= queue_max_discard_segments(q))
+		goto no_merge;
+	if (blk_rq_sectors(req) + bio_sectors(next->bio) >
+	    blk_rq_get_max_sectors(req, blk_rq_pos(req)))
+		goto no_merge;
+
+	req->nr_phys_segments = segments + blk_rq_nr_discard_segments(next);
+	return true;
+no_merge:
+	req_set_nomerge(q, req);
+	return false;
+}
+
 static int ll_merge_requests_fn(struct request_queue *q, struct request *req,
 				struct request *next)
 {
@@ -684,9 +702,13 @@ static struct request *attempt_merge(str
 	 * If we are allowed to merge, then append bio list
 	 * from next to rq and release next. merge_requests_fn
 	 * will have updated segment counts, update sector
-	 * counts here.
+	 * counts here. Handle DISCARDs separately, as they
+	 * have separate settings.
 	 */
-	if (!ll_merge_requests_fn(q, req, next))
+	if (req_op(req) == REQ_OP_DISCARD) {
+		if (!req_attempt_discard_merge(q, req, next))
+			return NULL;
+	} else if (!ll_merge_requests_fn(q, req, next))
 		return NULL;
 
 	/*
@@ -716,7 +738,8 @@ static struct request *attempt_merge(str
 
 	req->__data_len += blk_rq_bytes(next);
 
-	elv_merge_requests(q, req, next);
+	if (req_op(req) != REQ_OP_DISCARD)
+		elv_merge_requests(q, req, next);
 
 	/*
 	 * 'next' is going away, so update stats accordingly
