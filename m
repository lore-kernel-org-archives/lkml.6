Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04270C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3CFD2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548692233;
	bh=YARUUnAuoeTPAFZDJxcgx5iSRQjH70LrSUPomEq7RNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Yh3CLNiGiLawmIVa/oSQlrf6g/CTJ+5NcH6aER7V2UyPM3ITSu8477EspadaGre82
	 RQld+B9znrxdtY3Kf4wzSb6RhjvqzAH4pqNjKSFpwYRSzJuJKlBLfOg37iDaT7fv7Z
	 uUn0VGo/WmDpv0/XzVVMWWHl9Q4b8sEZ3JRmgpks=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388154AbfA1QRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:17:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:50886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732669AbfA1QRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:17:09 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CAF620879;
        Mon, 28 Jan 2019 16:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692229;
        bh=YARUUnAuoeTPAFZDJxcgx5iSRQjH70LrSUPomEq7RNg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h15NwdLHYuJDBj3Vhz26g0ImyixAPjhDaPCq2mYBMgokFQQqkWzIECX+65ABCXoUX
         cxYP7t4gPM6yyS8hWceECkFMerGnYDHalAN35hpvfju4/QAu/YBr0YMH2FK6TBOJO/
         lx+KXn13q0wVnjPjCD1p4PrNkn0GsxgdsZX8ZTDQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dave Carroll <david.carroll@microsemi.com>,
        Don Brace <don.brace@microsemi.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, esc.storagedev@microsemi.com,
        linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 119/170] scsi: smartpqi: correct volume status
Date:   Mon, 28 Jan 2019 11:11:09 -0500
Message-Id: <20190128161200.55107-119-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161200.55107-1-sashal@kernel.org>
References: <20190128161200.55107-1-sashal@kernel.org>
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
index cc27ae2e8a2d..5ec2898d21cd 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -1184,6 +1184,9 @@ static void pqi_get_volume_status(struct pqi_ctrl_info *ctrl_info,
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

