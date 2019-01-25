Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA4EC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 22:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4399C218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 22:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbfAYW1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 17:27:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36690 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726262AbfAYW1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 17:27:31 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ED87788E61;
        Fri, 25 Jan 2019 22:27:30 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-23.phx2.redhat.com [10.3.112.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BFC0560FDF;
        Fri, 25 Jan 2019 22:27:20 +0000 (UTC)
Date:   Fri, 25 Jan 2019 17:27:17 -0500
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH ghak100 V2 2/2] audit: ignore fcaps on umount
Message-ID: <20190125222717.x7lyzjn2qfzdzp4k@madcap2.tricolour.ca>
References: <cover.1548196083.git.rgb@redhat.com>
 <397a8b086e6aa9eb797f1538901e95462822ecb0.1548196083.git.rgb@redhat.com>
 <CAHC9VhQ14FtJAMxjmrGNu2-AkJe6ELjHnaEHjULLHjwo2FDhkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhQ14FtJAMxjmrGNu2-AkJe6ELjHnaEHjULLHjwo2FDhkQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 25 Jan 2019 22:27:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-25 16:45, Paul Moore wrote:
> On Wed, Jan 23, 2019 at 1:35 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > Don't fetch fcaps when umount2 is called to avoid a process hang while
> > it waits for the missing resource to (possibly never) re-appear.
> >
> > Note the comment above user_path_mountpoint_at():
> >  * A umount is a special case for path walking. We're not actually interested
> >  * in the inode in this situation, and ESTALE errors can be a problem.  We
> >  * simply want track down the dentry and vfsmount attached at the mountpoint
> >  * and avoid revalidating the last component.
> >
> > This can happen on ceph, cifs, 9p, lustre, fuse (gluster) or NFS.
> >
> > Please see the github issue tracker
> > https://github.com/linux-audit/audit-kernel/issues/100
> >
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> >  fs/namei.c            |  2 +-
> >  fs/namespace.c        |  2 ++
> >  include/linux/audit.h | 15 ++++++++++-----
> >  include/linux/namei.h |  3 +++
> >  kernel/audit.c        | 10 +++++++++-
> >  kernel/audit.h        |  2 +-
> >  kernel/auditsc.c      |  6 +++---
> >  7 files changed, 29 insertions(+), 11 deletions(-)
> >
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 914178cdbe94..87d7710a2e1d 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -2720,7 +2720,7 @@ int user_path_at_empty(int dfd, const char __user *name, unsigned flags,
> >         if (unlikely(error == -ESTALE))
> >                 error = path_mountpoint(&nd, flags | LOOKUP_REVAL, path);
> >         if (likely(!error))
> > -               audit_inode(name, path->dentry, 0);
> > +               audit_inode(name, path->dentry, flags & LOOKUP_NO_EVAL);
> >         restore_nameidata();
> >         putname(name);
> >         return error;
> > diff --git a/fs/namespace.c b/fs/namespace.c
> > index a677b59efd74..e5de0e372df2 100644
> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c
> > @@ -1640,6 +1640,8 @@ int ksys_umount(char __user *name, int flags)
> >         if (!(flags & UMOUNT_NOFOLLOW))
> >                 lookup_flags |= LOOKUP_FOLLOW;
> >
> > +       lookup_flags |= LOOKUP_NO_EVAL;
> > +
> >         retval = user_path_mountpoint_at(AT_FDCWD, name, lookup_flags, &path);
> >         if (retval)
> >                 goto out;
> > diff --git a/include/linux/audit.h b/include/linux/audit.h
> > index a625c29a2ea2..5d914b534536 100644
> > --- a/include/linux/audit.h
> > +++ b/include/linux/audit.h
> > @@ -25,6 +25,7 @@
> >
> >  #include <linux/sched.h>
> >  #include <linux/ptrace.h>
> > +#include <linux/namei.h>  /* LOOKUP_* */
> >  #include <uapi/linux/audit.h>
> >
> >  #define AUDIT_INO_UNSET ((unsigned long)-1)
> > @@ -225,6 +226,7 @@ extern void __audit_syscall_entry(int major, unsigned long a0, unsigned long a1,
> >
> >  #define AUDIT_INODE_PARENT     1       /* dentry represents the parent */
> >  #define AUDIT_INODE_HIDDEN     2       /* audit record should be hidden */
> > +#define AUDIT_INODE_NOEVAL     4       /* audit record incomplete */
> >  extern void __audit_inode(struct filename *name, const struct dentry *dentry,
> >                                 unsigned int flags);
> >  extern void __audit_file(const struct file *);
> > @@ -285,12 +287,15 @@ static inline void audit_getname(struct filename *name)
> >  }
> >  static inline void audit_inode(struct filename *name,
> >                                 const struct dentry *dentry,
> > -                               unsigned int parent) {
> > +                               unsigned int flags) {
> >         if (unlikely(!audit_dummy_context())) {
> > -               unsigned int flags = 0;
> > -               if (parent)
> > -                       flags |= AUDIT_INODE_PARENT;
> > -               __audit_inode(name, dentry, flags);
> > +               unsigned int aflags = 0;
> > +
> > +               if (flags & LOOKUP_PARENT)
> > +                       aflags |= AUDIT_INODE_PARENT;
> > +               if (flags & LOOKUP_NO_EVAL)
> > +                       aflags |= AUDIT_INODE_NOEVAL;
> > +               __audit_inode(name, dentry, aflags);
> >         }
> >  }
> >  static inline void audit_file(struct file *file)
> > diff --git a/include/linux/namei.h b/include/linux/namei.h
> > index a78606e8e3df..9138b4471dbf 100644
> > --- a/include/linux/namei.h
> > +++ b/include/linux/namei.h
> > @@ -24,6 +24,8 @@
> >   *  - internal "there are more path components" flag
> >   *  - dentry cache is untrusted; force a real lookup
> >   *  - suppress terminal automount
> > + *  - skip revalidation
> > + *  - don't fetch xattrs on audit_inode
> >   */
> >  #define LOOKUP_FOLLOW          0x0001
> >  #define LOOKUP_DIRECTORY       0x0002
> > @@ -33,6 +35,7 @@
> >  #define LOOKUP_REVAL           0x0020
> >  #define LOOKUP_RCU             0x0040
> >  #define LOOKUP_NO_REVAL                0x0080
> > +#define LOOKUP_NO_EVAL         0x0100
> >
> >  /*
> >   * Intent data
> > diff --git a/kernel/audit.c b/kernel/audit.c
> > index ca55ccb46b76..45d5131943eb 100644
> > --- a/kernel/audit.c
> > +++ b/kernel/audit.c
> > @@ -2081,6 +2081,10 @@ void audit_log_cap(struct audit_buffer *ab, char *prefix, kernel_cap_t *cap)
> >
> >  static void audit_log_fcaps(struct audit_buffer *ab, struct audit_names *name)
> >  {
> > +       if (name->fcap_ver == -1) {
> > +               audit_log_format(ab, " cap_fe=? cap_fver=? cap_fp=? cap_fi=?");
> > +               return;
> > +       }
> >         audit_log_cap(ab, "cap_fp", &name->fcap.permitted);
> >         audit_log_cap(ab, "cap_fi", &name->fcap.inheritable);
> >         audit_log_format(ab, " cap_fe=%d cap_fver=%x",
> > @@ -2111,7 +2115,7 @@ static inline int audit_copy_fcaps(struct audit_names *name,
> >
> >  /* Copy inode data into an audit_names. */
> >  void audit_copy_inode(struct audit_names *name, const struct dentry *dentry,
> > -                     struct inode *inode)
> > +                     struct inode *inode, unsigned int flags)
> >  {
> >         name->ino   = inode->i_ino;
> >         name->dev   = inode->i_sb->s_dev;
> > @@ -2120,6 +2124,10 @@ void audit_copy_inode(struct audit_names *name, const struct dentry *dentry,
> >         name->gid   = inode->i_gid;
> >         name->rdev  = inode->i_rdev;
> >         security_inode_getsecid(inode, &name->osid);
> > +       if (flags & AUDIT_INODE_NOEVAL) {
> > +               name->fcap_ver = -1;
> > +               return;
> > +       }
> 
> I'm not in love with the -1 sentinel, especially without a cast in
> front of it (style nit I suppose), but I love the idea of adding
> another flag to audit_names even more.  Since it looks like the
> version portion of cpu_vfs_cap_data.magic_etc is limited to eight bits
> I suppose we could break up fcap_ver and use some of the 32 bits for
> our own flags.  Not sure I like that option any more than the others.

Would you prefer 0xFFFFFFFF, or 0xFF (assuming it somehow needs to be
compatible with the shifted revision mask), or even 0xFFFFFF00 to avoid
using those 8 bits?

As far as I know, only one bit of the original 24 magic_etc flag bits is
used and that is for the fE (file Effective) bit.

> I'm also beginning to wonder why we don't just include the fcaps
> version info in the audit_cap_data struct; I can't think of a reason
> why you would ever want to know one without the other.  Thoughts?

I wondered that myself...  struct audit_cap_data is also used in
audit_context.capset where it has no need of the version since it is
storing process caps (and the effective field is a union with fE) and in
audit_context.aux where it is chained in as audit_aux_data_bprm_fcaps
with three instances of audit_cap_data but only one version.

We could just keep fcap_ver and fE in the original magic_etc and use
a high order bit of the VFS_CAP_FLAGS_MASK...

Is it worth changing?

> >         audit_copy_fcaps(name, dentry);
> >  }
> >
> > diff --git a/kernel/audit.h b/kernel/audit.h
> > index 6ffb70575082..25ab276be8e5 100644
> > --- a/kernel/audit.h
> > +++ b/kernel/audit.h
> > @@ -214,7 +214,7 @@ struct audit_context {
> >
> >  extern void audit_copy_inode(struct audit_names *name,
> >                              const struct dentry *dentry,
> > -                            struct inode *inode);
> > +                            struct inode *inode, unsigned int flags);
> >  extern void audit_log_cap(struct audit_buffer *ab, char *prefix,
> >                           kernel_cap_t *cap);
> >  extern void audit_log_name(struct audit_context *context,
> > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > index 3d05d5fc6240..9a1257afc4d4 100644
> > --- a/kernel/auditsc.c
> > +++ b/kernel/auditsc.c
> > @@ -1853,7 +1853,7 @@ void __audit_inode(struct filename *name, const struct dentry *dentry,
> >                 n->type = AUDIT_TYPE_NORMAL;
> >         }
> >         handle_path(dentry);
> > -       audit_copy_inode(n, dentry, inode);
> > +       audit_copy_inode(n, dentry, inode, flags & AUDIT_INODE_NOEVAL);
> >  }
> >
> >  void __audit_file(const struct file *file)
> > @@ -1952,7 +1952,7 @@ void __audit_inode_child(struct inode *parent,
> >                 n = audit_alloc_name(context, AUDIT_TYPE_PARENT);
> >                 if (!n)
> >                         return;
> > -               audit_copy_inode(n, NULL, parent);
> > +               audit_copy_inode(n, NULL, parent, 0);
> >         }
> >
> >         if (!found_child) {
> > @@ -1971,7 +1971,7 @@ void __audit_inode_child(struct inode *parent,
> >         }
> >
> >         if (inode)
> > -               audit_copy_inode(found_child, dentry, inode);
> > +               audit_copy_inode(found_child, dentry, inode, 0);
> >         else
> >                 found_child->ino = AUDIT_INO_UNSET;
> >  }
> > --
> > 1.8.3.1
> >
> 
> 
> -- 
> paul moore
> www.paul-moore.com
> 
> --
> Linux-audit mailing list
> Linux-audit@redhat.com
> https://www.redhat.com/mailman/listinfo/linux-audit

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
