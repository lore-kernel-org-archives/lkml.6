Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305F1C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 00:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 856E0208B9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 00:03:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 856E0208B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbeH1DwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 23:52:10 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:39378 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbeH1DwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 23:52:09 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fuRTS-0000kN-Kd; Tue, 28 Aug 2018 00:03:10 +0000
Date:   Tue, 28 Aug 2018 01:03:10 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Jamal Hadi Salim <jhs@mojatatu.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Pirko <jiri@resnulli.us>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>
Subject: Re: [PATCH] net: sched: Fix memory exposure from short TCA_U32_SEL
Message-ID: <20180828000310.GE6515@ZenIV.linux.org.uk>
References: <20180826055801.GA42063@beast>
 <20180826061534.GT6515@ZenIV.linux.org.uk>
 <CAGXu5jK7VzayzZTcxgZBf-+YHWO+Hv7s8utj2rzTc3gFtA8pFQ@mail.gmail.com>
 <20180826173236.GU6515@ZenIV.linux.org.uk>
 <20180826225749.GY6515@ZenIV.linux.org.uk>
 <cb9d4e74-3498-48bd-45e0-05e925dbdb5b@mojatatu.com>
 <CAM_iQpVEyq9hR3bbOtLFKoLo6nHCtiL6A__uEz3JdDO79GF_8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM_iQpVEyq9hR3bbOtLFKoLo6nHCtiL6A__uEz3JdDO79GF_8A@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 02:31:41PM -0700, Cong Wang wrote:
> > I cant think of any challenges. Cong/Jiri? Would it require development
> > time classifiers/actions/qdiscs to sit in that directory (I suspect you
> > dont want them in include/net).
> > BTW, the idea of improving grep-ability of the code by prefixing the
> > ops appropriately makes sense. i.e we should have ops->cls_init,
> > ops->act_init etc.
> 
> Hmm? Isn't struct tcf_proto_ops used and must be provided
> by each tc filter module? How does it work if you move it into
> net/sched/* for out-of-tree modules? Are they supposed to
> include "..../net/sched/tcf_proto.h"?? Or something else?

If you care about out-of-tree modules, that could easily live in
include/net/tcf_proto.h, provided that it's not pulled by indirect
includes into hell knows how many places.  Try
make allmodconfig
make >/dev/null 2>&1
find -name '.*.cmd'|xargs grep sch_generic.h

That finds 2977 files here, most of them having nothing to do with
net/sched.

> BTW, we need some grep tool that really understands C syntax,
> not making each variable friendly to plain grep.

This isn't the matter of C syntax; it needs to handle C typization,
and you really can't do that anywhere near reliably without looking
at preprocessor output.  Which very much depends upon .config...

BTW, something odd in cls_u32.c: what happens if we have the following
graph:
tcf_proto <tp>, it's ->data being <c0> and ->root - <ht0>
tc_u_common <c0>, in its ->hlist
	<ht1>, in its ->ht[0]
		<knode>
	<ht0>
and set ->ht_down in <knode> to the <ht0>?  AFAICS,
there's nothing to prevent that - TCA_U32_LINK being
0x80000000 will do just that.  What happens upon u32_destroy()
in that case?  Unless I'm misreading that code, refcounts will be
	<c0>:	1
	<ht0>:	2
	<ht1>:	1
and in u32_destroy() we'll get this:
	root_ht = <ht0>
	tp_c = <c0>
        if (root_ht && --root_ht->refcnt == 0)
                u32_destroy_hnode(tp, root_ht, extack);
decrements refcnt to 1 and does nothing else.
        if (--tp_c->refcnt == 0) {
is satisfied
                hlist_del(&tp_c->hnode);
<c0> unhashed
                while ((ht = rtnl_dereference(tp_c->hlist)) != NULL) {
we take ht = <ht1>
                        u32_clear_hnode(tp, ht, extack);
which does
        for (h = 0; h <= ht->divisor; h++) {
                while ((n = rtnl_dereference(ht->ht[h])) != NULL) {
n = <knode>
                        RCU_INIT_POINTER(ht->ht[h],
                                         rtnl_dereference(n->next));
remove <knode> from <ht1>->ht[0]
                        tcf_unbind_filter(tp, &n->res);
                        u32_remove_hw_knode(tp, n, extack);
                        idr_remove(&ht->handle_idr, n->handle);
                        if (tcf_exts_get_net(&n->exts))
                                tcf_queue_work(&n->rwork, u32_delete_key_freepf_work);
                        else
                                u32_destroy_key(n->tp, n, true);
... and we hit u32_destroy_key(<tp>, <knode>, true), which does
        struct tc_u_hnode *ht = rtnl_dereference(n->ht_down);
ht = <ht0>
        tcf_exts_destroy(&n->exts);
        tcf_exts_put_net(&n->exts);
        if (ht && --ht->refcnt == 0)
                kfree(ht);
*NOW* <ht0>->refcnt is 0, and we free the damn thing.
	....
	kfree(n);
<knode> is freed and we return to u32_destroy_hnode() where we
see that there's nothing else left in <ht1>->ht[...] and return
to u32_destroy().  Where
                        RCU_INIT_POINTER(tp_c->hlist, ht->next);
sets <c0>->hlist to <ht1>->next, aka <h0>.  Which is already freed.

                        /* u32_destroy_key() will later free ht for us, if it's
                         * still referenced by some knode
                         */
                        if (--ht->refcnt == 0)
                                kfree_rcu(ht, rcu);
<ht1>->refcnt reaches 0 and we free it (RCU-delayed)
                }
... and we go for the next iteration, this time with ht = <ht0>.
Doing all kinds of unsanitary things to the memory it used to occupy...

Incidentally, if we hit
                                tcf_queue_work(&n->rwork, u32_delete_key_freepf_work);
instead of u32_destroy_key(), the things don't seem to be any better - we
won't do anything to <knode> until rtnl is dropped, so u32_destroy() won't
break on the second pass through the loop - it'll free <ht0> there and
return.  Setting us up for trouble, since when u32_delete_key_freepf_work()
finally gets to u32_destroy_key() we'll have <knode>->ht_down pointing
to freed memory and decrementing its contents...

What am I missing in there?  Is it just "we should never have ->ht_down
pointing to anyone's ->root"?  If so, I'm not sure how to detect that;
if not... what should happen to the orphaned root_ht?  Should it
remain on the list?  We might have two tcf_proto sharing tp->data,
so tp_c and its list might very well survive the u32_destroy()...

Note, BTW, that if we do leave the orphan on the list and later
change the tc_u_knode so that ->ht_down doesn't point to that
thing anymore, we'll get its refcount incremented to 2 in
u32_init_knode(), then decremented to 1 by u32_set_parms() and
then arrange for u32_delete_key_work() to be run.  Which will 
drive the refcount to 0 and free the damn thing.  While it's
still in the middle of ->hlist...
