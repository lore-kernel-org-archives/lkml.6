Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE271C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C198D21852
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729896AbfA2XSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 18:18:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48412 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729828AbfA2XSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 18:18:01 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A38D17F41D;
        Tue, 29 Jan 2019 23:18:00 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-14.phx2.redhat.com [10.3.112.14])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E3CEB19C65;
        Tue, 29 Jan 2019 23:17:53 +0000 (UTC)
Date:   Tue, 29 Jan 2019 18:17:51 -0500
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        Eric Paris <eparis@redhat.com>, Steve Grubb <sgrubb@redhat.com>
Subject: Re: [PATCH ghak105 V2] audit: remove audit_context when CONFIG_
 AUDIT and not AUDITSYSCALL
Message-ID: <20190129231750.i3yxoqv3jb352dwk@madcap2.tricolour.ca>
References: <6378bddc2ca871615ebbdaffe17ee0b4482c44a0.1548700115.git.rgb@redhat.com>
 <CAHC9VhQkLAgEUf6Rc6ovDyiJuNvm6PaKp0gGzDus6nkKDekWww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhQkLAgEUf6Rc6ovDyiJuNvm6PaKp0gGzDus6nkKDekWww@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 29 Jan 2019 23:18:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-29 18:07, Paul Moore wrote:
> On Mon, Jan 28, 2019 at 1:33 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > Remove audit_context from struct task_struct and struct audit_buffer
> > when CONFIG_AUDIT is enabled but CONFIG_AUDITSYSCALL is not.
> >
> > Also, audit_log_name() (and supporting inode and fcaps functions) should
> > have been put back in auditsc.c when soft and hard link logging was
> > normalized since it is only used by syscall auditing.
> >
> > See github issue https://github.com/linux-audit/audit-kernel/issues/105
> >
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> > Changelog:
> > v2:
> > - resolve merge conflicts from rebase on upstreamed ghak103 patch
> > - wrap task_struct audit_context in CONFIG_AUDITSYSCALL
> >
> >  include/linux/sched.h |   4 +-
> >  kernel/audit.c        | 157 +++-----------------------------------------------
> >  kernel/audit.h        |   9 ---
> >  kernel/auditsc.c      | 150 +++++++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 161 insertions(+), 159 deletions(-)
> 
> ...
> 
> > diff --git a/kernel/audit.c b/kernel/audit.c
> > index 3f3f1888cac7..15e41603fd34 100644
> > --- a/kernel/audit.c
> > +++ b/kernel/audit.c
> > @@ -205,7 +205,9 @@ struct audit_net {
> >   * use simultaneously. */
> >  struct audit_buffer {
> >         struct sk_buff       *skb;      /* formatted skb ready to send */
> > +#ifdef CONFIG_AUDITSYSCALL
> >         struct audit_context *ctx;      /* NULL or associated context */
> > +#endif
> >         gfp_t                gfp_mask;
> >  };
> >
> > @@ -1696,7 +1698,9 @@ static struct audit_buffer *audit_buffer_alloc(struct audit_context *ctx,
> >         if (!nlmsg_put(ab->skb, 0, 0, type, 0, 0))
> >                 goto err;
> >
> > +#ifdef CONFIG_AUDITSYSCALL
> >         ab->ctx = ctx;
> > +#endif
> 
> I vaguely remember reading/hearing something in the past about
> kmem_cache_alloc() not returning a zero'd out buffer in all cases, can
> you say for certain that "ab" in this case is always going to be
> zero'd out?  This is an honest question.

Ok, then maybe we should be using kmem_cache_zalloc() instead of
kmem_cache_alloc() in audit_buffer_alloc()?  (as I've done in
the last patch of ghak81/first patch of ghak90)

If this is too much overhead, then we can initialize ctx = NULL;

> If we can't guarantee that "ab" is zero'd out, we should manually set
> ab->ctx to NULL when !CONFIG_AUDITSYSCALL.

But ctx isn't part of struct audit_buffer when !CONFIG_AUDITSYSCALL.  It
is #ifdef-ed out.  What am I missing?

> >         ab->gfp_mask = gfp_mask;
> >
> >         return ab;
> > @@ -1809,7 +1813,11 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
> >                 return NULL;
> >         }
> >
> > +#ifdef CONFIG_AUDITSYSCALL
> >         audit_get_stamp(ab->ctx, &t, &serial);
> > +#else
> > +       audit_get_stamp(NULL, &t, &serial);
> > +#endif
> 
> If ab->ctx is NULL we don't really need this, do we?

We do if ctx isn't part of struct audit_buffer when
!CONFIG_AUDITSYSCALL.

> >         audit_log_format(ab, "audit(%llu.%03lu:%u): ",
> >                          (unsigned long long)t.tv_sec, t.tv_nsec/1000000, serial);
> >
> 
> paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
