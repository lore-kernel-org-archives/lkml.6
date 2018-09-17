Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBF9ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFCB52147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nOdcMHV5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFCB52147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbeIQUVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 16:21:14 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49678 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727870AbeIQUVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 16:21:14 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8HEhpU8118798;
        Mon, 17 Sep 2018 14:53:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=8ARR21D7FW8H3TPq4ht6cYrmxewWoxg3zF/2qrnODfI=;
 b=nOdcMHV5eG6jZy4Ft/UeJ2LnBGOKhrowwK1GIA5I0mR04SQbS84NlK/BOBxq1LQpkHAJ
 l1sc4n/2aS5cyDkdZxtwIUbZlfjBU90KEFKw/k/V1gWXOywodnHURku35BZ0gFm11m76
 NyDMvfWoIs9jKtHwCwLinBbX9dMy4cxegRTGvpJ3jKjuz+mXUNWR5mxiY8z0Ez//r2kS
 yXvLiZIQGwI3mVb5sns48zZLp3ThlNdGTRmgcmEyyji1NnVw1fk6oxhT72TBEsRC/D12
 cHP8slUpGRMS8xLdtWj4CpRxv6AEURzfYWdXiyZubIBbdS50IaDNPY/Mhev2fTomGlE5 ZQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2mgt1pepvr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Sep 2018 14:53:26 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8HErQIr008863
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Sep 2018 14:53:26 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8HErQ0W005054;
        Mon, 17 Sep 2018 14:53:26 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 17 Sep 2018 07:53:26 -0700
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <Haakon.Bugge@oracle.com>
To:     Doug Ledford <dledford@redhat.com>, yishaih@mellanox.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        jgg@ziepe.ca
Cc:     jackm@dev.mellanox.co.il
Subject: [PATCH 2/2] IB/mlx4: Add port and TID to MAD debug print
Date:   Mon, 17 Sep 2018 16:53:09 +0200
Message-Id: <20180917145309.1255642-3-Haakon.Bugge@oracle.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180917145309.1255642-1-Haakon.Bugge@oracle.com>
References: <20180917145309.1255642-1-Haakon.Bugge@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9018 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=883
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809170149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add said information and make the debug print format consistent.

Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
---
 drivers/infiniband/hw/mlx4/mad.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/mad.c b/drivers/infiniband/hw/mlx4/mad.c
index 1718715cc094..2b3e8a959dd9 100644
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
+			 "dlid_bits:%d dqpn:%d wc_flags:0x%x tid:%08x cls:%x mtd:%x atr:%x\n",
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

