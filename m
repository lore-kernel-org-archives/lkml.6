Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3280C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E91420815
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729443AbfBCOCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:02:44 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53116 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728058AbfBCNtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:49:47 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9a-0003tg-3u; Sun, 03 Feb 2019 13:49:46 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9X-0006wc-Le; Sun, 03 Feb 2019 14:49:43 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Leon Romanovsky" <leonro@mellanox.com>,
        "Jason Gunthorpe" <jgg@mellanox.com>,
        "Parav Pandit" <parav@mellanox.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.682514080@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 090/305] IB/cm: Avoid AV ah_attr overwriting during
 LAP message handling
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Parav Pandit <parav@mellanox.com>

commit a5c57d327272bdf3a8b19686eaca2ec683449e67 upstream.

AH attribute of the cm_id can be overwritten if LAP message is received
on CM request which is in progress. This bug got introduced to avoid
sleeping when spin lock is held as part of commit in Fixes tag.

Therefore validate the cm_id state first and continue to perform AV
ah_attr initialization.

Given that Aleternative path related messages are not supported for
RoCE, init_av_from_response/path is such messages are ok to be called
from blocking context.

Fixes: 33f93e1ebcf5 ("IB/cm: Fix sleeping while spin lock is held")
Signed-off-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/infiniband/core/cm.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -2770,12 +2770,6 @@ static int cm_lap_handler(struct cm_work
 	if (!cm_id_priv)
 		return -EINVAL;
 
-	ret = cm_init_av_for_response(work->port, work->mad_recv_wc->wc,
-				      work->mad_recv_wc->recv_buf.grh,
-				      &cm_id_priv->av);
-	if (ret)
-		goto deref;
-
 	param = &work->cm_event.param.lap_rcvd;
 	param->alternate_path = &work->path[0];
 	cm_format_path_from_lap(cm_id_priv, param->alternate_path, lap_msg);
@@ -2813,10 +2807,16 @@ static int cm_lap_handler(struct cm_work
 		goto unlock;
 	}
 
-	cm_id_priv->id.lap_state = IB_CM_LAP_RCVD;
-	cm_id_priv->tid = lap_msg->hdr.tid;
+	ret = cm_init_av_for_response(work->port, work->mad_recv_wc->wc,
+				      work->mad_recv_wc->recv_buf.grh,
+				      &cm_id_priv->av);
+	if (ret)
+		goto unlock;
+
 	cm_init_av_by_path(param->alternate_path, &cm_id_priv->alt_av,
 			   cm_id_priv);
+	cm_id_priv->id.lap_state = IB_CM_LAP_RCVD;
+	cm_id_priv->tid = lap_msg->hdr.tid;
 	ret = atomic_inc_and_test(&cm_id_priv->work_count);
 	if (!ret)
 		list_add_tail(&work->list, &cm_id_priv->work_list);

