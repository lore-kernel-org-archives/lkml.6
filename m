Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932491AbeCKVq3 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 17:46:29 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:50977 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932161AbeCKVq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 17:46:27 -0400
X-Google-Smtp-Source: AG47ELtXEAnuaBIOfVXkvybseCWDHCMK5dHa818QtdUpUhvrwQCVWdeqoHHedzorJ3iQ0RYCrm+1bHTjhDXmaArU0/4=
MIME-Version: 1.0
In-Reply-To: <20180311210537.3674-1-christian.brauner@ubuntu.com>
References: <20180311210537.3674-1-christian.brauner@ubuntu.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 11 Mar 2018 14:46:26 -0700
X-Google-Sender-Auth: weW2ubdGc_olrWjChkhsf5cM1wo
Message-ID: <CA+55aFxH0O4tXtOux0kajrhCHGo0NcUT1jTvT-O0prfsegyp_A@mail.gmail.com>
Subject: Re: [PATCH 0/3 v2] devpts: handle /dev/ptmx bind-mounts
To: Christian Brauner <christian.brauner@ubuntu.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 11, 2018 at 2:05 PM, Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> This is the second iteration of this patch.

This looks good to me. Just wondering how this should be merged, and
whether we should have a Cc: stable for it?

.. and, just in case, maybe Al can verify that there's nothing subtle
about follow_up() that we need to worry about. That said, NFS already
has that exact same loop for follow_to_parent(), just syntactically
slightly different version.

In fact, I wonder if we even need to do that

        if ((DEVPTS_SB(path.mnt->mnt_sb) == fsi) &&
            (path.mnt->mnt_root == fsi->ptmx_dentry)) {

and maybe we could do the follow_up() loop unconditionally?

Because if the ptmx dentry is *not* a bind mount, then the loop will
be a no-op, and if it *is* a bind-mount, then I'm not convinced we
should even try to just limit it to the devpts case - maybe somebody
did a bind-mount on just a legacy ptmx device node?

So that "if()" actually seems to be to be superfluous, and only limit
the "follow bind mounts' case unnecessarily. Hmm?

           Linus
