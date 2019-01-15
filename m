Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D08C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F24CD20868
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731447AbfAOQVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:21:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48971 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730280AbfAOQVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:21:17 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 317B2C057F93;
        Tue, 15 Jan 2019 16:21:17 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-10.phx2.redhat.com [10.3.112.10])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B62435D776;
        Tue, 15 Jan 2019 16:21:15 +0000 (UTC)
Date:   Tue, 15 Jan 2019 11:21:12 -0500
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH ghak59 V3 2/4] audit: add syscall information to
 CONFIG_CHANGE records
Message-ID: <20190115162112.jq6m2j4wmyk4rq25@madcap2.tricolour.ca>
References: <cover.1544477629.git.rgb@redhat.com>
 <43548fafdfa98ee64ecfd0d7a69a2f5cb2c31c50.1544477629.git.rgb@redhat.com>
 <CAHC9VhSaTvVgSWVWo42Ur2k6hVNJ1XBkLwrd-J4-SUuidwXUYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhSaTvVgSWVWo42Ur2k6hVNJ1XBkLwrd-J4-SUuidwXUYg@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 15 Jan 2019 16:21:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-14 17:58, Paul Moore wrote:
> On Mon, Dec 10, 2018 at 5:18 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > Tie syscall information to all CONFIG_CHANGE calls since they are all a
> > result of user actions.
> >
> > Exclude user records from syscall context:
> > Since the function audit_log_common_recv_msg() is shared by a number of
> > AUDIT_CONFIG_CHANGE and the entire range of AUDIT_USER_* record types,
> > and since the AUDIT_CONFIG_CHANGE message type has been converted to a
> > syscall accompanied record type, special-case the AUDIT_USER_* range of
> > messages so they remain standalone records.
> >
> > See: https://github.com/linux-audit/audit-kernel/issues/59
> > See: https://github.com/linux-audit/audit-kernel/issues/50
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> >  kernel/audit.c          | 27 +++++++++++++++++++--------
> >  kernel/audit_fsnotify.c |  2 +-
> >  kernel/audit_tree.c     |  2 +-
> >  kernel/audit_watch.c    |  2 +-
> >  kernel/auditfilter.c    |  2 +-
> >  5 files changed, 23 insertions(+), 12 deletions(-)
> >
> > diff --git a/kernel/audit.c b/kernel/audit.c
> > index 0e8026423fbd..a321fea94cc6 100644
> > --- a/kernel/audit.c
> > +++ b/kernel/audit.c
> > @@ -1072,6 +1073,16 @@ static void audit_log_common_recv_msg(struct audit_buffer **ab, u16 msg_type)
> >         audit_log_task_context(*ab);
> >  }
> >
> > +static inline void audit_log_user_recv_msg(struct audit_buffer **ab, u16 msg_type)
> > +{
> > +       audit_log_common_recv_msg(NULL, ab, msg_type);
> > +}
> 
> This makes sense because this is used by "user" records ...
> 
> > +static inline void audit_log_config_change_alt(struct audit_buffer **ab)
> > +{
> > +       audit_log_common_recv_msg(audit_context(), ab, AUDIT_CONFIG_CHANGE);
> > +}
> 
> ... and I don't believe this makes sense because there is no real
> logical grouping with the callers like there is for
> audit_log_user_recv_msg().

I don't follow "logical grouping".  They are all CONFIG_CHANGE record
prefixes with the current context.

Can you suggest an alternate name or another way of sharing
audit_log_common_recv_msg() since the only differences between the two
are a NULL context vs current task's context and the message type.  I
wasn't particularly happy with this name either.  I'd really like to
refactor this with all the rest of the CONFIG_CHANGE records, but there
is too much of a format difference to make it work without reordering or
deleting useless fields.

I know you had suggested making two different functions, but I think
they are more similar than different and merit the common factored code.

> paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
