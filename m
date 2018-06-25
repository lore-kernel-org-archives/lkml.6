Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7D9C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F8A2256A2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:23:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F8A2256A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932103AbeFYJXP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 05:23:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:56935 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755063AbeFYJXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 05:23:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BEA4DAB43;
        Mon, 25 Jun 2018 09:23:10 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E17241E3629; Mon, 25 Jun 2018 11:22:57 +0200 (CEST)
Date:   Mon, 25 Jun 2018 11:22:57 +0200
From:   Jan Kara <jack@suse.cz>
To:     Paul Moore <paul@paul-moore.com>
Cc:     jack@suse.cz, willy@infradead.org, baijiaju1990@gmail.com,
        Eric Paris <eparis@redhat.com>, amir73il@gmail.com,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] kernel: audit_tree: Fix a sleep-in-atomic-context bug
Message-ID: <20180625092257.kyqnmn4ki7cuqkat@quack2.suse.cz>
References: <20180621033245.10754-1-baijiaju1990@gmail.com>
 <20180621042912.GA4967@bombadil.infradead.org>
 <20180622092340.dzl2ea7tdkjdkdhg@quack2.suse.cz>
 <CAHC9VhTPCmAXjZgo_i=M_Yo9pJXqUJAmAfL7+pYYb6cOSWw9Zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhTPCmAXjZgo_i=M_Yo9pJXqUJAmAfL7+pYYb6cOSWw9Zw@mail.gmail.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 22-06-18 14:56:09, Paul Moore wrote:
> On Fri, Jun 22, 2018 at 5:23 AM Jan Kara <jack@suse.cz> wrote:
> > On Wed 20-06-18 21:29:12, Matthew Wilcox wrote:
> > > On Thu, Jun 21, 2018 at 11:32:45AM +0800, Jia-Ju Bai wrote:
> > > > The kernel may sleep with holding a spinlock.
> > > > The function call paths (from bottom to top) in Linux-4.16.7 are:
> > > >
> > > > [FUNC] kmem_cache_alloc(GFP_KERNEL)
> > > > fs/notify/mark.c, 439:
> > > >             kmem_cache_alloc in fsnotify_attach_connector_to_object
> > > > fs/notify/mark.c, 520:
> > > >             fsnotify_attach_connector_to_object in fsnotify_add_mark_list
> > > > fs/notify/mark.c, 590:
> > > >             fsnotify_add_mark_list in fsnotify_add_mark_locked
> > > > kernel/audit_tree.c, 437:
> > > >             fsnotify_add_mark_locked in tag_chunk
> > > > kernel/audit_tree.c, 423:
> > > >             spin_lock in tag_chunk
> > >
> > > There are several locks here; your report would be improved by saying
> > > which one is the problem.  I'm assuming it's old_entry->lock.
> > >
> > >         spin_lock(&old_entry->lock);
> > > ...
> > >         if (fsnotify_add_inode_mark_locked(chunk_entry,
> > >                              old_entry->connector->inode, 1)) {
> > > ...
> > >         return fsnotify_add_mark_locked(mark, inode, NULL, allow_dups);
> > > ...
> > >         ret = fsnotify_add_mark_list(mark, inode, mnt, allow_dups);
> > > ...
> > >         if (inode)
> > >                 connp = &inode->i_fsnotify_marks;
> > >         conn = fsnotify_grab_connector(connp);
> > >         if (!conn) {
> > >                 err = fsnotify_attach_connector_to_object(connp, inode, mnt);
> > >
> > > It seems to me that this is safe because old_entry is looked up from
> > > fsnotify_find_mark, and it can't be removed while its lock is held.
> > > Therefore there's always a 'conn' returned from fsnotify_grab_connector(),
> > > and so this path will never be taken.
> > >
> > > But this code path is confusing to me, and I could be wrong.  Jan, please
> > > confirm my analysis is correct?
> >
> > Yes, you are correct. The presence of another mark in the list (and the
> > fact we pin it there using refcount & mark_mutex) guarantees we won't need
> > to allocate the connector. I agree the audit code's use of fsnotify would
> > deserve some cleanup.
> 
> I'm always open to suggestions and patches (hint, hint) from the
> fsnotify experts ;)

Yeah, I was looking into it on Friday and today :). Currently I've got a
bit stuck because I think I've found some races in audit_tree code and I
haven't yet decided how to fix them. E.g. am I right the following can
happen?

CPU1                                    CPU2
tag_chunk(inode, tree1)                 tag_chunk(inode, tree2)
  old_entry = fsnotify_find_mark();       old_entry = fsnotify_find_mark();
  old = container_of(old_entry);          old = container_of(old_entry);
  chunk = alloc_chunk(old->count + 1);    chunk = alloc_chunk(old->count + 1);
  mutex_lock(&group->mark_mutex);
  adds new mark
  replaces chunk
  old->dead = 1;
  mutex_unlock(&group->mark_mutex);
                                          mutex_lock(&group->mark_mutex);
                                          if (!(old_entry->flags &
                                                FSNOTIFY_MARK_FLAG_ATTACHED)) {
                                            Check fails as old_entry is
                                            not yet destroyed
                                          adds new mark
                                          replaces old chunk again ->
                                            list corruption, lost refs, ...
                                          mutex_unlock(&group->mark_mutex);

Generally there's a bigger problem that audit_tree code can have multiple
marks attached to one inode but only one of them is the "valid" one (i.e.,
the one embedded in the latest chunk). This is only a temporary state until
fsnotify_destroy_mark() detaches the mark and then on last reference drop
we really remove the mark from inode's list but during that window it is
undefined which mark is returned from fsnotify_find_mark()...

So am I right the above can really happen or is there some higher level
synchronization I'm missing? If this can really happen, I think I'll need
to rework the code so that audit_tree has just one mark attached and
let it probably point to the current chunk.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
