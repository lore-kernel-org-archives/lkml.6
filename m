Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3951DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F156620863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CRZJVlTU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F156620863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbeK2VyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 16:54:04 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43032 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbeK2VyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 16:54:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iKWlWDZpYIW+yqMwBdnKiXRdSj3GHtdg5osH4/Hh3D4=; b=CRZJVlTUS5Zu3OReqSKmvrzlW
        0roet09nvPsmyZt0CgH87OXJNnWcOqjS2C2yl+w0/+N6SxId6uabbkA16r8aQBccGbZumz0fgREve
        Uu9qYfhtAcdp9oDDlJRBFWr8X6pv1/rckSCVwUEWb6IC3aUqPJAHm7ovYw4F1/fxlI/ib6JhRcFA7
        SMQv/p1xU461fu9lGVjtU3itG9nZL4UIZd5OVoGd52qzDShzvBfFIFZ00XCd8TEz5x2HOp4rZyvam
        8kB/NfMLXUR/baxzTrZjvP6PvG1UBdMH2c7KLjOMofnahV31HQPu9M0BD5RnVvvxn9kaQ7U1S/jNC
        KbvpGtpdQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSJsX-0001xd-DL; Thu, 29 Nov 2018 10:49:05 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C60BE2029FD58; Thu, 29 Nov 2018 11:49:02 +0100 (CET)
Date:   Thu, 29 Nov 2018 11:49:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     mingo@redhat.com, tj@kernel.org, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 22/27] locking/lockdep: Reuse list entries that are no
 longer in use
Message-ID: <20181129104902.GH2131@hirez.programming.kicks-ass.net>
References: <20181128234325.110011-1-bvanassche@acm.org>
 <20181128234325.110011-23-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128234325.110011-23-bvanassche@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 03:43:20PM -0800, Bart Van Assche wrote:
> Instead of abandoning elements of list_entries[] that are no longer in
> use, make alloc_list_entry() reuse array elements that have been freed.

> diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> index 43327a1dd488..01e55fca7c2c 100644
> --- a/include/linux/lockdep.h
> +++ b/include/linux/lockdep.h
> @@ -183,6 +183,11 @@ static inline void lockdep_copy_map(struct lockdep_map *to,
>  struct lock_list {
>  	/* Entry in locks_after or locks_before. */
>  	struct list_head		lock_order_entry;
> +	/*
> +	 * Entry in all_list_entries when in use and entry in
> +	 * free_list_entries when not in use.
> +	 */
> +	struct list_head		alloc_entry;
>  	struct lock_class		*class;
>  	struct lock_class		*links_to;
>  	struct stack_trace		trace;

> +static LIST_HEAD(all_list_entries);
> +static LIST_HEAD(free_list_entries);
>  

> @@ -862,7 +867,10 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
>   */
>  static struct lock_list *alloc_list_entry(void)
>  {
> -	if (nr_list_entries >= MAX_LOCKDEP_ENTRIES) {
> +	struct lock_list *e = list_first_entry_or_null(&free_list_entries,
> +						       typeof(*e), alloc_entry);
> +
> +	if (!e) {
>  		if (!debug_locks_off_graph_unlock())
>  			return NULL;
>  
> @@ -870,7 +878,8 @@ static struct lock_list *alloc_list_entry(void)
>  		dump_stack();
>  		return NULL;
>  	}
> -	return list_entries + nr_list_entries++;
> +	list_move_tail(&e->alloc_entry, &all_list_entries);
> +	return e;
>  }

> @@ -4235,19 +4244,19 @@ static void zap_class(struct list_head *zapped_classes,
>  		      struct lock_class *class)
>  {
>  	struct lock_class *links_to;
> +	struct lock_list *entry, *tmp;
>  
>  	/*
>  	 * Remove all dependencies this lock is
>  	 * involved in:
>  	 */
> +	list_for_each_entry_safe(entry, tmp, &all_list_entries, alloc_entry) {
>  		if (entry->class != class && entry->links_to != class)
>  			continue;
>  		links_to = entry->links_to;
>  		WARN_ON_ONCE(entry->class == links_to);
>  		list_del_rcu(&entry->lock_order_entry);
> +		list_move(&entry->alloc_entry, &free_list_entries);
>  		entry->class = NULL;
>  		entry->links_to = NULL;
>  		check_free_class(zapped_classes, class);

Hurm.. I'm confused here.

The reason you cannot re-use lock_order_entry for the free list is
because list_del_rcu(), right? But if so, then what ensures the
list_entry is not re-used before it's grace-period?
