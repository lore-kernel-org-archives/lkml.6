Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCAAAC433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 17:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B1F208D8
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 17:32:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34B1F208D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbeHZVPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 17:15:51 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:36088 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbeHZVPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 17:15:51 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1ftytx-0000y3-1a; Sun, 26 Aug 2018 17:32:37 +0000
Date:   Sun, 26 Aug 2018 18:32:37 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>
Subject: Re: [PATCH] net: sched: Fix memory exposure from short TCA_U32_SEL
Message-ID: <20180826173236.GU6515@ZenIV.linux.org.uk>
References: <20180826055801.GA42063@beast>
 <20180826061534.GT6515@ZenIV.linux.org.uk>
 <CAGXu5jK7VzayzZTcxgZBf-+YHWO+Hv7s8utj2rzTc3gFtA8pFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXu5jK7VzayzZTcxgZBf-+YHWO+Hv7s8utj2rzTc3gFtA8pFQ@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 25, 2018 at 11:19:30PM -0700, Kees Cook wrote:
> >> -     n = kzalloc(sizeof(*n) + s->nkeys*sizeof(struct tc_u32_key), GFP_KERNEL);
> >> +     n = kzalloc(offsetof(typeof(*n), sel) + sel_size, GFP_KERNEL);
> >
> > ITYM
> >         n = kzalloc(offsetof(struct tc_u_common, sel.keys[s->nkeys]), GFP_KERNEL);
> 
> I prefer to reuse sel_size and keep typeof() to keep things tied to
> "n" more directly. *shrug*

This is rather search-hostile, though.  Fresh example from the same
area: where are struct tcf_proto instances created?  Is it true that
each is followed by ->ops->init()?  Is it true that ->ops->init()
is never called twice for the same instance?  Is it true that
->ops->destroy() is called exactly once between successful ->ops->init()
and freeing the object?

That's precisely the kind of questions you end up asking when learning
a new area.  Your variant makes those harder to answer; it does make
it easier to catch local problems on casual grep, but it's hell both
on the newbies trying to make sense of an area and on the old hands
from different areas.

That, BTW, is why I hate the use of sizeof(*p) in kmalloc, etc.
arguments.  typeof is even worse in that respect.

As for the questions above...  Do try to grep for ->init calls.  Good
luck getting through the damn pile.  And "it must see the definition
of tcf_proto_ops" doesn't narrow it - it's defined in net/sch_generic.h,
which gets pulled by linux/filter.h, which gets pulled by net/sock.h,
which gets pulled by arseloads of code.

