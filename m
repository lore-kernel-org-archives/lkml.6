Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752055AbeCCN5w (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 08:57:52 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:41430 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751994AbeCCN5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 08:57:51 -0500
X-Google-Smtp-Source: AG47ELvWYBoGJK3XoYPnYcuWgzW/mQCaOg/aocXyVC3p7BB7N4WVlQMLCe2yWH6u+YGbRNRktZsqPQ==
Message-ID: <1520085468.4280.22.camel@redhat.com>
Subject: Re: [PATCH v7 07/61] fscache: Use appropriate radix tree accessors
From: Jeff Layton <jlayton@redhat.com>
To: Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <mawilcox@microsoft.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Date: Sat, 03 Mar 2018 08:57:48 -0500
In-Reply-To: <20180219194556.6575-8-willy@infradead.org>
References: <20180219194556.6575-1-willy@infradead.org>
         <20180219194556.6575-8-willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5 (3.26.5-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-02-19 at 11:45 -0800, Matthew Wilcox wrote:
> From: Matthew Wilcox <mawilcox@microsoft.com>
> 
> Don't open-code accesses to data structure internals.
> 
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
> ---
>  fs/fscache/cookie.c | 2 +-
>  fs/fscache/object.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
> index ff84258132bb..e9054e0c1a49 100644
> --- a/fs/fscache/cookie.c
> +++ b/fs/fscache/cookie.c
> @@ -608,7 +608,7 @@ void __fscache_relinquish_cookie(struct fscache_cookie *cookie, bool retire)
>  	/* Clear pointers back to the netfs */
>  	cookie->netfs_data	= NULL;
>  	cookie->def		= NULL;
> -	BUG_ON(cookie->stores.rnode);
> +	BUG_ON(!radix_tree_empty(&cookie->stores));
>  
>  	if (cookie->parent) {
>  		ASSERTCMP(atomic_read(&cookie->parent->usage), >, 0);
> diff --git a/fs/fscache/object.c b/fs/fscache/object.c
> index 7a182c87f378..aa0e71f02c33 100644
> --- a/fs/fscache/object.c
> +++ b/fs/fscache/object.c
> @@ -956,7 +956,7 @@ static const struct fscache_state *_fscache_invalidate_object(struct fscache_obj
>  	 * retire the object instead.
>  	 */
>  	if (!fscache_use_cookie(object)) {
> -		ASSERT(object->cookie->stores.rnode == NULL);
> +		ASSERT(radix_tree_empty(&object->cookie->stores));
>  		set_bit(FSCACHE_OBJECT_RETIRED, &object->flags);
>  		_leave(" [no cookie]");
>  		return transit_to(KILL_OBJECT);

Reviewed-by: Jeff Layton <jlayton@redhat.com>
