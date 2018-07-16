Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37EE9ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E62F6208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jMqDC9fs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E62F6208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731179AbeGPN2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 09:28:01 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46422 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729854AbeGPN2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 09:28:00 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6GCxP5A170269;
        Mon, 16 Jul 2018 13:00:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=GomDL5C2OIVulv6LBVyiEAkPrCsAk/DE2CgCJkrvw7c=;
 b=jMqDC9fscuYWdVpSjTYjvpgI4994MUpDGMjEJ1cgctaVJuFA0U6zl/yfJfDoL1v5Og7O
 ouwAQE8GiDtUVsNpl+mrTYBU1/2PbzZFqAWtKjlj3lRqiIosOz8KmobY+G6jmDhk0zJI
 sCzlubaWi+gXyCErGVBtfhU5n07zxPJOHIv+e52WPpVwRhGOvVByZr47FtUT+ZYijYzC
 D2O96uT4Xyuh0s+WEhn3LJIf8YR067kyyV5G889nh/LhHr7CTmRWab+m29aErEZpLBA5
 jK8KLtARDMUJLznU5VPc4kQcF+bn9griALqHM/iV856rCSIDuIZBljgKjsdPbN0U3CRf Lw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2k7a33v9hm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Jul 2018 13:00:36 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6GD0Zv0031017
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Jul 2018 13:00:36 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6GD0YSD013881;
        Mon, 16 Jul 2018 13:00:34 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Jul 2018 06:00:34 -0700
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <Haakon.Bugge@oracle.com>
To:     Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: [PATCH] net/rds: void function cannot return -1
Date:   Mon, 16 Jul 2018 15:00:09 +0200
Message-Id: <20180716130009.1591379-1-Haakon.Bugge@oracle.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8955 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=745
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807160152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b6fb0df12db6 ("RDS/IB: Make ib_recv_refill return void") did
not change the comment accordingly.

Fixes: b6fb0df12db6 ("RDS/IB: Make ib_recv_refill return void")
Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
---
 net/rds/ib_recv.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/rds/ib_recv.c b/net/rds/ib_recv.c
index b4e421aa9727..e5ce93419263 100644
--- a/net/rds/ib_recv.c
+++ b/net/rds/ib_recv.c
@@ -376,8 +376,6 @@ static void release_refill(struct rds_connection *conn)
  * This tries to allocate and post unused work requests after making sure that
  * they have all the allocations they need to queue received fragments into
  * sockets.
- *
- * -1 is returned if posting fails due to temporary resource exhaustion.
  */
 void rds_ib_recv_refill(struct rds_connection *conn, int prefill, gfp_t gfp)
 {
-- 
2.14.3

