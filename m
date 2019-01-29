Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E0EC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 147E520882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762174;
	bh=oY5Rap6zRcEXMcY1pT14kBkDPaJlQNE/aXFV6hKgQkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RhaMz+480Wl2esC/9JaZNKP3vYQXU5AM98WzByg9l73w8NepLQgYXKLEgAGnc4VTJ
	 HJCBnQEpLQQlW4CC0MsKkbRLcDB8+F+sVygqv0t5qIFVrGClvsOtGT8T3ib1hMD1Ww
	 lOPVk5KLoaPC/7D7Pat9dam0c0kM1KTrT9+QYEkU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730162AbfA2Lmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:42:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:60742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729083AbfA2Lmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:42:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41C6F20882;
        Tue, 29 Jan 2019 11:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762169;
        bh=oY5Rap6zRcEXMcY1pT14kBkDPaJlQNE/aXFV6hKgQkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H30mmwqrwMRB+jpgnuQGPL9WwTQFw/ZhirlGhabe+waamh1yzLtrVnAvjH/RVkdRb
         iQsWXKincL9zVYg6J/HZObWb3w/G1FRi7eS949LXlSjuAaapAinDZV+obGX8RQsyzj
         OrrXetjCmjJUtVv8QPR2Sxj0BdqkVckpfWC9U87o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
        Paul Blakey <paulb@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Ivan Vecera <ivecera@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 015/103] net/sched: cls_flower: allocate mask dynamically in fl_change()
Date:   Tue, 29 Jan 2019 12:34:52 +0100
Message-Id: <20190129113200.444340274@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113159.567154026@linuxfoundation.org>
References: <20190129113159.567154026@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ivan Vecera <ivecera@redhat.com>

[ Upstream commit 2cddd20147826aef283115abb00012d4dafe3cdb ]

Recent changes (especially 05cd271fd61a ("cls_flower: Support multiple
masks per priority")) in the fl_flow_mask structure grow it and its
current size e.g. on x86_64 with defconfig is 760 bytes and more than
1024 bytes with some debug options enabled. Prior the mentioned commit
its size was 176 bytes (using defconfig on x86_64).
With regard to this fact it's reasonable to allocate this structure
dynamically in fl_change() to reduce its stack size.

v2:
- use kzalloc() instead of kcalloc()

Fixes: 05cd271fd61a ("cls_flower: Support multiple masks per priority")
Cc: Jiri Pirko <jiri@resnulli.us>
Cc: Paul Blakey <paulb@mellanox.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/cls_flower.c |   19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -1176,17 +1176,23 @@ static int fl_change(struct net *net, st
 	struct cls_fl_head *head = rtnl_dereference(tp->root);
 	struct cls_fl_filter *fold = *arg;
 	struct cls_fl_filter *fnew;
+	struct fl_flow_mask *mask;
 	struct nlattr **tb;
-	struct fl_flow_mask mask = {};
 	int err;
 
 	if (!tca[TCA_OPTIONS])
 		return -EINVAL;
 
-	tb = kcalloc(TCA_FLOWER_MAX + 1, sizeof(struct nlattr *), GFP_KERNEL);
-	if (!tb)
+	mask = kzalloc(sizeof(struct fl_flow_mask), GFP_KERNEL);
+	if (!mask)
 		return -ENOBUFS;
 
+	tb = kcalloc(TCA_FLOWER_MAX + 1, sizeof(struct nlattr *), GFP_KERNEL);
+	if (!tb) {
+		err = -ENOBUFS;
+		goto errout_mask_alloc;
+	}
+
 	err = nla_parse_nested(tb, TCA_FLOWER_MAX, tca[TCA_OPTIONS],
 			       fl_policy, NULL);
 	if (err < 0)
@@ -1229,12 +1235,12 @@ static int fl_change(struct net *net, st
 		}
 	}
 
-	err = fl_set_parms(net, tp, fnew, &mask, base, tb, tca[TCA_RATE], ovr,
+	err = fl_set_parms(net, tp, fnew, mask, base, tb, tca[TCA_RATE], ovr,
 			   tp->chain->tmplt_priv, extack);
 	if (err)
 		goto errout_idr;
 
-	err = fl_check_assign_mask(head, fnew, fold, &mask);
+	err = fl_check_assign_mask(head, fnew, fold, mask);
 	if (err)
 		goto errout_idr;
 
@@ -1281,6 +1287,7 @@ static int fl_change(struct net *net, st
 	}
 
 	kfree(tb);
+	kfree(mask);
 	return 0;
 
 errout_mask:
@@ -1294,6 +1301,8 @@ errout:
 	kfree(fnew);
 errout_tb:
 	kfree(tb);
+errout_mask_alloc:
+	kfree(mask);
 	return err;
 }
 


