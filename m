Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753223AbeDPSBC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 14:01:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35206 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752177AbeDPSBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 14:01:01 -0400
Date: Mon, 16 Apr 2018 13:55:04 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Kees Cook <keescook@chromium.org>
Cc: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Eric Paris <eparis@redhat.com>,
        Paul Moore <paul@paul-moore.com>, Steve Grubb <sgrubb@redhat.com>
Subject: Re: [PATCH ghak21 V4 1/2] audit: remove path param from link denied
 function
Message-ID: <20180416175504.ldn62amrk7oxogia@madcap2.tricolour.ca>
References: <cover.1521620371.git.rgb@redhat.com>
 <20dd27aecaac4a158acecb9dbb5365327f0696ec.1521620371.git.rgb@redhat.com>
 <CAGXu5jJrCntv1fGLtVALyh5+UGdn5DvCkM230Vn7QGutY8k1og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jJrCntv1fGLtVALyh5+UGdn5DvCkM230Vn7QGutY8k1og@mail.gmail.com>
User-Agent: NeoMutt/20171027
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-16 10:55, Kees Cook wrote:
> On Wed, Mar 21, 2018 at 1:42 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> > In commit 45b578fe4c3cade6f4ca1fc934ce199afd857edc
> > ("audit: link denied should not directly generate PATH record")
> > the need for the struct path *link parameter was removed.
> > Remove the now useless struct path argument.
> >
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> >  fs/namei.c            | 4 ++--
> >  include/linux/audit.h | 6 ++----
> >  kernel/audit.c        | 3 +--
> >  3 files changed, 5 insertions(+), 8 deletions(-)
> >
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 9cc91fb..e3682bb 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -945,7 +945,7 @@ static inline int may_follow_link(struct nameidata *nd)
> >         if (nd->flags & LOOKUP_RCU)
> >                 return -ECHILD;
> >
> > -       audit_log_link_denied("follow_link", &nd->stack[0].link);
> > +       audit_log_link_denied("follow_link");
> >         return -EACCES;
> >  }
> >
> > @@ -1011,7 +1011,7 @@ static int may_linkat(struct path *link)
> >         if (safe_hardlink_source(inode) || inode_owner_or_capable(inode))
> >                 return 0;
> >
> > -       audit_log_link_denied("linkat", link);
> > +       audit_log_link_denied("linkat");
> >         return -EPERM;
> >  }
> 
> This removed the "link" details in both cases, and then commit
> ea841bafda3f ("audit: add refused symlink to audit_names") added back
> one of them:
> 
> > diff --git a/fs/namei.c b/fs/namei.c
> > index e3682bb72cb5..5f8e8e2732e1 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -945,6 +945,7 @@ static inline int may_follow_link(struct nameidata *nd)
> >         if (nd->flags & LOOKUP_RCU)
> >                 return -ECHILD;
> >
> > +       audit_inode(nd->name, nd->stack[0].link.dentry, 0);
> >         audit_log_link_denied("follow_link");
> >         return -EACCES;
> >  }
> 
> Why remove it in the first place, and why add it back open-coded in
> only one place?

In both cases, the extra PATH record didn't make sense with the SYSCALL
record "items=" field and conflicted with another PATH record's "item="
field.

All the necessary details were already available in the hardlink case
via two PATH records associated with the SYSCALL record.

There were two conflicting PATH records in the symlink case, one of them
incomplete, so it made more sense to make the existing one complete.

> -Kees

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
