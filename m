Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8956AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 560912083D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131931;
	bh=ECyXcTdnIPGeo6UOxgyKNfN8HELrQu51W7fo5yLkl68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pf6VKJ+oW0wiq+O80PZvKcHds6YH/rKL2K1+Ab+ayHHtwwl9SwLAbXucgwl4R7Mfm
	 OxYhcgfuH3vjvS3iF8c242ZunvdSaZjtA5cl1lSUL67D4LjMZdsR+lfbWlAEg0B/zM
	 msjvZyBzwYszucMEOp1Lu0n8EPMP7qZ5c+FcO4is=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729914AbfBYV6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:58:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:53052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729768AbfBYVTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:19:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37A8321841;
        Mon, 25 Feb 2019 21:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129589;
        bh=ECyXcTdnIPGeo6UOxgyKNfN8HELrQu51W7fo5yLkl68=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dcyZAJtveUyAzcWTNK+UeNwfEBYA2tbMaf4Jd+fZlvbzH5zz3946GDnHrwCuYXrlK
         Hk4mGX62JBpXERJgnJsJ+pUG89YLoKy9G64R+MkUUMUpRxKh3ZN9St+425f7PMPBTT
         mUgyqbzR4kQFSGg2A3VDFjle/HeYxhQANCEgf3A0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Manish Rangankar <mrangankar@marvell.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 35/71] scsi: qedi: Add ep_state for login completion on un-reachable targets
Date:   Mon, 25 Feb 2019 22:11:37 +0100
Message-Id: <20190225195037.155494165@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195034.555044862@linuxfoundation.org>
References: <20190225195034.555044862@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
index a02b34ea5cab1..45f044f35cea8 100644
--- a/drivers/scsi/qedi/qedi_iscsi.c
+++ b/drivers/scsi/qedi/qedi_iscsi.c
@@ -961,6 +961,7 @@ static int qedi_ep_poll(struct iscsi_endpoint *ep, int timeout_ms)
 
 	qedi_ep = ep->dd_data;
 	if (qedi_ep->state == EP_STATE_IDLE ||
+	    qedi_ep->state == EP_STATE_OFLDCONN_NONE ||
 	    qedi_ep->state == EP_STATE_OFLDCONN_FAILED)
 		return -1;
 
@@ -1043,6 +1044,7 @@ static void qedi_ep_disconnect(struct iscsi_endpoint *ep)
 
 	switch (qedi_ep->state) {
 	case EP_STATE_OFLDCONN_START:
+	case EP_STATE_OFLDCONN_NONE:
 		goto ep_release_conn;
 	case EP_STATE_OFLDCONN_FAILED:
 			break;
@@ -1233,6 +1235,7 @@ static int qedi_set_path(struct Scsi_Host *shost, struct iscsi_path *path_data)
 
 	if (!is_valid_ether_addr(&path_data->mac_addr[0])) {
 		QEDI_NOTICE(&qedi->dbg_ctx, "dst mac NOT VALID\n");
+		qedi_ep->state = EP_STATE_OFLDCONN_NONE;
 		ret = -EIO;
 		goto set_path_exit;
 	}
diff --git a/drivers/scsi/qedi/qedi_iscsi.h b/drivers/scsi/qedi/qedi_iscsi.h
index 3247287cb0e7e..812b4b68e6e48 100644
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