As far as I can tell, the solution is
	* outside of net/sched/*.c, tcf_proto_ops is mentioned only
in
include/net/pkt_cls.h:23:int register_tcf_proto_ops(struct tcf_proto_ops *ops);
include/net/pkt_cls.h:24:int unregister_tcf_proto_ops(struct tcf_proto_ops *ops);
and
include/net/sch_generic.h:304:  const struct tcf_proto_ops      *ops;
include/net/sch_generic.h:327:  const struct tcf_proto_ops *tmplt_ops;
	* the first two are irrelevant - externs don't get you any
access to the data structure
	* tmplt_ops is only used in net/sched/*.c; for everything else
it could've been opaque pointer - it's not even looked at
	* tcf_proto ->ops is, of course, ungreppable.  However,
tcf_proto itself, outside of net/sched/*.c, is only mentioned in
include/net/act_api.h:175:int tcf_action_init(struct net *net, struct tcf_proto *tp, struct nlattr *nla,
include/net/act_api.h:179:struct tc_action *tcf_action_init_1(struct net *net, struct tcf_proto *tp,
include/net/pkt_cls.h:20:       int     (*fn)(struct tcf_proto *, void *node, struct tcf_walker *);
include/net/pkt_cls.h:48:                 struct tcf_proto __rcu **p_filter_chain, struct Qdisc *q,
include/net/pkt_cls.h:90:int tcf_classify(struct sk_buff *skb, const struct tcf_proto *tp,
include/net/pkt_cls.h:96:                 struct tcf_proto __rcu **p_filter_chain, struct Qdisc *q,
include/net/pkt_cls.h:196:static inline int tcf_classify(struct sk_buff *skb, const struct tcf_proto *tp,
include/net/pkt_cls.h:221:tcf_bind_filter(struct tcf_proto *tp, struct tcf_result *r, unsigned long base)
include/net/pkt_cls.h:238:tcf_unbind_filter(struct tcf_proto *tp, struct tcf_result *r)
include/net/pkt_cls.h:385:int tcf_exts_validate(struct net *net, struct tcf_proto *tp,
include/net/pkt_cls.h:497:int tcf_em_tree_validate(struct tcf_proto *, struct nlattr *,
include/net/pkt_cls.h:713:                         const struct tcf_proto *tp, u32 flags,
include/net/sch_generic.h:237:          const struct tcf_proto *goto_tp;
include/net/sch_generic.h:254:                                      const struct tcf_proto *,
include/net/sch_generic.h:256:  int                     (*init)(struct tcf_proto*);
include/net/sch_generic.h:257:  void                    (*destroy)(struct tcf_proto *tp,
include/net/sch_generic.h:260:  void*                   (*get)(struct tcf_proto*, u32 handle);
include/net/sch_generic.h:262:                                  struct tcf_proto*, unsigned long,
include/net/sch_generic.h:266:  int                     (*delete)(struct tcf_proto *tp, void *arg,
include/net/sch_generic.h:269:  void                    (*walk)(struct tcf_proto*, struct tcf_walker *arg);
include/net/sch_generic.h:270:  int                     (*reoffload)(struct tcf_proto *tp, bool add,
include/net/sch_generic.h:281:  int                     (*dump)(struct net*, struct tcf_proto*, void *,
include/net/sch_generic.h:290:struct tcf_proto {
include/net/sch_generic.h:292:  struct tcf_proto __rcu  *next;
include/net/sch_generic.h:297:                                      const struct tcf_proto *,
include/net/sch_generic.h:317:typedef void tcf_chain_head_change_t(struct tcf_proto *tp_head, void *priv);
include/net/sch_generic.h:320:  struct tcf_proto __rcu *filter_chain;
include/net/sch_generic.h:1098: struct tcf_proto *filter_list;
include/net/sch_generic.h:1122:                   struct tcf_proto *tp_head);
	* excluding externs, arguments in function pointers or a typedef for
such (neither would give an access to thus typed pointer), we are left with
include/net/pkt_cls.h:96:                 struct tcf_proto __rcu **p_filter_chain, struct Qdisc *q,
include/net/pkt_cls.h:196:static inline int tcf_classify(struct sk_buff *skb, const struct tcf_proto *tp,
include/net/pkt_cls.h:221:tcf_bind_filter(struct tcf_proto *tp, struct tcf_result *r, unsigned long base)
include/net/pkt_cls.h:238:tcf_unbind_filter(struct tcf_proto *tp, struct tcf_result *r)
include/net/pkt_cls.h:713:                         const struct tcf_proto *tp, u32 flags,
include/net/sch_generic.h:237:          const struct tcf_proto *goto_tp;
include/net/sch_generic.h:290:struct tcf_proto {
include/net/sch_generic.h:292:  struct tcf_proto __rcu  *next;
include/net/sch_generic.h:320:  struct tcf_proto __rcu *filter_chain;
include/net/sch_generic.h:1098: struct tcf_proto *filter_list;
	* the first two are in arguments of static inlines which do not
use the arguments in question.
	* the next three (tcf_bind_filter, tcf_unbind_filter and
tc_cls_common_offload_init) do not use ->ops or pass tcf_proto * to
anyone.  Incidentally, they are only used in net/sched/*.c
	* goto_tp is also used only in net/sched/*.c.  Moreover,
all its uses anywhere could as well have been an opaque pointer.
	* grepping for filter_chain catches an unrelated local field
of the same name in mellanox, a function with the same name in
uprobes.c and a bunch of uses in net/sched/*.c.
	* search for filter_list gets false positives in trace_events_filter.c,
a bunch of uses in net/sched/*.c and
net/core/dev.c:3533:    switch (tcf_classify(skb, miniq->filter_list, &cl_res, false)) {
net/core/dev.c:4593:    switch (tcf_classify(skb, miniq->filter_list, &cl_res, false)) {
both of which are opaque.
	* the last remaining source of such pointers is
include/net/sch_generic.h:292:  struct tcf_proto __rcu  *next;
Of course, that's ungreppable.  However, it's within the struct tcf_proto itself, so
anyone accessing it as something non-opaque would already have to access tcf_proto
pointers, and not in provably opaque fashion.  Theoretically, the three tcf_...
inlines above need another look; fortunately, they don't use ->next at all, not to
mention not being used anywhere outside of net/sched/*.c

	The 80 lines above prove that we only need to grep net/sched/*.c for
tcf_proto_ops method calls.  And only because we don't have (thank $DEITY)
anything that could deconstruct types - as soon as some bastard grows means
to say "type of the second argument of the function pointed to by p", this
kind of analysis, painful as it is, goes out of window.  Even as it is,
do you really like the idea of newbies trying to get through the exercises
like the one above?

	Incidentally, that's not the end -
git grep -n '[-]>[      ]*init\>' net/sched/
git grep -n '\.[        ]*init\>' net/sched/
does catch 93 hits.  Excluding comparisons, assignments and initializers,
we are down to
net/sched/act_api.c:878:                err = a_o->init(net, tb[TCA_ACT_OPTIONS], est, &a, ovr, bind,
net/sched/act_api.c:881:                err = a_o->init(net, nla, est, &a, ovr, bind, rtnl_held,
net/sched/cls_api.c:173:        err = tp->ops->init(tp);
net/sched/sch_api.c:1155:               err = ops->init(sch, tca[TCA_OPTIONS], extack);
net/sched/sch_generic.c:901:    if (!ops->init || ops->init(sch, NULL, extack) == 0)
	Note that we have no less than 3 different methods of the same name
here, going just by the number of arguments.  Fortunately, only one candidate
for tcf_proto one, that in tcf_proto_create().  And there it's obviously done
on new object, with nothing else seeing it until the call.

	Only that's not quite all I wanted to know - are there any other places
where tcf_proto instances get created?  They are not members of any structs,
unions or arrays, thankfully (that we can see from grep) and there's no
variables of that type, be it auto or static duration.  So it should all be
dynamically allocated.  Moreover, from the above it looks like no twit could've
done such allocation in his/her/its misbegotten driver (they would have to
find the size somehow, and the search above would've spotted that).  It has to
be somewhere in net/sched, if anywhere at all.  And no, you can't rely upon
k.*alloc being used to allocate them - not apriori in unfamiliar code, not when
looking for a bug somewhere, etc.  net/sched/*.c is 49KLoC; "read through and
see if it's done anywhere" is neither feasible nor supportable (what, do it
again each cycle?)

	*IF* nobody plays games with sizeof(expression) (or typeof()), one
could look for mentionings of struct tcf_proto in there and exclude the
ones that actually mention pointers.  That would've shown both the allocations
and places where container_of() gets used, etc.  No such luck, thanks to
misguided souls preaching the "robust" uses of sizeof...

	Sure, I can find all places in net/sched/*.c where we are declaring
pointers to tcf_proto or get those out of mentionings of fields of that
type.  256 hits total, and of course a lot of those are declarations of
function arguments, which means that the function needs to be read through,
thanks to the possibility of wonders like
	tp->next = kmalloc(sizeof(*tp), GFP_KERNEL);
AFAICS, nothing exaclty like that exists there, but...

	Most of such arguments are thankfully called 'tp', so grepping for
that in there allows to drop such declarations from the list.  The list,
of course, grows, but it no longer contains that number of "need to look
through the entire" function hits.  That, and some judicious use of search
and replace reduces it to something I'd been able to get through in about
an hour.  All instances *are* created by tcf_proto_create().  The same fun-filled 
activity has proven (modulo misreadings in that fun, of course) that all
instances are either freed before getting returned by tcf_proto_create() (in
case of ->init() failure) or go out in tcf_proto_destroy() via kfree_rcu(),
after ->ops->destroy() call done to them.  And apparently that's the only
caller of ->destroy(), so modulo locking questions (I hadn't even started
to look into that) the answers to all questions in the beginning are
"yes".

	Now, I'm fairly used to that kind of digging (and have a bunch of
useful vi macros, search patterns, etc.), so I'd managed to get through all
that.  Took me about an hour and a half total.  Do you really expect the
newbies to get through that joy?  Sure, they (and I) can ask the maintainers,
who would've answered those questions instantly (well, modulo the email
latency, etc.)  And for newbies asking that kind of questions is certainly
the right thing to do (or noting the suspected answer down and moving along,
to verify it later).  But then the same maintainers have to verify that
this answer doesn't rot - that changes there (and elsewhere - never underestimate
the amount of weirdness cropping up as one-off hack in the bowels of drivers/*)
do not invalidate it?  Same search, more or less...

	VFS-side I'm trying to enforce "no sizeof(expression), unless it's
sizeof(local_variable)".  Not religiously so, but any new instances of
sizeof in there are checked for that (once I get around to that).  typeof
is rare as hens teeth in there, and should bloody remain so, TYVM.
It belongs inside very low-level macros and (almost) nowhere else.

	There is a conflict of interests between "I don't give a damn what's
being allocated here, it does get sufficient size for resulting pointer
type and that's all I'm interested in" and "I'm looking for the places where
>this< is allocated".  Your variant is firmly on the former side...
