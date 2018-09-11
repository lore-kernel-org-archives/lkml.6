Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0F9C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 22:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F113620880
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 22:09:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F113620880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fromorbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbeILDKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 23:10:23 -0400
Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:7464 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727796AbeILDKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 23:10:23 -0400
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail06.adl2.internode.on.net with ESMTP; 12 Sep 2018 07:38:58 +0930
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1fzqq9-0003uG-HK; Wed, 12 Sep 2018 08:08:57 +1000
Date:   Wed, 12 Sep 2018 08:08:57 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Larry Woodman <lwoodman@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Wangkai (Kevin C)" <wangkai86@huawei.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v3 3/4] fs/dcache: Track & report number of negative
 dentries
Message-ID: <20180911220857.GG5631@dastard>
References: <1536693506-11949-1-git-send-email-longman@redhat.com>
 <1536693506-11949-4-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536693506-11949-4-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 03:18:25PM -0400, Waiman Long wrote:
> The current dentry number tracking code doesn't distinguish between
> positive & negative dentries. It just reports the total number of
> dentries in the LRU lists.
> 
> As excessive number of negative dentries can have an impact on system
> performance, it will be wise to track the number of positive and
> negative dentries separately.
> 
> This patch adds tracking for the total number of negative dentries
> in the system LRU lists and reports it in the 7th field in the

Not the 7th field anymore.

> /proc/sys/fs/dentry-state file. The number, however, does not include
> negative dentries that are in flight but not in the LRU yet as well
> as those in the shrinker lists.
> 
> The number of positive dentries in the LRU lists can be roughly found
> by subtracting the number of negative dentries from the unused count.
> 
> Matthew Wilcox had confirmed that since the introduction of the
> dentry_stat structure in 2.1.60, the dummy array was there, probably for
> future extension. They were not replacements of pre-existing fields. So
> no sane applications that read the value of /proc/sys/fs/dentry-state
> will do dummy thing if the last 2 fields of the sysctl parameter are
> not zero. IOW, it will be safe to use one of the dummy array entry for
> negative dentry count.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
....
> ---
>  Documentation/sysctl/fs.txt | 26 ++++++++++++++++----------
>  fs/dcache.c                 | 31 +++++++++++++++++++++++++++++++
>  include/linux/dcache.h      |  7 ++++---
>  3 files changed, 51 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/sysctl/fs.txt b/Documentation/sysctl/fs.txt
> index 819caf8..3b4f441 100644
> --- a/Documentation/sysctl/fs.txt
> +++ b/Documentation/sysctl/fs.txt
> @@ -56,26 +56,32 @@ of any kernel data structures.
>  
>  dentry-state:
>  
> -From linux/fs/dentry.c:
> +From linux/include/linux/dcache.h:
>  --------------------------------------------------------------
> -struct {
> +struct dentry_stat_t dentry_stat {
>          int nr_dentry;
>          int nr_unused;
>          int age_limit;         /* age in seconds */
>          int want_pages;        /* pages requested by system */
> -        int dummy[2];
> -} dentry_stat = {0, 0, 45, 0,};
> --------------------------------------------------------------- 
> -
> -Dentries are dynamically allocated and deallocated, and
> -nr_dentry seems to be 0 all the time. Hence it's safe to
> -assume that only nr_unused, age_limit and want_pages are
> -used. Nr_unused seems to be exactly what its name says.
> +        int nr_negative;       /* # of unused negative dentries */
> +        int dummy;	       /* Reserved */

/* reserved for future use */

....
> @@ -331,6 +343,8 @@ static inline void __d_clear_type_and_inode(struct dentry *dentry)
>  	flags &= ~(DCACHE_ENTRY_TYPE | DCACHE_FALLTHRU);
>  	WRITE_ONCE(dentry->d_flags, flags);
>  	dentry->d_inode = NULL;
> +	if (dentry->d_flags & DCACHE_LRU_LIST)
> +		this_cpu_inc(nr_dentry_negative);
>  }
>  
>  static void dentry_free(struct dentry *dentry)
> @@ -385,6 +399,10 @@ static void dentry_unlink_inode(struct dentry * dentry)
>   * The per-cpu "nr_dentry_unused" counters are updated with
>   * the DCACHE_LRU_LIST bit.
>   *
> + * The per-cpu "nr_dentry_negative" counters are only updated
> + * when deleted or added to the per-superblock LRU list, not
> + * on the shrink list.

This tells us what the code is doing, but it doesn't explain why
a different accounting method to nr_dentry_unused was chosen. What
constraints require the accounting to be done this way rather than
just mirror the unused dentry accounting?

> @@ -1836,6 +1862,11 @@ static void __d_instantiate(struct dentry *dentry, struct inode *inode)
>  	WARN_ON(d_in_lookup(dentry));
>  
>  	spin_lock(&dentry->d_lock);
> +	/*
> +	 * Decrement negative dentry count if it was in the LRU list.
> +	 */
> +	if (dentry->d_flags & DCACHE_LRU_LIST)
> +		this_cpu_dec(nr_dentry_negative);
>  	hlist_add_head(&dentry->d_u.d_alias, &inode->i_dentry);
>  	raw_write_seqcount_begin(&dentry->d_seq);
>  	__d_set_inode_and_type(dentry, inode, add_flags);
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index ef4b70f..73ff9f0 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -62,9 +62,10 @@ struct qstr {
>  struct dentry_stat_t {
>  	long nr_dentry;
>  	long nr_unused;
> -	long age_limit;          /* age in seconds */
> -	long want_pages;         /* pages requested by system */
> -	long dummy[2];
> +	long age_limit;		/* age in seconds */
> +	long want_pages;	/* pages requested by system */
> +	long nr_negative;	/* # of unused negative dentries */
> +	long dummy;		/* Reserved */

/* reserved for future use */

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
