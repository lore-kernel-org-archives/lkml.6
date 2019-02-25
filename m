Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1338C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9015520C01
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129941;
	bh=+H1jnGRMYG1frzaeAq/Rkui3EJEKMbxn0L4eOvYyajY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yOh07Vla+XaklSjssvKJy5kkJDY+p/2aAeh9qNO1u8rZn1I/54wwlNAV1Nwv7toX0
	 uSydK0Dzt0RfQ5J4VWZZLQo3EqQR+/nN+9AluyWblSOFlX1A+K6I3Qx89ygjyht6nF
	 4c5NV/Ra0MiZfx0tPWnsQnsFu9KDv+NvM1zp7reQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbfBYVZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:25:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:60068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730852AbfBYVZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:25:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 902812084D;
        Mon, 25 Feb 2019 21:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129935;
        bh=+H1jnGRMYG1frzaeAq/Rkui3EJEKMbxn0L4eOvYyajY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jt2+zvHjFV7n8l3I5vkyE/zSeUUcxgto7ewxlCfwZVUg2nl6kmqEUzZTtjSJod/zA
         Du3J7MujP5FAzCG2cPpVNRg/e1E8mQ/1APTv/uV8CfGeIxtT/O5MeouzDVtSM0Prn0
         QkvxOUAY9uG4x68AxdhrlnkZyJ0XuNWpVISF5ufQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian <bugs@abtelecom.ro>,
        Ben Hutchings <ben@decadent.org.uk>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 115/152] net_sched: fix a race condition in tcindex_destroy()
Date:   Mon, 25 Feb 2019 22:11:47 +0100
Message-Id: <20190225195050.974492177@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
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

From: Cong Wang <xiyou.wangcong@gmail.com>

[ Upstream commit 8015d93ebd27484418d4952284fd02172fa4b0b2 ]

tcindex_destroy() invokes tcindex_destroy_element() via
a walker to delete each filter result in its perfect hash
table, and tcindex_destroy_element() calls tcindex_delete()
which schedules tcf RCU works to do the final deletion work.
Unfortunately this races with the RCU callback
__tcindex_destroy(), which could lead to use-after-free as
reported by Adrian.

Fix this by migrating this RCU callback to tcf RCU work too,
as that workqueue is ordered, we will not have use-after-free.

Note, we don't need to hold netns refcnt because we don't call
tcf_exts_destroy() here.

Fixes: 27ce4f05e2ab ("net_sched: use tcf_queue_work() in tcindex filter")
Reported-by: Adrian <bugs@abtelecom.ro>
Cc: Ben Hutchings <ben@decadent.org.uk>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jiri Pirko <jiri@resnulli.us>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/cls_tcindex.c |   18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

--- a/net/sched/cls_tcindex.c
+++ b/net/sched/cls_tcindex.c
@@ -48,7 +48,7 @@ struct tcindex_data {
 	u32 hash;		/* hash table size; 0 if undefined */
 	u32 alloc_hash;		/* allocated size */
 	u32 fall_through;	/* 0: only classify if explicit match */
-	struct rcu_head rcu;
+	struct rcu_work rwork;
 };
 
 static inline int tcindex_filter_is_set(struct tcindex_filter_result *r)
@@ -229,9 +229,11 @@ static int tcindex_destroy_element(struc
 	return tcindex_delete(tp, arg, &last, NULL);
 }
 
-static void __tcindex_destroy(struct rcu_head *head)
+static void tcindex_destroy_work(struct work_struct *work)
 {
-	struct tcindex_data *p = container_of(head, struct tcindex_data, rcu);
+	struct tcindex_data *p = container_of(to_rcu_work(work),
+					      struct tcindex_data,
+					      rwork);
 
 	kfree(p->perfect);
 	kfree(p->h);
@@ -258,9 +260,11 @@ static int tcindex_filter_result_init(st
 	return tcf_exts_init(&r->exts, TCA_TCINDEX_ACT, TCA_TCINDEX_POLICE);
 }
 
-static void __tcindex_partial_destroy(struct rcu_head *head)
+static void tcindex_partial_destroy_work(struct work_struct *work)
 {
-	struct tcindex_data *p = container_of(head, struct tcindex_data, rcu);
+	struct tcindex_data *p = container_of(to_rcu_work(work),
+					      struct tcindex_data,
+					      rwork);
 
 	kfree(p->perfect);
 	kfree(p);
@@ -478,7 +482,7 @@ tcindex_set_parms(struct net *net, struc
 	}
 
 	if (oldp)
-		call_rcu(&oldp->rcu, __tcindex_partial_destroy);
+		tcf_queue_work(&oldp->rwork, tcindex_partial_destroy_work);
 	return 0;
 
 errout_alloc:
@@ -570,7 +574,7 @@ static void tcindex_destroy(struct tcf_p
 	walker.fn = tcindex_destroy_element;
 	tcindex_walk(tp, &walker);
 
-	call_rcu(&p->rcu, __tcindex_destroy);
+	tcf_queue_work(&p->rwork, tcindex_destroy_work);
 }
 
 


