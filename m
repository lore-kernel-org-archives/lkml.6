Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35F1C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 23:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6314120675
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 23:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730962AbeLNXEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 18:04:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59142 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726389AbeLNXEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 18:04:14 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3C61E3F73C;
        Fri, 14 Dec 2018 23:04:13 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-24.phx2.redhat.com [10.3.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 62CB810021B1;
        Fri, 14 Dec 2018 23:04:02 +0000 (UTC)
Date:   Fri, 14 Dec 2018 18:03:59 -0500
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-audit@redhat.com,
        Eric Paris <eparis@redhat.com>, sgrubb@redhat.com
Subject: Re: [RFC PATCH ghak100 V1 0/2] audit: avoid umount hangs on missing
 mount
Message-ID: <20181214230359.5a6hshxrj6kqu3ev@madcap2.tricolour.ca>
References: <cover.1542149969.git.rgb@redhat.com>
 <CAHC9VhT8iFLSXJBvocg_aPeveBy0hZ4bxZ547ufbUsTnkONpZg@mail.gmail.com>
 <20181214162744.23sbfyl3rnwkgoie@madcap2.tricolour.ca>
 <CAHC9VhQa5-CvFJkdY=XUkXc4Q1qVNy+3mcqrgzu8RosX-jP0iw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhQa5-CvFJkdY=XUkXc4Q1qVNy+3mcqrgzu8RosX-jP0iw@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 14 Dec 2018 23:04:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-12-14 17:02, Paul Moore wrote:
> On Fri, Dec 14, 2018 at 11:27 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> > On 2018-12-12 08:03, Paul Moore wrote:
> > > On Fri, Nov 16, 2018 at 12:34 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > > On user and remote filesystems, a forced umount can still hang due to
> > > > attemting to fetch the fcaps of a mounted filesystem that is no longer
> > > > available.
> > > >
> > > > These two patches take different approaches to address this, one by
> > > > avoiding the lookup when the MNT_FORCE flag is included, the other by
> > > > providing a method to filter out auditing specified types of filesystems.
> > > >
> > > > This can happen on ceph, cifs, 9p, lustre, fuse (gluster) or NFS.
> > > >
> > > > Arguably the better way to address this issue is to disable auditing
> > > > processes that touch removable filesystems.
> > > > Please see the github issue tracker
> > > > https://github.com/linux-audit/audit-kernel/issues/100
> > > >
> > > > Richard Guy Briggs (2):
> > > >   audit: avoid fcaps on MNT_FORCE
> > > >   audit: moar filter PATH records keyed on filesystem magic
> > > >
> > > >  fs/namei.c            |  2 +-
> > > >  fs/namespace.c        |  3 +++
> > > >  include/linux/audit.h |  8 ++++++--
> > > >  kernel/audit.c        |  5 +++--
> > > >  kernel/audit.h        |  2 +-
> > > >  kernel/auditsc.c      | 29 ++++++++++++++++++++++++++---
> > > >  6 files changed, 40 insertions(+), 9 deletions(-)
> > >
> > > Just to get this out of the way, don't use "moar", spell it properly.
> > >
> > > Beyond that, it's not clear to me from your cover letter if you are
> > > proposing these patches as an "or" or as an "and"; assuming the
> > > patch(es) are reasonable, do you want us to merge both of these
> > > patches, or only the one we like the most?
> >
> > I would like each one to be considered on its own merits.
> >
> > The second was discussed back when the logs were flooded with "(null)"
> > PATH records due to debugfs and tracefs noise.  Do you agree with the
> > general concept or not?
> 
> I believe I was in favor of this back then, and I think it is still a
> reasonable feature to add independent of the umount hang problem.

I wasn't so keen then, but see more use for it now.

> One possible enhancement might be to also support filesystem names and
> not just magic numbers.  This could either be done in userspace or the
> kernel via AUDIT_FSNAME, or similar.  If you do take the _FSNAME
> approach you should have the kernel convert that to a magic number
> when it translates the rule (performance reasons).

I had looked at filesystem names previously with Steve and I seem to
recall that was much better left to userspace to convert.  The biggest
challenge I see here is that in-kernel filsystems have all their magic
numbers listed in the kernel, whereas discovering the magic numbers for
fuse and other remote filesystems is a bit harder.  This was one of the
reasons I wanted to include the magic number in the name= field in patch
#1 for ghak8 so it was easy to figure out what type of filesystem was
involved.

> > The first is being picked apart (rightfully) due to assumptions and
> > choices made long ago in the audit system.  So while it is still in far
> > more flux than the second patch, I think it has the potential to fix the
> > problem more correctly and permanently but in the process may challenge
> > our rules about the format and invariability of audit records.  The
> > basic premise is to prevent audit from trying to get information (fcaps)
> > from a filesystem that is likely to be far more ephemeral than local
> > on-disk kernel filesystems or to fail to do so more gracefully.
> 
> There is one minor nit: use "flags" instead of "lflags" in the
> audit_inode parameter list, the local "flags" variable can be changed
> to something else; the parameters are what callers see, make them
> simple and familiar.

Noted.

> However, beyond that I think the general approach of not recording
> fcaps is reasonable if we can't reliably do it.  What do the fcaps
> entries look like in this particular case, are they "0" or "?"?  I
> would suggest "?" is the correct answer here.

I'd agree "?" would be the best option to make it clear it is not
available rather than just zero.

> paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
