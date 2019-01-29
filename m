Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2F6C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F35420881
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548763441;
	bh=GHgedVjATHK59ZfXQYFiHgIKJZUDtR8L/SyJJoU7mvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rR/BBW1gwtR9AQ/8/ehiO05jWprBJBr01/aLMe1BOPU/Dc8ZzZf1KWxvTojknQ023
	 jrQ3sOsZ7T/BvYlHGaaoKh0I56Wd35ivLUHaM/YjuTcpVLk5+rnDVcaKVejV5hAuLL
	 x1MERFUaI2aJLf8Yrkf0SHg4P5h+IurySO5KO4K0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730303AbfA2LnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:43:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:33202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730286AbfA2LnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:43:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D740A20857;
        Tue, 29 Jan 2019 11:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762200;
        bh=GHgedVjATHK59ZfXQYFiHgIKJZUDtR8L/SyJJoU7mvg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YW+B5Hk2hxzAGDGYa75xI6f08fzT1hSM04Hd/1l+YJhE38/8T+/ZOmrgaQk/KeacD
         ikiSTeif16USn2fRk387uzlzrzVfuIUEBSfRKGxnZkFskDtgZvSqYYITV3sFgHcoIA
         8/leuMs8Z+D/8ahz9QvZy7qKN7fU+ZLMDpQA8xNE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Davide Caratti <dcaratti@redhat.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 007/103] net/sched: act_tunnel_key: fix memory leak in case of action replace
Date:   Tue, 29 Jan 2019 12:34:44 +0100
Message-Id: <20190129113159.964228453@linuxfoundation.org>
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

From: Davide Caratti <dcaratti@redhat.com>

[ Upstream commit 9174c3df1cd181c14913138d50ccbe539bb08335 ]

running the following TDC test cases:

 7afc - Replace tunnel_key set action with all parameters
 364d - Replace tunnel_key set action with all parameters and cookie

it's possible to trigger kmemleak warnings like:

  unreferenced object 0xffff94797127ab40 (size 192):
  comm "tc", pid 3248, jiffies 4300565293 (age 1006.862s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 c0 93 f9 8a ff ff ff ff  ................
    41 84 ee 89 ff ff ff ff 00 00 00 00 00 00 00 00  A...............
  backtrace:
    [<000000001e85b61c>] tunnel_key_init+0x31d/0x820 [act_tunnel_key]
    [<000000007f3f6ee7>] tcf_action_init_1+0x384/0x4c0
    [<00000000e89e3ded>] tcf_action_init+0x12b/0x1a0
    [<00000000c1c8c0f8>] tcf_action_add+0x73/0x170
    [<0000000095a9fc28>] tc_ctl_action+0x122/0x160
    [<000000004bebeac5>] rtnetlink_rcv_msg+0x263/0x2d0
    [<000000009fd862dd>] netlink_rcv_skb+0x4a/0x110
    [<00000000b55199e7>] netlink_unicast+0x1a0/0x250
    [<000000004996cd21>] netlink_sendmsg+0x2c1/0x3c0
    [<000000004d6a94b4>] sock_sendmsg+0x36/0x40
    [<000000005d9f0208>] ___sys_sendmsg+0x280/0x2f0
    [<00000000dec19023>] __sys_sendmsg+0x5e/0xa0
    [<000000004b82ac81>] do_syscall_64+0x5b/0x180
    [<00000000a0f1209a>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
    [<000000002926b2ab>] 0xffffffffffffffff

when the tunnel_key action is replaced, the kernel forgets to release the
dst metadata: ensure they are released by tunnel_key_init(), the same way
it's done in tunnel_key_release().

Fixes: d0f6dd8a914f4 ("net/sched: Introduce act_tunnel_key")
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Acked-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/act_tunnel_key.c |   19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

--- a/net/sched/act_tunnel_key.c
+++ b/net/sched/act_tunnel_key.c
@@ -197,6 +197,15 @@ static const struct nla_policy tunnel_ke
 	[TCA_TUNNEL_KEY_ENC_TTL]      = { .type = NLA_U8 },
 };
 
+static void tunnel_key_release_params(struct tcf_tunnel_key_params *p)
+{
+	if (!p)
+		return;
+	if (p->tcft_action == TCA_TUNNEL_KEY_ACT_SET)
+		dst_release(&p->tcft_enc_metadata->dst);
+	kfree_rcu(p, rcu);
+}
+
 static int tunnel_key_init(struct net *net, struct nlattr *nla,
 			   struct nlattr *est, struct tc_action **a,
 			   int ovr, int bind, bool rtnl_held,
@@ -360,8 +369,7 @@ static int tunnel_key_init(struct net *n
 	rcu_swap_protected(t->params, params_new,
 			   lockdep_is_held(&t->tcf_lock));
 	spin_unlock_bh(&t->tcf_lock);
-	if (params_new)
-		kfree_rcu(params_new, rcu);
+	tunnel_key_release_params(params_new);
 
 	if (ret == ACT_P_CREATED)
 		tcf_idr_insert(tn, *a);
@@ -385,12 +393,7 @@ static void tunnel_key_release(struct tc
 	struct tcf_tunnel_key_params *params;
 
 	params = rcu_dereference_protected(t->params, 1);
-	if (params) {
-		if (params->tcft_action == TCA_TUNNEL_KEY_ACT_SET)
-			dst_release(&params->tcft_enc_metadata->dst);
-
-		kfree_rcu(params, rcu);
-	}
+	tunnel_key_release_params(params);
 }
 
 static int tunnel_key_geneve_opts_dump(struct sk_buff *skb,


