Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59578C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C555214DB
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:47:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C555214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729767AbeKLFgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:36:47 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55280 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727143AbeKLFdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:33:47 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wABJi9C3121680
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 14:44:20 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2npdcu1j01-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 14:44:20 -0500
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 11 Nov 2018 19:44:19 -0000
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 11 Nov 2018 19:44:13 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wABJiCWv36569178
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 11 Nov 2018 19:44:12 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8FEE0B205F;
        Sun, 11 Nov 2018 19:44:12 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6264CB206E;
        Sun, 11 Nov 2018 19:44:12 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.207.24])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 11 Nov 2018 19:44:12 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 3A27516C5DB4; Sun, 11 Nov 2018 11:44:13 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        "David S. Miller" <davem@davemloft.net>,
        bridge@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [PATCH tip/core/rcu 33/41] net/bridge: Replace call_rcu_bh() and rcu_barrier_bh()
Date:   Sun, 11 Nov 2018 11:44:02 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181111194104.GA4787@linux.ibm.com>
References: <20181111194104.GA4787@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18111119-2213-0000-0000-00000315A7E8
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010028; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01116019; UDB=6.00578733; IPR=6.00896120;
 MB=3.00024114; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-11 19:44:18
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111119-2214-0000-0000-00005C386BB9
Message-Id: <20181111194410.6368-33-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-11_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=859 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811110188
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that call_rcu()'s callback is not invoked until after all bh-disable
regions of code have completed (in addition to explicitly marked
RCU read-side critical sections), call_rcu() can be used in place
of call_rcu_bh().  Similarly, rcu_barrier() can be used in place of
rcu_barrier_bh().  This commit therefore makes these changes.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
Cc: Roopa Prabhu <roopa@cumulusnetworks.com>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: <bridge@lists.linux-foundation.org>
Cc: <netdev@vger.kernel.org>
---
 net/bridge/br_mdb.c       |  2 +-
 net/bridge/br_multicast.c | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index a7ea2d431714..596ec6e7df11 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -728,7 +728,7 @@ static int __br_mdb_del(struct net_bridge *br, struct br_mdb_entry *entry)
 		rcu_assign_pointer(*pp, p->next);
 		hlist_del_init(&p->mglist);
 		del_timer(&p->timer);
-		call_rcu_bh(&p->rcu, br_multicast_free_pg);
+		call_rcu(&p->rcu, br_multicast_free_pg);
 		err = 0;
 
 		if (!mp->ports && !mp->host_joined &&
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 6bac0d6b7b94..0255223f2001 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -260,7 +260,7 @@ static void br_multicast_group_expired(struct timer_list *t)
 	hlist_del_rcu(&mp->hlist[mdb->ver]);
 	mdb->size--;
 
-	call_rcu_bh(&mp->rcu, br_multicast_free_group);
+	call_rcu(&mp->rcu, br_multicast_free_group);
 
 out:
 	spin_unlock(&br->multicast_lock);
@@ -291,7 +291,7 @@ static void br_multicast_del_pg(struct net_bridge *br,
 		del_timer(&p->timer);
 		br_mdb_notify(br->dev, p->port, &pg->addr, RTM_DELMDB,
 			      p->flags);
-		call_rcu_bh(&p->rcu, br_multicast_free_pg);
+		call_rcu(&p->rcu, br_multicast_free_pg);
 
 		if (!mp->ports && !mp->host_joined &&
 		    netif_running(br->dev))
@@ -358,7 +358,7 @@ static int br_mdb_rehash(struct net_bridge_mdb_htable __rcu **mdbp, int max,
 	}
 
 	br_mdb_rehash_seq++;
-	call_rcu_bh(&mdb->rcu, br_mdb_free);
+	call_rcu(&mdb->rcu, br_mdb_free);
 
 out:
 	rcu_assign_pointer(*mdbp, mdb);
@@ -1629,7 +1629,7 @@ br_multicast_leave_group(struct net_bridge *br,
 			rcu_assign_pointer(*pp, p->next);
 			hlist_del_init(&p->mglist);
 			del_timer(&p->timer);
-			call_rcu_bh(&p->rcu, br_multicast_free_pg);
+			call_rcu(&p->rcu, br_multicast_free_pg);
 			br_mdb_notify(br->dev, port, group, RTM_DELMDB,
 				      p->flags);
 
@@ -2051,19 +2051,19 @@ void br_multicast_dev_del(struct net_bridge *br)
 		hlist_for_each_entry_safe(mp, n, &mdb->mhash[i],
 					  hlist[ver]) {
 			del_timer(&mp->timer);
-			call_rcu_bh(&mp->rcu, br_multicast_free_group);
+			call_rcu(&mp->rcu, br_multicast_free_group);
 		}
 	}
 
 	if (mdb->old) {
 		spin_unlock_bh(&br->multicast_lock);
-		rcu_barrier_bh();
+		rcu_barrier();
 		spin_lock_bh(&br->multicast_lock);
 		WARN_ON(mdb->old);
 	}
 
 	mdb->old = mdb;
-	call_rcu_bh(&mdb->rcu, br_mdb_free);
+	call_rcu(&mdb->rcu, br_mdb_free);
 
 out:
 	spin_unlock_bh(&br->multicast_lock);
-- 
2.17.1

