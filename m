Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752407AbeCLIEY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 04:04:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34304 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752370AbeCLIET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 04:04:19 -0400
Date: Mon, 12 Mar 2018 03:59:38 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>, Kees Cook <keescook@chromium.org>
Subject: Re: [RFC PATCH ghak21 4/4] audit: add parent of refused symlink to
 audit_names
Message-ID: <20180312075938.7uo7vhzdyzhtzsph@madcap2.tricolour.ca>
References: <cover.1518603831.git.rgb@redhat.com>
 <1c5184985e422774329484153b0147c2861e91a7.1518603831.git.rgb@redhat.com>
 <CAHC9VhQAiQdCeayzYY5Nr0rqJu0q0AbbM2ovqAe7hYNZGOwyxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhQAiQdCeayzYY5Nr0rqJu0q0AbbM2ovqAe7hYNZGOwyxA@mail.gmail.com>
User-Agent: NeoMutt/20171027
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-08 19:50, Paul Moore wrote:
> On Wed, Feb 14, 2018 at 11:18 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> > Audit link denied events for symlinks were missing the parent PATH
> > record.  Add it.  Since the full pathname may not be available,
> > reconstruct it from the path in the nameidata supplied.
> >
> > See: https://github.com/linux-audit/audit-kernel/issues/21
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> >  fs/namei.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 0edf133..bf1c046b 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -923,6 +923,7 @@ static inline int may_follow_link(struct nameidata *nd)
> >         const struct inode *inode;
> >         const struct inode *parent;
> >         kuid_t puid;
> > +       char *pathname;
> >
> >         if (!sysctl_protected_symlinks)
> >                 return 0;
> > @@ -945,6 +946,14 @@ static inline int may_follow_link(struct nameidata *nd)
> >         if (nd->flags & LOOKUP_RCU)
> >                 return -ECHILD;
> >
> > +       pathname = kmalloc(PATH_MAX + 1, GFP_KERNEL);
> > +       if (!pathname)
> > +               return -ENOMEM;
> 
> Two things here:
> 
> 1. We need to allocate a buffer to feed to d_absolute_path(), and
> getname_kernel() is just going to make another copy so we need to make
> sure we clean up after ourselves.  Perhaps I missing it, but I'm not
> seeing where we free the kmalloc'd buffer or call putname().  Feel
> free to correct me if I'm missing something obvious.

That is put very diplomatically!  Both fixed, with audit_panic() as
needed.

> 2. While the audit_* calls are going to bail early in the cases where
> audit is disabled, or not configured, we are going to pay the penalty
> for the kmalloc() call above, as well as the getname_kernel() and
> d_absolute_path() calls below.  I think it might be beneficial to
> create a new function (audit_log_symlink_denied() perhaps?) which
> encapsulates all the audit bits in may_follow_link() and exits early
> when needed.  What do you think?

I agree a seperate function is appropriate.  There was some back and
forth between namei.c and audit.c due to struct nameidata and
audit_panic() not able to co-exist due to them both being local to their
respective sub-systems.

> (Point #2 is why I didn't merge patch 3/4, just include it in this
> revised patch)

On reviewing this, I'm not totally convinced the parent record is
necessary to fully understand what happenned since there is a CWD
record.  I left 3 and 4 as seperate patches in case it is found that
only 3 is necessary.

> > +       audit_inode(getname_kernel(d_absolute_path(&nd->stack[0].link, pathname,
> > +                                                  PATH_MAX + 1)),
> > +                   nd->stack[0].link.dentry, 0);
> > +       audit_inode(nd->name, nd->stack[0].link.dentry->d_parent, LOOKUP_PARENT);
> > +
> >         audit_inode(nd->name, nd->stack[0].link.dentry, 0);
> >         audit_log_link_denied("follow_link", &nd->stack[0].link);
> >
> >         return -EACCES;
> > --
> > 1.8.3.1
> 
> -- 
> paul moore
> www.paul-moore.com

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
