Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED65C169C4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 02:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80A7C21848
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 02:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729902AbfA3Cyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 21:54:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58166 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727729AbfA3Cyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 21:54:53 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BC891821CC;
        Wed, 30 Jan 2019 02:54:52 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-14.phx2.redhat.com [10.3.112.14])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C3B295D97A;
        Wed, 30 Jan 2019 02:54:46 +0000 (UTC)
Date:   Tue, 29 Jan 2019 21:54:43 -0500
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        Eric Paris <eparis@redhat.com>, Steve Grubb <sgrubb@redhat.com>
Subject: Re: [PATCH ghak105 V2] audit: remove audit_context when CONFIG_
 AUDIT and not AUDITSYSCALL
Message-ID: <20190130025443.ccby2yjwsdeofxrq@madcap2.tricolour.ca>
References: <6378bddc2ca871615ebbdaffe17ee0b4482c44a0.1548700115.git.rgb@redhat.com>
 <CAHC9VhQkLAgEUf6Rc6ovDyiJuNvm6PaKp0gGzDus6nkKDekWww@mail.gmail.com>
 <20190129231750.i3yxoqv3jb352dwk@madcap2.tricolour.ca>
 <CAHC9VhRoTkXgiD8vRtHZFERL+pdDhobuAh9yb_0pFXe__pQmzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhRoTkXgiD8vRtHZFERL+pdDhobuAh9yb_0pFXe__pQmzg@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 30 Jan 2019 02:54:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-29 18:26, Paul Moore wrote:
> On Tue, Jan 29, 2019 at 6:18 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > On 2019-01-29 18:07, Paul Moore wrote:
> > > On Mon, Jan 28, 2019 at 1:33 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > > Remove audit_context from struct task_struct and struct audit_buffer
> > > > when CONFIG_AUDIT is enabled but CONFIG_AUDITSYSCALL is not.
> > > >
> > > > Also, audit_log_name() (and supporting inode and fcaps functions) should
> > > > have been put back in auditsc.c when soft and hard link logging was
> > > > normalized since it is only used by syscall auditing.
> > > >
> > > > See github issue https://github.com/linux-audit/audit-kernel/issues/105
> > > >
> > > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > > ---
> > > > Changelog:
> > > > v2:
> > > > - resolve merge conflicts from rebase on upstreamed ghak103 patch
> > > > - wrap task_struct audit_context in CONFIG_AUDITSYSCALL
> > > >
> > > >  include/linux/sched.h |   4 +-
> > > >  kernel/audit.c        | 157 +++-----------------------------------------------
> > > >  kernel/audit.h        |   9 ---
> > > >  kernel/auditsc.c      | 150 +++++++++++++++++++++++++++++++++++++++++++++++
> > > >  4 files changed, 161 insertions(+), 159 deletions(-)
> > >
> > > ...
> > >
> > > > diff --git a/kernel/audit.c b/kernel/audit.c
> > > > index 3f3f1888cac7..15e41603fd34 100644
> > > > --- a/kernel/audit.c
> > > > +++ b/kernel/audit.c
> > > > @@ -205,7 +205,9 @@ struct audit_net {
> > > >   * use simultaneously. */
> > > >  struct audit_buffer {
> > > >         struct sk_buff       *skb;      /* formatted skb ready to send */
> > > > +#ifdef CONFIG_AUDITSYSCALL
> > > >         struct audit_context *ctx;      /* NULL or associated context */
> > > > +#endif
> > > >         gfp_t                gfp_mask;
> > > >  };
> > > >
> > > > @@ -1696,7 +1698,9 @@ static struct audit_buffer *audit_buffer_alloc(struct audit_context *ctx,
> > > >         if (!nlmsg_put(ab->skb, 0, 0, type, 0, 0))
> > > >                 goto err;
> > > >
> > > > +#ifdef CONFIG_AUDITSYSCALL
> > > >         ab->ctx = ctx;
> > > > +#endif
> > >
> > > I vaguely remember reading/hearing something in the past about
> > > kmem_cache_alloc() not returning a zero'd out buffer in all cases, can
> > > you say for certain that "ab" in this case is always going to be
> > > zero'd out?  This is an honest question.
> >
> > Ok, then maybe we should be using kmem_cache_zalloc() instead of
> > kmem_cache_alloc() in audit_buffer_alloc()?  (as I've done in
> > the last patch of ghak81/first patch of ghak90)
> >
> > If this is too much overhead, then we can initialize ctx = NULL;
> 
> We don't need zalloc() since we're setting all the fields, although
> more on this below ...

Ok...

> > > If we can't guarantee that "ab" is zero'd out, we should manually set
> > > ab->ctx to NULL when !CONFIG_AUDITSYSCALL.
> >
> > But ctx isn't part of struct audit_buffer when !CONFIG_AUDITSYSCALL.  It
> > is #ifdef-ed out.  What am I missing?
> 
> You're not, I am.  I saw the obvious bit where you removed it from the
> task_struct, but completely glossed over the bit where you also
> removed it from the audit_buffer struct.  My mistake.
> 
> Once the audit container ID stuff lands we are going to need to have
> the audit_context pointer in the audit_buffer regardless of the
> CONFIG_AUDITSYSCALL setting, right?  Assuming the answer is yes, I
> think I'd just assume leave the pointer in the audit_buffer (setting
> it to NULL when !CONFIG_AUDITSYSCALL) so we don't have to have those
> #ifdef's in the middle of the functions (I generally like to avoid
> those if possible).  I think it's still worth making the changes to
> task_struct, as that is the right thing to do and doesn't have the
> same level of impact.

I like to avoid #ifdef compiler directives out when I can too, creating
stubs in the header file to do the job.

Why do we need an audit_context pointer in struct audit_buffer?  I'll
take a stab at answering this...  I was thinking it wasn't necessary,
but now I think I see what I was missing.  I think the only reason is to
connect records to one event through the timestamp and serial number
when syscall is disabled.  Up until now it wasn't needed unless full
syscall functionality was present, but once we have an audit container
identifier aux record we will need to join them, at minimum with a local
context for user and netfilter_pkt records.

So I have to ask, does it make sense to restructure things so that the
struct audit_buffer has a serial and ctime field so that it isn't needed
in the struct audit_context?  I'm not sure if this is possible.  I'll
have to go back and look at the code to see if this is the case...

> paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
