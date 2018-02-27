Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751634AbeB0Dgw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 22:36:52 -0500
Received: from mail-io0-f176.google.com ([209.85.223.176]:38989 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751507AbeB0Dgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 22:36:50 -0500
X-Google-Smtp-Source: AG47ELss/jICzcTMfWgH1va6UXoodvmaQC35/GRudKUeA2YcQPImtfSiKeJWxd2owRZ/fEY6mVXzYE0ZmlsIiOpMfkA=
MIME-Version: 1.0
In-Reply-To: <87r2p7rvn5.fsf@xmission.com>
References: <87po4rz4ui.fsf_-_@xmission.com> <20180226235302.12708-3-ebiederm@xmission.com>
 <CA+55aFySgJyR6JLcS9HLC9wEpWU1isdyTkchHxZHbJWsh7HFpg@mail.gmail.com> <87r2p7rvn5.fsf@xmission.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 26 Feb 2018 19:36:48 -0800
X-Google-Sender-Auth: -nKnweAw8x76Ioyruwq9CyN5L1A
Message-ID: <CA+55aFz+=zyuAcM3J5PfNNXqErf2x595eP=7tY_-p_L2ryr0rg@mail.gmail.com>
Subject: Re: [PATCH v7 3/7] fs/posix_acl: Document that get_acl respects ACL_DONT_CACHE
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alban Crequy <alban@kinvolk.io>,
        Seth Forshee <seth.forshee@canonical.com>,
        Sargun Dhillon <sargun@sargun.me>, Dongsu Park <dongsu@kinvolk.io>,
        "Serge E. Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 6:53 PM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> So the purpose for having a patch in the first place is that
> 2a3a2a3f3524 ("ovl: don't cache acl on overlay layer")
> which addded ACL_DONT_CACHED did not result in any comment updates
> to get_acl.

I'm not opposed to just updating the comments.

I just think your updates were somewhat misleading.

> Which mean that if you read the comments in get_acl() that you
> don't even think of ACL_DONT_CACHED.

Right. By all means add a comment about ACL_DONT_CACHE disabling the
cache entirely.

But don't _remove_ the other valid way to flush the cache, and don't
make that comment above cmpxchg() be even more confusing than the code
is.

> Does this look better as a comment updating patch?
>
> diff --git a/fs/posix_acl.c b/fs/posix_acl.c
> index 2fd0fde16fe1..5453094b8828 100644
> --- a/fs/posix_acl.c
> +++ b/fs/posix_acl.c
> @@ -98,6 +98,11 @@ struct posix_acl *get_acl(struct inode *inode, int type)
>         struct posix_acl **p;
>         struct posix_acl *acl;
>
> +       /*
> +        * To avoid caching the result of ->get_acl
> +        * set inode->i_acl = inode->i_default_acl = ACL_DONT_CACHE;
> +        */
> +
>         /*
>          * The sentinel is used to detect when another operation like
>          * set_cached_acl() or forget_cached_acl() races with get_acl().
> @@ -126,9 +131,7 @@ struct posix_acl *get_acl(struct inode *inode, int type)
>                 /* fall through */ ;
>
>         /*
> -        * Normally, the ACL returned by ->get_acl will be cached.
> -        * A filesystem can prevent that by calling
> -        * forget_cached_acl(inode, type) in ->get_acl.
> +        * The ACL returned by ->get_acl will be cached.

Why do you hate forget_cached_acl()?

It's perfectly valid too. Don't remove that comment. Maybe reword it
to talk not about "preventing", but about "invalidating the cache".

But the old comment that you remove isn't _wrong_, it's just that the
"preventing" from returning the cached state with forget_cached_acl()
is just a one-time thing.

So forget_cached_acl() exists, and it works, and it does exactly what
its name says. It is a perfectly valid way to prevent the current
entry from being used in the future.

See? I object to you removing that, and trying to make it be like
ACL_DONT_CACHE is the *onyl* way to not cache something.

Because honestly, that's what your comment updates do. They take the
comments about _one_ case, and switch it over to be about the _othger_
case.

But dammit, there are _two_ ways to not cache things.

"Fixing" the comment to talk about one and removing the other isn't a
fix. It's just a stupid change that now has the problem the other way
around!

So fix the comment to really just talk about both things.

First: talk about how to avoid caching entirely (ACL_DONT_CACHE).
Then, talk about how to invalidate the cache once it has been
instantiated (forget_cached_acl()).

Don't do this idiotic "remove the valid comment just because you
happened to care about the _other_ case"


              Linus
