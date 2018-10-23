Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D0AC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 15:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A0C62075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 15:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E/r/36GH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A0C62075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbeJWXxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 19:53:38 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43452 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeJWXxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 19:53:38 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9NFIdH3133558;
        Tue, 23 Oct 2018 15:29:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=gRp5gV7KiXIiBAmlkuUWTmfhiaW6dnKrpoppEuRUBJo=;
 b=E/r/36GHNsXsIe4iSxiMcGlZSEv3EFg2hwr/DzCTsGfuppwVfByKyUFpWlDA+vvRsiOS
 f6icgKDTpMAv+SXF9tdvs+fguZmZzhnxsSijxOAzxoRGB4tFC/HUhE2Asbb4TO3OgOOL
 06/odHPMrH+RftHJ1lH2wwZv0sqtvgF7tq77rRoiMZ6Hqj4DcTx/9xyFcuSc2Bql+xEz
 rt66K2XTU4BMkcSTgaIOiyB9HI/8tpv01YRQiclgjiF9jwvK6Z5PLBR5WDU1/+JYzA8V
 2w4l2VjLVB6rAJPGGVIK9B51K2Ibt1SRKKp6jWKublAlckIskq7eo1TczMe9Z5/E0IQE yw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2n7w0qp1du-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Oct 2018 15:29:39 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9NFTcm2029027
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Oct 2018 15:29:38 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9NFTa7q031010;
        Tue, 23 Oct 2018 15:29:36 GMT
Received: from manish-VirtualBox.in.oracle.com (/10.191.233.140)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 23 Oct 2018 08:29:36 -0700
From:   mk.singh@oracle.com
To:     netdev@vger.kernel.org
Cc:     Manish Kumar Singh <mk.singh@oracle.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] bonding:avoid repeated display of same link status change
Date:   Tue, 23 Oct 2018 20:59:24 +0530
Message-Id: <20181023152924.24033-1-mk.singh@oracle.com>
X-Mailer: git-send-email 2.14.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9054 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810230123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manish Kumar Singh <mk.singh@oracle.com>

When link status change needs to be committed and rtnl lock couldn't be
taken, avoid redisplay of same link status change message.

Signed-off-by: Manish Kumar Singh <mk.singh@oracle.com>
---
 drivers/net/bonding/bond_main.c | 6 ++++--
 include/net/bonding.h           | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 2b01180be834..af9ef889a429 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2096,7 +2096,7 @@ static int bond_miimon_inspect(struct bonding *bond)
 			bond_propose_link_state(slave, BOND_LINK_FAIL);
 			commit++;
 			slave->delay = bond->params.downdelay;
-			if (slave->delay) {
+			if (slave->delay && !atomic_read(&bond->rtnl_needed)) {
 				netdev_info(bond->dev, "link status down for %sinterface %s, disabling it in %d ms\n",
 					    (BOND_MODE(bond) ==
 					     BOND_MODE_ACTIVEBACKUP) ?
@@ -2136,7 +2136,7 @@ static int bond_miimon_inspect(struct bonding *bond)
 			commit++;
 			slave->delay = bond->params.updelay;
 
-			if (slave->delay) {
+			if (slave->delay && !atomic_read(&bond->rtnl_needed)) {
 				netdev_info(bond->dev, "link status up for interface %s, enabling it in %d ms\n",
 					    slave->dev->name,
 					    ignore_updelay ? 0 :
@@ -2310,9 +2310,11 @@ static void bond_mii_monitor(struct work_struct *work)
 		if (!rtnl_trylock()) {
 			delay = 1;
 			should_notify_peers = false;
+			atomic_set(&bond->rtnl_needed, 1);
 			goto re_arm;
 		}
 
+		atomic_set(&bond->rtnl_needed, 0);
 		bond_for_each_slave(bond, slave, iter) {
 			bond_commit_link_state(slave, BOND_SLAVE_NOTIFY_LATER);
 		}
diff --git a/include/net/bonding.h b/include/net/bonding.h
index a4f116f06c50..a4353506bb4f 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -229,6 +229,7 @@ struct bonding {
 	struct	 dentry *debug_dir;
 #endif /* CONFIG_DEBUG_FS */
 	struct rtnl_link_stats64 bond_stats;
+	atomic_t rtnl_needed;
 };
 
 #define bond_slave_get_rcu(dev) \
-- 
2.14.1

