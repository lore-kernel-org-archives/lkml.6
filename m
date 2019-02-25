Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A766C10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3687B20652
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130740;
	bh=Yp0FrF9rK5FmNN7DM7gKSGvh4qp5FAJSe0plQMWOdMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZgnlXSNKjBAng44L5+oI8O7I7/HjiR0Jj+8vRBWGwDqoKWZmxnERFbSPSjo94ARY7
	 fp/gnSHlRNxdLlalQjXAQPOIXMT1XxrJfUX75CSy51fwbvrS9T2jOJ0QvAbrVVTNRG
	 TwKNTwCDb5r+IbhlrbX1WiJ3VXyeE6AZ/dkJ8/GY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733187AbfBYVgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:36:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:43490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727745AbfBYVgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:36:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE4B921841;
        Mon, 25 Feb 2019 21:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130590;
        bh=Yp0FrF9rK5FmNN7DM7gKSGvh4qp5FAJSe0plQMWOdMo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FUBhAAB/cShN4CLjrSjQfx5phhtuNCJASwhIdKkezXoTf+D9mHhW0EPCnuBeGfh3L
         DukfnaUXtAMVSSxMWeM6+Vl8MjNeFoxu+gR/MOstt0hTZHkqxW3GKqDBjhZe78U/Sr
         /PZgZgGefJzqYtrz698q5xmfresRrpYC91ag23fE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 142/183] net_sched: fix two more memory leaks in cls_tcindex
Date:   Mon, 25 Feb 2019 22:11:55 +0100
Message-Id: <20190225195118.818453238@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cong Wang <xiyou.wangcong@gmail.com>

[ Upstream commit 1db817e75f5b9387b8db11e37d5f0624eb9223e0 ]

struct tcindex_filter_result contains two parts:
struct tcf_exts and struct tcf_result.

For the local variable 'cr', its exts part is never used but
initialized without being released properly on success path. So
just completely remove the exts part to fix this leak.

For the local variable 'new_filter_result', it is never properly
released if not used by 'r' on success path.

Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jiri Pirko <jiri@resnulli.us>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/cls_tcindex.c |   16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

--- a/net/sched/cls_tcindex.c
+++ b/net/sched/cls_tcindex.c
@@ -304,9 +304,9 @@ tcindex_set_parms(struct net *net, struc
 		  struct nlattr *est, bool ovr, struct netlink_ext_ack *extack)
 {
 	struct tcindex_filter_result new_filter_result, *old_r = r;
-	struct tcindex_filter_result cr;
 	struct tcindex_data *cp = NULL, *oldp;
 	struct tcindex_filter *f = NULL; /* make gcc behave */
+	struct tcf_result cr = {};
 	int err, balloc = 0;
 	struct tcf_exts e;
 
@@ -347,11 +347,8 @@ tcindex_set_parms(struct net *net, struc
 	err = tcindex_filter_result_init(&new_filter_result);
 	if (err < 0)
 		goto errout1;
-	err = tcindex_filter_result_init(&cr);
-	if (err < 0)
-		goto errout1;
 	if (old_r)
-		cr.res = r->res;
+		cr = r->res;
 
 	if (tb[TCA_TCINDEX_HASH])
 		cp->hash = nla_get_u32(tb[TCA_TCINDEX_HASH]);
@@ -442,8 +439,8 @@ tcindex_set_parms(struct net *net, struc
 	}
 
 	if (tb[TCA_TCINDEX_CLASSID]) {
-		cr.res.classid = nla_get_u32(tb[TCA_TCINDEX_CLASSID]);
-		tcf_bind_filter(tp, &cr.res, base);
+		cr.classid = nla_get_u32(tb[TCA_TCINDEX_CLASSID]);
+		tcf_bind_filter(tp, &cr, base);
 	}
 
 	if (old_r && old_r != r) {
@@ -455,7 +452,7 @@ tcindex_set_parms(struct net *net, struc
 	}
 
 	oldp = p;
-	r->res = cr.res;
+	r->res = cr;
 	tcf_exts_change(&r->exts, &e);
 
 	rcu_assign_pointer(tp->root, cp);
@@ -474,6 +471,8 @@ tcindex_set_parms(struct net *net, struc
 				; /* nothing */
 
 		rcu_assign_pointer(*fp, f);
+	} else {
+		tcf_exts_destroy(&new_filter_result.exts);
 	}
 
 	if (oldp)
@@ -486,7 +485,6 @@ errout_alloc:
 	else if (balloc == 2)
 		kfree(cp->h);
 errout1:
-	tcf_exts_destroy(&cr.exts);
 	tcf_exts_destroy(&new_filter_result.exts);
 errout:
 	kfree(cp);


