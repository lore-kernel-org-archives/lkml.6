Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932478AbeCMAhV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 20:37:21 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:41447 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932261AbeCMAhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 20:37:16 -0400
X-Google-Smtp-Source: AG47ELuN/ZYrn7ff8HgXsXCmiwxYiJzkb7vFOPeWCcr8UUkK0dlpUp5BZeTJ6eNeju3tqyQlvmaCnzRQtFwVfB2kpgE=
MIME-Version: 1.0
In-Reply-To: <20180313000131.28971-3-christian.brauner@ubuntu.com>
References: <20180313000131.28971-1-christian.brauner@ubuntu.com> <20180313000131.28971-3-christian.brauner@ubuntu.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 12 Mar 2018 17:37:14 -0700
X-Google-Sender-Auth: __VmzQ-5xm28UUehmvhU_aIxRzU
Message-ID: <CA+55aFwZ5ef0EAM4XqTpGQ39iBGF0Ff45aH6k7BfSKXXVJcrzg@mail.gmail.com>
Subject: Re: [PATCH 2/3 v4] devpts: resolve devpts bind-mounts
To: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 5:01 PM, Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> ChangeLog v3->v4:
> * simplify if condition

Ok, I definitely prefer this simpler version.

We could simplify it even more, though. That end could be just

        ...
        dput(path.dentry);
        if (!err) {
                if (DEVPTS_SB(path.mnt->mnt_sb) == fsi)
                        return path.mnt;
                err = -ENODEV;
        }

        mntput(path.mnt);
        return ERR_PTR(err);

instead.

And it might be worth adding a comment that devpts_ptmx_path() always
returns a DEVPTS filesystem of an error. I already wrote out "that's
not right, you can't do DEVPTS_SB() without checking s_magic", but
devpts_ptmx_path() will have done that already.

             Linus
