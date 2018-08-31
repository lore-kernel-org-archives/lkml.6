Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCE8C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 04:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFD8F20661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 04:03:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFD8F20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbeHaIJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 04:09:04 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:48162 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbeHaIJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 04:09:03 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fvaej-0005c5-FW; Fri, 31 Aug 2018 04:03:33 +0000
Date:   Fri, 31 Aug 2018 05:03:33 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Jamal Hadi Salim <jhs@mojatatu.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Pirko <jiri@resnulli.us>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>
Subject: Re: [PATCH] net: sched: Fix memory exposure from short TCA_U32_SEL
Message-ID: <20180831040333.GA20509@ZenIV.linux.org.uk>
References: <20180826055801.GA42063@beast>
 <20180826061534.GT6515@ZenIV.linux.org.uk>
 <CAGXu5jK7VzayzZTcxgZBf-+YHWO+Hv7s8utj2rzTc3gFtA8pFQ@mail.gmail.com>
 <20180826173236.GU6515@ZenIV.linux.org.uk>
 <20180826225749.GY6515@ZenIV.linux.org.uk>
 <cb9d4e74-3498-48bd-45e0-05e925dbdb5b@mojatatu.com>
 <CAM_iQpVEyq9hR3bbOtLFKoLo6nHCtiL6A__uEz3JdDO79GF_8A@mail.gmail.com>
 <20180828000310.GE6515@ZenIV.linux.org.uk>
 <20180828155938.GF6515@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828155938.GF6515@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 04:59:38PM +0100, Al Viro wrote:
> On Tue, Aug 28, 2018 at 01:03:10AM +0100, Al Viro wrote:
> >                         if (tcf_exts_get_net(&n->exts))
> >                                 tcf_queue_work(&n->rwork, u32_delete_key_freepf_work);
> >                         else
> >                                 u32_destroy_key(n->tp, n, true);
> > ... and we hit u32_destroy_key(<tp>, <knode>, true), which does
> 
> Speaking of which, we'd better never hit that branch for other reasons - there's
> no RCU delay between removal of knode from the hash chain and its kfree().
> tcf_queue_work() does guarantee such delay (by use of queue_rcu_work()), direct
> call doesn't...
> 
> Anyway, whichever branch is taken, the memory corruption problem remains - the
> comments below are accurate, AFAICS.
> 
> > Incidentally, if we hit
> >                                 tcf_queue_work(&n->rwork, u32_delete_key_freepf_work);
> > instead of u32_destroy_key(), the things don't seem to be any better - we
> > won't do anything to <knode> until rtnl is dropped, so u32_destroy() won't
> > break on the second pass through the loop - it'll free <ht0> there and
> > return.  Setting us up for trouble, since when u32_delete_key_freepf_work()
> > finally gets to u32_destroy_key() we'll have <knode>->ht_down pointing
> > to freed memory and decrementing its contents...

Build the kernel with slab poisoning and try this:
tc qdisc add dev eth0 ingress
tc filter add dev eth0 parent ffff: protocol ip prio 100 handle 1: u32 divisor 1
tc filter add dev eth0 parent ffff: protocol ip prio 200 handle 2: u32 divisor 1
tc filter add dev eth0 parent ffff: protocol ip prio 100 handle 1:0:11 u32 ht 1: link 801: offset at 0 mask 0f00 shift 6 plus 0 eat match ip protocol 6 ff
tc filter delete dev eth0 parent ffff: protocol ip prio 200
tc filter change dev eth0 parent ffff: protocol ip prio 100 handle 1:0:11 u32 ht 1: link 0: offset at 0 mask 0f00 shift 6 plus 0 eat match ip protocol 6 ff
tc filter delete dev eth0 parent ffff: protocol ip prio 100

Then watch it oops in u32_lookup_ht() from u32_get() from tc_del_tfilter()
Oopsing insn: cmp    %ebp,0x8(%rbx).  RBX: 6b6b6b6b6b6b6b6b, i.e. slab
poison...

What happens is that ht 801: (created when we'd added tcf_proto for prio 200)
gets pinned down by link 801: in the third tc filter add.  Then removal of
prio 200 triggers u32_destroy(), dropping refcount on 801: and doing nothing
else to it.  Then filter change drops the last reference to 801:, freeing
it.  And we have a freed struct tc_u_hnode stuck in the middle of the list...
