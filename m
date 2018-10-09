Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F1E6C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA48E2054F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Qu7r30hW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA48E2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbeJIUpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 16:45:14 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47346 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbeJIUpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 16:45:05 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w99DO0dc078850;
        Tue, 9 Oct 2018 13:28:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=BundRp6hFN5Q/gzCC/KnlIkhLHDripEBGPRb3OPKDo8=;
 b=Qu7r30hWAmMhevM85PAKHGd8VMdZ6gA/UfReFJ5uGhIN+R3PuBfALXhmv7E85PMl5fBM
 u2+n0jEGtXQnG4/XRSxVTotJ1XTdeAuZBrjrs2JFMNRLgQDUXuWxS11tV3HTLGi+jI9t
 c5BatFzC53JVg+TvSLoWvyc29iweB2O9ZN7K7E/PCL0JzSkLEEbtIxsIyKb/NDdBf4i0
 AcVIX7tZErwie4wfuFMS1brRmZ88AOJyN0uCASiLftNJqKUN2aESd+xLuvfaTHzr2UEO
 7k2zI3AImwJWoopWU09N8Qwb4MNtjoAEdK6w1AxSmpWJxz0aNw7n46P3Y7U2/wuU9O// nw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2mxnpqw46a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Oct 2018 13:28:02 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w99DRunV002046
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Oct 2018 13:27:57 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w99DRubs001804;
        Tue, 9 Oct 2018 13:27:56 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 09 Oct 2018 13:27:56 +0000
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <Haakon.Bugge@oracle.com>
To:     Yishai Hadas <yishaih@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     leon@kernel.org
Subject: [PATCH  v3 1/2] IB/mlx4: Enable debug print of SMPs
Date:   Tue,  9 Oct 2018 15:27:39 +0200
Message-Id: <20181009132740.2210085-2-Haakon.Bugge@oracle.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20181009132740.2210085-1-Haakon.Bugge@oracle.com>
References: <20181009132740.2210085-1-Haakon.Bugge@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9040 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=729
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810090133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IB Subnet Management Packets (SMPs) were excluded from debug prints.

Fixed by enabling print even on QP0 MADs.

Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>

---

v1 -> v3:
   * No changes
---
 drivers/infiniband/hw/mlx4/mad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx4/mad.c b/drivers/infiniband/hw/mlx4/mad.c
index e5466d786bb1..1718715cc094 100644
--- a/drivers/infiniband/hw/mlx4/mad.c
+++ b/drivers/infiniband/hw/mlx4/mad.c
@@ -807,7 +807,7 @@ static int ib_process_mad(struct ib_device *ibdev, int mad_flags, u8 port_num,
 	int err;
 	struct ib_port_attr pattr;
 
-	if (in_wc && in_wc->qp->qp_num) {
+	if (in_wc && in_wc->qp) {
 		pr_debug("received MAD: slid:%d sqpn:%d "
 			"dlid_bits:%d dqpn:%d wc_flags:0x%x, cls %x, mtd %x, atr %x\n",
 			in_wc->slid, in_wc->src_qp,
-- 
2.14.3

