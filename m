Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932630AbeENOaD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 10:30:03 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:35127 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753971AbeENO1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 10:27:41 -0400
From: Vlad Buslov <vladbu@mellanox.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
        jiri@resnulli.us, pablo@netfilter.org, kadlec@blackhole.kfki.hu,
        fw@strlen.de, ast@kernel.org, daniel@iogearbox.net,
        edumazet@google.com, vladbu@mellanox.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, kliteyn@mellanox.com
Subject: [PATCH 08/14] net: sched: account for temporary action reference
Date: Mon, 14 May 2018 17:27:09 +0300
Message-Id: <1526308035-12484-9-git-send-email-vladbu@mellanox.com>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1526308035-12484-1-git-send-email-vladbu@mellanox.com>
References: <1526308035-12484-1-git-send-email-vladbu@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tca_get_fill function has 'bind' and 'ref' arguments that get passed
down to action dump function. These arguments values are subtracted from
actual reference and bind counter values before writing them to skb.

In order to prevent concurrent action delete, RTM_GETACTION handler
acquires a reference to action before 'dumping' it and releases it
afterwards. This reference is temporal and should not be accounted by
userspace clients. (both logically and to preserver current API
behavior)

Use existing infrastructure of tca_get_fill arguments to subtract that
temporary reference and not expose it to userspace.

Signed-off-by: Vlad Buslov <vladbu@mellanox.com>
---
 net/sched/act_api.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 3f02cd1..2772276e 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -935,7 +935,7 @@ tcf_get_notify(struct net *net, u32 portid, struct nlmsghdr *n,
 	if (!skb)
 		return -ENOBUFS;
 	if (tca_get_fill(skb, actions, portid, n->nlmsg_seq, 0, event,
-			 0, 0) <= 0) {
+			 0, 1) <= 0) {
 		NL_SET_ERR_MSG(extack, "Failed to fill netlink attributes while adding TC action");
 		kfree_skb(skb);
 		return -EINVAL;
@@ -1125,7 +1125,7 @@ tcf_del_notify(struct net *net, struct nlmsghdr *n, struct list_head *actions,
 		return -ENOBUFS;
 
 	if (tca_get_fill(skb, actions, portid, n->nlmsg_seq, 0, RTM_DELACTION,
-			 0, 1) <= 0) {
+			 0, 2) <= 0) {
 		NL_SET_ERR_MSG(extack, "Failed to fill netlink TC action attributes");
 		kfree_skb(skb);
 		return -EINVAL;
-- 
2.7.5
