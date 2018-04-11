Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752836AbeDKA7s (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 20:59:48 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:44774 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752754AbeDKA7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 20:59:47 -0400
Date: Wed, 11 Apr 2018 01:59:38 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Michal Hocko <mhocko@suse.com>,
        syzbot <syzbot+5a170e19c963a2e0df79@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, linux-mm <linux-mm@kvack.org>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: WARNING in kill_block_super
Message-ID: <20180411005938.GN30522@ZenIV.linux.org.uk>
References: <001a114043bcfab6ab05689518f9@google.com>
 <6c95e826-4b9f-fb21-b311-830411e58480@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c95e826-4b9f-fb21-b311-830411e58480@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2018 at 07:53:07PM +0900, Tetsuo Handa wrote:
> Al and Michal, are you OK with this patch?

First of all, it does *NOT* fix the problems with careless ->kill_sb().
The fuse-blk case is the only real rationale so far.  Said that,

> @@ -166,6 +166,7 @@ static void destroy_unused_super(struct super_block *s)
>  	security_sb_free(s);
>  	put_user_ns(s->s_user_ns);
>  	kfree(s->s_subtype);
> +	kfree(s->s_shrink.nr_deferred);

is probably better done with an inlined helper (fs/super.c has no business knowing
about ->nr_deferred name, and there probably will be other users of that
preallocation of yours).  And the same helper would be better off zeroing the
pointer, same as unregister_shrinker() does.


> -int register_shrinker(struct shrinker *shrinker)
> +int prepare_shrinker(struct shrinker *shrinker)

preallocate_shrinker(), perhaps?

> +int register_shrinker(struct shrinker *shrinker)
> +{
> +	int err = prepare_shrinker(shrinker);
> +
> +	if (err)
> +		return err;
> +	register_shrinker_prepared(shrinker);

	if (!err)
		register_....;
	return err;

would be better, IMO.
