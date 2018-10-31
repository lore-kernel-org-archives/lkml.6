Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC26ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 21:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 783312081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 21:17:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 783312081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730036AbeKAGRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 02:17:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40040 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726314AbeKAGRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 02:17:42 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7B83D3082133;
        Wed, 31 Oct 2018 21:17:54 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-24.phx2.redhat.com [10.3.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A97475D6AA;
        Wed, 31 Oct 2018 21:17:42 +0000 (UTC)
Date:   Wed, 31 Oct 2018 17:17:39 -0400
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
Message-ID: <20181031211739.6jag6b5qve77qmmu@madcap2.tricolour.ca>
References: <cover.1533065887.git.rgb@redhat.com>
 <e41cb6760a8183c0955c378fce7b500819f9838f.1533065887.git.rgb@redhat.com>
 <CAHC9VhRPMAUsgs2zXkPEFZPQS6dmAO1-kBX1Y-7tRkD-kwGEjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhRPMAUsgs2zXkPEFZPQS6dmAO1-kBX1Y-7tRkD-kwGEjw@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 31 Oct 2018 21:17:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-19 19:17, Paul Moore wrote:
> On Sun, Aug 5, 2018 at 4:33 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> > Add audit container identifier auxiliary record to tty logging rule
> > event standalone records.
> >
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > Acked-by: Serge Hallyn <serge@hallyn.com>
> > ---
> >  drivers/tty/tty_audit.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/tty/tty_audit.c b/drivers/tty/tty_audit.c
> > index 50f567b..3e21477 100644
> > --- a/drivers/tty/tty_audit.c
> > +++ b/drivers/tty/tty_audit.c
> > @@ -66,8 +66,9 @@ static void tty_audit_log(const char *description, dev_t dev,
> >         uid_t uid = from_kuid(&init_user_ns, task_uid(tsk));
> >         uid_t loginuid = from_kuid(&init_user_ns, audit_get_loginuid(tsk));
> >         unsigned int sessionid = audit_get_sessionid(tsk);
> > +       struct audit_context *context = audit_alloc_local(GFP_KERNEL);
> >
> > -       ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_TTY);
> > +       ab = audit_log_start(context, GFP_KERNEL, AUDIT_TTY);
> >         if (ab) {
> >                 char name[sizeof(tsk->comm)];
> >
> > @@ -80,6 +81,8 @@ static void tty_audit_log(const char *description, dev_t dev,
> >                 audit_log_n_hex(ab, data, size);
> >                 audit_log_end(ab);
> >         }
> > +       audit_log_contid(context, "tty", audit_get_contid(tsk));
> > +       audit_free_context(context);
> >  }
> 
> Since I never polished up my task_struct/current fix patch enough to
> get it past RFC status during this development window (new job, stolen
> laptop, etc.) *and* it looks like you are going to need at least one
> more respin of this patchset, go ahead and fix this patch to use
> current instead of generating a local context.  I'll deal with the
> merge fallout if/when it happens.

Sure, I will switch it to current in the call to audit_get_contid().

The local context is a distinct issue.  Like USER records, I prefer
local due to potential record volume, it is already trackable as far as
Steve is concerned, and if it is to be connected with the syscall
record, it should be linked to syscall records in a seperate new github
issue with its own patch.  It accumulates events until the buffer is
flushed to a record, so the timestamp only represents the flush (usually
user "CR/enter").

> Local contexts are a last resort.  If you ever find yourself writing
> code that generates a local context, you should first be 100% certain
> that the event is not the the result of a process initiated action (in
> which case it should take from the task's context).

Well, I'm 100% certain it is linked to a process, but so are USER
records that are already being discussed as the exception.  This is
basically a keystroke logger (that has a flag to omit passwords).

> paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
