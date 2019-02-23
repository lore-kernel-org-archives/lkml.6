Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370E0C4360F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F01EB205C9
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550956758;
	bh=ELjzsE8e4CEEak6VIwRQG9K7M0M7X2raWVRFJaXbppg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wQ0hatfuLbaObOjKGo6jNkI3ez6BAd4SPJZTNp5VEnwLb5q9Gs7GStF//s41dNBbp
	 E9CCOf6dBNlohfSncSU9er9g6pHo2QLKycNoh2yeWr7M2/2djhP+XxBykGzFZ9iKHx
	 hXR++zNLF2Z4ZVKK09L000bt5wQfqgfZTYb76gmY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729528AbfBWVJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:09:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:44996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729507AbfBWVJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:09:23 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DCC12085A;
        Sat, 23 Feb 2019 21:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550956163;
        bh=ELjzsE8e4CEEak6VIwRQG9K7M0M7X2raWVRFJaXbppg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cv32UIsnqUT+/ii+bhLBVUpqXpVziclUzwMaeo69uBb9Aklgr/EThv251k5ThJuWv
         lLM0KejYsdWf2kqO5pzpDMHEMTyZcXS2MZKu431bR1kpFurpk9lWl2md4SB4R50G7d
         svha7HrDV1OnPqeYPwg2fSKoBU997qcZQueEZmSA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ming Lu <ming.lu@citrix.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 30/45] scsi: libfc: free skb when receiving invalid flogi resp
Date:   Sat, 23 Feb 2019 16:08:20 -0500
Message-Id: <20190223210835.201708-30-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223210835.201708-1-sashal@kernel.org>
References: <20190223210835.201708-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ming Lu <ming.lu@citrix.com>

[ Upstream commit 5d8fc4a9f0eec20b6c07895022a6bea3fb6dfb38 ]

The issue to be fixed in this commit is when libfc found it received a
invalid FLOGI response from FC switch, it would return without freeing the
fc frame, which is just the skb data. This would cause memory leak if FC
switch keeps sending invalid FLOGI responses.

This fix is just to make it execute `fc_frame_free(fp)` before returning
from function `fc_lport_flogi_resp`.

Signed-off-by: Ming Lu <ming.lu@citrix.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/libfc/fc_lport.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/libfc/fc_lport.c b/drivers/scsi/libfc/fc_lport.c
index 2fd0ec6511704..ca7967e390f19 100644
--- a/drivers/scsi/libfc/fc_lport.c
+++ b/drivers/scsi/libfc/fc_lport.c
@@ -1739,14 +1739,14 @@ void fc_lport_flogi_resp(struct fc_seq *sp, struct fc_frame *fp,
 	    fc_frame_payload_op(fp) != ELS_LS_ACC) {
 		FC_LPORT_DBG(lport, "FLOGI not accepted or bad response\n");
 		fc_lport_error(lport, fp);
-		goto err;
+		goto out;
 	}
 
 	flp = fc_frame_payload_get(fp, sizeof(*flp));
 	if (!flp) {
 		FC_LPORT_DBG(lport, "FLOGI bad response\n");
 		fc_lport_error(lport, fp);
-		goto err;
+		goto out;
 	}
 
 	mfs = ntohs(flp->fl_csp.sp_bb_data) &
@@ -1756,7 +1756,7 @@ void fc_lport_flogi_resp(struct fc_seq *sp, struct fc_frame *fp,
 		FC_LPORT_DBG(lport, "FLOGI bad mfs:%hu response, "
 			     "lport->mfs:%hu\n", mfs, lport->mfs);
 		fc_lport_error(lport, fp);
-		goto err;
+		goto out;
 	}
 
 	if (mfs <= lport->mfs) {
-- 
2.19.1

