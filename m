Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F0AC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 04:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54D8720856
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 04:36:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54D8720856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726153AbeICIzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 04:55:01 -0400
Received: from nautica.notk.org ([91.121.71.147]:52120 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbeICIzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 04:55:01 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id C2AA9C009; Mon,  3 Sep 2018 06:36:35 +0200 (CEST)
Date:   Mon, 3 Sep 2018 06:36:20 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Tomas Bortoli <tomasbortoli@gmail.com>
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        v9fs-developer@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
        Dominique Martinet <dominique.martinet@cea.fr>
Subject: Re: [PATCH v4] 9p: Add refcount to p9_req_t
Message-ID: <20180903043620.GA11460@nautica>
References: <1535518779-28551-1-git-send-email-asmadeus@codewreck.org>
 <1535626341-20693-1-git-send-email-asmadeus@codewreck.org>
 <96b44210-3c4d-b5c9-0806-ad4b53fe911f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <96b44210-3c4d-b5c9-0806-ad4b53fe911f@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Bortoli wrote on Fri, Aug 31, 2018:
> On 08/30/2018 12:52 PM, Dominique Martinet wrote:
> > From: Tomas Bortoli <tomasbortoli@gmail.com>
> > 
> > To avoid use-after-free(s), use a refcount to keep track of the
> > usable references to any instantiated struct p9_req_t.
> > 
> > This commit adds p9_req_put(), p9_req_get() and p9_req_try_get() as
> > wrappers to kref_put(), kref_get() and kref_get_unless_zero().
> > These are used by the client and the transports to keep track of
> > valid requests' references.
> > 
> > p9_free_req() is added back and used as callback by kref_put().
> > 
> > Add SLAB_TYPESAFE_BY_RCU as it ensures that the memory freed by
> > kmem_cache_free() will not be reused for another type until the rcu
> > synchronisation period is over, so an address gotten under rcu read
> > lock is safe to inc_ref() without corrupting random memory while
> > the lock is held.
> > 
> > Co-developed-by: Dominique Martinet <dominique.martinet@cea.fr>
> > Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
> > Reported-by: syzbot+467050c1ce275af2a5b8@syzkaller.appspotmail.com
> > Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
> > ---
> > v3:
> >  - add req put if virtio zc request fails
> >  - add req put if cancelled callback is not defined for virtio
> >  - (incorrectly) add req put in rdma cancelled callback
> > 
> > v4:
> >  - removed rdma's cancelled callback put again
> >  - changed the else if no cancelled callback into actually giving virtio
> > a callback, xen does not need to call put in that case either because
> > both function rely on tag_lookup to find the request. trans_fd only
> > needs to put in cancelled because it also keeps the req in a list around
> > for cancel.
> >  - add req put for trans xen's request(), I'm not sure why that one was
> > missing either..
> > 
> > And with that I believe I am done testing all four transports.
> > I'll do a second round of tests next week just to make sure, but it
> > should be good enough™
> > Sorry for the multiple iterations.
>
> LGTM, thanks Dominique!

Thanks.

I've pushed this with the other patches to my '9p-next' branch, which
will get merged to linux-next today/tomorrow, so they can soak up some
syzbot testing as well.
That doesn't mean they cannot get reviews anymore, so don't be shy!


Tomas, I didn't see you reply about the 'rename req to rreq' requested
patch for trans_fd, but it's trivial so if you're not going to do it I
will submit something around next week.

-- 
Dominique
