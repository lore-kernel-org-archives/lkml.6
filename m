Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752366AbeCLIGR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 04:06:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34396 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751239AbeCLIGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 04:06:15 -0400
Date: Mon, 12 Mar 2018 04:01:34 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>, Kees Cook <keescook@chromium.org>
Subject: Re: [RFC PATCH ghak21 2/4] audit: link denied should not directly
 generate PATH record
Message-ID: <20180312080134.lxix6zbamjaf3x4x@madcap2.tricolour.ca>
References: <cover.1518603831.git.rgb@redhat.com>
 <f48d5d1f1e429e2dee817ae723f9a02a67ed1f3b.1518603831.git.rgb@redhat.com>
 <CAHC9VhTYqJ5v1MTqch624PS8d8YkgeEK4tEY5cUcgXgD8ofU1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhTYqJ5v1MTqch624PS8d8YkgeEK4tEY5cUcgXgD8ofU1A@mail.gmail.com>
User-Agent: NeoMutt/20171027
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-08 19:26, Paul Moore wrote:
> On Wed, Feb 14, 2018 at 11:18 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> > Audit link denied events generate duplicate PATH records which disagree
> > in different ways from symlink and hardlink denials.
> > audit_log_link_denied() should not directly generate PATH records.
> >
> > See: https://github.com/linux-audit/audit-kernel/issues/21
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> >  kernel/audit.c | 14 +-------------
> >  1 file changed, 1 insertion(+), 13 deletions(-)
> 
> Merged, thanks.

Self-NACK.  Please un-merge this RFC v1 version and merge instead the v2
patch since it removes the now-unnecessary struct path * parameter from
audit_log_link_denied().

> > diff --git a/kernel/audit.c b/kernel/audit.c
> > index 4c3fd24..683b249 100644
> > --- a/kernel/audit.c
> > +++ b/kernel/audit.c
> > @@ -2259,31 +2259,19 @@ void audit_log_task_info(struct audit_buffer *ab, struct task_struct *tsk)
> >  void audit_log_link_denied(const char *operation, const struct path *link)
> >  {
> >         struct audit_buffer *ab;
> > -       struct audit_names *name;
> >
> >         if (!audit_enabled || audit_dummy_context())
> >                 return;
> >
> > -       name = kzalloc(sizeof(*name), GFP_NOFS);
> > -       if (!name)
> > -               return;
> > -
> >         /* Generate AUDIT_ANOM_LINK with subject, operation, outcome. */
> >         ab = audit_log_start(current->audit_context, GFP_KERNEL,
> >                              AUDIT_ANOM_LINK);
> >         if (!ab)
> > -               goto out;
> > +               return;
> >         audit_log_format(ab, "op=%s", operation);
> >         audit_log_task_info(ab, current);
> >         audit_log_format(ab, " res=0");
> >         audit_log_end(ab);
> > -
> > -       /* Generate AUDIT_PATH record with object. */
> > -       name->type = AUDIT_TYPE_NORMAL;
> > -       audit_copy_inode(name, link->dentry, d_backing_inode(link->dentry));
> > -       audit_log_name(current->audit_context, name, link, 0, NULL);
> > -out:
> > -       kfree(name);
> >  }
> >
> >  /**
> > --
> > 1.8.3.1
> >
> 
> 
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
