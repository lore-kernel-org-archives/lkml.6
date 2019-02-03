Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E3BC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEB0320815
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729690AbfBCOCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:02:02 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53226 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728103AbfBCNtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:49:49 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9a-0003tp-UA; Sun, 03 Feb 2019 13:49:47 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9X-0006wH-Gu; Sun, 03 Feb 2019 14:49:43 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Jason Gunthorpe" <jgg@mellanox.com>,
        "Leon Romanovsky" <leon@kernel.org>,
        "Parav Pandit" <parav@mellanox.com>,
        "Daniel Jurgens" <danielj@mellanox.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.323641903@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 088/305] IB/{cm, umad}: Handle av init error
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

commit 0c4386ec77cfcd0ccbdbe8c2e67dd3a49b2a4c7f upstream.

cm_init_av_for_response depends on ib_init_ah_from_wc() whose return
status is ignored.
ib_init_ah_from_wc() can fail and its return status should be handled as
done in this patch.

Signed-off-by: Parav Pandit <parav@mellanox.com>
Reviewed-by: Daniel Jurgens <danielj@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/infiniband/core/cm.c       | 34 ++++++++++++++++++------------
 drivers/infiniband/core/user_mad.c | 10 ++++++---
 2 files changed, 28 insertions(+), 16 deletions(-)

--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -380,13 +380,13 @@ static void cm_set_private_data(struct c
 	cm_id_priv->private_data_len = private_data_len;
 }
 
-static void cm_init_av_for_response(struct cm_port *port, struct ib_wc *wc,
-				    struct ib_grh *grh, struct cm_av *av)
+static int cm_init_av_for_response(struct cm_port *port, struct ib_wc *wc,
+				   struct ib_grh *grh, struct cm_av *av)
 {
 	av->port = port;
 	av->pkey_index = wc->pkey_index;
-	ib_init_ah_from_wc(port->cm_dev->ib_device, port->port_num, wc,
-			   grh, &av->ah_attr);
+	return ib_init_ah_from_wc(port->cm_dev->ib_device, port->port_num, wc,
+				  grh, &av->ah_attr);
 }
 
 static int cm_init_av_by_path(struct ib_sa_path_rec *path, struct cm_av *av,
@@ -1601,9 +1601,11 @@ static int cm_req_handler(struct cm_work
 
 	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
 	cm_id_priv->id.remote_id = req_msg->local_comm_id;
-	cm_init_av_for_response(work->port, work->mad_recv_wc->wc,
-				work->mad_recv_wc->recv_buf.grh,
-				&cm_id_priv->av);
+	ret = cm_init_av_for_response(work->port, work->mad_recv_wc->wc,
+				      work->mad_recv_wc->recv_buf.grh,
+				      &cm_id_priv->av);
+	if (ret)
+		goto destroy;
 	cm_id_priv->timewait_info = cm_create_timewait_info(cm_id_priv->
 							    id.local_id);
 	if (IS_ERR(cm_id_priv->timewait_info)) {
@@ -2807,9 +2809,11 @@ static int cm_lap_handler(struct cm_work
 
 	cm_id_priv->id.lap_state = IB_CM_LAP_RCVD;
 	cm_id_priv->tid = lap_msg->hdr.tid;
-	cm_init_av_for_response(work->port, work->mad_recv_wc->wc,
-				work->mad_recv_wc->recv_buf.grh,
-				&cm_id_priv->av);
+	ret = cm_init_av_for_response(work->port, work->mad_recv_wc->wc,
+				      work->mad_recv_wc->recv_buf.grh,
+				      &cm_id_priv->av);
+	if (ret)
+		goto unlock;
 	cm_init_av_by_path(param->alternate_path, &cm_id_priv->alt_av,
 			   cm_id_priv);
 	ret = atomic_inc_and_test(&cm_id_priv->work_count);
@@ -3060,6 +3064,7 @@ static int cm_sidr_req_handler(struct cm
 	struct cm_id_private *cm_id_priv, *cur_cm_id_priv;
 	struct cm_sidr_req_msg *sidr_req_msg;
 	struct ib_wc *wc;
+	int ret;
 
 	cm_id = ib_create_cm_id(work->port->cm_dev->ib_device, NULL, NULL);
 	if (IS_ERR(cm_id))
@@ -3072,9 +3077,12 @@ static int cm_sidr_req_handler(struct cm
 	wc = work->mad_recv_wc->wc;
 	cm_id_priv->av.dgid.global.subnet_prefix = cpu_to_be64(wc->slid);
 	cm_id_priv->av.dgid.global.interface_id = 0;
-	cm_init_av_for_response(work->port, work->mad_recv_wc->wc,
-				work->mad_recv_wc->recv_buf.grh,
-				&cm_id_priv->av);
+	ret = cm_init_av_for_response(work->port, work->mad_recv_wc->wc,
+				      work->mad_recv_wc->recv_buf.grh,
+				      &cm_id_priv->av);
+	if (ret)
+		goto out;
+
 	cm_id_priv->id.remote_id = sidr_req_msg->request_id;
 	cm_id_priv->tid = sidr_req_msg->hdr.tid;
 	atomic_inc(&cm_id_priv->work_count);
--- a/drivers/infiniband/core/user_mad.c
+++ b/drivers/infiniband/core/user_mad.c
@@ -234,10 +234,14 @@ static void recv_handler(struct ib_mad_a
 	packet->mad.hdr.grh_present = !!(mad_recv_wc->wc->wc_flags & IB_WC_GRH);
 	if (packet->mad.hdr.grh_present) {
 		struct ib_ah_attr ah_attr;
+		int ret;
 
-		ib_init_ah_from_wc(agent->device, agent->port_num,
-				   mad_recv_wc->wc, mad_recv_wc->recv_buf.grh,
-				   &ah_attr);
+		ret = ib_init_ah_from_wc(agent->device, agent->port_num,
+					 mad_recv_wc->wc,
+					 mad_recv_wc->recv_buf.grh,
+					 &ah_attr);
+		if (ret)
+			goto err2;
 
 		packet->mad.hdr.gid_index = ah_attr.grh.sgid_index;
 		packet->mad.hdr.hop_limit = ah_attr.grh.hop_limit;

