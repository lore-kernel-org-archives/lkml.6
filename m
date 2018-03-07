Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965137AbeCGToo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 14:44:44 -0500
Received: from mail-it0-f52.google.com ([209.85.214.52]:55644 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965096AbeCGTog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 14:44:36 -0500
X-Google-Smtp-Source: AG47ELutPyKqhV8KuPets37HoI/T6nvKKKytA9UjoEavtuG2mWxsJ6ogoGCoFnWTBaXcRBf5fArigrdJ+aqRBwK5+M8=
MIME-Version: 1.0
In-Reply-To: <20180307161744.GA17562@gmail.com>
References: <20180307161744.GA17562@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 7 Mar 2018 11:44:35 -0800
X-Google-Sender-Auth: Z_eUwLQGG-1IVVBUrM7EU2sQTqw
Message-ID: <CA+55aFx+dcUPK4A19ewpjNKkes7AgmEuTcqY8wYopZ-31ujpjQ@mail.gmail.com>
Subject: Re: Invalid /proc/<pid>/fd/{0,1,2} symlinks with TIOCGPTPEER
To: Christian Brauner <christian.brauner@canonical.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 7, 2018 at 8:17 AM, Christian Brauner
<christian.brauner@canonical.com> wrote:
>
> unshare --mount
> mount --bind /dev/pts/ptmx /dev/ptmx
> chmod 666 /dev/ptmx

Oh. Why are you using a bind mount in the first place?

Anyway, I guess we just have to add another special case for this.

Which doesn't look horrible. Right now path_pts() just does

        ret = path_parent_directory(path);

and that simply doesn't work for a bind mount file.

I think we could just change path_parent_directory() to go through
file bind mounts. The other user is follow_dotdot(), but that always
takes a directory, so it wouldn't be affected.

But it's probably safer to just teach path_pts to just walk up the
bind mount first, and then do the existing path_parent_directory.

Anybody want to just try that thing?

            Linus
