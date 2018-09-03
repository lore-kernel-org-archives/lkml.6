Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1F4C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3275E20779
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:05:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3275E20779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729560AbeICV0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:26:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39524 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728032AbeICV0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:26:35 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7767DD07;
        Mon,  3 Sep 2018 17:05:34 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Thumshirn <jthumshirn@suse.de>,
        ard <ard@kwaak.net>, Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 046/107] scsi: fcoe: clear FC_RP_STARTED flags when receiving a LOGO
Date:   Mon,  3 Sep 2018 18:56:10 +0200
Message-Id: <20180903165639.512393460@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165637.293735109@linuxfoundation.org>
References: <20180903165637.293735109@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Thumshirn <jthumshirn@suse.de>

[ Upstream commit 1550ec458e0cf1a40a170ab1f4c46e3f52860f65 ]

When receiving a LOGO request we forget to clear the FC_RP_STARTED flag
before starting the rport delete routine.

As the started flag was not cleared, we're not deleting the rport but
waiting for a restart and thus are keeping the reference count of the rdata
object at 1.

This leads to the following kmemleak report:
unreferenced object 0xffff88006542aa00 (size 512):
  comm "kworker/0:2", pid 24, jiffies 4294899222 (age 226.880s)
  hex dump (first 32 bytes):
    68 96 fe 65 00 88 ff ff 00 00 00 00 00 00 00 00  h..e............
    01 00 00 00 08 00 00 00 02 c5 45 24 ac b8 00 10  ..........E$....
  backtrace:
    [<(____ptrval____)>] fcoe_ctlr_vn_add.isra.5+0x7f/0x770 [libfcoe]
    [<(____ptrval____)>] fcoe_ctlr_vn_recv+0x12af/0x27f0 [libfcoe]
    [<(____ptrval____)>] fcoe_ctlr_recv_work+0xd01/0x32f0 [libfcoe]
    [<(____ptrval____)>] process_one_work+0x7ff/0x1420
    [<(____ptrval____)>] worker_thread+0x87/0xef0
    [<(____ptrval____)>] kthread+0x2db/0x390
    [<(____ptrval____)>] ret_from_fork+0x35/0x40
    [<(____ptrval____)>] 0xffffffffffffffff

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Reported-by: ard <ard@kwaak.net>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/libfc/fc_rport.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/scsi/libfc/fc_rport.c
+++ b/drivers/scsi/libfc/fc_rport.c
@@ -1935,6 +1935,7 @@ static void fc_rport_recv_logo_req(struc
 		FC_RPORT_DBG(rdata, "Received LOGO request while in state %s\n",
 			     fc_rport_state(rdata));
 
+		rdata->flags &= ~FC_RP_STARTED;
 		fc_rport_enter_delete(rdata, RPORT_EV_STOP);
 		mutex_unlock(&rdata->rp_mutex);
 		kref_put(&rdata->kref, rdata->local_port->tt.rport_destroy);


