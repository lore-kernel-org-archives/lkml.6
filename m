Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F2AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F0DB20823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfARMfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 07:35:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57454 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbfARMfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 07:35:42 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8EDAA2CD80D;
        Fri, 18 Jan 2019 12:35:41 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-19.phx2.redhat.com [10.3.112.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F23F5C21F;
        Fri, 18 Jan 2019 12:35:29 +0000 (UTC)
Date:   Fri, 18 Jan 2019 07:35:26 -0500
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Steve Grubb <sgrubb@redhat.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH ghak59 V3 2/4] audit: add syscall information to
 CONFIG_CHANGE records
Message-ID: <20190118123526.3e67xaef4wfsasi4@madcap2.tricolour.ca>
References: <cover.1544477629.git.rgb@redhat.com>
 <43548fafdfa98ee64ecfd0d7a69a2f5cb2c31c50.1544477629.git.rgb@redhat.com>
 <CAHC9VhSaTvVgSWVWo42Ur2k6hVNJ1XBkLwrd-J4-SUuidwXUYg@mail.gmail.com>
 <20190117103255.1f640a42@ivy-bridge>
 <CAHC9VhQvk+6AFjVU_ygyn8Q6FGwVy_JqXj7wWSNYYp5zSiBcuw@mail.gmail.com>
 <20190117153430.olcpsdq67mozk35e@madcap2.tricolour.ca>
 <CAHC9VhRBA0k9Mo2_GuscaxOGigbUhytepQ_3O1HQRvwZOwmt_A@mail.gmail.com>
 <20190117231838.im4nku57qxutjveh@madcap2.tricolour.ca>
 <CAHC9VhTEDJUa7hWuZ28cwcZt1ZCSUSBf_EXo9DxrRnhuWmqL=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhTEDJUa7hWuZ28cwcZt1ZCSUSBf_EXo9DxrRnhuWmqL=A@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 18 Jan 2019 12:35:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-17 22:26, Paul Moore wrote:
> On Thu, Jan 17, 2019 at 6:19 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > On 2019-01-17 12:58, Paul Moore wrote:
> > > On Thu, Jan 17, 2019 at 10:34 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > >
> > > > On 2019-01-17 08:21, Paul Moore wrote:
> > > > > On Thu, Jan 17, 2019 at 4:33 AM Steve Grubb <sgrubb@redhat.com> wrote:
> > > > > > On Mon, 14 Jan 2019 17:58:58 -0500 Paul Moore <paul@paul-moore.com> wrote:
> > > > > > > On Mon, Dec 10, 2018 at 5:18 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > > > > > > Tie syscall information to all CONFIG_CHANGE calls since they are
> > > > > > > > all a result of user actions.
> > > > > >
> > > > > > Please don't tie syscall information to this. The syscall will be
> > > > > > sendto. We don't need that information, its implicit. Also, doing this
> > > > > > will possibly wreck things in libauparse. Please test the events with
> > > > > > ausearch --format csv and --format text. IFF the event looks better or
> > > > > > the same should we do this. If stuff disappears, the patch is
> > > > > > breaking things
> > > > >
> > > > > We've discussed this quite a bit already; connecting associated
> > > > > records into a single event is something that should happen, needs to
> > > > > happen, and will happen.  Conceptually it makes no sense to record the
> > > > > syscall (and any other associated records) which triggers the audit
> > > > > configuration change, and the configuration change record itself as
> > > > > two distinct events - they are the same event.  We've also heard from
> > > > > a prominent user that associating records in this way is desirable.
> > > > >
> > > > > If the ausearch csv and text audit log transformations can't handle
> > > > > this particular change, I would consider that a shortcoming of that
> > > > > code.  We have multi-record events now, and this is only going to
> > > > > increase in the future.
> > > > >
> > > > > Richard, if you can't make the requested changes to this patch and
> > > > > resubmit by ... let's say the middle of next week? that should be
> > > > > enough time, yes? ... please let me know and I'll make the changes and
> > > > > get this merged.
> > > >
> > > > I would do the change, which should be very trivial, but I'm dense
> > > > enough that I still don't know what you want.  In the last 6 months I've
> > > > asked a number of direct questions that have not been directly
> > > > addressed.  Perhaps I should be able to figure it out from the more
> > > > general or fundamental principles replies I've gotten (which have been
> > > > helpful, but perhaps incomplete), but I'm still having some trouble.
> > > > Perhaps I'm exposing my limitations.
> > >
> > > Since code is unambiguous, let me just cut and paste what I was
> > > thinking (be warned, this is a cut-n-paste, so the whitespace is
> > > probably mangled):
> >
> > Thank you.  Very clear.  I don't see the point of
> > audit_log_user_recv_msg() for reasons already stated but that's ok.
> 
> That's a fair comment.  I think there is some value in having the
> function dedicated for the user messages since they are fairly unique
> in that we don't ever want to associate them with the current task,
> but it does result in a single use function (which I generally
> dislike).  Who knows, maybe at some future point in time we'll get rid
> of audit_log_user_recv_msg(), but let's stick with it for now.
> 
> > Since we're looking at these, here are the various field formats of the
> > AUDIT_CONFIG_CHANGE records.
> >
> > Steve and Paul, are they worth attempting to normalize?
> 
> Right now, my vote is "no".  Although I'm voting that way pretty much
> just because I want to get this patch in during this development cycle
> and I'm fairly certain that trying to reach any consensus around
> normalization is going to drag this out.  I would strongly encourage
> you to just tweak this patch as we've just talked about and leave it
> at that for the time being.

Agreed.  They are already inconsistent, so this patch isn't going to make
that worse.

> paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
