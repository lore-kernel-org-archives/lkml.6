Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935487AbeCHITJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 03:19:09 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:45131 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934158AbeCHITI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 03:19:08 -0500
X-Google-Smtp-Source: AG47ELsYzlU7lHeB8scJSAG2z05LRqpwO6qr5E9HI9l33KBFOQuHsjqpxI/v+oD+9isOgeX/wKEZfA==
From: Christian Brauner <christian.brauner@canonical.com>
X-Google-Original-From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Thu, 8 Mar 2018 09:19:04 +0100
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: Invalid /proc/<pid>/fd/{0,1,2} symlinks with TIOCGPTPEER
Message-ID: <20180308081903.GC22728@gmail.com>
References: <20180307161744.GA17562@gmail.com>
 <CA+55aFx+dcUPK4A19ewpjNKkes7AgmEuTcqY8wYopZ-31ujpjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFx+dcUPK4A19ewpjNKkes7AgmEuTcqY8wYopZ-31ujpjQ@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07, 2018 at 11:44:35AM -0800, Linus Torvalds wrote:
> On Wed, Mar 7, 2018 at 8:17 AM, Christian Brauner
> <christian.brauner@canonical.com> wrote:
> >
> > unshare --mount
> > mount --bind /dev/pts/ptmx /dev/ptmx
> > chmod 666 /dev/ptmx
> 
> Oh. Why are you using a bind mount in the first place?

Containers employing user namespaces can't mknod() and because of the
way some LSMs check access permissions (path-based AppArmor being one
example) a symlink to /dev/pts/ptmx won't work either so a bind-mount
seems like the most reliable solution.

> 
> Anyway, I guess we just have to add another special case for this.
> 
> Which doesn't look horrible. Right now path_pts() just does
> 
>         ret = path_parent_directory(path);
> 
> and that simply doesn't work for a bind mount file.
> 
> I think we could just change path_parent_directory() to go through
> file bind mounts. The other user is follow_dotdot(), but that always
> takes a directory, so it wouldn't be affected.
> 
> But it's probably safer to just teach path_pts to just walk up the
> bind mount first, and then do the existing path_parent_directory.
> 
> Anybody want to just try that thing?

Sure. I can try and take a look.

Christian
