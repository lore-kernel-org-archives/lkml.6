Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BC7C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 22:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3320921746
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 22:57:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3320921746
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbeH0Clv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 22:41:51 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:40382 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbeH0Clv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 22:41:51 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fu3yf-0006Kb-E4; Sun, 26 Aug 2018 22:57:49 +0000
Date:   Sun, 26 Aug 2018 23:57:49 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>
Subject: Re: [PATCH] net: sched: Fix memory exposure from short TCA_U32_SEL
Message-ID: <20180826225749.GY6515@ZenIV.linux.org.uk>
References: <20180826055801.GA42063@beast>
 <20180826061534.GT6515@ZenIV.linux.org.uk>
 <CAGXu5jK7VzayzZTcxgZBf-+YHWO+Hv7s8utj2rzTc3gFtA8pFQ@mail.gmail.com>
 <20180826173236.GU6515@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180826173236.GU6515@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 26, 2018 at 06:32:37PM +0100, Al Viro wrote:

> As far as I can tell, the solution is
[snip long and painful reasoning]
> pointers, and not in provably opaque fashion.  Theoretically, the three tcf_...
> inlines above need another look; fortunately, they don't use ->next at all, not to
> mention not being used anywhere outside of net/sched/*.c
> 
> 	The 80 lines above prove that we only need to grep net/sched/*.c for
> tcf_proto_ops method calls.  And only because we don't have (thank $DEITY)
> anything that could deconstruct types - as soon as some bastard grows means
> to say "type of the second argument of the function pointed to by p", this
> kind of analysis, painful as it is, goes out of window.  Even as it is,
> do you really like the idea of newbies trying to get through the exercises
> like the one above?

BTW, would there be any problem if we took the definitions of tcf_proto and
tcf_proto_ops to e.g. net/sched/tcf_proto.h (along with the three inlines in
in pkt_cls.h), left forwards in sch_generic.h and added includes of "tcf_proto.h"
where needed in net/sched/*.c?

That would make tcf_proto/tcf_proto_ops opaque outside of net/sched, reducing
the exposure of internals.  Something like a diff below (against net/master,
builds clean, ought to result in identical binary):

diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
index ef727f71336e..35f8eec3f7c0 100644
--- a/include/net/pkt_cls.h
+++ b/include/net/pkt_cls.h
@@ -217,35 +217,6 @@ cls_set_class(struct Qdisc *q, unsigned long *clp, unsigned long cl)
 	return old_cl;
 }
 
-static inline void
-tcf_bind_filter(struct tcf_proto *tp, struct tcf_result *r, unsigned long base)
-{
-	struct Qdisc *q = tp->chain->block->q;
-	unsigned long cl;
-
-	/* Check q as it is not set for shared blocks. In that case,
-	 * setting class is not supported.
-	 */
-	if (!q)
-		return;
-	cl = q->ops->cl_ops->bind_tcf(q, base, r->classid);
-	cl = cls_set_class(q, &r->class, cl);
-	if (cl)
-		q->ops->cl_ops->unbind_tcf(q, cl);
-}
-
-static inline void
-tcf_unbind_filter(struct tcf_proto *tp, struct tcf_result *r)
-{
-	struct Qdisc *q = tp->chain->block->q;
-	unsigned long cl;
-
-	if (!q)
-		return;
-	if ((cl = __cls_set_class(&r->class, 0)) != 0)
-		q->ops->cl_ops->unbind_tcf(q, cl);
-}
-
 struct tcf_exts {
 #ifdef CONFIG_NET_CLS_ACT
 	__u32	type; /* for backward compat(TCA_OLD_COMPAT) */
@@ -708,18 +679,6 @@ static inline bool tc_in_hw(u32 flags)
 	return (flags & TCA_CLS_FLAGS_IN_HW) ? true : false;
 }
 
