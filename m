Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41622C4646D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 22:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E381E217A2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 22:51:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E381E217A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732072AbeHDAtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 20:49:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38332 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731846AbeHDAtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 20:49:39 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0333BBBF;
        Fri,  3 Aug 2018 22:51:20 +0000 (UTC)
Date:   Fri, 3 Aug 2018 15:51:20 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     vdavydov.dev@gmail.com, mhocko@suse.com, aryabinin@virtuozzo.com,
        ying.huang@intel.com, penguin-kernel@I-love.SAKURA.ne.jp,
        willy@infradead.org, shakeelb@google.com, jbacik@fb.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Use special value SHRINKER_REGISTERING instead
 list_empty() check
Message-Id: <20180803155120.0d65511b46c100565b4f8a2c@linux-foundation.org>
In-Reply-To: <153331055842.22632.9290331685041037871.stgit@localhost.localdomain>
References: <153331055842.22632.9290331685041037871.stgit@localhost.localdomain>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Aug 2018 18:36:14 +0300 Kirill Tkhai <ktkhai@virtuozzo.com> wrote:

> The patch introduces a special value SHRINKER_REGISTERING to use instead
> of list_empty() to detect a semi-registered shrinker.
> 
> This should be clearer for a reader since "list is empty"  is not
> an intuitive state of a shrinker), and this gives a better assembler
> code:
> 
> Before:
> callq  <idr_find>
> mov    %rax,%r15
> test   %rax,%rax
> je     <shrink_slab_memcg+0x1d5>
> mov    0x20(%rax),%rax
> lea    0x20(%r15),%rdx
> cmp    %rax,%rdx
> je     <shrink_slab_memcg+0xbd>
> mov    0x8(%rsp),%edx
> mov    %r15,%rsi
> lea    0x10(%rsp),%rdi
> callq  <do_shrink_slab>
> 
> After:
> callq  <idr_find>
> mov    %rax,%r15
> lea    -0x1(%rax),%rax
> cmp    $0xfffffffffffffffd,%rax
> ja     <shrink_slab_memcg+0x1cd>
> mov    0x8(%rsp),%edx
> mov    %r15,%rsi
> lea    0x10(%rsp),%rdi
> callq  ffffffff810cefd0 <do_shrink_slab>
> 
> Also, improve the comment.

All this isn't terribly nice.  Why can't we avoid installing the
shrinker into the idr until it is fully initialized?

Or extend the down_write(shrinker_rwsem) coverage so it protects the
entire initialization, instead of only in the prealloc_memcg_shrinker()
part of that initialization.  This is not as good - it would be better
to do all the initialization locklessly then just install the fully
initialized thing under the lock.

> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -170,6 +170,21 @@ static LIST_HEAD(shrinker_list);
>  static DECLARE_RWSEM(shrinker_rwsem);
>  
>  #ifdef CONFIG_MEMCG_KMEM
> +
> +/*
> + * There is a window between prealloc_shrinker()
> + * and register_shrinker_prepared(). We don't want
> + * to clear bit of a shrinker in such the state
> + * in shrink_slab_memcg(), since this will impose
> + * restrictions on a code registering a shrinker
> + * (they would have to guarantee, their LRU lists
> + * are empty till shrinker is completely registered).
> + * So, we use this value to detect the situation,
> + * when id is assigned, but shrinker is not completely
> + * registered yet.
> + */

This comment is still quite hard to understand.  Could you please spend
a little more time over it?


