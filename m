Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEEEC43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B66A624FEE
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:34:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B66A624FEE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755198AbeFXPeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:34:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59328 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754659AbeFXPeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:34:15 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EBBC12C;
        Sun, 24 Jun 2018 15:34:13 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Davide Caratti <dcaratti@redhat.com>,
        Simon Horman <simon.horman@netronome.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 06/64] net/sched: act_simple: fix parsing of TCA_DEF_DATA
Date:   Sun, 24 Jun 2018 23:21:47 +0800
Message-Id: <20180624142743.998517903@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180624142743.613370789@linuxfoundation.org>
References: <20180624142743.613370789@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Davide Caratti <dcaratti@redhat.com>

[ Upstream commit 8d499533e0bc02d44283dbdab03142b599b8ba16 ]

use nla_strlcpy() to avoid copying data beyond the length of TCA_DEF_DATA
netlink attribute, in case it is less than SIMP_MAX_DATA and it does not
end with '\0' character.

v2: fix errors in the commit message, thanks Hangbin Liu

Fixes: fa1b1cff3d06 ("net_cls_act: Make act_simple use of netlink policy.")
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Reviewed-by: Simon Horman <simon.horman@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/act_simple.c |   15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

--- a/net/sched/act_simple.c
+++ b/net/sched/act_simple.c
@@ -53,22 +53,22 @@ static void tcf_simp_release(struct tc_a
 	kfree(d->tcfd_defdata);
 }
 
-static int alloc_defdata(struct tcf_defact *d, char *defdata)
+static int alloc_defdata(struct tcf_defact *d, const struct nlattr *defdata)
 {
 	d->tcfd_defdata = kzalloc(SIMP_MAX_DATA, GFP_KERNEL);
 	if (unlikely(!d->tcfd_defdata))
 		return -ENOMEM;
-	strlcpy(d->tcfd_defdata, defdata, SIMP_MAX_DATA);
+	nla_strlcpy(d->tcfd_defdata, defdata, SIMP_MAX_DATA);
 	return 0;
 }
 
-static void reset_policy(struct tcf_defact *d, char *defdata,
+static void reset_policy(struct tcf_defact *d, const struct nlattr *defdata,
 			 struct tc_defact *p)
 {
 	spin_lock_bh(&d->tcf_lock);
 	d->tcf_action = p->action;
 	memset(d->tcfd_defdata, 0, SIMP_MAX_DATA);
-	strlcpy(d->tcfd_defdata, defdata, SIMP_MAX_DATA);
+	nla_strlcpy(d->tcfd_defdata, defdata, SIMP_MAX_DATA);
 	spin_unlock_bh(&d->tcf_lock);
 }
 
@@ -87,7 +87,6 @@ static int tcf_simp_init(struct net *net
 	struct tcf_defact *d;
 	bool exists = false;
 	int ret = 0, err;
-	char *defdata;
 
 	if (nla == NULL)
 		return -EINVAL;
@@ -110,8 +109,6 @@ static int tcf_simp_init(struct net *net
 		return -EINVAL;
 	}
 
-	defdata = nla_data(tb[TCA_DEF_DATA]);
-
 	if (!exists) {
 		ret = tcf_idr_create(tn, parm->index, est, a,
 				     &act_simp_ops, bind, false);
@@ -119,7 +116,7 @@ static int tcf_simp_init(struct net *net
 			return ret;
 
 		d = to_defact(*a);
-		ret = alloc_defdata(d, defdata);
+		ret = alloc_defdata(d, tb[TCA_DEF_DATA]);
 		if (ret < 0) {
 			tcf_idr_release(*a, bind);
 			return ret;
@@ -133,7 +130,7 @@ static int tcf_simp_init(struct net *net
 		if (!ovr)
 			return -EEXIST;
 
-		reset_policy(d, defdata, parm);
+		reset_policy(d, tb[TCA_DEF_DATA], parm);
 	}
 
 	if (ret == ACT_P_CREATED)


