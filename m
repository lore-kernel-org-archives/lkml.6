Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6CEC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99CEA214FF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZX4X16kV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99CEA214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbeJHWiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:38:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:56158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727180AbeJHWiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:38:00 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F2B4214FF;
        Mon,  8 Oct 2018 15:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539012345;
        bh=10gqXAJoPWk59g7kC2enWNS8xpHeMoIc7qZq32GCm/c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZX4X16kVCvbDd48n+bTx4dFUhMuoBdm83+Wc2T6w5PxFKHxC5/laKLCFgVabW0zRY
         Ov7UTwJHMHCljN5O4+vuGDA2VR8IvgLjk6Crfbd0yM+aRZIQobpXpgBDL3rqLwoOJW
         LXjpEmmW1SHhDM/fmy38TElaUNzz1TiNOLe+fgR8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Laura Abbott <labbott@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 19/58] scsi: ibmvscsis: Fix a stringop-overflow warning
Date:   Mon,  8 Oct 2018 11:24:44 -0400
Message-Id: <20181008152523.70705-19-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008152523.70705-1-sashal@kernel.org>
References: <20181008152523.70705-1-sashal@kernel.org>
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
index c3a76af9f5fa..95bf381413e8 100644
--- a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
+++ b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
@@ -3475,8 +3475,7 @@ static int ibmvscsis_probe(struct vio_dev *vdev,
 		vscsi->dds.window[LOCAL].liobn,
 		vscsi->dds.window[REMOTE].liobn);
 
-	strcpy(vscsi->eye, "VSCSI ");
-	strncat(vscsi->eye, vdev->name, MAX_EYE);
+	snprintf(vscsi->eye, sizeof(vscsi->eye), "VSCSI %s", vdev->name);
 
 	vscsi->dds.unit_id = vdev->unit_address;
 	strncpy(vscsi->dds.partition_name, partition_name,
-- 
2.17.1

