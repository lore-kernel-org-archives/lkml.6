Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 97DA9C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D2F220020
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GF2TbVo2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D2F220020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966141AbeFNOMy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:12:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:54104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966105AbeFNOMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:12:45 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3E09208DB;
        Thu, 14 Jun 2018 14:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985565;
        bh=EdmCGdqGMVTka76uejO3Qlp3of+dEpkvktZcpbue4aU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GF2TbVo2DgJS7xF1IzKxgflBsGvINWm9PA48xb2VRsKwO2vcwDmVIVUvdUwIvw29p
         TdPwgnLWqYMySIbqPxF9POjRZEzvPSoZXvGiIW/eJzmzemDqndaocaWJqGX0hIXXhv
         WrBnutN1r3Gm3LZCsCQJ97eiYiFJ2PUo8+4W1f5g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin Wilck <mwilck@suse.com>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.9 09/30] nvmet: dont report 0-bytes in serial number
Date:   Thu, 14 Jun 2018 16:04:50 +0200
Message-Id: <20180614132600.643890113@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614132600.255515394@linuxfoundation.org>
References: <20180614132600.255515394@linuxfoundation.org>
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

From: Martin Wilck <mwilck@suse.com>

commit 42de82a8b544fa55670feef7d6f85085fba48fc0 upstream.

The NVME standard mandates that the SN, MN, and FR fields of the Identify
Controller Data Structure be "ASCII strings".  That means that they may
not contain 0-bytes, not even string terminators.

Signed-off-by: Martin Wilck <mwilck@suse.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
[hch: fixed for the move of the serial field, updated description]
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/nvme/target/admin-cmd.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -166,11 +166,21 @@ out:
 	nvmet_req_complete(req, status);
 }
 
+static void copy_and_pad(char *dst, int dst_len, const char *src, int src_len)
+{
+	int len = min(src_len, dst_len);
+
+	memcpy(dst, src, len);
+	if (dst_len > len)
+		memset(dst + len, ' ', dst_len - len);
+}
+
 static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	struct nvme_id_ctrl *id;
 	u16 status = 0;
+	const char model[] = "Linux";
 
 	id = kzalloc(sizeof(*id), GFP_KERNEL);
 	if (!id) {
@@ -182,8 +192,10 @@ static void nvmet_execute_identify_ctrl(
 	id->vid = 0;
 	id->ssvid = 0;
 
-	memset(id->sn, ' ', sizeof(id->sn));
-	snprintf(id->sn, sizeof(id->sn), "%llx", ctrl->subsys->serial);
+	bin2hex(id->sn, &ctrl->subsys->serial,
+		min(sizeof(ctrl->subsys->serial), sizeof(id->sn) / 2));
+	copy_and_pad(id->mn, sizeof(id->mn), model, sizeof(model) - 1);
+	copy_and_pad(id->fr, sizeof(id->fr), UTS_RELEASE, strlen(UTS_RELEASE));
 
 	memset(id->mn, ' ', sizeof(id->mn));
 	strncpy((char *)id->mn, "Linux", sizeof(id->mn));


