Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4565C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A1BC2171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690901;
	bh=1QZBhWSQPkW60bzxbv8zPff9FZaNsJSK/mpMFMmgMVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JF1JPIClxJxpkM1z7eO1m2BmwUoa4O/8VRuzKg3if/n7Snw1BMZmT4c7YzEQnaTXm
	 g6Isa8GkC26RjfRne+2ezsswp/rK7M/3Sm/iqSuzYR7+2HSnsekpe04NwpqZA6Cyhd
	 ynURBP21g48c2aaYiAHeAKCR0IPMGuBxFw+R9F5I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbfA1PzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:55:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:41004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729804AbfA1Py4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:54:56 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55FDD20855;
        Mon, 28 Jan 2019 15:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690896;
        bh=1QZBhWSQPkW60bzxbv8zPff9FZaNsJSK/mpMFMmgMVk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=al+DG/JGDJiTalbiOUHkhQnUumSuRGSMx9K0WPrRlY8qmlaNk7XA2SGr3Az3CojCA
         RyUCPKVUoxb8G95wuR4b+hD4FkAACDQq8U942SFPkZc1aMwDM5DPv9GW27so9Hlwxv
         FYiEOha+ayiedK9j4sAKlDINR4eaijIZCGUDeGlA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dave Carroll <david.carroll@microsemi.com>,
        Don Brace <don.brace@microsemi.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, esc.storagedev@microsemi.com,
        linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 227/304] scsi: smartpqi: correct volume status
Date:   Mon, 28 Jan 2019 10:42:24 -0500
Message-Id: <20190128154341.47195-227-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Carroll <david.carroll@microsemi.com>

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

