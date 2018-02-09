Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752167AbeBISdS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 13:33:18 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:34694 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751004AbeBISdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 13:33:16 -0500
X-Google-Smtp-Source: AH8x225RidPQckuZ2ObCAjbxhmMilunrGKFET7u//gFhdc0hljUybTOOl9YibtwBrIMlifz97VPfeR6gzXp+cU5aVqM=
MIME-Version: 1.0
In-Reply-To: <1517851938-5892-1-git-send-email-amir73il@gmail.com>
References: <1517851938-5892-1-git-send-email-amir73il@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 9 Feb 2018 10:33:15 -0800
X-Google-Sender-Auth: ObH1ktaZ_ovoecS1blEeYnu4QMw
Message-ID: <CA+55aFz34O6dA6fYy36yYA0w==dwkLX6UOCnTrioCO6__+rajQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] <linux/stringhash.h>: fix end_name_hash() for 64bit long
To: Amir Goldstein <amir73il@gmail.com>
Cc: George Spelvin <linux@sciencehorizons.net>,
        Al Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 5, 2018 at 9:32 AM, Amir Goldstein <amir73il@gmail.com> wrote:
> The comment claims that this helper will try not to loose bits, but
> for 64bit long it looses the high bits before hashing 64bit long into
> 32bit int. Use the helper hash_long() to do the right thing for 64bit
> long. For 32bit long, there is no change.

Ok, sorry for the delay, I only got back to this now because the merge
window is calming down (famous last words - sometimes Friday ends up
being busy, but I might decide that it's too late if somebody sends me
an annoying late pull request now).

And after having looked more at it, I take back all my complaints
about the patch, you were right and I was mis-reading things or just
being stupid.

I also don't worry too much about the possible performance impact of
this on 64-bit, since most architectures that actually care about
performance end up not using this very much (the dcache code is the
most performance-critical, but the word-at-a-time case uses its own
hashing anyway).

So this ends up being mostly used for filesystems that do their own
degraded hashing (usually because they want a case-insensitive
comparison function).

A _tiny_ worry remains, in that not everybody uses DCACHE_WORD_ACCESS,
and then this potentially makes things more expensive on 64-bit
architectures with slow or lacking multipliers even for the normal
case.

That said, realistically the only such architecture I can think of is
PA-RISC. Nobody really cares about performance on that, it's more of a
"look ma, I've got warts^W an odd machine" platform.

So I think your patch is fine, and all my initial worries were just
misplaced from not looking at this properly.

Sorry.

I *would* love to get some kind of estimate on how this changes the
hash distribution. Do you have anything like that? The way this
function is designed to be used, the upper bits should be used for the
hash bucket information, so doing some bucket size distribution on
(say) the upper ~12 bits or something with some real string input
would be really good.

                Linus
