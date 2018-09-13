Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BEFC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E2AF2146E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:35:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E2AF2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbeIMSoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:44:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59038 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727716AbeIMSop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:44:45 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B0189CF3;
        Thu, 13 Sep 2018 13:35:14 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 14/78] act_ife: fix a potential deadlock
Date:   Thu, 13 Sep 2018 15:31:01 +0200
Message-Id: <20180913131806.685192745@linuxfoundation.org>
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

[ Upstream commit 5ffe57da29b3802baeddaa40909682bbb4cb4d48 ]

use_all_metadata() acquires read_lock(&ife_mod_lock), then calls
add_metainfo() which calls find_ife_oplist() which acquires the same
lock again. Deadlock!

Introduce __add_metainfo() which accepts struct tcf_meta_ops *ops
as an additional parameter and let its callers to decide how
to find it. For use_all_metadata(), it already has ops, no
need to find it again, just call __add_metainfo() directly.

And, as ife_mod_lock is only needed for find_ife_oplist(),
this means we can make non-atomic allocation for populate_metalist()
now.

Fixes: 817e9f2c5c26 ("act_ife: acquire ife_mod_lock before reading ifeoplist")
Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/act_ife.c |   34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

--- a/net/sched/act_ife.c
+++ b/net/sched/act_ife.c
@@ -296,22 +296,16 @@ static int load_metaops_and_vet(u32 meta
 
 /* called when adding new meta information
 */
-static int add_metainfo(struct tcf_ife_info *ife, u32 metaid, void *metaval,
-			int len, bool atomic, bool exists)
+static int __add_metainfo(const struct tcf_meta_ops *ops,
+			  struct tcf_ife_info *ife, u32 metaid, void *metaval,
+			  int len, bool atomic, bool exists)
 {
 	struct tcf_meta_info *mi = NULL;
-	struct tcf_meta_ops *ops = find_ife_oplist(metaid);
 	int ret = 0;
 
-	if (!ops)
-		return -ENOENT;
-
 	mi = kzalloc(sizeof(*mi), atomic ? GFP_ATOMIC : GFP_KERNEL);
-	if (!mi) {
-		/*put back what find_ife_oplist took */
-		module_put(ops->owner);
+	if (!mi)
 		return -ENOMEM;
-	}
 
 	mi->metaid = metaid;
 	mi->ops = ops;
@@ -319,7 +313,6 @@ static int add_metainfo(struct tcf_ife_i
 		ret = ops->alloc(mi, metaval, atomic ? GFP_ATOMIC : GFP_KERNEL);
 		if (ret != 0) {
 			kfree(mi);
-			module_put(ops->owner);
 			return ret;
 		}
 	}
@@ -333,6 +326,21 @@ static int add_metainfo(struct tcf_ife_i
 	return ret;
 }
 
+static int add_metainfo(struct tcf_ife_info *ife, u32 metaid, void *metaval,
+			int len, bool exists)
+{
+	const struct tcf_meta_ops *ops = find_ife_oplist(metaid);
+	int ret;
+
+	if (!ops)
+		return -ENOENT;
+	ret = __add_metainfo(ops, ife, metaid, metaval, len, false, exists);
+	if (ret)
+		/*put back what find_ife_oplist took */
+		module_put(ops->owner);
+	return ret;
+}
+
 static int use_all_metadata(struct tcf_ife_info *ife, bool exists)
 {
 	struct tcf_meta_ops *o;
@@ -341,7 +349,7 @@ static int use_all_metadata(struct tcf_i
 
 	read_lock(&ife_mod_lock);
 	list_for_each_entry(o, &ifeoplist, list) {
-		rc = add_metainfo(ife, o->metaid, NULL, 0, true, exists);
+		rc = __add_metainfo(o, ife, o->metaid, NULL, 0, true, exists);
 		if (rc == 0)
 			installed += 1;
 	}
@@ -430,7 +438,7 @@ static int populate_metalist(struct tcf_
 			if (rc != 0)
 				return rc;
 
-			rc = add_metainfo(ife, i, val, len, false, exists);
+			rc = add_metainfo(ife, i, val, len, exists);
 			if (rc)
 				return rc;
 		}


