Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4214DC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 21:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F0A2146E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 21:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfBAV57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 16:57:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48068 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbfBAV57 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 16:57:59 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 638E77EBAD;
        Fri,  1 Feb 2019 21:57:58 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-22.phx2.redhat.com [10.3.112.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C70F5C70C;
        Fri,  1 Feb 2019 21:57:49 +0000 (UTC)
Date:   Fri, 1 Feb 2019 16:57:46 -0500
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>, Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH ghak100 V2 2/2] audit: ignore fcaps on umount
Message-ID: <20190201215746.poboa7dgz643zsfg@madcap2.tricolour.ca>
References: <cover.1548196083.git.rgb@redhat.com>
 <397a8b086e6aa9eb797f1538901e95462822ecb0.1548196083.git.rgb@redhat.com>
 <20190201204205.GA26179@archlinux-ryzen>
 <CAHC9VhTzy-0cPgD01XyRRPcsgtoV2NZ1NEzun388jPmXmEB-7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhTzy-0cPgD01XyRRPcsgtoV2NZ1NEzun388jPmXmEB-7Q@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 01 Feb 2019 21:57:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-02-01 16:05, Paul Moore wrote:
> On Fri, Feb 1, 2019 at 3:42 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> > On Wed, Jan 23, 2019 at 01:35:00PM -0500, Richard Guy Briggs wrote:
> > > Don't fetch fcaps when umount2 is called to avoid a process hang while
> > > it waits for the missing resource to (possibly never) re-appear.
> > >
> > > Note the comment above user_path_mountpoint_at():
> > >  * A umount is a special case for path walking. We're not actually interested
> > >  * in the inode in this situation, and ESTALE errors can be a problem.  We
> > >  * simply want track down the dentry and vfsmount attached at the mountpoint
> > >  * and avoid revalidating the last component.
> > >
> > > This can happen on ceph, cifs, 9p, lustre, fuse (gluster) or NFS.
> > >
> > > Please see the github issue tracker
> > > https://github.com/linux-audit/audit-kernel/issues/100
> > >
> > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > ---
> > >  fs/namei.c            |  2 +-
> > >  fs/namespace.c        |  2 ++
> > >  include/linux/audit.h | 15 ++++++++++-----
> > >  include/linux/namei.h |  3 +++
> > >  kernel/audit.c        | 10 +++++++++-
> > >  kernel/audit.h        |  2 +-
> > >  kernel/auditsc.c      |  6 +++---
> > >  7 files changed, 29 insertions(+), 11 deletions(-)
> 
> ...
> 
> > >  /* Copy inode data into an audit_names. */
> > >  void audit_copy_inode(struct audit_names *name, const struct dentry *dentry,
> > > -                   struct inode *inode)
> > > +                   struct inode *inode, unsigned int flags)
> > >  {
> > >       name->ino   = inode->i_ino;
> > >       name->dev   = inode->i_sb->s_dev;
> > > @@ -2120,6 +2124,10 @@ void audit_copy_inode(struct audit_names *name, const struct dentry *dentry,
> > >       name->gid   = inode->i_gid;
> > >       name->rdev  = inode->i_rdev;
> > >       security_inode_getsecid(inode, &name->osid);
> > > +     if (flags & AUDIT_INODE_NOEVAL) {
> >
> > I don't know if this has been reported or if I am missing something but
> > on next-20190201, this line causes an error with arm allyesconfig (as
> > CONFIG_AUDITSYCALL doesn't get selected):
> 
> ...
> 
> >   CC      kernel/audit.o
> > kernel/audit.c: In function 'audit_copy_inode':
> > kernel/audit.c:2130:14: error: 'AUDIT_INODE_NOEVAL' undeclared (first use in this function); did you mean 'AUDIT_TYPE_NORMAL'?
> >   if (flags & AUDIT_INODE_NOEVAL) {
> >               ^~~~~~~~~~~~~~~~~~
> >               AUDIT_TYPE_NORMAL
> > kernel/audit.c:2130:14: note: each undeclared identifier is reported only once for each function it appears in
> > make[2]: *** [scripts/Makefile.build:277: kernel/audit.o] Error 1
> > make[1]: *** [Makefile:1699: kernel/audit.o] Error 2
> > make: *** [Makefile:296: __build_one_by_one] Error 2
> 
> I hadn't seen this reported to the audit list yet, thanks for letting us now.

Thanks Nathan for the report.

> Richard, please submit a patch to fix this ASAP.  Looking at this, the
> obvious fix is to move audit_copy_inode() to auditsc.c, but I'm not
> sure if that itself is going to cause problems (it doesn't look like
> it).  Actually, thinking out loud, I wonder if we shouldn't move
> audit_log_cap(), audit_log_fcaps(), audit_copy_fcaps(), and
> audit_log_name() too?

They have all been moved in ghak105 v2 patch 2 which is in your queue.
Lemme think if there is a quicker simpler solution for this patch.
That ghak105 v2.patch2 will have a number of merge conflicts and I've
already sorted those out, so I'm willing to post a respin (v3) of it to
make your life easier.  (audit_log_key() should also be moved, now that
I check...)

> paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
