Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753099AbeEPJtM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 05:49:12 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:43400 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752514AbeEPJs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 05:48:57 -0400
X-Google-Smtp-Source: AB8JxZq7u8+l9OO3taCX1McC869fZ1G6NRP6IERRW6Q1l5G8/s9mljKkjgY9v1CuDf5X4RCukANS+A==
Date: Wed, 16 May 2018 11:48:50 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Vlad Buslov <vladbu@mellanox.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, pablo@netfilter.org,
        kadlec@blackhole.kfki.hu, fw@strlen.de, ast@kernel.org,
        daniel@iogearbox.net, edumazet@google.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, kliteyn@mellanox.com
Subject: Re: [PATCH 14/14] net: sched: implement delete for all actions
Message-ID: <20180516094850.GF1972@nanopsycho>
References: <1526308035-12484-1-git-send-email-vladbu@mellanox.com>
 <1526308035-12484-15-git-send-email-vladbu@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526308035-12484-15-git-send-email-vladbu@mellanox.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, May 14, 2018 at 04:27:15PM CEST, vladbu@mellanox.com wrote:
>Implement delete function that is required to delete actions without
>holding rtnl lock. Use action API function that atomically deletes action
>only if it is still in action idr. This implementation prevents concurrent
>threads from deleting same action twice.
>
>Signed-off-by: Vlad Buslov <vladbu@mellanox.com>
>---
> net/sched/act_bpf.c        |  8 ++++++++
> net/sched/act_connmark.c   |  8 ++++++++
> net/sched/act_csum.c       |  8 ++++++++
> net/sched/act_gact.c       |  8 ++++++++
> net/sched/act_ife.c        |  8 ++++++++
> net/sched/act_ipt.c        | 16 ++++++++++++++++
> net/sched/act_mirred.c     |  8 ++++++++
> net/sched/act_nat.c        |  8 ++++++++
> net/sched/act_pedit.c      |  8 ++++++++
> net/sched/act_police.c     |  8 ++++++++
> net/sched/act_sample.c     |  8 ++++++++
> net/sched/act_simple.c     |  8 ++++++++
> net/sched/act_skbedit.c    |  8 ++++++++
> net/sched/act_skbmod.c     |  8 ++++++++
> net/sched/act_tunnel_key.c |  8 ++++++++
> net/sched/act_vlan.c       |  8 ++++++++
> 16 files changed, 136 insertions(+)
>
>diff --git a/net/sched/act_bpf.c b/net/sched/act_bpf.c
>index 0bf4ecf..36f7f66 100644
>--- a/net/sched/act_bpf.c
>+++ b/net/sched/act_bpf.c
>@@ -394,6 +394,13 @@ static int tcf_bpf_search(struct net *net, struct tc_action **a, u32 index,
> 	return tcf_idr_search(tn, a, index);
> }
> 
>+static int tcf_bpf_delete(struct net *net, u32 index)
>+{
>+	struct tc_action_net *tn = net_generic(net, bpf_net_id);
>+
>+	return tcf_idr_find_delete(tn, index);
>+}
>+
> static struct tc_action_ops act_bpf_ops __read_mostly = {
> 	.kind		=	"bpf",
> 	.type		=	TCA_ACT_BPF,
>@@ -404,6 +411,7 @@ static struct tc_action_ops act_bpf_ops __read_mostly = {
> 	.init		=	tcf_bpf_init,
> 	.walk		=	tcf_bpf_walker,
> 	.lookup		=	tcf_bpf_search,
>+	.delete		=	tcf_bpf_delete,

I wonder, right before this patch, how the idr index got removed?
delete op is NULL and I didn't find anyone else to do it.

Also, after this patch, does it make sense to have following check in
tcf_action_del_1()?

       if (ops->delete)
	       err = ops->delete(net, index);

Looks like ops->delete is non-null for all.

Seems to me that you need to introduce this patch filling up the delete
op in all acts and only after that introduce a code that actually calls
it.

[...]
