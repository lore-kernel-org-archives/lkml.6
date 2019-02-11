Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7805CC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C952054F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549900732;
	bh=qrRKHz8Jw4WKYbhyRChcspY9tiasDNFFKiCc7+GpKtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fYRC/XKfnmqmZRP61QGrViiAvRedz7XkSxDxsY2WLNB9HIR/KvkYfGD0VcAg8Yqgl
	 Gl8dH2cv/c08vJby4R6LA5fdgUes3Puw3rywhTX8i84TaPlGcTbK0smi3oeTVRDVR5
	 Hghj4tA0ROyO+1oKFwpSv0GUoQb51R/VJ7hOb91I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387414AbfBKP6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:58:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:40120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729901AbfBKOci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:32:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88DB8214DA;
        Mon, 11 Feb 2019 14:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895558;
        bh=qrRKHz8Jw4WKYbhyRChcspY9tiasDNFFKiCc7+GpKtE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qyQ4dRfLZC7qkZCPek/bDT6MBhsCo2Ol4sDBP1r5QtRdQNrHsC/CNK87r7nZb81Ia
         SnhV7efxvT1CviiLA4BSECwM4hBf3BXdLpMH6IdtKzMxvt5MXDSaj4/VDTHXcsAiMn
         hOPJe/VmYwPrUW/gcMiI9LFq1vkvnAOiyYK+81SA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Murthy Bhat <murthy.bhat@microsemi.com>,
        Mahesh Rajashekhara <mahesh.rajashekhara@microsemi.com>,
        Scott Teel <scott.teel@microsemi.com>,
        Kevin Barnett <kevin.barnett@microsemi.com>,
        Dave Carroll <david.carroll@microsemi.com>,
        Don Brace <don.brace@microsemi.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 215/352] scsi: smartpqi: correct volume status
Date:   Mon, 11 Feb 2019 15:17:22 +0100
Message-Id: <20190211141900.885081142@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 7ff44499bafbd376115f0bb6b578d980f56ee13b ]

- fix race condition when a unit is deleted after an RLL,
  and before we have gotten the LV_STATUS page of the unit.
  - In this case we will get a standard inquiry, rather than
    the desired page.  This will result in a unit presented
    which no longer exists.
  - If we ask for LV_STATUS, insure we get LV_STATUS

Reviewed-by: Murthy Bhat <murthy.bhat@microsemi.com>
Reviewed-by: Mahesh Rajashekhara <mahesh.rajashekhara@microsemi.com>
Reviewed-by: Scott Teel <scott.teel@microsemi.com>
Reviewed-by: Kevin Barnett <kevin.barnett@microsemi.com>
Signed-off-by: Dave Carroll <david.carroll@microsemi.com>
Signed-off-by: Don Brace <don.brace@microsemi.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/smartpqi/smartpqi_init.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index 5a86dddbd8ba..489e5cbbcbba 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -1168,6 +1168,9 @@ static void pqi_get_volume_status(struct pqi_ctrl_info *ctrl_info,
 	if (rc)
 		goto out;
 
+	if (vpd->page_code != CISS_VPD_LV_STATUS)
+		goto out;
+
 	page_length = offsetof(struct ciss_vpd_logical_volume_status,
 		volume_status) + vpd->page_length;
 	if (page_length < sizeof(*vpd))
-- 
2.19.1



