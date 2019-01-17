Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339A0C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07A0820851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbfAQJdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 04:33:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45344 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726727AbfAQJdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 04:33:05 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 890DCCD263;
        Thu, 17 Jan 2019 09:33:05 +0000 (UTC)
Received: from ivy-bridge (ovpn-116-20.ams2.redhat.com [10.36.116.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1B64560BE8;
        Thu, 17 Jan 2019 09:32:56 +0000 (UTC)
Date:   Thu, 17 Jan 2019 10:32:55 +0100
From:   Steve Grubb <sgrubb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Richard Guy Briggs <rgb@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        Eric Paris <eparis@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH ghak59 V3 2/4] audit: add syscall information to
 CONFIG_CHANGE records
Message-ID: <20190117103255.1f640a42@ivy-bridge>
In-Reply-To: <CAHC9VhSaTvVgSWVWo42Ur2k6hVNJ1XBkLwrd-J4-SUuidwXUYg@mail.gmail.com>
References: <cover.1544477629.git.rgb@redhat.com>
        <43548fafdfa98ee64ecfd0d7a69a2f5cb2c31c50.1544477629.git.rgb@redhat.com>
        <CAHC9VhSaTvVgSWVWo42Ur2k6hVNJ1XBkLwrd-J4-SUuidwXUYg@mail.gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 17 Jan 2019 09:33:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2019 17:58:58 -0500
Paul Moore <paul@paul-moore.com> wrote:

> On Mon, Dec 10, 2018 at 5:18 PM Richard Guy Briggs <rgb@redhat.com>
> wrote:
> >
> > Tie syscall information to all CONFIG_CHANGE calls since they are
> > all a result of user actions.

Please don't tie syscall information to this. The syscall will be
sendto. We don't need that information, its implicit. Also, doing this
will possibly wreck things in libauparse. Please test the events with
ausearch --format csv and --format text. IFF the event looks better or
the same should we do this. If stuff disappears, the patch is
breaking things

-Steve


> > Exclude user records from syscall context:
> > Since the function audit_log_common_recv_msg() is shared by a
> > number of AUDIT_CONFIG_CHANGE and the entire range of AUDIT_USER_*
> > record types, and since the AUDIT_CONFIG_CHANGE message type has
> > been converted to a syscall accompanied record type, special-case
> > the AUDIT_USER_* range of messages so they remain standalone
> > records.
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
> > @@ -1072,6 +1073,16 @@ static void audit_log_common_recv_msg(struct
> > audit_buffer **ab, u16 msg_type) audit_log_task_context(*ab);
> >  }
> >
> > +static inline void audit_log_user_recv_msg(struct audit_buffer
> > **ab, u16 msg_type) +{
> > +       audit_log_common_recv_msg(NULL, ab, msg_type);
> > +}  
> 
> This makes sense because this is used by "user" records ...
> 
> > +static inline void audit_log_config_change_alt(struct audit_buffer
> > **ab) +{
> > +       audit_log_common_recv_msg(audit_context(), ab,
> > AUDIT_CONFIG_CHANGE); +}  
> 
> ... and I don't believe this makes sense because there is no real
> logical grouping with the callers like there is for
> audit_log_user_recv_msg().
> 

