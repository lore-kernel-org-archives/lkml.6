Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752888AbeDOSeU (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 14:34:20 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:46023 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752527AbeDOSeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 14:34:18 -0400
X-Google-Smtp-Source: AIpwx49gNoa++zbcRKmbfUBRUMOdkuKgQDlvML9j+G720zyiTYR1ZdPALSmxz0fsRHO+lW19qo4E+yJ6ePosKqfyKsg=
MIME-Version: 1.0
In-Reply-To: <20180415005056.GX30522@ZenIV.linux.org.uk>
References: <20180413181350.88831-1-khazhy@google.com> <20180413202823.204377-1-khazhy@google.com>
 <20180413141430.2788e2562e3e24bd273fe78b@linux-foundation.org>
 <3362fb2d-85ff-86af-399f-698c986e46cc@suse.com> <20180414080206.GV30522@ZenIV.linux.org.uk>
 <CA+55aFz4fwzcUWWT78AxK+GeVNVveWPNS+=V+ppb1ksn56TjUA@mail.gmail.com>
 <20180414205846.GW30522@ZenIV.linux.org.uk> <CA+55aFxD1xKqbobvoHQUWc5jc9n7-7KXYeSQy-CpE0SUZHi0PQ@mail.gmail.com>
 <20180415005056.GX30522@ZenIV.linux.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 15 Apr 2018 11:34:17 -0700
X-Google-Sender-Auth: -74GhxaSDtpvH5kD8KXmrmb3VKc
Message-ID: <CA+55aFwB0A-F8HW=QZu9O7Mtt4ryB1prB6cwh+6cwHv9b5bLNw@mail.gmail.com>
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

On Sat, Apr 14, 2018 at 5:51 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>>                 if (!list_empty(&data.select.found))

That was obviously meant to be just

                if (data.select.found)

I had just cut-and-pasted a bit too much.

> You would have to do the same in check_and_drop() as well,
> and that brings back d_invalidate()/d_invalidate() livelock
> we used to have.  See 81be24d263db...

Ugh. These are all really incestuous and very intertwined. Yes.

> I'm trying to put something together, but the damn thing is
> full of potential livelocks, unfortunately ;-/  Will send
> a followup once I have something resembling a sane solution...

Ok, that patch of yours looks like a nice cleanup, although *please*
don't do this:

-       struct detach_data *data = _data;
-
        if (d_mountpoint(dentry)) {
                __dget_dlock(dentry);
-               data->mountpoint = dentry;
+               *(struct dentry **)_data = dentry;

Please keep the temporary variable, and make it do

+       struct dcache **victim = _victim;
...
+               *victim = dentry;

to kind of match the caller, which does

                d_walk(dentry, &victim, find_submount);

because I abhor those casts inside code, and we have a pattern of
passing 'void *_xyz' to callback functions and then making the right
type by that kind of

        struct right_type *xyz = _xyz;

at the very top of the function.

No, it's obviously not type-safe, but at least it's _legible_, and is
a pattern, while that "let's randomly just do a cast in the middle of
the code" is just nasty.

Side note: I do feel like "d_walk()" should be returning whether it
terminated early or not. For example, this very same code in the
caller does

+               struct dentry *victim = NULL;
+               d_walk(dentry, &victim, find_submount);
+               if (!victim) {

but in many ways it would be more natural to just check the exit condition, and

+               struct dentry *victim;
+               if (!d_walk(dentry, &victim, find_submount)) {

don't you think? Because that matches the actual setting condition in
the find_submount() callback.

There are other situations where the same thing is true: that
path_check_mount() currently has that "info->mounted" flag, but again,
it could be replaced by just checking what the quit condition was, and
whether we terminated early or not. Because the two are 100%
equivalent, and the return value in many ways would be more logical, I
feel.

(I'm not sure if we should just return the actual exit condition -
defaulting to D_WALK_CONTINUE if there was nothing to walk at all - or
whether we should just return a boolean for "terminated early")

Hmm?

                    Linus
