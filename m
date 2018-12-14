Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D625C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 153A2206C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730043AbeLNQ15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 11:27:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60464 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730002AbeLNQ1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 11:27:55 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C0F42307D992;
        Fri, 14 Dec 2018 16:27:54 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-24.phx2.redhat.com [10.3.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 73AD819C65;
        Fri, 14 Dec 2018 16:27:47 +0000 (UTC)
Date:   Fri, 14 Dec 2018 11:27:44 -0500
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-audit@redhat.com,
        Eric Paris <eparis@redhat.com>, sgrubb@redhat.com
Subject: Re: [RFC PATCH ghak100 V1 0/2] audit: avoid umount hangs on missing
 mount
Message-ID: <20181214162744.23sbfyl3rnwkgoie@madcap2.tricolour.ca>
References: <cover.1542149969.git.rgb@redhat.com>
 <CAHC9VhT8iFLSXJBvocg_aPeveBy0hZ4bxZ547ufbUsTnkONpZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhT8iFLSXJBvocg_aPeveBy0hZ4bxZ547ufbUsTnkONpZg@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 14 Dec 2018 16:27:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-12-12 08:03, Paul Moore wrote:
> On Fri, Nov 16, 2018 at 12:34 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > On user and remote filesystems, a forced umount can still hang due to
> > attemting to fetch the fcaps of a mounted filesystem that is no longer
> > available.
> >
> > These two patches take different approaches to address this, one by
> > avoiding the lookup when the MNT_FORCE flag is included, the other by
> > providing a method to filter out auditing specified types of filesystems.
> >
> > This can happen on ceph, cifs, 9p, lustre, fuse (gluster) or NFS.
> >
> > Arguably the better way to address this issue is to disable auditing
> > processes that touch removable filesystems.
> > Please see the github issue tracker
> > https://github.com/linux-audit/audit-kernel/issues/100
> >
> > Richard Guy Briggs (2):
> >   audit: avoid fcaps on MNT_FORCE
> >   audit: moar filter PATH records keyed on filesystem magic
> >
> >  fs/namei.c            |  2 +-
> >  fs/namespace.c        |  3 +++
> >  include/linux/audit.h |  8 ++++++--
> >  kernel/audit.c        |  5 +++--
> >  kernel/audit.h        |  2 +-
> >  kernel/auditsc.c      | 29 ++++++++++++++++++++++++++---
> >  6 files changed, 40 insertions(+), 9 deletions(-)
> 
> Just to get this out of the way, don't use "moar", spell it properly.
> 
> Beyond that, it's not clear to me from your cover letter if you are
> proposing these patches as an "or" or as an "and"; assuming the
> patch(es) are reasonable, do you want us to merge both of these
> patches, or only the one we like the most?

I would like each one to be considered on its own merits.

The second was discussed back when the logs were flooded with "(null)"
PATH records due to debugfs and tracefs noise.  Do you agree with the
general concept or not?

The first is being picked apart (rightfully) due to assumptions and
choices made long ago in the audit system.  So while it is still in far
more flux than the second patch, I think it has the potential to fix the
problem more correctly and permanently but in the process may challenge
our rules about the format and invariability of audit records.  The
basic premise is to prevent audit from trying to get information (fcaps)
from a filesystem that is likely to be far more ephemeral than local
on-disk kernel filesystems or to fail to do so more gracefully.

> paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
