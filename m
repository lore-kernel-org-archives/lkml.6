Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBA5C282C0
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 07:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9D97214C6
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 07:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ewZHFfyO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfA0HIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 02:08:40 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:2665 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfA0HIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 02:08:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1548572919; x=1580108919;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=I9uS5c2zlfuikCDmgUHPIcKKT9lIOhMWPAj4ZVXpxX0=;
  b=ewZHFfyOEONzoSFa0iolQMtNEm3bQJxbjPZdXm5cU6BLvr5Pm2i2R1uy
   03Dr7a2Krsu9dc3Lb4wAkBbTuBiALb/TcxEz2HENDw2yclCVasMjrG6PZ
   0R90Irvc/lXVnROI5Ip5oVW/Ns3W4HrJjFoZw5eNEKJFexRDGRdp3N45v
   gVj1LdhBcCZBP1tsNwnZOT4ievQobSagmb+NTNkj2Ka/pp0boT9r5WCIK
   Chi1w8c95YWX1037AWKFeRpiZl9cW8GNogl2fVfIJ+H4fSinwGdxEKrBO
   D1XgXHUw1FsFHNyL8/coxXOpQiFcjMqDSnNJXrgZcN6ptGC7c8OqIXoRe
   w==;
X-IronPort-AV: E=Sophos;i="5.56,529,1539619200"; 
   d="scan'208";a="204903924"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jan 2019 15:08:39 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 26 Jan 2019 22:49:42 -0800
Received: from kfae422988.sdcorp.global.sandisk.com ([10.0.230.227])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Jan 2019 23:08:38 -0800
From:   Avri Altman <avri.altman@wdc.com>
To:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Evan Green <evgreen@chromium.org>
Cc:     Avi Shchislowski <avi.shchislowski@wdc.com>,
        Alex Lemberg <alex.lemberg@wdc.com>,
        Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v4 3/3] scsi: ufs-bsg: Allow reading descriptors
Date:   Sun, 27 Jan 2019 09:07:48 +0200
Message-Id: <1548572868-12589-4-git-send-email-avri.altman@wdc.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1548572868-12589-1-git-send-email-avri.altman@wdc.com>
References: <1548572868-12589-1-git-send-email-avri.altman@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add this functionality, placing the descriptor being read in the actual
data buffer in the bio.

That is, for both read and write descriptors query upiu, we are using
the job's request_payload.  This in turn, is mapped back in user land to
the applicable sg_io_v4 xferp: dout_xferp for write descriptor,
and din_xferp for read descriptor.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 Documentation/scsi/ufs.txt |  7 ++++++-
 drivers/scsi/ufs/ufs_bsg.c | 20 ++++++++++++--------
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/Documentation/scsi/ufs.txt b/Documentation/scsi/ufs.txt
index 78fe7cb..1769f71 100644
--- a/Documentation/scsi/ufs.txt
+++ b/Documentation/scsi/ufs.txt
@@ -150,9 +150,14 @@ send SG_IO with the applicable sg_io_v4:
 	if (dir == SG_DXFER_TO_DEV) {
 		io_hdr_v4.dout_xfer_len = (uint32_t)byte_cnt;
 		io_hdr_v4.dout_xferp = (uintptr_t)(__u64)buff;
+	} else {
+		io_hdr_v4.din_xfer_len = (uint32_t)byte_cnt;
+		io_hdr_v4.din_xferp = (uintptr_t)(__u64)buff;
 	}
 
-If you wish to write a descriptor, use the dout_xferp sg_io_v4.
+If you wish to read or write a descriptor, use the appropriate xferp of
+sg_io_v4.
+
 
 UFS Specifications can be found at,
 UFS - http://www.jedec.org/sites/default/files/docs/JESD220.pdf
diff --git a/drivers/scsi/ufs/ufs_bsg.c b/drivers/scsi/ufs/ufs_bsg.c
index 2fd0769..869e71f 100644
--- a/drivers/scsi/ufs/ufs_bsg.c
+++ b/drivers/scsi/ufs/ufs_bsg.c
@@ -48,12 +48,8 @@ static int ufs_bsg_alloc_desc_buffer(struct ufs_hba *hba, struct bsg_job *job,
 	struct utp_upiu_query *qr;
 	u8 *descp;
 
-	if (desc_op == UPIU_QUERY_OPCODE_READ_DESC) {
-		dev_err(hba->dev, "unsupported opcode %d\n", desc_op);
-		return -ENOTSUPP;
-	}
-
-	if (desc_op != UPIU_QUERY_OPCODE_WRITE_DESC)
+	if (desc_op != UPIU_QUERY_OPCODE_WRITE_DESC &&
+	    desc_op != UPIU_QUERY_OPCODE_READ_DESC)
 		goto out;
 
 	qr = &bsg_request->upiu_req.qr;
@@ -71,8 +67,10 @@ static int ufs_bsg_alloc_desc_buffer(struct ufs_hba *hba, struct bsg_job *job,
 	if (!descp)
 		return -ENOMEM;
 
-	sg_copy_to_buffer(job->request_payload.sg_list,
-			  job->request_payload.sg_cnt, descp, *desc_len);
+	if (desc_op == UPIU_QUERY_OPCODE_WRITE_DESC)
+		sg_copy_to_buffer(job->request_payload.sg_list,
+				  job->request_payload.sg_cnt, descp,
+				  *desc_len);
 
 	*desc_buff = descp;
 
@@ -140,6 +138,12 @@ static int ufs_bsg_request(struct bsg_job *job)
 	if (!desc_buff)
 		goto out;
 
+	if (desc_op == UPIU_QUERY_OPCODE_READ_DESC && desc_len)
+		bsg_reply->reply_payload_rcv_len =
+			sg_copy_from_buffer(job->request_payload.sg_list,
+					    job->request_payload.sg_cnt,
+					    desc_buff, desc_len);
+
 	kfree(desc_buff);
 
 out:
-- 
1.9.1

