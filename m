Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A6BECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D516F214C1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:12:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D516F214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731470AbeIXSOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:14:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55064 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbeIXSOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:14:33 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 07933107D;
        Mon, 24 Sep 2018 12:12:43 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+93a5839deb355537440f@syzkaller.appspotmail.com,
        Sowmini Varadhan <sowmini.varadhan@oracle.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        rds-devel@oss.oracle.com, Cong Wang <xiyou.wangcong@gmail.com>,
        Santosh Shilimkar <santosh.shilimkar@oarcle.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 004/173] rds: fix two RCU related problems
Date:   Mon, 24 Sep 2018 13:50:38 +0200
Message-Id: <20180924113114.845407997@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113114.334025954@linuxfoundation.org>
References: <20180924113114.334025954@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cong Wang <xiyou.wangcong@gmail.com>

[ Upstream commit cc4dfb7f70a344f24c1c71e298deea0771dadcb2 ]

When a rds sock is bound, it is inserted into the bind_hash_table
which is protected by RCU. But when releasing rds sock, after it
is removed from this hash table, it is freed immediately without
respecting RCU grace period. This could cause some use-after-free
as reported by syzbot.

Mark the rds sock with SOCK_RCU_FREE before inserting it into the
bind_hash_table, so that it would be always freed after a RCU grace
period.

The other problem is in rds_find_bound(), the rds sock could be
freed in between rhashtable_lookup_fast() and rds_sock_addref(),
so we need to extend RCU read lock protection in rds_find_bound()
to close this race condition.

Reported-and-tested-by: syzbot+8967084bcac563795dc6@syzkaller.appspotmail.com
Reported-by: syzbot+93a5839deb355537440f@syzkaller.appspotmail.com
Cc: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Cc: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Cc: rds-devel@oss.oracle.com
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@oarcle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/rds/bind.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/net/rds/bind.c
+++ b/net/rds/bind.c
@@ -60,11 +60,13 @@ struct rds_sock *rds_find_bound(__be32 a
 	u64 key = ((u64)addr << 32) | port;
 	struct rds_sock *rs;
 
-	rs = rhashtable_lookup_fast(&bind_hash_table, &key, ht_parms);
+	rcu_read_lock();
+	rs = rhashtable_lookup(&bind_hash_table, &key, ht_parms);
 	if (rs && !sock_flag(rds_rs_to_sk(rs), SOCK_DEAD))
 		rds_sock_addref(rs);
 	else
 		rs = NULL;
+	rcu_read_unlock();
 
 	rdsdebug("returning rs %p for %pI4:%u\n", rs, &addr,
 		ntohs(port));
@@ -157,6 +159,7 @@ int rds_bind(struct socket *sock, struct
 		goto out;
 	}
 
+	sock_set_flag(sk, SOCK_RCU_FREE);
 	ret = rds_add_bound(rs, sin->sin_addr.s_addr, &sin->sin_port);
 	if (ret)
 		goto out;


