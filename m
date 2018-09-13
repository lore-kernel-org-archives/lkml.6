Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D85C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3786421480
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:50:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3786421480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730710AbeIMS77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:59:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33160 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727760AbeIMS76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:59:58 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D2421CFE;
        Thu, 13 Sep 2018 13:50:22 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vlad Buslov <vladbu@mellanox.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 011/197] act_ife: move tcfa_lock down to where necessary
Date:   Thu, 13 Sep 2018 15:29:20 +0200
Message-Id: <20180913131842.017814375@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cong Wang <xiyou.wangcong@gmail.com>

[ Upstream commit 4e407ff5cd67ec76eeeea1deec227b7982dc7f66 ]

The only time we need to take tcfa_lock is when adding
a new metainfo to an existing ife->metalist. We don't need
to take tcfa_lock so early and so broadly in tcf_ife_init().

This means we can always take ife_mod_lock first, avoid the
reverse locking ordering warning as reported by Vlad.

Reported-by: Vlad Buslov <vladbu@mellanox.com>
Tested-by: Vlad Buslov <vladbu@mellanox.com>
Cc: Vlad Buslov <vladbu@mellanox.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/act_ife.c |   36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

--- a/net/sched/act_ife.c
+++ b/net/sched/act_ife.c
@@ -265,10 +265,8 @@ static const char *ife_meta_id2name(u32
 #endif
 
 /* called when adding new meta information
- * under ife->tcf_lock for existing action
 */
-static int load_metaops_and_vet(struct tcf_ife_info *ife, u32 metaid,
-				void *val, int len, bool exists)
+static int load_metaops_and_vet(u32 metaid, void *val, int len)
 {
 	struct tcf_meta_ops *ops = find_ife_oplist(metaid);
 	int ret = 0;
@@ -276,13 +274,9 @@ static int load_metaops_and_vet(struct t
 	if (!ops) {
 		ret = -ENOENT;
 #ifdef CONFIG_MODULES
-		if (exists)
-			spin_unlock_bh(&ife->tcf_lock);
 		rtnl_unlock();
 		request_module("ife-meta-%s", ife_meta_id2name(metaid));
 		rtnl_lock();
-		if (exists)
-			spin_lock_bh(&ife->tcf_lock);
 		ops = find_ife_oplist(metaid);
 #endif
 	}
@@ -299,10 +293,9 @@ static int load_metaops_and_vet(struct t
 }
 
 /* called when adding new meta information
- * under ife->tcf_lock for existing action
 */
 static int add_metainfo(struct tcf_ife_info *ife, u32 metaid, void *metaval,
-			int len, bool atomic)
+			int len, bool atomic, bool exists)
 {
 	struct tcf_meta_info *mi = NULL;
 	struct tcf_meta_ops *ops = find_ife_oplist(metaid);
@@ -329,12 +322,16 @@ static int add_metainfo(struct tcf_ife_i
 		}
 	}
 
+	if (exists)
+		spin_lock_bh(&ife->tcf_lock);
 	list_add_tail(&mi->metalist, &ife->metalist);
+	if (exists)
+		spin_unlock_bh(&ife->tcf_lock);
 
 	return ret;
 }
 
-static int use_all_metadata(struct tcf_ife_info *ife)
+static int use_all_metadata(struct tcf_ife_info *ife, bool exists)
 {
 	struct tcf_meta_ops *o;
 	int rc = 0;
@@ -342,7 +339,7 @@ static int use_all_metadata(struct tcf_i
 
 	read_lock(&ife_mod_lock);
 	list_for_each_entry(o, &ifeoplist, list) {
-		rc = add_metainfo(ife, o->metaid, NULL, 0, true);
+		rc = add_metainfo(ife, o->metaid, NULL, 0, true, exists);
 		if (rc == 0)
 			installed += 1;
 	}
@@ -419,7 +416,6 @@ static void tcf_ife_cleanup(struct tc_ac
 		kfree_rcu(p, rcu);
 }
 
-/* under ife->tcf_lock for existing action */
 static int populate_metalist(struct tcf_ife_info *ife, struct nlattr **tb,
 			     bool exists)
 {
@@ -433,11 +429,11 @@ static int populate_metalist(struct tcf_
 			val = nla_data(tb[i]);
 			len = nla_len(tb[i]);
 
-			rc = load_metaops_and_vet(ife, i, val, len, exists);
+			rc = load_metaops_and_vet(i, val, len);
 			if (rc != 0)
 				return rc;
 
-			rc = add_metainfo(ife, i, val, len, exists);
+			rc = add_metainfo(ife, i, val, len, false, exists);
 			if (rc)
 				return rc;
 		}
@@ -531,8 +527,6 @@ static int tcf_ife_init(struct net *net,
 		p->eth_type = ife_type;
 	}
 
-	if (exists)
-		spin_lock_bh(&ife->tcf_lock);
 
 	if (ret == ACT_P_CREATED)
 		INIT_LIST_HEAD(&ife->metalist);
@@ -544,9 +538,6 @@ static int tcf_ife_init(struct net *net,
 metadata_parse_err:
 			if (ret == ACT_P_CREATED)
 				tcf_idr_release(*a, bind);
-
-			if (exists)
-				spin_unlock_bh(&ife->tcf_lock);
 			kfree(p);
 			return err;
 		}
@@ -561,18 +552,17 @@ metadata_parse_err:
 		 * as we can. You better have at least one else we are
 		 * going to bail out
 		 */
-		err = use_all_metadata(ife);
+		err = use_all_metadata(ife, exists);
 		if (err) {
 			if (ret == ACT_P_CREATED)
 				tcf_idr_release(*a, bind);
-
-			if (exists)
-				spin_unlock_bh(&ife->tcf_lock);
 			kfree(p);
 			return err;
 		}
 	}
 
+	if (exists)
+		spin_lock_bh(&ife->tcf_lock);
 	ife->tcf_action = parm->action;
 	if (exists)
 		spin_unlock_bh(&ife->tcf_lock);


