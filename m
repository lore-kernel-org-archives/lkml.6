Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829F6C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ED9D244AF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qDnldk2P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ED9D244AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753729AbeGDKss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 06:48:48 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:40302 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753295AbeGDKsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 06:48:47 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w64AdJRw117119;
        Wed, 4 Jul 2018 10:48:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2017-10-26;
 bh=8rbKbQPMDSPUzDfj7cVeos6rt6STjgld/s/JO47/N1w=;
 b=qDnldk2P01WSJm56PWFinnpfvZ8pVfKtSfCBpQVSN906ViHarlhK1Z0wDyvcFttS/Vrm
 v2LHj80nWbT73NO6u04Zh6qj1D1fYKLtZYec7sMG740mt5DisPWZ5+s2/tdAP8DS81Ft
 7WaXJ8AG2myVrIHm0hGoJfdT8f/A+E/gO4IlOjMO6Z57DGfOpQgsqhTv6p4/Mh+CkgMB
 8bissJ+BGs9Wleeq/xP3nrMsU1gdP3cLFuDQRBiEREEyWEakndFY+od2BGG4m5CnAeo8
 3JhwO7W1vopUgIRMHzeQgFWNEiKtFy+0p7vpYl76b1YTXpf4SC/mvXGvrrhoVFkrCCgp Iw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2k0dnjabcv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Jul 2018 10:48:33 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w64AmWJM012324
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Jul 2018 10:48:33 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w64AmWie021037;
        Wed, 4 Jul 2018 10:48:32 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 04 Jul 2018 03:48:31 -0700
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <Haakon.Bugge@oracle.com>
To:     Doug Ledford <dledford@redhat.com>,
        Don Hiatt <don.hiatt@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Sean Hefty <sean.hefty@intel.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
Subject: [PATCH] IB/cm: Remove unused and erroneous msg sequence encoding
Date:   Wed,  4 Jul 2018 12:48:01 +0200
Message-Id: <20180704104801.912482-1-Haakon.Bugge@oracle.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8943 signatures=668704
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807040126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In cm_form_tid(), a two bit message sequence number is OR'ed into bit
31-30 of the lower TID value.

After commit f06d26537559 ("IB/cm: Randomize starting comm ID"), the
local_id is XOR'ed with a 32-bit random value. Hence, bit 31-30 in the
lower TID now has an arbitrarily value and it makes no sense to OR in
the message sequence number.

Adding to that, the evolution in use of IDR routines in cm_alloc_id()
has always had the possibility of returning a value with bit 30 set.

In addition, said bits are never checked.

Hence, remove the encoding and the corresponding enum.

Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
---
 drivers/infiniband/core/cm.c      | 14 ++++++--------
 drivers/infiniband/core/cm_msgs.h |  7 -------
 2 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index de699f67a755..4724cb09b69d 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1256,14 +1256,12 @@ struct ib_cm_id *ib_cm_insert_listen(struct ib_device *device,
 }
 EXPORT_SYMBOL(ib_cm_insert_listen);
 
-static __be64 cm_form_tid(struct cm_id_private *cm_id_priv,
-			  enum cm_msg_sequence msg_seq)
+static __be64 cm_form_tid(struct cm_id_private *cm_id_priv)
 {
 	u64 hi_tid, low_tid;
 
 	hi_tid   = ((u64) cm_id_priv->av.port->mad_agent->hi_tid) << 32;
-	low_tid  = (u64) ((__force u32)cm_id_priv->id.local_id |
-			  (msg_seq << 30));
+	low_tid  = (u64)cm_id_priv->id.local_id;
 	return cpu_to_be64(hi_tid | low_tid);
 }
 
@@ -1291,7 +1289,7 @@ static void cm_format_req(struct cm_req_msg *req_msg,
 					      pri_path->opa.slid);
 
 	cm_format_mad_hdr(&req_msg->hdr, CM_REQ_ATTR_ID,
-			  cm_form_tid(cm_id_priv, CM_MSG_SEQUENCE_REQ));
+			  cm_form_tid(cm_id_priv));
 
 	req_msg->local_comm_id = cm_id_priv->id.local_id;
 	req_msg->service_id = param->service_id;
@@ -2465,7 +2463,7 @@ static void cm_format_dreq(struct cm_dreq_msg *dreq_msg,
 			  u8 private_data_len)
 {
 	cm_format_mad_hdr(&dreq_msg->hdr, CM_DREQ_ATTR_ID,
-			  cm_form_tid(cm_id_priv, CM_MSG_SEQUENCE_DREQ));
+			  cm_form_tid(cm_id_priv));
 	dreq_msg->local_comm_id = cm_id_priv->id.local_id;
 	dreq_msg->remote_comm_id = cm_id_priv->id.remote_id;
 	cm_dreq_set_remote_qpn(dreq_msg, cm_id_priv->remote_qpn);
@@ -3096,7 +3094,7 @@ static void cm_format_lap(struct cm_lap_msg *lap_msg,
 		alt_ext = opa_is_extended_lid(alternate_path->opa.dlid,
 					      alternate_path->opa.slid);
 	cm_format_mad_hdr(&lap_msg->hdr, CM_LAP_ATTR_ID,
-			  cm_form_tid(cm_id_priv, CM_MSG_SEQUENCE_LAP));
+			  cm_form_tid(cm_id_priv));
 	lap_msg->local_comm_id = cm_id_priv->id.local_id;
 	lap_msg->remote_comm_id = cm_id_priv->id.remote_id;
 	cm_lap_set_remote_qpn(lap_msg, cm_id_priv->remote_qpn);
@@ -3472,7 +3470,7 @@ static void cm_format_sidr_req(struct cm_sidr_req_msg *sidr_req_msg,
 			       struct ib_cm_sidr_req_param *param)
 {
 	cm_format_mad_hdr(&sidr_req_msg->hdr, CM_SIDR_REQ_ATTR_ID,
-			  cm_form_tid(cm_id_priv, CM_MSG_SEQUENCE_SIDR));
+			  cm_form_tid(cm_id_priv));
 	sidr_req_msg->request_id = cm_id_priv->id.local_id;
 	sidr_req_msg->pkey = param->path->pkey;
 	sidr_req_msg->service_id = param->service_id;
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index 8b76f0ef965e..476d4309576d 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -44,13 +44,6 @@
 
 #define IB_CM_CLASS_VERSION	2 /* IB specification 1.2 */
 
-enum cm_msg_sequence {
-	CM_MSG_SEQUENCE_REQ,
-	CM_MSG_SEQUENCE_LAP,
-	CM_MSG_SEQUENCE_DREQ,
-	CM_MSG_SEQUENCE_SIDR
-};
-
 struct cm_req_msg {
 	struct ib_mad_hdr hdr;
 
-- 
2.14.3

