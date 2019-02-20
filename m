Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91759C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 07:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60BFC21773
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 07:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MJCf2i7N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730436AbfBTHLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 02:11:53 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:24886 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfBTHLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 02:11:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550646713; x=1582182713;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=90uZ6pdSNgTEPjjbmkydkiq58Fmjwb7vIUWjOSLsHSQ=;
  b=MJCf2i7NWIAckNzJ1MMnxPT8fHDD7z4FPw5k67/7Oe7PvV6jASAiN8OF
   X/B0eE/5WWxPuTgRN/H8BsQflBLPbVRzT0Vj8fdSjDsjah/paqTsUns4i
   T2kpofRBGyp45dY3r0gtgkYZNH6F8F3ym+pdRC2liVwAd7hlja3vUdw1P
   J0iPoJcnZxJD2YMRL4IDxeLy6pLyyIbuWC+ztLOyPuyhmkwJEnmuRRade
   HDhwySZGoTN8P81fRABPJJEojyq7k/7e4EPXqjeAHo2TG3MZLXnrp7CSa
   4qQgNDBaRgFDESEs2RrDg8srGl9UoWWYK2i8cNsd3Cpc0FTXpKSZ4UFWK
   g==;
X-IronPort-AV: E=Sophos;i="5.58,388,1544457600"; 
   d="scan'208";a="103461504"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Feb 2019 15:11:52 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 19 Feb 2019 22:50:15 -0800
Received: from kfae422988.sdcorp.global.sandisk.com ([10.0.230.227])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Feb 2019 23:11:49 -0800
From:   Avri Altman <avri.altman@wdc.com>
To:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Bean Huo <beanhuo@micron.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     Avi Shchislowski <avi.shchislowski@wdc.com>,
        Alex Lemberg <alex.lemberg@wdc.com>,
        Avri Altman <avri.altman@wdc.com>
Subject: [REPOST PATCH v4 1/3] scsi: ufs-bsg: Change the calling convention for write descriptor
Date:   Wed, 20 Feb 2019 09:11:12 +0200
Message-Id: <1550646674-15258-2-git-send-email-avri.altman@wdc.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1550646674-15258-1-git-send-email-avri.altman@wdc.com>
References: <1550646674-15258-1-git-send-email-avri.altman@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we had a write descriptor query upiu, we appended the descriptor
right after the bsg request.  This was fine as the bsg driver allows to
allocate whatever buffer we needed in its job request.

Still, the proper way to deliver payload, however small (we only write
config descriptors of 144 bytes), is by using the job request payload
data buffer.

So change this ABI now, while ufs-bsg is still new, and nobody is
actually using it.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
Reviewed-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Bean Huo <beanhuo@micron.com>
---
 Documentation/scsi/ufs.txt |  6 ++++++
 drivers/scsi/ufs/ufs_bsg.c | 47 +++++++++++++++++++++++++---------------------
 2 files changed, 32 insertions(+), 21 deletions(-)

diff --git a/Documentation/scsi/ufs.txt b/Documentation/scsi/ufs.txt
index 520b5b0..78fe7cb 100644
--- a/Documentation/scsi/ufs.txt
+++ b/Documentation/scsi/ufs.txt
@@ -147,6 +147,12 @@ send SG_IO with the applicable sg_io_v4:
 	io_hdr_v4.max_response_len = reply_len;
 	io_hdr_v4.request_len = request_len;
 	io_hdr_v4.request = (__u64)request_upiu;
+	if (dir == SG_DXFER_TO_DEV) {
+		io_hdr_v4.dout_xfer_len = (uint32_t)byte_cnt;
+		io_hdr_v4.dout_xferp = (uintptr_t)(__u64)buff;
+	}
+
+If you wish to write a descriptor, use the dout_xferp sg_io_v4.
 
 UFS Specifications can be found at,
 UFS - http://www.jedec.org/sites/default/files/docs/JESD220.pdf
