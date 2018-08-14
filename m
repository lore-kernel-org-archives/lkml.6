Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27799C46470
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D602421727
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:35:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D602421727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbeHNUXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:23:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57130 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbeHNUXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:23:06 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E48A3DF2;
        Tue, 14 Aug 2018 17:34:57 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Laurence Oberman <loberman@redhat.com>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Omar Sandoval <osandov@fb.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>
Subject: [PATCH 4.14 005/104] scsi: virtio_scsi: fix IO hang caused by automatic irq vector affinity
Date:   Tue, 14 Aug 2018 19:16:19 +0200
Message-Id: <20180814171515.629502779@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171515.270692185@linuxfoundation.org>
References: <20180814171515.270692185@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming Lei <ming.lei@redhat.com>

commit b5b6e8c8d3b4cbeb447a0f10c7d5de3caa573299 upstream.

Since commit 84676c1f21e8ff5 ("genirq/affinity: assign vectors to all
possible CPUs") it is possible to end up in a scenario where only
offline CPUs are mapped to an interrupt vector.

This is only an issue for the legacy I/O path since with blk-mq/scsi-mq
an I/O can't be submitted to a hardware queue if the queue isn't mapped
to an online CPU.

Fix this issue by forcing virtio-scsi to use blk-mq.

[mkp: commit desc]

Cc: Omar Sandoval <osandov@fb.com>,
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
Cc: James Bottomley <james.bottomley@hansenpartnership.com>,
Cc: Christoph Hellwig <hch@lst.de>,
Cc: Don Brace <don.brace@microsemi.com>
Cc: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Laurence Oberman <loberman@redhat.com>
Fixes: 84676c1f21e8 ("genirq/affinity: assign vectors to all possible CPUs")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/virtio_scsi.c |   59 ++-------------------------------------------
 1 file changed, 3 insertions(+), 56 deletions(-)

--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -91,9 +91,6 @@ struct virtio_scsi_vq {
 struct virtio_scsi_target_state {
 	seqcount_t tgt_seq;
 
-	/* Count of outstanding requests. */
-	atomic_t reqs;
-
 	/* Currently active virtqueue for requests sent to this target. */
 	struct virtio_scsi_vq *req_vq;
 };
@@ -152,8 +149,6 @@ static void virtscsi_complete_cmd(struct
 	struct virtio_scsi_cmd *cmd = buf;
 	struct scsi_cmnd *sc = cmd->sc;
 	struct virtio_scsi_cmd_resp *resp = &cmd->resp.cmd;
-	struct virtio_scsi_target_state *tgt =
-				scsi_target(sc->device)->hostdata;
 
 	dev_dbg(&sc->device->sdev_gendev,
 		"cmd %p response %u status %#02x sense_len %u\n",
@@ -210,8 +205,6 @@ static void virtscsi_complete_cmd(struct
 	}
 
 	sc->scsi_done(sc);
-
-	atomic_dec(&tgt->reqs);
 }
 
 static void virtscsi_vq_done(struct virtio_scsi *vscsi,
@@ -580,10 +573,7 @@ static int virtscsi_queuecommand_single(
 					struct scsi_cmnd *sc)
 {
 	struct virtio_scsi *vscsi = shost_priv(sh);
-	struct virtio_scsi_target_state *tgt =
-				scsi_target(sc->device)->hostdata;
 
-	atomic_inc(&tgt->reqs);
 	return virtscsi_queuecommand(vscsi, &vscsi->req_vqs[0], sc);
 }
 
@@ -596,55 +586,11 @@ static struct virtio_scsi_vq *virtscsi_p
 	return &vscsi->req_vqs[hwq];
 }
 
-static struct virtio_scsi_vq *virtscsi_pick_vq(struct virtio_scsi *vscsi,
-					       struct virtio_scsi_target_state *tgt)
-{
-	struct virtio_scsi_vq *vq;
-	unsigned long flags;
-	u32 queue_num;
-
-	local_irq_save(flags);
-	if (atomic_inc_return(&tgt->reqs) > 1) {
-		unsigned long seq;
-
-		do {
-			seq = read_seqcount_begin(&tgt->tgt_seq);
-			vq = tgt->req_vq;
-		} while (read_seqcount_retry(&tgt->tgt_seq, seq));
-	} else {
-		/* no writes can be concurrent because of atomic_t */
-		write_seqcount_begin(&tgt->tgt_seq);
-
-		/* keep previous req_vq if a reader just arrived */
-		if (unlikely(atomic_read(&tgt->reqs) > 1)) {
-			vq = tgt->req_vq;
-			goto unlock;
-		}
-
-		queue_num = smp_processor_id();
-		while (unlikely(queue_num >= vscsi->num_queues))
-			queue_num -= vscsi->num_queues;
-		tgt->req_vq = vq = &vscsi->req_vqs[queue_num];
- unlock:
-		write_seqcount_end(&tgt->tgt_seq);
-	}
-	local_irq_restore(flags);
-
-	return vq;
-}
-
 static int virtscsi_queuecommand_multi(struct Scsi_Host *sh,
 				       struct scsi_cmnd *sc)
 {
 	struct virtio_scsi *vscsi = shost_priv(sh);
-	struct virtio_scsi_target_state *tgt =
-				scsi_target(sc->device)->hostdata;
-	struct virtio_scsi_vq *req_vq;
-
-	if (shost_use_blk_mq(sh))
-		req_vq = virtscsi_pick_vq_mq(vscsi, sc);
-	else
-		req_vq = virtscsi_pick_vq(vscsi, tgt);
+	struct virtio_scsi_vq *req_vq = virtscsi_pick_vq_mq(vscsi, sc);
 
 	return virtscsi_queuecommand(vscsi, req_vq, sc);
 }
@@ -775,7 +721,6 @@ static int virtscsi_target_alloc(struct
 		return -ENOMEM;
 
 	seqcount_init(&tgt->tgt_seq);
-	atomic_set(&tgt->reqs, 0);
 	tgt->req_vq = &vscsi->req_vqs[0];
 
 	starget->hostdata = tgt;
@@ -823,6 +768,7 @@ static struct scsi_host_template virtscs
 	.target_alloc = virtscsi_target_alloc,
 	.target_destroy = virtscsi_target_destroy,
 	.track_queue_depth = 1,
+	.force_blk_mq = 1,
 };
 
 static struct scsi_host_template virtscsi_host_template_multi = {
@@ -844,6 +790,7 @@ static struct scsi_host_template virtscs
 	.target_destroy = virtscsi_target_destroy,
 	.map_queues = virtscsi_map_queues,
 	.track_queue_depth = 1,
+	.force_blk_mq = 1,
 };
 
 #define virtscsi_config_get(vdev, fld) \


