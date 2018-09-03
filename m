Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144C9C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C82E420868
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:51:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C82E420868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbeICVMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:12:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36320 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727686AbeICVMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:12:22 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 750FACF3;
        Mon,  3 Sep 2018 16:51:25 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 33/56] scsi: fcoe: drop frames in ELS LOGO error path
Date:   Mon,  3 Sep 2018 18:49:23 +0200
Message-Id: <20180903164925.713562624@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903164924.078355019@linuxfoundation.org>
References: <20180903164924.078355019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Thumshirn <jthumshirn@suse.de>

[ Upstream commit 63d0e3dffda311e77b9a8c500d59084e960a824a ]

Drop the frames in the ELS LOGO error path instead of just returning an
error.

This fixes the following kmemleak report:
unreferenced object 0xffff880064cb1000 (size 424):
  comm "kworker/0:2", pid 24, jiffies 4294904293 (age 68.504s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<(____ptrval____)>] _fc_frame_alloc+0x2c/0x180 [libfc]
    [<(____ptrval____)>] fc_lport_enter_logo+0x106/0x360 [libfc]
    [<(____ptrval____)>] fc_fabric_logoff+0x8c/0xc0 [libfc]
    [<(____ptrval____)>] fcoe_if_destroy+0x79/0x3b0 [fcoe]
    [<(____ptrval____)>] fcoe_destroy_work+0xd2/0x170 [fcoe]
    [<(____ptrval____)>] process_one_work+0x7ff/0x1420
    [<(____ptrval____)>] worker_thread+0x87/0xef0
    [<(____ptrval____)>] kthread+0x2db/0x390
    [<(____ptrval____)>] ret_from_fork+0x35/0x40
    [<(____ptrval____)>] 0xffffffffffffffff

which can be triggered by issuing
echo eth0 > /sys/bus/fcoe/ctlr_destroy

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/fcoe/fcoe_ctlr.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/scsi/fcoe/fcoe_ctlr.c
+++ b/drivers/scsi/fcoe/fcoe_ctlr.c
@@ -752,9 +752,9 @@ int fcoe_ctlr_els_send(struct fcoe_ctlr
 	case ELS_LOGO:
 		if (fip->mode == FIP_MODE_VN2VN) {
 			if (fip->state != FIP_ST_VNMP_UP)
-				return -EINVAL;
+				goto drop;
 			if (ntoh24(fh->fh_d_id) == FC_FID_FLOGI)
-				return -EINVAL;
+				goto drop;
 		} else {
 			if (fip->state != FIP_ST_ENABLED)
 				return 0;


