Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D381FC07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99B7220854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:35:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99B7220854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbeIMSom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:44:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59028 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727716AbeIMSol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:44:41 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6F468D18;
        Thu, 13 Sep 2018 13:35:11 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vlad Buslov <vladbu@mellanox.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 13/78] act_ife: move tcfa_lock down to where necessary
Date:   Thu, 13 Sep 2018 15:31:00 +0200
Message-Id: <20180913131806.627503894@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131805.732342940@linuxfoundation.org>
References: <20180913131805.732342940@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

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
 net/sched/act_ife.c |   37 +++++++++++++------------------------
 1 file changed, 13 insertions(+), 24 deletions(-)

--- a/net/sched/act_ife.c
+++ b/net/sched/act_ife.c
@@ -267,10 +267,8 @@ static int ife_validate_metatype(struct
 }
 
 /* called when adding new meta information
- * under ife->tcf_lock for existing action
 */
-static int load_metaops_and_vet(struct tcf_ife_info *ife, u32 metaid,
-				void *val, int len, bool exists)
+static int load_metaops_and_vet(u32 metaid, void *val, int len)
 {
 	struct tcf_meta_ops *ops = find_ife_oplist(metaid);
 	int ret = 0;
@@ -278,13 +276,9 @@ static int load_metaops_and_vet(struct t
 	if (!ops) {
 		ret = -ENOENT;
 #ifdef CONFIG_MODULES
-		if (exists)
-			spin_unlock_bh(&ife->tcf_lock);
 		rtnl_unlock();
 		request_module("ifemeta%u", metaid);
 		rtnl_lock();
-		if (exists)
-			spin_lock_bh(&ife->tcf_lock);
 		ops = find_ife_oplist(metaid);
 #endif
 	}
@@ -301,10 +295,9 @@ static int load_metaops_and_vet(struct t
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
@@ -331,12 +324,16 @@ static int add_metainfo(struct tcf_ife_i
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
@@ -344,7 +341,7 @@ static int use_all_metadata(struct tcf_i
 
 	read_lock(&ife_mod_lock);
 	list_for_each_entry(o, &ifeoplist, list) {
-		rc = add_metainfo(ife, o->metaid, NULL, 0, true);
+		rc = add_metainfo(ife, o->metaid, NULL, 0, true, exists);
 		if (rc == 0)
 			installed += 1;
 	}
@@ -416,7 +413,6 @@ static void tcf_ife_cleanup(struct tc_ac
 	spin_unlock_bh(&ife->tcf_lock);
 }
 
-/* under ife->tcf_lock for existing action */
 static int populate_metalist(struct tcf_ife_info *ife, struct nlattr **tb,
 			     bool exists)
 {
@@ -430,11 +426,11 @@ static int populate_metalist(struct tcf_
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
@@ -510,6 +506,8 @@ static int tcf_ife_init(struct net *net,
 	if (exists)
 		spin_lock_bh(&ife->tcf_lock);
 	ife->tcf_action = parm->action;
+	if (exists)
+		spin_unlock_bh(&ife->tcf_lock);
 
 	if (parm->flags & IFE_ENCODE) {
 		if (daddr)
@@ -537,9 +535,6 @@ metadata_parse_err:
 				tcf_hash_release(*a, bind);
 			if (ret == ACT_P_CREATED)
 				_tcf_ife_cleanup(*a, bind);
-
-			if (exists)
-				spin_unlock_bh(&ife->tcf_lock);
 			return err;
 		}
 
@@ -553,20 +548,14 @@ metadata_parse_err:
 		 * as we can. You better have at least one else we are
 		 * going to bail out
 		 */
-		err = use_all_metadata(ife);
+		err = use_all_metadata(ife, exists);
 		if (err) {
 			if (ret == ACT_P_CREATED)
 				_tcf_ife_cleanup(*a, bind);
-
-			if (exists)
-				spin_unlock_bh(&ife->tcf_lock);
 			return err;
 		}
 	}
 
-	if (exists)
-		spin_unlock_bh(&ife->tcf_lock);
-
 	if (ret == ACT_P_CREATED)
 		tcf_hash_insert(tn, *a);
 


