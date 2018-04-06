Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752750AbeDFMrR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 08:47:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42437 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752021AbeDFMrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 08:47:16 -0400
X-Google-Smtp-Source: AIpwx49OkwmJT6dgmldhZ4iG4Wi1tUArtqzSbc17XiWGQtZHOOPjRwHYyLvJRl5IHfWkC4mRwgSfoQ==
From: Christian Brauner <christian.brauner@canonical.com>
X-Google-Original-From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Fri, 6 Apr 2018 14:47:12 +0200
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3 RESEND] namei: add follow_up_bind()
Message-ID: <20180406124711.GA9263@gmail.com>
References: <20180405105103.21572-1-christian.brauner@ubuntu.com>
 <CA+55aFzb7xzsOb=vfrwDFTX0SToOe1esgj2B1YNMPTDPUa8Nnw@mail.gmail.com>
 <20180405174455.GA27462@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180405174455.GA27462@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05, 2018 at 07:45:15PM +0200, Christian Brauner wrote:
> On Thu, Apr 05, 2018 at 09:28:56AM -0700, Linus Torvalds wrote:
> > On Thu, Apr 5, 2018 at 3:51 AM, Christian Brauner
> > <christian.brauner@ubuntu.com> wrote:
> > >
> > > This series adds:
> > > - follow_up_bind() to namei.{c,h}
> > > - switches fs/nfsd/vfs.c:follow_to_parent() to use follow_up_bind()
> > > - switches fs/devpts/inode.c:devpts_mntget() to use follow_up_bind()
> > 
> > Hmm. Seems fair enough to me, although I wonder how much this really
> > helps. It does get rid of a duplicate code pattern, but:
> > 
> >  4 files changed, 14 insertions(+), 5 deletions(-)
> > 
> > and while some of that is just the new comment, some of it is just "overhead".
> 
> Fwiw, it does get read of these while loops in two places but I
> personally see the biggest value in making it obvious what bind-mount
> resolution means.
> 
> > 
> > It's also a bit odd how the new helper is marked "inline", but nobody
> > will inline it because it's not actually in the header file or any of
> > the isers in the same C file. So instead, it has to be exported. I
> > wonder if it should just be a trivial inline in <linux/namei.h>? Maybe
> > it originally was, and that's where the inline came from, and then
> > Christian decided to make it be by the regular "follow_up()" instead?
> 
> I head it inline first but it would have required to forward declare
> struct vfsmount in the head and I wasn't sure if that was going to fly.
> But I explicitly left the inline in there because I was following
> user_path_create() ([1], [2]) which does the same. But if that's an
> issue I can make it static inline in the header like I had, forward
> declare struct vfsmount and remove the unnecessary inline from
> user_path_create() in a separate patch unless there's a specific reason
> to leave it in there.
> 
> [1]: https://elixir.bootlin.com/linux/latest/source/include/linux/namei.h#L79
> [2]: https://elixir.bootlin.com/linux/latest/source/fs/namei.c#L3680

In case that wasn't clear from the previous message: I'd wait for a go
ahead on this if that's ok.

Christian

> 
> > 
> > But with all that said, I certainly don't *mind* the patch series.
> 
> Cool.
> 
> Thanks!
> Christian
> 
> > 
> > Al, I'm leaving this up to you, and expect to get it from your vfs
> > tree eventually. Or not.
> > 
> >                       Linus
