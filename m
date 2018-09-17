Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0484ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 07:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8566C214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 07:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C0eDBeq4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8566C214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbeIQMsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 08:48:07 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49398 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbeIQMsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 08:48:07 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8H7Iaf7108208;
        Mon, 17 Sep 2018 07:21:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=y11XadcloNkt0PL6tCQyEf9WKqWkIgRTGmPRr8X1mdk=;
 b=C0eDBeq406z25oBTXS7RaCy7SR2c8zPYIx/c+yYDQRuTQE0uqAYprN8KU73BJX3dcTcn
 9CuuIU0NFDRP4gUaHomd4w/7PAeK0r971jF+SGHDG4tXEjbgP+TIx0YaIAm3NrXd/X9P
 wmb23rDF3rXiL1Jo52kvKhmiiiMhqgMkoG2bIWdAhxRJ48sAKWSlgBhjv4/KQTq/Cz3U
 WrfarteEtCfQc7jXzo/j6PzaAsqKstEZ9M0MUZDS3NeU8r1ajB7z6xpS+S+30sobk1Aa
 1XoevRVZhxAQtbIm8tL0VpHrMsDA2Eg1tDmNnWWkCdSTZ2dgMVihNKI/nWmpSlKrt6Sv nA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2mgsgtcdkp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Sep 2018 07:21:53 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8H7Lk2N029799
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Sep 2018 07:21:47 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8H7LktV023158;
        Mon, 17 Sep 2018 07:21:46 GMT
Received: from manish-VirtualBox.sg.oracle.com (/10.191.34.242)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 17 Sep 2018 00:21:45 -0700
From:   mk.singh@oracle.com
To:     netdev@vger.kernel.org
Cc:     Manish Kumar Singh <mk.singh@oracle.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] bonding: avoid repeated display of same link status change
Date:   Mon, 17 Sep 2018 12:50:59 +0530
Message-Id: <20180917072059.32657-1-mk.singh@oracle.com>
X-Mailer: git-send-email 2.14.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9018 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809170078
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
index 217b790d22ed..fb4e3aff1677 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2087,7 +2087,7 @@ static int bond_miimon_inspect(struct bonding *bond)
 			bond_propose_link_state(slave, BOND_LINK_FAIL);
 			commit++;
 			slave->delay = bond->params.downdelay;
-			if (slave->delay) {
+			if (slave->delay && !bond->rtnl_needed) {
 				netdev_info(bond->dev, "link status down for %sinterface %s, disabling it in %d ms\n",
 					    (BOND_MODE(bond) ==
 					     BOND_MODE_ACTIVEBACKUP) ?
@@ -2127,7 +2127,7 @@ static int bond_miimon_inspect(struct bonding *bond)
 			commit++;
 			slave->delay = bond->params.updelay;
 
-			if (slave->delay) {
+			if (slave->delay && !bond->rtnl_needed) {
 				netdev_info(bond->dev, "link status up for interface %s, enabling it in %d ms\n",
 					    slave->dev->name,
 					    ignore_updelay ? 0 :
@@ -2301,9 +2301,11 @@ static void bond_mii_monitor(struct work_struct *work)
 		if (!rtnl_trylock()) {
 			delay = 1;
 			should_notify_peers = false;
+			bond->rtnl_needed = true;
 			goto re_arm;
 		}
 
+		bond->rtnl_needed = false;
 		bond_for_each_slave(bond, slave, iter) {
 			bond_commit_link_state(slave, BOND_SLAVE_NOTIFY_LATER);
 		}
diff --git a/include/net/bonding.h b/include/net/bonding.h
index 808f1d167349..50d61cf77855 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -234,6 +234,7 @@ struct bonding {
 	struct	 dentry *debug_dir;
 #endif /* CONFIG_DEBUG_FS */
 	struct rtnl_link_stats64 bond_stats;
+	bool rtnl_needed;
 };
 
 #define bond_slave_get_rcu(dev) \
-- 
2.14.1

