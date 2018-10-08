Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDDAC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A570121557
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GYWis8yG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A570121557
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbeJHWjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:39:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:57784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728321AbeJHWi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:38:59 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F6E521531;
        Mon,  8 Oct 2018 15:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539012403;
        bh=7y62hsutKLMT+XCZBNRTdv9lF1uGf+aZsTMv6VDD69Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GYWis8yGRZhh3wZZp4Q4c5q8xq41R5qQEioKSoGC4Uu6rl3+YlF3+v+UI+aQPKLa9
         5Uiow5gwn6PJqdQMU5m2sdUV4+17DDsEbRe01pwDscoVyU+yNa4WzawtUv4iOc/XTX
         6QkCyepDXCrstcbbD/yF/w+1ci6bi36Dg0LHaAhE=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Laura Abbott <labbott@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 14/32] scsi: ibmvscsis: Fix a stringop-overflow warning
Date:   Mon,  8 Oct 2018 11:26:11 -0400
Message-Id: <20181008152629.70812-14-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008152629.70812-1-sashal@kernel.org>
References: <20181008152629.70812-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laura Abbott <labbott@redhat.com>

[ Upstream commit d792d4c4fc866ae224b0b0ca2aabd87d23b4d6cc ]

There's currently a warning about string overflow with strncat:

drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c: In function 'ibmvscsis_probe':
drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:3479:2: error: 'strncat' specified
bound 64 equals destination size [-Werror=stringop-overflow=]
  strncat(vscsi->eye, vdev->name, MAX_EYE);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Switch to a single snprintf instead of a strcpy + strcat to handle this
cleanly.

Signed-off-by: Laura Abbott <labbott@redhat.com>
Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
index 2799a6b08f73..c6878f596520 100644
--- a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
+++ b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
@@ -3465,8 +3465,7 @@ static int ibmvscsis_probe(struct vio_dev *vdev,
 		 vscsi->dds.window[LOCAL].liobn,
 		 vscsi->dds.window[REMOTE].liobn);
 
-	strcpy(vscsi->eye, "VSCSI ");
-	strncat(vscsi->eye, vdev->name, MAX_EYE);
+	snprintf(vscsi->eye, sizeof(vscsi->eye), "VSCSI %s", vdev->name);
 
 	vscsi->dds.unit_id = vdev->unit_address;
 	strncpy(vscsi->dds.partition_name, partition_name,
-- 
2.17.1

