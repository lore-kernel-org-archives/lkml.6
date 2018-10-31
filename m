Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AD3C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D64A920685
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d0c9joiE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D64A920685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729243AbeJaT4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 15:56:31 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38338 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728918AbeJaTzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 15:55:44 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9VAnn9r133983;
        Wed, 31 Oct 2018 10:58:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=V4/gdpncSNEQ4mZl16I2UnE30UBx6m4HftDP1gv2Atw=;
 b=d0c9joiE/zKrhnyCi1N6JtSUqChZZ6zYUIHOriAMbo/3lc/o3U33e61oSVtm0zKXGA6I
 gGYBmMol36B1+LD9JbIZMCjTW/URtdZm++rcJjecv4KdMVe14RfVJt9yT6w0QiLnWBJh
 +uGVa0oGoM6JOnMUap4jMJWicINX7LmawY/f7oZI+IY6f3XyVuI6b+dCpOuBQ/9+CeMG
 IXmhnmG/tSdKYhPz0MGpmkU7Zo+G3NiqAuqYm5CiiWqzR18tdg7052ppgbS09tUPxkub
 9uXIIlQHc9FmyCGu4jFFrxdqVJcmvjNPvPodyg9hi7+QSkpIFA2bd/BHaEhJo3B+h7Pm Mw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2ncfyq235b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Oct 2018 10:58:02 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9VAw1EY018986
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Oct 2018 10:58:01 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9VAvxlB029153;
        Wed, 31 Oct 2018 10:58:00 GMT
Received: from manish-VirtualBox.in.oracle.com (/10.191.249.11)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 31 Oct 2018 03:57:59 -0700
From:   mk.singh@oracle.com
To:     netdev@vger.kernel.org
Cc:     eric.dumazet@gmail.com, mkubecek@suse.cz,
        Manish Kumar Singh <mk.singh@oracle.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] bonding:avoid repeated display of same link status change
Date:   Wed, 31 Oct 2018 16:27:28 +0530
Message-Id: <20181031105729.7442-1-mk.singh@oracle.com>
X-Mailer: git-send-email 2.14.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9062 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810310090
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manish Kumar Singh <mk.singh@oracle.com>

When link status change needs to be committed and rtnl lock couldn't be
taken, avoid redisplay of same link status change message.

Signed-off-by: Manish Kumar Singh <mk.singh@oracle.com>
---
 drivers/net/bonding/bond_main.c | 8 ++++++--
 include/net/bonding.h           | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 2b01180be834..b3d95c7040ac 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2096,7 +2096,8 @@ static int bond_miimon_inspect(struct bonding *bond)
 			bond_propose_link_state(slave, BOND_LINK_FAIL);
 			commit++;
 			slave->delay = bond->params.downdelay;
-			if (slave->delay) {
+			if (slave->delay &&
+			    !atomic64_read(&bond->rtnl_needed)) {
 				netdev_info(bond->dev, "link status down for %sinterface %s, disabling it in %d ms\n",
 					    (BOND_MODE(bond) ==
 					     BOND_MODE_ACTIVEBACKUP) ?
@@ -2136,7 +2137,8 @@ static int bond_miimon_inspect(struct bonding *bond)
 			commit++;
 			slave->delay = bond->params.updelay;
 
-			if (slave->delay) {
+			if (slave->delay &&
+			    !atomic64_read(&bond->rtnl_needed)) {
 				netdev_info(bond->dev, "link status up for interface %s, enabling it in %d ms\n",
 					    slave->dev->name,
 					    ignore_updelay ? 0 :
@@ -2310,9 +2312,11 @@ static void bond_mii_monitor(struct work_struct *work)
 		if (!rtnl_trylock()) {
 			delay = 1;
 			should_notify_peers = false;
+			atomic64_set(&bond->rtnl_needed, 1);
 			goto re_arm;
 		}
 
+		atomic64_set(&bond->rtnl_needed, 0);
 		bond_for_each_slave(bond, slave, iter) {
 			bond_commit_link_state(slave, BOND_SLAVE_NOTIFY_LATER);
 		}
diff --git a/include/net/bonding.h b/include/net/bonding.h
index a4f116f06c50..20c3c875266f 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -229,6 +229,7 @@ struct bonding {
 	struct	 dentry *debug_dir;
 #endif /* CONFIG_DEBUG_FS */
 	struct rtnl_link_stats64 bond_stats;
+	atomic64_t rtnl_needed;
 };
 
 #define bond_slave_get_rcu(dev) \
-- 
2.14.1

