Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1265BC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB3A32087D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="guyBu6GL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB3A32087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbeJIUpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 16:45:06 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47348 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbeJIUpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 16:45:05 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w99DO0db078850;
        Tue, 9 Oct 2018 13:27:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=wBahTmqAfYt1JUTGiGkUyDZwUXaFmdEyBYCHb95HMNQ=;
 b=guyBu6GLGxCMW4URagpW0n6b5qcjg1zqKMotbhu1nlC+QgMqCDP1pNlDAVRl9XIT9NnM
 Mx2xJEAP8DPKUhVUOBzuOyZ0NmcbC62qip7uxtna8OSMsI8S/QHT+iKQjIGqC2BTnK7t
 5WWjPzxvcRFyl6I5WpH5gR5hu3Ymzq3oBM6bsxlP8dLHCNrEp+LvFvVdjJIMzwo4QoW0
 y6QOef1x4z0y1eO7JOvtZWQAb7pcKB7boGkV05zEu+Jp/1HZGX7Za3iMGtty+sSJBl3X
 5ClLzng3QJXmb/QZDnM+UWENYWyBzP73XQcKlspQh6dwydRx6vIHQ+S3hDqq8lBI1PJF Kw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2mxnpqw45w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Oct 2018 13:27:59 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w99DRwGG001061
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Oct 2018 13:27:58 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w99DRvno014439;
        Tue, 9 Oct 2018 13:27:57 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 09 Oct 2018 13:27:57 +0000
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <Haakon.Bugge@oracle.com>
To:     Yishai Hadas <yishaih@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     leon@kernel.org
Subject: [PATCH  v3 2/2] IB/mlx4: Add port and TID to MAD debug print
Date:   Tue,  9 Oct 2018 15:27:40 +0200
Message-Id: <20181009132740.2210085-3-Haakon.Bugge@oracle.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20181009132740.2210085-1-Haakon.Bugge@oracle.com>
References: <20181009132740.2210085-1-Haakon.Bugge@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9040 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=949
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810090133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add said information and make the debug print format consistent.

Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
Acked-by: Leon Romanovsky <leonro@mellanox.com>

---

v1 -> v2:
    * Fixed incorrect format for printing the TID
v2 -> v3:
    * Added Leon's a-b
---
 drivers/infiniband/hw/mlx4/mad.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/mad.c b/drivers/infiniband/hw/mlx4/mad.c
index 1718715cc094..8942f5f7f04d 100644
--- a/drivers/infiniband/hw/mlx4/mad.c
+++ b/drivers/infiniband/hw/mlx4/mad.c
@@ -808,14 +808,16 @@ static int ib_process_mad(struct ib_device *ibdev, int mad_flags, u8 port_num,
 	struct ib_port_attr pattr;
 
 	if (in_wc && in_wc->qp) {
-		pr_debug("received MAD: slid:%d sqpn:%d "
-			"dlid_bits:%d dqpn:%d wc_flags:0x%x, cls %x, mtd %x, atr %x\n",
-			in_wc->slid, in_wc->src_qp,
-			in_wc->dlid_path_bits,
-			in_wc->qp->qp_num,
-			in_wc->wc_flags,
-			in_mad->mad_hdr.mgmt_class, in_mad->mad_hdr.method,
-			be16_to_cpu(in_mad->mad_hdr.attr_id));
+		pr_debug("received MAD: port:%d slid:%d sqpn:%d "
+			 "dlid_bits:%d dqpn:%d wc_flags:0x%x tid:%016llx cls:%x mtd:%x atr:%x\n",
+			 port_num,
+			 in_wc->slid, in_wc->src_qp,
+			 in_wc->dlid_path_bits,
+			 in_wc->qp->qp_num,
+			 in_wc->wc_flags,
+			 be64_to_cpu(in_mad->mad_hdr.tid),
+			 in_mad->mad_hdr.mgmt_class, in_mad->mad_hdr.method,
+			 be16_to_cpu(in_mad->mad_hdr.attr_id));
 		if (in_wc->wc_flags & IB_WC_GRH) {
 			pr_debug("sgid_hi:0x%016llx sgid_lo:0x%016llx\n",
 				 be64_to_cpu(in_grh->sgid.global.subnet_prefix),
-- 
2.14.3

