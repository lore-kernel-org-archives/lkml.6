Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E2FC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DE3E20644
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SeKNmfv6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DE3E20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbeJHWtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:49:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:56202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726977AbeJHWiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:38:00 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79E9C21508;
        Mon,  8 Oct 2018 15:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539012346;
        bh=sR3Lr+0lVpha/GBqZZFq5yugh34NGuyHEQMuvlRl6a8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SeKNmfv6vJKWjnSzHNp6WIySQj7pDeT965fJdFytT6wSl1pxtlF8kvJ615me0Hpc5
         wxQFN4GzO5JSZTs5Kt12DmPOHH7JsMVKMTcefMjePM+4JPl4zW4B8UZuDi3wHp4qCh
         CNPhNk+kSTZVlQXntDdqjxv6W033cZX0kkWJpjcE=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Laura Abbott <labbott@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 20/58] scsi: ibmvscsis: Ensure partition name is properly NUL terminated
Date:   Mon,  8 Oct 2018 11:24:45 -0400
Message-Id: <20181008152523.70705-20-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008152523.70705-1-sashal@kernel.org>
References: <20181008152523.70705-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laura Abbott <labbott@redhat.com>

[ Upstream commit adad633af7b970bfa5dd1b624a4afc83cac9b235 ]

While reviewing another part of the code, Kees noticed that the strncpy of the
partition name might not always be NUL terminated. Switch to using strscpy
which does this safely.

Reported-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Laura Abbott <labbott@redhat.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
index 95bf381413e8..ada1ebebd325 100644
--- a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
+++ b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
@@ -3478,7 +3478,7 @@ static int ibmvscsis_probe(struct vio_dev *vdev,
 	snprintf(vscsi->eye, sizeof(vscsi->eye), "VSCSI %s", vdev->name);
 
 	vscsi->dds.unit_id = vdev->unit_address;
-	strncpy(vscsi->dds.partition_name, partition_name,
+	strscpy(vscsi->dds.partition_name, partition_name,
 		sizeof(vscsi->dds.partition_name));
 	vscsi->dds.partition_num = partition_number;
 
-- 
2.17.1

