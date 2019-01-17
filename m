Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF83C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04A8A205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbfAQQIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 11:08:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43728 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727584AbfAQQIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 11:08:18 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 10CC481DF0;
        Thu, 17 Jan 2019 16:08:18 +0000 (UTC)
Received: from ivy-bridge (unknown [10.36.118.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 54CE019751;
        Thu, 17 Jan 2019 16:08:16 +0000 (UTC)
Date:   Thu, 17 Jan 2019 17:08:15 +0100
From:   Steve Grubb <sgrubb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Richard Guy Briggs <rgb@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        Eric Paris <eparis@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH ghak59 V3 2/4] audit: add syscall information to
 CONFIG_CHANGE records
Message-ID: <20190117170815.40131a69@ivy-bridge>
In-Reply-To: <CAHC9VhQvk+6AFjVU_ygyn8Q6FGwVy_JqXj7wWSNYYp5zSiBcuw@mail.gmail.com>
References: <cover.1544477629.git.rgb@redhat.com>
        <43548fafdfa98ee64ecfd0d7a69a2f5cb2c31c50.1544477629.git.rgb@redhat.com>
        <CAHC9VhSaTvVgSWVWo42Ur2k6hVNJ1XBkLwrd-J4-SUuidwXUYg@mail.gmail.com>
        <20190117103255.1f640a42@ivy-bridge>
        <CAHC9VhQvk+6AFjVU_ygyn8Q6FGwVy_JqXj7wWSNYYp5zSiBcuw@mail.gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 17 Jan 2019 16:08:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jan 2019 08:21:40 -0500
Paul Moore <paul@paul-moore.com> wrote:

> On Thu, Jan 17, 2019 at 4:33 AM Steve Grubb <sgrubb@redhat.com> wrote:
> > On Mon, 14 Jan 2019 17:58:58 -0500
> > Paul Moore <paul@paul-moore.com> wrote:
> >  
> > > On Mon, Dec 10, 2018 at 5:18 PM Richard Guy Briggs
> > > <rgb@redhat.com> wrote:  
> > > >
> > > > Tie syscall information to all CONFIG_CHANGE calls since they
> > > > are all a result of user actions.  
> >
> > Please don't tie syscall information to this. The syscall will be
> > sendto. We don't need that information, its implicit. Also, doing
> > this will possibly wreck things in libauparse. Please test the
> > events with ausearch --format csv and --format text. IFF the event
> > looks better or the same should we do this. If stuff disappears,
> > the patch is breaking things  
> 
> We've discussed this quite a bit already;

Yes, and you still don't seem be listening. You have to cooperate on
modifying events. We as a community need to respect each other's needs
and work together to solve problems. What this is saying sounds a lot
like I don't care if it breaks things, I'm gonna do it my way. Tough
luck.

You do not have to make sense of any of these events. So, what does it
really matter to you how the event is formed? What I'm asking for is
have these changes been vetted to ensure that they are not breaking
things?

> connecting associated records into a single event is something that
> should happen, needs to happen, and will happen.  Conceptually it
> makes no sense to record the syscall (and any other associated
> records) which triggers the audit configuration change, and the
> configuration change record itself as two distinct events - they are
> the same event.

Except that they are not. The design of the audit system is to save
disk space as much as possible by emitting single record events on
certain event types that are simple. To add a syscall to it adds useless
information (such as a socket address record), slows down processing,
and wastes disk space. If you get a SYSCALL record, that indicates that
you have triggered an event that the system admin has placed explicit
rules on. That is different than the common criteria required
configuration change event. 

>  We've also heard from a prominent user that
> associating records in this way is desirable.
> 
> If the ausearch csv and text audit log transformations can't handle
> this particular change, I would consider that a shortcoming of that
> code.  We have multi-record events now, and this is only going to
> increase in the future.

Isn't there some kind a guideline about not breaking user space?

-Steve

> Richard, if you can't make the requested changes to this patch and
> resubmit by ... let's say the middle of next week? that should be
> enough time, yes? ... please let me know and I'll make the changes and
> get this merged.
> 

