Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751737AbeCUIxA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 04:53:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43406 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751539AbeCUIw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 04:52:56 -0400
Date: Wed, 21 Mar 2018 04:47:58 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH ghak21 V3 2/2] audit: add refused symlink to audit_names
Message-ID: <20180321084758.ncpjmvlvkbsgfgra@madcap2.tricolour.ca>
References: <cover.1521005283.git.rgb@redhat.com>
 <b55492688f43df914037c48314db483a3c6ad05b.1521005283.git.rgb@redhat.com>
 <CAHC9VhQSjhjEkdrXhFVgMmnhAeR3EB_LB8nc2QtXuySqrUSmLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhQSjhjEkdrXhFVgMmnhAeR3EB_LB8nc2QtXuySqrUSmLQ@mail.gmail.com>
User-Agent: NeoMutt/20171027
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-20 16:11, Paul Moore wrote:
> On Wed, Mar 14, 2018 at 1:43 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> > Audit link denied events for symlinks had duplicate PATH records rather
> > than just updating the existing PATH record.  Update the symlink's PATH
> > record with the current dentry and inode information.
> >
> > See: https://github.com/linux-audit/audit-kernel/issues/21
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> >  fs/namei.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 50d2533..00f5041 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -945,6 +945,7 @@ static inline int may_follow_link(struct nameidata *nd)
> >         if (nd->flags & LOOKUP_RCU)
> >                 return -ECHILD;
> >
> > +       audit_inode(nd->name, nd->stack[0].link.dentry, 0);
> >         audit_log_link_denied("follow_link", &nd->stack[0].link);
> 
> That's the one, right above this comment ...
> 
> Be honest, this never compiled did it?

As far as your view is concerned it wasn't.  It was compiled and tested,
but the fix ended up in the following patch in the branch that wasn't
included in this patchset so it effectively failed this bisection test.
The sample records were copied from the test and not cooked.  git add -p
and/or git rebase -i fumble.

> My confidence for these patches is really low right now, which is not
> good for something asking to go in at this stage in the -rcX
> development cycle.  There have been some delays due to review, so I'm
> willing to be a little flexible on timelines and accept stuff this
> week, but for the v4 patchset please provide before and after audit
> logs for both hard and soft links both where CWD is the same as the
> parent as well as different (eight logs total if I did the math
> right).  You can include them in the 0/2 patch as it's probably a bit
> much for the individual patches.

I'm very sorry to have wasted your time.  I know it is precious right now.

> >         return -EACCES;
> >  }
> 
> paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
