Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824DCC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BDC2222A7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549899715;
	bh=OY9+b9H2QrM+RoBN7aOJV1Vy5f6SRqNw9GSLdal+bQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r/yPDHQ7S90DRL4pj+HsVeOE0OEOGrY90g/RO76R6yPy1qJRzku3plC8C02T4LuMR
	 AlG8D1+AuVqt8i6Z31n37PmXHhsTQ4Bn7IBWEVCkR7+mZShe4NgExfhZvEcKNm12kk
	 7PyqSazMf6s9JDtWYrs6O5l5K4akLJNn0LK4T1hU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732752AbfBKOrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:47:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:60540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387486AbfBKOrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:47:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D306E206BA;
        Mon, 11 Feb 2019 14:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896436;
        bh=OY9+b9H2QrM+RoBN7aOJV1Vy5f6SRqNw9GSLdal+bQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W4EDwZh/lu5HF3ktuJ/RsbmDbB3pkw9J6hJJXCSeXP+4G7CZbZSwj4NPxhOnLFBOH
         rWzzMTzqpGcwPmw3ljvMk6yMKz6uOnMjt1knSr6G7Hy9P14dfRRyEycgoNwtQ3Rjl+
         sPr2DkMoV8rfCL7AwdAEifGbK3ZDABDaNTXUpKqI=
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
Subject: [PATCH 4.19 182/313] scsi: smartpqi: correct volume status
Date:   Mon, 11 Feb 2019 15:17:42 +0100
Message-Id: <20190211141905.473740799@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index 58eb0d31d8d9..3781e8109dd7 100644
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



