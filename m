Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E155C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D1532147A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548763846;
	bh=vc15gTcsQuWlKw4jadbfQyj8MHTSztgKhvrk4Jjx//Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UFaaQiQf3zwtHVzfiJ3kW8TFIo7zWFzjMm7KMsSvl/Nr3oX2hNMxhrAGZLIzaHfUv
	 CexIVlioOd4/lKBFD6ZSY1d9zyFIJl09OlYnxEsalIFMmLlQhzYXQTRoXREcr8riUb
	 eOrVG3wZhNF4CMbXsFTn4JLIuMUx0EJlNEpRhC0I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbfA2LhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:37:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:53778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728734AbfA2LhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:37:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45C5120844;
        Tue, 29 Jan 2019 11:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548761827;
        bh=vc15gTcsQuWlKw4jadbfQyj8MHTSztgKhvrk4Jjx//Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uzrf+cjiDIGlevMV4eUuYHFs2uxqeOVEvM8ZGbsw7HrQ4eJqNoGYAX+NkbTZdeWsZ
         pfV6E6j6bmQ02CW2ZUjGJNH/aEmnUl48cnNM0js1mKFRSfnoC55ZIQfaZgFnFE+SmD
         wHnWDeYjlOl59NhrC05Vb14G5orOAxOjLQyThXHA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
        Paul Blakey <paulb@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Ivan Vecera <ivecera@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 015/117] net/sched: cls_flower: allocate mask dynamically in fl_change()
Date:   Tue, 29 Jan 2019 12:34:26 +0100
Message-Id: <20190129113208.380083549@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113207.477505932@linuxfoundation.org>
References: <20190129113207.477505932@linuxfoundation.org>
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
 
@@ -1278,6 +1284,7 @@ static int fl_change(struct net *net, st
 	}
 
 	kfree(tb);
+	kfree(mask);
 	return 0;
 
 errout_mask:
@@ -1291,6 +1298,8 @@ errout:
 	kfree(fnew);
 errout_tb:
 	kfree(tb);
+errout_mask_alloc:
+	kfree(mask);
 	return err;
 }
 


