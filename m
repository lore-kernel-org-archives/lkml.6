Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E4FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97454214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729947AbfAJW7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 17:59:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58490 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726369AbfAJW7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 17:59:09 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5EC8813AA0;
        Thu, 10 Jan 2019 22:59:08 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-10.phx2.redhat.com [10.3.112.10])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 43E1B7F1AD;
        Thu, 10 Jan 2019 22:58:50 +0000 (UTC)
Date:   Thu, 10 Jan 2019 17:58:47 -0500
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     containers@lists.linux-foundation.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org, ebiederm@xmission.com,
        luto@kernel.org, carlos@redhat.com, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, simo@redhat.com,
        Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>
Subject: Re: [PATCH ghak90 (was ghak32) V4 06/10] audit: add containerid
 support for tty_audit
Message-ID: <20190110225847.vumlt2jor57djrdc@madcap2.tricolour.ca>
References: <cover.1533065887.git.rgb@redhat.com>
 <e41cb6760a8183c0955c378fce7b500819f9838f.1533065887.git.rgb@redhat.com>
 <CAHC9VhRPMAUsgs2zXkPEFZPQS6dmAO1-kBX1Y-7tRkD-kwGEjw@mail.gmail.com>
 <20181031211739.6jag6b5qve77qmmu@madcap2.tricolour.ca>
 <CAHC9VhTnj3Sg9R-XM0U9gqOsNXT+Tn+VVRXJtBTt0A0DPQ0GQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhTnj3Sg9R-XM0U9gqOsNXT+Tn+VVRXJtBTt0A0DPQ0GQg@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 10 Jan 2019 22:59:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-03 15:11, Paul Moore wrote:
> On Wed, Oct 31, 2018 at 5:17 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > On 2018-10-19 19:17, Paul Moore wrote:
> > > On Sun, Aug 5, 2018 at 4:33 AM Richard Guy Briggs
> <rgb@redhat.com> wrote:
> > > > Add audit container identifier auxiliary record to tty logging rule
> > > > event standalone records.
> > > >
> > > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > > Acked-by: Serge Hallyn <serge@hallyn.com>
> > > > ---
> > > >  drivers/tty/tty_audit.c | 5 ++++-
> > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/tty/tty_audit.c b/drivers/tty/tty_audit.c
> > > > index 50f567b..3e21477 100644
> > > > --- a/drivers/tty/tty_audit.c
> > > > +++ b/drivers/tty/tty_audit.c
> > > > @@ -66,8 +66,9 @@ static void tty_audit_log(const char *description, dev_t dev,
> > > >         uid_t uid = from_kuid(&amp;init_user_ns, task_uid(tsk));
> > > >         uid_t loginuid = from_kuid(&amp;init_user_ns, audit_get_loginuid(tsk));
> > > >         unsigned int sessionid = audit_get_sessionid(tsk);
> > > > +       struct audit_context *context = audit_alloc_local(GFP_KERNEL);
> > > >
> > > > -       ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_TTY);
> > > > +       ab = audit_log_start(context, GFP_KERNEL, AUDIT_TTY);
> > > >         if (ab) {
> > > >                 char name[sizeof(tsk->comm)];
> > > >
> > > > @@ -80,6 +81,8 @@ static void tty_audit_log(const char *description, dev_t dev,
> > > >                 audit_log_n_hex(ab, data, size);
> > > >                 audit_log_end(ab);
> > > >         }
> > > > +       audit_log_contid(context, "tty", audit_get_contid(tsk));
> > > > +       audit_free_context(context);
> > > >  }
> > >
> > > Since I never polished up my task_struct/current fix patch enough to
> > > get it past RFC status during this development window (new job, stolen
> > > laptop, etc.) *and* it looks like you are going to need at least one
> > > more respin of this patchset, go ahead and fix this patch to use
> > > current instead of generating a local context.  I'll deal with the
> > > merge fallout if/when it happens.
> >
> > Sure, I will switch it to current in the call to audit_get_contid().
> >
> > The local context is a distinct issue.  Like USER records, I prefer
> > local due to potential record volume, it is already trackable as far as
> > Steve is concerned, and if it is to be connected with the syscall
> > record, it should be linked to syscall records in a seperate new github
> > issue with its own patch.  It accumulates events until the buffer is
> > flushed to a record, so the timestamp only represents the flush (usually
> > user "CR/enter").
> 
> Generally, yes, associating records is a separate issue, but in this
> particular case you are changing this record by making it a "local"
> record, which as we've discussed before, I view as a necessary evil
> and something that must be minimized.  A quick look at the
> tty_audit_log() callers shows tty_audit_tiocsti() which is an ioctl
> handler (and thus current should be valid and correct), and
> tty_audit_buf_push() whose callers all seem have valid and correct
> current values; if you find that not to be the case please let me
> know.

Unless I'm misunderstanding what "local" means, it already had a local
context by virtue of having a NULL context since it was never previously
connected to syscall events, so changing it to a local context doesn't
change that other than making it possible to associate an auxiliary
audit container identifier record.

The reasoning I'm also applying here is that the contents of this record
don't all come from this one syscall, but most likely came in from an
entire line of individual keystrokes, so the syscall information is only
from the last one of those syscalls, though that syscall information
other than the timestamp should be the same.

Reading your reply above it isn't clear to me that I had made these two
points clear previously.  If you still think this record should be
associated to a syscall despite my reasoning above, I'm willing to
connect it, but will do so in a seperate issue/patch.

> > > Local contexts are a last resort.  If you ever find yourself writing
> > > code that generates a local context, you should first be 100% certain
> > > that the event is not the the result of a process initiated action (in
> > > which case it should take from the task's context).
> >
> > Well, I'm 100% certain it is linked to a process, but so are USER
> > records that are already being discussed as the exception.  This is
> > basically a keystroke logger (that has a flag to omit passwords).
> 
> --
> paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
