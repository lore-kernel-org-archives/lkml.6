Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932449AbeCLVwr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 17:52:47 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:50568 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932265AbeCLVwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 17:52:46 -0400
X-Google-Smtp-Source: AG47ELvTJOG3Vfpg9zJfVnebkvliv6KRB1mwKv7K5UJPJ+d1BbZxNQV5RnSzUTpw211kx282kOJZUSRpWwyqJK2MfM4=
MIME-Version: 1.0
In-Reply-To: <20180312201022.GA16689@gmail.com>
References: <20180312171330.32054-1-christian.brauner@ubuntu.com>
 <20180312171330.32054-3-christian.brauner@ubuntu.com> <87a7vdf4ve.fsf@xmission.com>
 <20180312201022.GA16689@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 12 Mar 2018 14:52:44 -0700
X-Google-Sender-Auth: E9xw32rAvD3lmDAhk1wTSyXcRa8
Message-ID: <CA+55aFzRbM9NiDThT-WrFQ_emmumcxyAF1SRsDZL2nYdJVy55w@mail.gmail.com>
Subject: Re: [PATCH 2/3 v3] devpts: resolve devpts bind-mounts
To: Christian Brauner <christian.brauner@canonical.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 1:10 PM, Christian Brauner
<christian.brauner@canonical.com> wrote:
>>
>> So let's just change the behavior of devpts_mntget error if a mount with
>> the pty underneath it can not be found.
>
> I'm sort of torn but I think I'd prefer changing the behavior too. The
> /dev/ptmx, /dev/pts/ptmx schisma is really a special case and I would
> like it to be the only one. I really don't want to support bind-mounting
> the ptmx character device under the devpts mounts across the system.
> That seems like unnecessary complexity that is also unused. So if Linus
> is fine with this change as well I don't mind sending a v4.

I'm fine with whatever error handling - I cannot imagine that it matters.

And if it does, and somebody finds somebody who depends on insane
behavior, we can revisit it then,

But fundamentally. I think there are only two valid situations:

 - people use devpts as-is (so the ptmx node is inherently in the same
subdirectory as the pts nodes, and is fundamentally the same
filesystem)

   NOTE! In this case, the ptmx node is *never* a bind-mount. It is
simply part of the pts directory as exported by devpts.

   This is the "people actually use /dev/pts/ptmx" case. It's fairly
rare, I think.

 - the parent directory ptmx node is an arbitrary ptmx node (symlink,
bind mount, or mknod)

   NOTE! In this case, the ptmx node is not necessarily associated
with the pts directory in any way, and the only thing that matters is
that it's the right special character device.

Honestly, I personally detest case #1, even if some people think it's
the "clean" case. It isn't particularly clean, since it fundamentally
is not how /dev/ptmx has traditionally ever worked. It would have been
clean had that been how ptmx worked traditionally, but that' ssimply
not the case.

But if something really odd happens, and we cannot find a pts
subdirectory, or there is not a pts node, or not a ptmx node in that
subdirectory, I think all bets are pretty much off path-wise.
Returning an error is probably better than returning a bogus path.

                 Linus
