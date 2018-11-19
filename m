Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034DEC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C174E205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwjhgNKa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C174E205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730855AbeKTC4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:56:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:55120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730817AbeKTC4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:56:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 300A420831;
        Mon, 19 Nov 2018 16:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645160;
        bh=L+3MMyd9MjHL7IkmilZQd4LaoLQ63dlf9tSIGQ2DRPw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KwjhgNKaxKpbbaN6tS6S+nJzcRlHGbDMucRUu4a5YOPAXhsK5KouqDvOl1Z1ywy+B
         fjwxISygBBapYLLnanALUrILboT+4mkpR1/QthXWk3n1dvOciLLkXC0HlhgWHHh+EY
         vhrr2mkU0HV/7FRnCDmFpccp/z43UMR+sGS+PzqA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Giridhar Malavali <giridhar.malavali@cavium.com>,
        "Ewan D. Milne" <emilne@redhat.com>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.19 058/205] scsi: qla2xxx: Fix for double free of SRB structure
Date:   Mon, 19 Nov 2018 17:26:05 +0100
Message-Id: <20181119162627.463264521@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Giridhar Malavali <giridhar.malavali@cavium.com>

commit bcc71cc3cde1468958a3ea859276d8d1a1a68265 upstream.

This patch fixes issue during switch command query where driver was freeing
SRB resources multiple times

Following stack trace will be seen
[  853.436234] BUG: unable to handle kernel NULL pointer dereference at
0000000000000001
[  853.436348] IP: [<ffffffff811df514>] kmem_cache_alloc+0x74/0x1e0
[  853.436476] PGD 0
[  853.436601] Oops: 0000 [#1] SMP

[  853.454700]  [<ffffffff81099f6a>] ? mod_timer+0x14a/0x220
[  853.455543]  [<ffffffff81185465>] mempool_alloc_slab+0x15/0x20
[  853.456395]  [<ffffffff811855a9>] mempool_alloc+0x69/0x170
[  853.457257]  [<ffffffff81098af2>] ? internal_add_timer+0x32/0x70
[  853.458136]  [<ffffffffc0092d2b>] qla2xxx_queuecommand+0x29b/0x3f0 [qla2xxx]
[  853.459024]  [<ffffffff8146535a>] scsi_dispatch_cmd+0xaa/0x230
[  853.459923]  [<ffffffff8146e11f>] scsi_request_fn+0x4df/0x680
[  853.460829]  [<ffffffff81029557>] ? __switch_to+0xd7/0x510
[  853.461747]  [<ffffffff812f7113>] __blk_run_queue+0x33/0x40
[  853.462670]  [<ffffffff812f7735>] blk_delay_work+0x25/0x40
[  853.463603]  [<ffffffff810a882a>] process_one_work+0x17a/0x440
[  853.464546]  [<ffffffff810a94f6>] worker_thread+0x126/0x3c0
[  853.465501]  [<ffffffff810a93d0>] ? manage_workers.isra.24+0x2a0/0x2a0
[  853.466447]  [<ffffffff810b099f>] kthread+0xcf/0xe0
[  853.467379]  [<ffffffff810b08d0>] ? insert_kthread_work+0x40/0x40
[  853.470172] Code: db e2 7e 49 8b 50 08 4d 8b 20 49 8b 40 10 4d 85 e4 0f 84 20
01 00 00 48 85 c0 0f 84 17 01 00 00 49 63 46 20 48 8d 4a 01 4d 8b 06 <49> 8b 1c
04 4c 89 e0 65 49 0f c7 08 0f 94 c0 84 c0 74 ba 49 63
[  853.472072] RIP  [<ffffffff811df514>] kmem_cache_alloc+0x74/0x1e0
[  853.472971]  RSP <ffff88103726fc50>

Fixes: 726b85487067 ("qla2xxx: Add framework for async fabric discovery")
Cc: <stable@vger.kernel.org>
Signed-off-by: Giridhar Malavali <giridhar.malavali@cavium.com>
Reviewed-by: Ewan D. Milne <emilne@redhat.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_gs.c   |    3 +++
 drivers/scsi/qla2xxx/qla_init.c |   15 +++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@ -3261,6 +3261,9 @@ static void qla24xx_async_gpsc_sp_done(v
 	    "Async done-%s res %x, WWPN %8phC \n",
 	    sp->name, res, fcport->port_name);
 
+	if (res == QLA_FUNCTION_TIMEOUT)
+		return;
+
 	if (res == (DID_ERROR << 16)) {
 		/* entry status error */
 		goto done;
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -52,12 +52,14 @@ qla2x00_sp_timeout(struct timer_list *t)
 	struct srb_iocb *iocb;
 	struct req_que *req;
 	unsigned long flags;
+	struct qla_hw_data *ha = sp->vha->hw;
 
-	spin_lock_irqsave(sp->qpair->qp_lock_ptr, flags);
+	WARN_ON(irqs_disabled());
+	spin_lock_irqsave(&ha->hardware_lock, flags);
 	req = sp->qpair->req;
 	req->outstanding_cmds[sp->handle] = NULL;
 	iocb = &sp->u.iocb_cmd;
-	spin_unlock_irqrestore(sp->qpair->qp_lock_ptr, flags);
+	spin_unlock_irqrestore(&ha->hardware_lock, flags);
 	iocb->timeout(sp);
 }
 
@@ -972,6 +974,15 @@ void qla24xx_async_gpdb_sp_done(void *s,
 
 	fcport->flags &= ~(FCF_ASYNC_SENT | FCF_ASYNC_ACTIVE);
 
+	if (res == QLA_FUNCTION_TIMEOUT)
+		return;
+
+	if (res == QLA_FUNCTION_TIMEOUT) {
+		dma_pool_free(sp->vha->hw->s_dma_pool, sp->u.iocb_cmd.u.mbx.in,
+			sp->u.iocb_cmd.u.mbx.in_dma);
+		return;
+	}
+
 	memset(&ea, 0, sizeof(ea));
 	ea.event = FCME_GPDB_DONE;
 	ea.fcport = fcport;


