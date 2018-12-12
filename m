Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08F5C6783B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 02:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EE452084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 02:45:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EE452084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbeLLCpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 21:45:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36052 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbeLLCpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 21:45:22 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2B245C049D7F;
        Wed, 12 Dec 2018 02:45:21 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-24.phx2.redhat.com [10.3.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A15B600CC;
        Wed, 12 Dec 2018 02:45:14 +0000 (UTC)
Date:   Tue, 11 Dec 2018 21:45:11 -0500
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-kernel@vger.kernel.org, linux-audit@redhat.com,
        Eric Paris <eparis@redhat.com>, viro@zeniv.linux.org.uk,
        sgrubb@redhat.com
Subject: Re: [PATCH ghak59 V3 0/4] audit: config_change normalizations and
 event record gathering
Message-ID: <20181212024511.iftyuvwueh2mbolb@madcap2.tricolour.ca>
References: <cover.1544477629.git.rgb@redhat.com>
 <CAHC9VhRqMt2k+pL7YF0MaZQfXZzttyHAXBJhHH56Mvswii4EKg@mail.gmail.com>
 <20181211224107.vdeksnc5bd5bb7mb@madcap2.tricolour.ca>
 <CAHC9VhSkKqdm=q5r4Y0-kEg2j84-AG5omo6frfORXVcJ_orUaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhSkKqdm=q5r4Y0-kEg2j84-AG5omo6frfORXVcJ_orUaw@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 12 Dec 2018 02:45:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-12-11 18:26, Paul Moore wrote:
> On Tue, Dec 11, 2018 at 5:41 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > On 2018-12-11 17:31, Paul Moore wrote:
> > > On Mon, Dec 10, 2018 at 5:18 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> 
> ...
> 
> > > > Richard Guy Briggs (4):
> > > >   audit: give a clue what CONFIG_CHANGE op was involved
> > > >   audit: add syscall information to CONFIG_CHANGE records
> > > >   audit: hand taken context to audit_kill_trees for syscall logging
> > > >   audit: extend config_change mark/watch/tree rule changes
> > > >
> > > >  kernel/audit.c          | 33 +++++++++++++++++++++++----------
> > > >  kernel/audit.h          |  4 ++--
> > > >  kernel/audit_fsnotify.c |  4 ++--
> > > >  kernel/audit_tree.c     | 28 +++++++++++++++-------------
> > > >  kernel/audit_watch.c    |  8 +++++---
> > > >  kernel/auditfilter.c    |  2 +-
> > > >  kernel/auditsc.c        | 12 ++++++------
> > > >  7 files changed, 54 insertions(+), 37 deletions(-)
> > >
> > > In order to make sure expectations are set appropriately, as we are at
> > > -rc6 right now this is not something that would go into audit/next now
> > > (assuming everything looks okay on review), it would go into
> > > audit/next *after* the upcoming merge window.
> >
> > I agree it is a bit late for this.  I wasn't expecting it to go in this
> > one.  I'm filling the queue since I'm blocked on other review for
> > ghak81(5.5wks), ghak90(5.5wks), ghak100(3.5wks).  ghak90 missed another
> > merge window.
> 
> As discussed previously, GHAK81
> (https://github.com/linux-audit/audit-kernel/issues/81) is something
> that I consider part of the audit container ID work (GHAK90).  I
> believe it's time to stop treating it as a separate issue.

Fine by me.  It was included in the ghak90 patchset this time and still
is in v5, waiting to get the questions replied to that arose out of the
review of v4 around Hallowe'en.

> The audit container ID work, GHAK90
> (https://github.com/linux-audit/audit-kernel/issues/90), is where all
> the dragon's lie.  That one takes a good deal of time to review, and
> quite frankly I'm really the only one who seems to be looking at it
> anymore, so it takes a bit longer.

We're working on finding other reviewers.

> Beside the fact that GHAK100
> (https://github.com/linux-audit/audit-kernel/issues/100) was marked as
> a RFC, I've been waiting to hear back from the VFS folks if they are
> comfortable with it.  Miklos Szeredi in particular had some concerns
> and it isn't clear to me from that thread that his concerns have been
> resolved.

I'm fine with Miklos' concerns and have ideas to address them.  I'd be
quite interested in your quick review to see if it is headed in the
right direction and I'm also hoping for opinions from you and the vfs
guys on Steve's question.

> paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