diff --git a/drivers/scsi/ufs/ufs_bsg.c b/drivers/scsi/ufs/ufs_bsg.c
index 775bb4e..2fd0769 100644
--- a/drivers/scsi/ufs/ufs_bsg.c
+++ b/drivers/scsi/ufs/ufs_bsg.c
@@ -27,15 +27,11 @@ static int ufs_bsg_get_query_desc_size(struct ufs_hba *hba, int *desc_len,
 
 static int ufs_bsg_verify_query_size(struct ufs_hba *hba,
 				     unsigned int request_len,
-				     unsigned int reply_len,
-				     int desc_len, enum query_opcode desc_op)
+				     unsigned int reply_len)
 {
 	int min_req_len = sizeof(struct ufs_bsg_request);
 	int min_rsp_len = sizeof(struct ufs_bsg_reply);
 
-	if (desc_op == UPIU_QUERY_OPCODE_WRITE_DESC)
-		min_req_len += desc_len;
-
 	if (min_req_len > request_len || min_rsp_len > reply_len) {
 		dev_err(hba->dev, "not enough space assigned\n");
 		return -EINVAL;
@@ -44,14 +40,13 @@ static int ufs_bsg_verify_query_size(struct ufs_hba *hba,
 	return 0;
 }
 
-static int ufs_bsg_verify_query_params(struct ufs_hba *hba,
-				       struct ufs_bsg_request *bsg_request,
-				       unsigned int request_len,
-				       unsigned int reply_len,
-				       uint8_t *desc_buff, int *desc_len,
-				       enum query_opcode desc_op)
+static int ufs_bsg_alloc_desc_buffer(struct ufs_hba *hba, struct bsg_job *job,
+				     uint8_t **desc_buff, int *desc_len,
+				     enum query_opcode desc_op)
 {
+	struct ufs_bsg_request *bsg_request = job->request;
 	struct utp_upiu_query *qr;
+	u8 *descp;
 
 	if (desc_op == UPIU_QUERY_OPCODE_READ_DESC) {
 		dev_err(hba->dev, "unsupported opcode %d\n", desc_op);
@@ -67,11 +62,19 @@ static int ufs_bsg_verify_query_params(struct ufs_hba *hba,
 		return -EINVAL;
 	}
 
-	if (ufs_bsg_verify_query_size(hba, request_len, reply_len, *desc_len,
-				      desc_op))
+	if (*desc_len > job->request_payload.payload_len) {
+		dev_err(hba->dev, "Illegal desc size\n");
 		return -EINVAL;
+	}
+
+	descp = kzalloc(*desc_len, GFP_KERNEL);
+	if (!descp)
+		return -ENOMEM;
 
-	desc_buff = (uint8_t *)(bsg_request + 1);
+	sg_copy_to_buffer(job->request_payload.sg_list,
+			  job->request_payload.sg_cnt, descp, *desc_len);
+
+	*desc_buff = descp;
 
 out:
 	return 0;
@@ -91,7 +94,7 @@ static int ufs_bsg_request(struct bsg_job *job)
 	enum query_opcode desc_op = UPIU_QUERY_OPCODE_NOP;
 	int ret;
 
-	ret = ufs_bsg_verify_query_size(hba, req_len, reply_len, 0, desc_op);
+	ret = ufs_bsg_verify_query_size(hba, req_len, reply_len);
 	if (ret)
 		goto out;
 
@@ -101,9 +104,8 @@ static int ufs_bsg_request(struct bsg_job *job)
 	switch (msgcode) {
 	case UPIU_TRANSACTION_QUERY_REQ:
 		desc_op = bsg_request->upiu_req.qr.opcode;
-		ret = ufs_bsg_verify_query_params(hba, bsg_request, req_len,
-						  reply_len, desc_buff,
-						  &desc_len, desc_op);
+		ret = ufs_bsg_alloc_desc_buffer(hba, job, &desc_buff,
+						&desc_len, desc_op);
 		if (ret)
 			goto out;
 
@@ -135,11 +137,14 @@ static int ufs_bsg_request(struct bsg_job *job)
 		break;
 	}
 
+	if (!desc_buff)
+		goto out;
+
+	kfree(desc_buff);
+
 out:
 	bsg_reply->result = ret;
-	job->reply_len = sizeof(struct ufs_bsg_reply) +
-			 bsg_reply->reply_payload_rcv_len;
-
+	job->reply_len = sizeof(struct ufs_bsg_reply);
 	bsg_job_done(job, ret, bsg_reply->reply_payload_rcv_len);
 
 	return ret;
-- 
1.9.1