-static inline void
-tc_cls_common_offload_init(struct tc_cls_common_offload *cls_common,
-			   const struct tcf_proto *tp, u32 flags,
-			   struct netlink_ext_ack *extack)
-{
-	cls_common->chain_index = tp->chain->index;
-	cls_common->protocol = tp->protocol;
-	cls_common->prio = tp->prio;
-	if (tc_skip_sw(flags) || flags & TCA_CLS_FLAGS_VERBOSE)
-		cls_common->extack = extack;
-}
-
 enum tc_fl_command {
 	TC_CLSFLOWER_REPLACE,
 	TC_CLSFLOWER_DESTROY,
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index a6d00093f35e..72dbb96fc549 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -246,65 +246,7 @@ struct tcf_result {
 
 struct tcf_chain;
 
-struct tcf_proto_ops {
-	struct list_head	head;
-	char			kind[IFNAMSIZ];
-
-	int			(*classify)(struct sk_buff *,
-					    const struct tcf_proto *,
-					    struct tcf_result *);
-	int			(*init)(struct tcf_proto*);
-	void			(*destroy)(struct tcf_proto *tp,
-					   struct netlink_ext_ack *extack);
-
-	void*			(*get)(struct tcf_proto*, u32 handle);
-	int			(*change)(struct net *net, struct sk_buff *,
-					struct tcf_proto*, unsigned long,
-					u32 handle, struct nlattr **,
-					void **, bool,
-					struct netlink_ext_ack *);
-	int			(*delete)(struct tcf_proto *tp, void *arg,
-					  bool *last,
-					  struct netlink_ext_ack *);
-	void			(*walk)(struct tcf_proto*, struct tcf_walker *arg);
-	int			(*reoffload)(struct tcf_proto *tp, bool add,
-					     tc_setup_cb_t *cb, void *cb_priv,
-					     struct netlink_ext_ack *extack);
-	void			(*bind_class)(void *, u32, unsigned long);
-	void *			(*tmplt_create)(struct net *net,
-						struct tcf_chain *chain,
-						struct nlattr **tca,
-						struct netlink_ext_ack *extack);
-	void			(*tmplt_destroy)(void *tmplt_priv);
-
-	/* rtnetlink specific */
-	int			(*dump)(struct net*, struct tcf_proto*, void *,
-					struct sk_buff *skb, struct tcmsg*);
-	int			(*tmplt_dump)(struct sk_buff *skb,
-					      struct net *net,
-					      void *tmplt_priv);
-
-	struct module		*owner;
-};
-
-struct tcf_proto {
-	/* Fast access part */
-	struct tcf_proto __rcu	*next;
-	void __rcu		*root;
-
-	/* called under RCU BH lock*/
-	int			(*classify)(struct sk_buff *,
-					    const struct tcf_proto *,
-					    struct tcf_result *);
-	__be16			protocol;
-
-	/* All the rest */
-	u32			prio;
-	void			*data;
-	const struct tcf_proto_ops	*ops;
-	struct tcf_chain	*chain;
-	struct rcu_head		rcu;
-};
+struct tcf_proto_ops;
 
 struct qdisc_skb_cb {
 	unsigned int		pkt_len;
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 229d63c99be2..e946ada18299 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -25,11 +25,12 @@
 #include <linux/list.h>
 #include <net/net_namespace.h>
 #include <net/sock.h>
-#include <net/sch_generic.h>
 #include <net/pkt_cls.h>
 #include <net/act_api.h>
 #include <net/netlink.h>
 
+#include "tcf_proto.h"
+
 static int tcf_action_goto_chain_init(struct tc_action *a, struct tcf_proto *tp)
 {
 	u32 chain_index = a->tcfa_action & TC_ACT_EXT_VAL_MASK;
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 31bd1439cf60..be5fba6355c5 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -31,6 +31,8 @@
 #include <net/pkt_sched.h>
 #include <net/pkt_cls.h>
 
+#include "tcf_proto.h"
+
 /* The list of all installed classifier types */
 static LIST_HEAD(tcf_proto_base);
 
diff --git a/net/sched/cls_basic.c b/net/sched/cls_basic.c
index 6a5dce8baf19..3772432889f2 100644
--- a/net/sched/cls_basic.c
+++ b/net/sched/cls_basic.c
@@ -22,6 +22,8 @@
 #include <net/act_api.h>
 #include <net/pkt_cls.h>
 
+#include "tcf_proto.h"
+
 struct basic_head {
 	struct list_head	flist;
 	struct idr		handle_idr;
diff --git a/net/sched/cls_bpf.c b/net/sched/cls_bpf.c
index fa6fe2fe0f32..fb2478e357cd 100644
--- a/net/sched/cls_bpf.c
+++ b/net/sched/cls_bpf.c
@@ -23,6 +23,8 @@
 #include <net/pkt_cls.h>
 #include <net/sock.h>
 
+#include "tcf_proto.h"
+
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Daniel Borkmann <dborkman@redhat.com>");
 MODULE_DESCRIPTION("TC BPF based classifier");
diff --git a/net/sched/cls_cgroup.c b/net/sched/cls_cgroup.c
index 3bc01bdde165..5638c711e53c 100644
--- a/net/sched/cls_cgroup.c
+++ b/net/sched/cls_cgroup.c
@@ -18,6 +18,8 @@
 #include <net/sock.h>
 #include <net/cls_cgroup.h>
 
+#include "tcf_proto.h"
+
 struct cls_cgroup_head {
 	u32			handle;
 	struct tcf_exts		exts;
diff --git a/net/sched/cls_flow.c b/net/sched/cls_flow.c
index 2bb043cd436b..7e60e432e3a8 100644
--- a/net/sched/cls_flow.c
+++ b/net/sched/cls_flow.c
@@ -33,6 +33,8 @@
 #include <net/netfilter/nf_conntrack.h>
 #endif
 
+#include "tcf_proto.h"
+
 struct flow_head {
 	struct list_head	filters;
 	struct rcu_head		rcu;
diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index 6fd9bdd93796..b36c61f7ee44 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -20,7 +20,6 @@
 #include <linux/ip.h>
 #include <linux/mpls.h>
 
-#include <net/sch_generic.h>
 #include <net/pkt_cls.h>
 #include <net/ip.h>
 #include <net/flow_dissector.h>
@@ -29,6 +28,8 @@
 #include <net/dst.h>
 #include <net/dst_metadata.h>
 
+#include "tcf_proto.h"
+
 struct fl_flow_key {
 	int	indev_ifindex;
 	struct flow_dissector_key_control control;
diff --git a/net/sched/cls_fw.c b/net/sched/cls_fw.c
index 29eeeaf3ea44..be872b1653f5 100644
--- a/net/sched/cls_fw.c
+++ b/net/sched/cls_fw.c
@@ -28,7 +28,8 @@
 #include <net/netlink.h>
 #include <net/act_api.h>
 #include <net/pkt_cls.h>
-#include <net/sch_generic.h>
+
+#include "tcf_proto.h"
 
 #define HTSIZE 256
 
diff --git a/net/sched/cls_matchall.c b/net/sched/cls_matchall.c
index 856fa79d4ffd..708faf62ecab 100644
--- a/net/sched/cls_matchall.c
+++ b/net/sched/cls_matchall.c
@@ -13,9 +13,10 @@
 #include <linux/init.h>
 #include <linux/module.h>
 
-#include <net/sch_generic.h>
 #include <net/pkt_cls.h>
 
+#include "tcf_proto.h"
+
 struct cls_mall_head {
 	struct tcf_exts exts;
 	struct tcf_result res;
diff --git a/net/sched/cls_route.c b/net/sched/cls_route.c
index 0404aa5fa7cb..d40ae6d14b2d 100644
--- a/net/sched/cls_route.c
+++ b/net/sched/cls_route.c
@@ -22,6 +22,8 @@
 #include <net/act_api.h>
 #include <net/pkt_cls.h>
 
+#include "tcf_proto.h"
+
 /*
  * 1. For now we assume that route tags < 256.
  *    It allows to use direct table lookups, instead of hash tables.
diff --git a/net/sched/cls_rsvp.c b/net/sched/cls_rsvp.c
index cbb5e0d600f3..131a81aeaa4e 100644
--- a/net/sched/cls_rsvp.c
+++ b/net/sched/cls_rsvp.c
@@ -20,6 +20,8 @@
 #include <net/act_api.h>
 #include <net/pkt_cls.h>
 
+#include "tcf_proto.h"
+
 #define RSVP_DST_LEN	1
 #define RSVP_ID		"rsvp"
 #define RSVP_OPS	cls_rsvp_ops
diff --git a/net/sched/cls_rsvp6.c b/net/sched/cls_rsvp6.c
index dd08aea2aee5..159dc01cf251 100644
--- a/net/sched/cls_rsvp6.c
+++ b/net/sched/cls_rsvp6.c
@@ -20,6 +20,8 @@
 #include <net/pkt_cls.h>
 #include <net/netlink.h>
 
+#include "tcf_proto.h"
+
 #define RSVP_DST_LEN	4
 #define RSVP_ID		"rsvp6"
 #define RSVP_OPS	cls_rsvp6_ops
diff --git a/net/sched/cls_tcindex.c b/net/sched/cls_tcindex.c
index 9ccc93f257db..e7d06c3d40a3 100644
--- a/net/sched/cls_tcindex.c
+++ b/net/sched/cls_tcindex.c
@@ -13,7 +13,8 @@
 #include <net/act_api.h>
 #include <net/netlink.h>
 #include <net/pkt_cls.h>
-#include <net/sch_generic.h>
+
+#include "tcf_proto.h"
 
 /*
  * Passing parameters to the root seems to be done more awkwardly than really
diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index d5d2a6dc3921..7b3bdfd80001 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -47,6 +47,8 @@
 #include <net/pkt_cls.h>
 #include <linux/idr.h>
 
+#include "tcf_proto.h"
+
 struct tc_u_knode {
 	struct tc_u_knode __rcu	*next;
 	u32			handle;
diff --git a/net/sched/ematch.c b/net/sched/ematch.c
index 1331a4c2d8ff..b123880fbe07 100644
--- a/net/sched/ematch.c
+++ b/net/sched/ematch.c
@@ -90,6 +90,8 @@
 #include <linux/skbuff.h>
 #include <net/pkt_cls.h>
 
+#include "tcf_proto.h"
+
 static LIST_HEAD(ematch_ops);
 static DEFINE_RWLOCK(ematch_mod_lock);
 
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 98541c6399db..d6ac218811d0 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -37,6 +37,8 @@
 #include <net/pkt_sched.h>
 #include <net/pkt_cls.h>
 
+#include "tcf_proto.h"
+
 /*
 
    Short review.
diff --git a/net/sched/sch_atm.c b/net/sched/sch_atm.c
index cd49afca9617..6bf259e55319 100644
--- a/net/sched/sch_atm.c
+++ b/net/sched/sch_atm.c
@@ -17,6 +17,8 @@
 #include <net/pkt_sched.h>
 #include <net/pkt_cls.h>
 
+#include "tcf_proto.h"
+
 /*
  * The ATM queuing discipline provides a framework for invoking classifiers
  * (aka "filters"), which in turn select classes of this queuing discipline.
diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 35fc7252187c..fcfd5f321447 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -75,6 +75,8 @@
 #include <net/netfilter/nf_conntrack_core.h>
 #endif
 
+#include "tcf_proto.h"
+
 #define CAKE_SET_WAYS (8)
 #define CAKE_MAX_TINS (8)
 #define CAKE_QUEUES (1024)
diff --git a/net/sched/sch_cbq.c b/net/sched/sch_cbq.c
index f42025d53cfe..8021ba377dfd 100644
--- a/net/sched/sch_cbq.c
+++ b/net/sched/sch_cbq.c
@@ -21,6 +21,8 @@
 #include <net/pkt_sched.h>
 #include <net/pkt_cls.h>
 
+#include "tcf_proto.h"
+
 
 /*	Class-Based Queueing (CBQ) algorithm.
 	=======================================
diff --git a/net/sched/sch_drr.c b/net/sched/sch_drr.c
index e0b0cf8a9939..19a48fa95b9b 100644
--- a/net/sched/sch_drr.c
+++ b/net/sched/sch_drr.c
@@ -18,6 +18,8 @@
 #include <net/pkt_sched.h>
 #include <net/pkt_cls.h>
 
+#include "tcf_proto.h"
+
 struct drr_class {
 	struct Qdisc_class_common	common;
 	unsigned int			filter_cnt;
diff --git a/net/sched/sch_dsmark.c b/net/sched/sch_dsmark.c
index 049714c57075..b3a4537afbcb 100644
--- a/net/sched/sch_dsmark.c
+++ b/net/sched/sch_dsmark.c
@@ -18,6 +18,8 @@
 #include <net/inet_ecn.h>
 #include <asm/byteorder.h>
 
+#include "tcf_proto.h"
+
 /*
  * classid	class		marking
  * -------	-----		-------
diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
index 6c0a9d5dbf94..8868a8e1a81f 100644
--- a/net/sched/sch_fq_codel.c
+++ b/net/sched/sch_fq_codel.c
@@ -28,6 +28,8 @@
 #include <net/codel_impl.h>
 #include <net/codel_qdisc.h>
 
+#include "tcf_proto.h"
+
 /*	Fair Queue CoDel.
  *
  * Principles :
diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index 3278a76f6861..9c75b77da56e 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -68,6 +68,8 @@
 #include <net/pkt_cls.h>
 #include <asm/div64.h>
 
+#include "tcf_proto.h"
+
 /*
  * kernel internal service curve representation:
  *   coordinates are given by 64 bit unsigned integers.
diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
index 43c4bfe625a9..c206b3cfdfb2 100644
--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -38,10 +38,10 @@
 #include <linux/workqueue.h>
 #include <linux/slab.h>
 #include <net/netlink.h>
-#include <net/sch_generic.h>
 #include <net/pkt_sched.h>
 #include <net/pkt_cls.h>
 
+#include "tcf_proto.h"
 /* HTB algorithm.
     Author: devik@cdi.cz
     ========================================================================
diff --git a/net/sched/sch_multiq.c b/net/sched/sch_multiq.c
index 1da7ea8de0ad..107563c14e24 100644
--- a/net/sched/sch_multiq.c
+++ b/net/sched/sch_multiq.c
@@ -27,6 +27,8 @@
 #include <net/pkt_sched.h>
 #include <net/pkt_cls.h>
 
+#include "tcf_proto.h"
+
 struct multiq_sched_data {
 	u16 bands;
 	u16 max_bands;
diff --git a/net/sched/sch_prio.c b/net/sched/sch_prio.c
index 222e53d3d27a..4fed3fd38dd3 100644
--- a/net/sched/sch_prio.c
+++ b/net/sched/sch_prio.c
@@ -22,6 +22,8 @@
 #include <net/pkt_sched.h>
 #include <net/pkt_cls.h>
 
+#include "tcf_proto.h"
+
 struct prio_sched_data {
 	int bands;
 	struct tcf_proto __rcu *filter_list;
diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index bb1a9c11fc54..32f68e639037 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -19,6 +19,8 @@
 #include <net/pkt_sched.h>
 #include <net/pkt_cls.h>
 
+#include "tcf_proto.h"
+
 
 /*  Quick Fair Queueing Plus
     ========================
diff --git a/net/sched/sch_sfb.c b/net/sched/sch_sfb.c
index 7cbdad8419b7..5465249c600f 100644
--- a/net/sched/sch_sfb.c
+++ b/net/sched/sch_sfb.c
@@ -28,6 +28,8 @@
 #include <net/pkt_cls.h>
 #include <net/inet_ecn.h>
 
+#include "tcf_proto.h"
+
 /*
  * SFB uses two B[l][n] : L x N arrays of bins (L levels, N bins per level)
  * This implementation uses L = 8 and N = 16
diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index 2f2678197760..abc1598e87e7 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -26,6 +26,8 @@
 #include <net/pkt_cls.h>
 #include <net/red.h>
 
+#include "tcf_proto.h"
+
 
 /*	Stochastic Fairness Queuing algorithm.
 	=======================================
diff --git a/net/sched/tcf_proto.h b/net/sched/tcf_proto.h
new file mode 100644
index 000000000000..b8d0e15e7f26
--- /dev/null
+++ b/net/sched/tcf_proto.h
@@ -0,0 +1,104 @@
+/* struct tcf_proto internal details - outside of net/sched it's opaque */
+
+#include <net/sch_generic.h>
+
+struct tcf_proto {
+	/* Fast access part */
+	struct tcf_proto __rcu	*next;
+	void __rcu		*root;
+
+	/* called under RCU BH lock*/
+	int			(*classify)(struct sk_buff *,
+					    const struct tcf_proto *,
+					    struct tcf_result *);
+	__be16			protocol;
+
+	/* All the rest */
+	u32			prio;
+	void			*data;
+	const struct tcf_proto_ops	*ops;
+	struct tcf_chain	*chain;
+	struct rcu_head		rcu;
+};
+
+struct tcf_proto_ops {
+	struct list_head	head;
+	char			kind[IFNAMSIZ];
+
+	int			(*classify)(struct sk_buff *,
+					    const struct tcf_proto *,
+					    struct tcf_result *);
+	int			(*init)(struct tcf_proto*);
+	void			(*destroy)(struct tcf_proto *tp,
+					   struct netlink_ext_ack *extack);
+
+	void*			(*get)(struct tcf_proto*, u32 handle);
+	int			(*change)(struct net *net, struct sk_buff *,
+					struct tcf_proto*, unsigned long,
+					u32 handle, struct nlattr **,
+					void **, bool,
+					struct netlink_ext_ack *);
+	int			(*delete)(struct tcf_proto *tp, void *arg,
+					  bool *last,
+					  struct netlink_ext_ack *);
+	void			(*walk)(struct tcf_proto*, struct tcf_walker *arg);
+	int			(*reoffload)(struct tcf_proto *tp, bool add,
+					     tc_setup_cb_t *cb, void *cb_priv,
+					     struct netlink_ext_ack *extack);
+	void			(*bind_class)(void *, u32, unsigned long);
+	void *			(*tmplt_create)(struct net *net,
+						struct tcf_chain *chain,
+						struct nlattr **tca,
+						struct netlink_ext_ack *extack);
+	void			(*tmplt_destroy)(void *tmplt_priv);
+
+	/* rtnetlink specific */
+	int			(*dump)(struct net*, struct tcf_proto*, void *,
+					struct sk_buff *skb, struct tcmsg*);
+	int			(*tmplt_dump)(struct sk_buff *skb,
+					      struct net *net,
+					      void *tmplt_priv);
+
+	struct module		*owner;
+};
+
+static inline void
+tcf_bind_filter(struct tcf_proto *tp, struct tcf_result *r, unsigned long base)
+{
+	struct Qdisc *q = tp->chain->block->q;
+	unsigned long cl;
+
+	/* Check q as it is not set for shared blocks. In that case,
+	 * setting class is not supported.
+	 */
+	if (!q)
+		return;
+	cl = q->ops->cl_ops->bind_tcf(q, base, r->classid);
+	cl = cls_set_class(q, &r->class, cl);
+	if (cl)
+		q->ops->cl_ops->unbind_tcf(q, cl);
+}
+
+static inline void
+tcf_unbind_filter(struct tcf_proto *tp, struct tcf_result *r)
+{
+	struct Qdisc *q = tp->chain->block->q;
+	unsigned long cl;
+
+	if (!q)
+		return;
+	if ((cl = __cls_set_class(&r->class, 0)) != 0)
+		q->ops->cl_ops->unbind_tcf(q, cl);
+}
+
+static inline void
+tc_cls_common_offload_init(struct tc_cls_common_offload *cls_common,
+			   const struct tcf_proto *tp, u32 flags,
+			   struct netlink_ext_ack *extack)
+{
+	cls_common->chain_index = tp->chain->index;
+	cls_common->protocol = tp->protocol;
+	cls_common->prio = tp->prio;
+	if (tc_skip_sw(flags) || flags & TCA_CLS_FLAGS_VERBOSE)
+		cls_common->extack = extack;
+}
