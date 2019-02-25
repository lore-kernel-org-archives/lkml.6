Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFE9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9FCC2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129911;
	bh=Hds2LlZ2fnUEoCcGh/dXmSYN2W6I/QwUei/nK7nTYbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PCVdOIAxhQv4SiAc0V2wZP4bymyKyHyPZmyW3OQs5sN3/xyZV3/UC9bEVvWEHnY89
	 Mujit6HOy9iQe0X/c0R0g+vUe7evtWGEQZU1EoPxdn88uqiizHWfQtRFwrno9/Gn7M
	 1DijykZzudlGvNMezhH9JKjs3P4vLdcqSpAHQK60=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731349AbfBYVZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:25:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:59630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727653AbfBYVZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:25:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0750F2084D;
        Mon, 25 Feb 2019 21:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129906;
        bh=Hds2LlZ2fnUEoCcGh/dXmSYN2W6I/QwUei/nK7nTYbQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uqyeMFL8Wh+fiMLFHt6hieLB0Dh/vrjUVKTlOVC4tV93wIPvTIFatw2S+SuA72zSq
         8AYIFwnforqDcWdYqebFRn+qCDNpZdnKZYp1dWSPZAYS4xBgfn4ehEHfDTWDGIDocT
         qjyC9Y3axATdnNa7n3EFNAkh9WrnKaATQIxAICzQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Manish Rangankar <mrangankar@marvell.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 068/152] scsi: qedi: Add ep_state for login completion on un-reachable targets
Date:   Mon, 25 Feb 2019 22:11:00 +0100
Message-Id: <20190225195048.002702939@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
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
index 2f0a4f2c5ff80..d4821b9dea45d 100644
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
index 11260776212fa..892d70d545537 100644
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



