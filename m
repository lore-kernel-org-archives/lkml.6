Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9663EC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 04:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5344720883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 04:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EcqxQu7C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5344720883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932564AbeFUE3a (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 00:29:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35180 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932173AbeFUE3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 00:29:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5PRqsDtSO9Z2tH/mokxu4giP6gBHx926LqV+oFeCIDk=; b=EcqxQu7Ch1UAM/QLEeYah/SQ8
        0u3eiaPFK5+OG4OfOuINUc7lrOVau1Bz0oL8mmLUZQ1lByPgMPj4BMDe4QMaQXste/xusN1S8YLLN
        f4kwBmN5FFpxxX88KoQlQvBEVkvHrv38vnymV941diBWYrGMUi/VNUrD35PZvwpGEOI020x8Aaqcu
        YZ93VlD7lqu6Jh3J5BAmqYth0MoPSHZ1Ok5ByTw/fsm7n2Dja7bXkCq4O4FZ/2wN7nCAFwCkppOxH
        GMjAEz5RniJa5jbA30cmGRBzqSyjBHqgNd20vLBlD4O4a81XM7BEeAMwxrbtaRSKH6dSsdakZO3i/
        aq8oCrAZA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVrDc-0007h9-Co; Thu, 21 Jun 2018 04:29:12 +0000
Date:   Wed, 20 Jun 2018 21:29:12 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     paul@paul-moore.com, eparis@redhat.com, jack@suse.cz,
        amir73il@gmail.com, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] kernel: audit_tree: Fix a sleep-in-atomic-context bug
Message-ID: <20180621042912.GA4967@bombadil.infradead.org>
References: <20180621033245.10754-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621033245.10754-1-baijiaju1990@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 11:32:45AM +0800, Jia-Ju Bai wrote:
> The kernel may sleep with holding a spinlock.
> The function call paths (from bottom to top) in Linux-4.16.7 are:
> 
> [FUNC] kmem_cache_alloc(GFP_KERNEL)
> fs/notify/mark.c, 439: 
> 		kmem_cache_alloc in fsnotify_attach_connector_to_object
> fs/notify/mark.c, 520: 
> 		fsnotify_attach_connector_to_object in fsnotify_add_mark_list
> fs/notify/mark.c, 590: 
> 		fsnotify_add_mark_list in fsnotify_add_mark_locked
> kernel/audit_tree.c, 437: 
> 		fsnotify_add_mark_locked in tag_chunk
> kernel/audit_tree.c, 423: 
> 		spin_lock in tag_chunk

There are several locks here; your report would be improved by saying
which one is the problem.  I'm assuming it's old_entry->lock.

        spin_lock(&old_entry->lock);
...
        if (fsnotify_add_inode_mark_locked(chunk_entry,
                             old_entry->connector->inode, 1)) {
...
        return fsnotify_add_mark_locked(mark, inode, NULL, allow_dups);
...
        ret = fsnotify_add_mark_list(mark, inode, mnt, allow_dups);
...
        if (inode)
                connp = &inode->i_fsnotify_marks;
        conn = fsnotify_grab_connector(connp);
        if (!conn) {
                err = fsnotify_attach_connector_to_object(connp, inode, mnt);

It seems to me that this is safe because old_entry is looked up from
fsnotify_find_mark, and it can't be removed while its lock is held.
Therefore there's always a 'conn' returned from fsnotify_grab_connector(),
and so this path will never be taken.

But this code path is confusing to me, and I could be wrong.  Jan, please
confirm my analysis is correct?

> [FUNC] kmem_cache_alloc(GFP_KERNEL)
> fs/notify/mark.c, 439: 
> 		kmem_cache_alloc in fsnotify_attach_connector_to_object
> fs/notify/mark.c, 520: 
> 		fsnotify_attach_connector_to_object in fsnotify_add_mark_list
> fs/notify/mark.c, 590: 
> 		fsnotify_add_mark_list in fsnotify_add_mark_locked
> kernel/audit_tree.c, 291: 
> 		fsnotify_add_mark_locked in untag_chunk
> kernel/audit_tree.c, 258: 
> 		spin_lock in untag_chunk

I'm just going to assume this one is the same.
