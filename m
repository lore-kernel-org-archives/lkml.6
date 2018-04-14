Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752139AbeDNVrY (ORCPT <rfc822;w@1wt.eu>);
        Sat, 14 Apr 2018 17:47:24 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:39862 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752046AbeDNVrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Apr 2018 17:47:22 -0400
X-Google-Smtp-Source: AIpwx4+DOHHKMjEZ9ukfqgJOEgZwrYsqE6FhC4keYK2bmWzgbTyQb4MUM8wpMfsCVaR1f0HkOKHsT2HvDvSace7glns=
MIME-Version: 1.0
In-Reply-To: <20180414205846.GW30522@ZenIV.linux.org.uk>
References: <20180413181350.88831-1-khazhy@google.com> <20180413202823.204377-1-khazhy@google.com>
 <20180413141430.2788e2562e3e24bd273fe78b@linux-foundation.org>
 <3362fb2d-85ff-86af-399f-698c986e46cc@suse.com> <20180414080206.GV30522@ZenIV.linux.org.uk>
 <CA+55aFz4fwzcUWWT78AxK+GeVNVveWPNS+=V+ppb1ksn56TjUA@mail.gmail.com> <20180414205846.GW30522@ZenIV.linux.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 14 Apr 2018 14:47:21 -0700
X-Google-Sender-Auth: KtCA0tWCQ6N52vJSRJ-MljtPo4c
Message-ID: <CA+55aFxD1xKqbobvoHQUWc5jc9n7-7KXYeSQy-CpE0SUZHi0PQ@mail.gmail.com>
Subject: Re: [PATCH] fs/dcache.c: re-add cond_resched() in shrink_dcache_parent()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Nikolay Borisov <nborisov@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Rientjes <rientjes@google.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>, Jeff Mahoney <jeffm@suse.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 14, 2018 at 1:58 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> That breaks d_invalidate(), unfortunately.  Look at the termination
> conditions in the loop there...

Ugh. I was going to say "but that doesn't even use select_collect()",
but yeah, detach_and_collect() calls it.

It would be easy enough to just change the

                if (!list_empty(&data.select.dispose))

there to

                if (!list_empty(&data.select.found))

too.

In fact, it probably *should* do that, exactly to get the whole
"cond_resched()" call in that whole call chain too. Because as-is, it
looks like it has the same issue as shrink_dcache_parent() does..

But yeah, the fact that I didn't notice that makes me a bit nervous.
But now I triple-checked, there are no other indirect callers.

            Linus
