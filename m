Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751664AbeB0BOD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 20:14:03 -0500
Received: from mail-io0-f173.google.com ([209.85.223.173]:39934 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751604AbeB0BOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 20:14:00 -0500
X-Google-Smtp-Source: AG47ELvImKWRZ03z2jpoLpjKyWFoUc0M+oW7bAjjHMFAHA4G86K1GMZxvtS89XAmqq0z4MBPtQ/e0XCTH3+MKlZteXY=
MIME-Version: 1.0
In-Reply-To: <20180226235302.12708-3-ebiederm@xmission.com>
References: <87po4rz4ui.fsf_-_@xmission.com> <20180226235302.12708-3-ebiederm@xmission.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 26 Feb 2018 17:13:59 -0800
X-Google-Sender-Auth: u-_feA-tkg-0c-ZQyAtif2kqLrQ
Message-ID: <CA+55aFySgJyR6JLcS9HLC9wEpWU1isdyTkchHxZHbJWsh7HFpg@mail.gmail.com>
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

On Mon, Feb 26, 2018 at 3:52 PM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> Additionaly update the comment above the call to get_acl itself and
> remove the wrong information that an implementation of get_acl can
> prevent caching by calling forget_cached_acl.

This part is just confusing.

First off, that comment is correct: a filesystem _can_ prevent the
returning of cached data by just calling forget_cached_acl().

Note that there are two different cases: saying that you _never_ want
to cache things (ACL_DONT_CACHE) and saying that there _currently_ is
no cached data (ACL_NOT_CACHED).

forget_cached_acl() just removes the current cache.

You're just replacing one case of "no cached" information with the other.

Just explain the two cases, don't try to muddy the waters even more..

PLUS you are just confusing things entirely. That whole new comment of yours:

+        * ACL_DONT_CACHE is treated as another task updating the acl and
+        * remains set.

is just garbage.

The code is very clear - it will only replace a ACL_NOT_CACHED entry.
The code is clear:

        if (cmpxchg(p, ACL_NOT_CACHED, sentinel) != ACL_NOT_CACHED)
                /* fall through */ ;

this is basically just an atomic "if *p == ACL_NOT_CACHED then replace
it with 'sentinel'".

Your comment does not add any clarity at all, and only confuses
things. It has nothing to do with "treated as another task updating
the acl".

The fact is, ACL_DONT_CACHE is treated as if the cache is simply
already filled - it's just filled with "no cache".

So the only thing special is ACL_NOT_CACHED, which is the only thing
we will try to _replace_.

So NAK on this patch entirely. It's just adding confusion, not adding
clarifications.

                Linus
