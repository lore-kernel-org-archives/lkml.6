Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F2BC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5A0B2190A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550026889;
	bh=yvP+iZRZSakHDaDXQMknfSWwr5hUxPvQPJha0lDIZD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KDszlp33qaVUAuyz2/JhtP64whOqiQyddM8TzKxkEfHT6YgfqX4+iNKqCWs0bOd5k
	 iDpdQB7PfggXZpYu3KwpGJ5Ln1eef+YFzZRawrt8a6C+r5SkX5Y2v6Sf6uMURQ0gPv
	 09ND+B+0Zt7qCvNqcEgC/kJIuH3y5A2EEkdTpdUw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390309AbfBMDB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 22:01:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:38828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728112AbfBMCfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:35:11 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A55BE222CC;
        Wed, 13 Feb 2019 02:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025310;
        bh=yvP+iZRZSakHDaDXQMknfSWwr5hUxPvQPJha0lDIZD4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IqUkECOvJXt1M9VFsFRT4zHVKQu9DqUV+yJtqHoISMxcy3hU3+7SesnDSHTGD4Hbh
         vFyTnqqK3yrzKQv9/bldBV9gwUaAKklFDDGpHH4Bb18pfgTpsGVfEfw17EEIO0UCBS
         5kMBejhk5bwuUpFZ1Sxn0H86K+PCSMxdue+d/lwg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Manish Rangankar <mrangankar@marvell.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 061/105] scsi: qedi: Add ep_state for login completion on un-reachable targets
Date:   Tue, 12 Feb 2019 21:32:52 -0500
Message-Id: <20190213023336.19019-61-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023336.19019-1-sashal@kernel.org>
References: <20190213023336.19019-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manish Rangankar <mrangankar@marvell.com>

[ Upstream commit 34a2ce887668db9dda4b56e6f155c49ac13f3e54 ]

When the driver finds invalid destination MAC for the first un-reachable
target, and before completes the PATH_REQ operation, set new ep_state to
OFFLDCONN_NONE so that as part of driver ep_poll mechanism, the upper
open-iscsi layer is notified to complete the login process on the first
un-reachable target and thus proceed login to other reachable targets.

Signed-off-by: Manish Rangankar <mrangankar@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qedi/qedi_iscsi.c | 3 +++
 drivers/scsi/qedi/qedi_iscsi.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/scsi/qedi/qedi_iscsi.c b/drivers/scsi/qedi/qedi_iscsi.c
index 2f0a4f2c5ff8..d4821b9dea45 100644
--- a/drivers/scsi/qedi/qedi_iscsi.c
+++ b/drivers/scsi/qedi/qedi_iscsi.c
@@ -954,6 +954,7 @@ static int qedi_ep_poll(struct iscsi_endpoint *ep, int timeout_ms)
 
 	qedi_ep = ep->dd_data;
 	if (qedi_ep->state == EP_STATE_IDLE ||
+	    qedi_ep->state == EP_STATE_OFLDCONN_NONE ||
 	    qedi_ep->state == EP_STATE_OFLDCONN_FAILED)
 		return -1;
 
@@ -1036,6 +1037,7 @@ static void qedi_ep_disconnect(struct iscsi_endpoint *ep)
 
 	switch (qedi_ep->state) {
 	case EP_STATE_OFLDCONN_START:
+	case EP_STATE_OFLDCONN_NONE:
 		goto ep_release_conn;
 	case EP_STATE_OFLDCONN_FAILED:
 			break;
@@ -1226,6 +1228,7 @@ static int qedi_set_path(struct Scsi_Host *shost, struct iscsi_path *path_data)
 
 	if (!is_valid_ether_addr(&path_data->mac_addr[0])) {
 		QEDI_NOTICE(&qedi->dbg_ctx, "dst mac NOT VALID\n");
+		qedi_ep->state = EP_STATE_OFLDCONN_NONE;
 		ret = -EIO;
 		goto set_path_exit;
 	}
diff --git a/drivers/scsi/qedi/qedi_iscsi.h b/drivers/scsi/qedi/qedi_iscsi.h
index 11260776212f..892d70d54553 100644
--- a/drivers/scsi/qedi/qedi_iscsi.h
+++ b/drivers/scsi/qedi/qedi_iscsi.h
@@ -59,6 +59,7 @@ enum {
 	EP_STATE_OFLDCONN_FAILED        = 0x2000,
 	EP_STATE_CONNECT_FAILED         = 0x4000,
 	EP_STATE_DISCONN_TIMEDOUT       = 0x8000,
+	EP_STATE_OFLDCONN_NONE          = 0x10000,
 };
 
 struct qedi_conn;
-- 
2.19.1

