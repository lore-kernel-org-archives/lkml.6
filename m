Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D66DC6778F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 22:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 204BD20852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 22:39:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 204BD20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388870AbeGXXri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 19:47:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57950 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388495AbeGXXrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 19:47:37 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 57CD04077EE6;
        Tue, 24 Jul 2018 22:38:58 +0000 (UTC)
Received: from ovpn-112-75.rdu2.redhat.com (ovpn-112-75.rdu2.redhat.com [10.10.112.75])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5FC8D111AF1B;
        Tue, 24 Jul 2018 22:38:55 +0000 (UTC)
Message-ID: <89963f4c8c4f89bc766ffc0b58fe8e24942c3793.camel@redhat.com>
Subject: Re: [PATCH] audit: fix potential null dereference
 'context->module.name'
From:   Eric Paris <eparis@redhat.com>
To:     Paul Moore <paul@paul-moore.com>, wang.yi59@zte.com.cn
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org,
        jiang.biao2@zte.com.cn, zhong.weidong@zte.com.cn
Date:   Tue, 24 Jul 2018 18:38:54 -0400
In-Reply-To: <CAHC9VhQy6Rakx6WZ236R+PjwtaZ2Sq9SuoGMC8iejOmhRbCM_w@mail.gmail.com>
References: <1532411834-33775-1-git-send-email-wang.yi59@zte.com.cn>
         <450ab68cc6b7cebbf1b6292e3140932ea1ac9e57.camel@redhat.com>
         <CAHC9VhQy6Rakx6WZ236R+PjwtaZ2Sq9SuoGMC8iejOmhRbCM_w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 24 Jul 2018 22:38:58 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 24 Jul 2018 22:38:58 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'eparis@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-24 at 15:55 -0400, Paul Moore wrote:
> On Tue, Jul 24, 2018 at 7:39 AM Eric Paris <eparis@redhat.com> wrote:
> > Would it make more sense to actually check for failure on
> > allocation
> > rather than try to remember to deal with it later? How about we
> > just
> > have audit_log_kern_module return an error and fail if we are OOM?
> 
> Generally I agree, checking on allocation is the right thing to do.
> However, in this particular case the error recovery for a failed
> allocation would likely ignore the record entirely, and I think a
> module load record with a "(null)" module name is still better than
> no
> module load record at all ... and yes, I understand that if the
> module
> name allocation fails there is a good chance other allocations will
> fail and we might not emit the record, but I'll take my chances that
> the load is transient and the system is able to recover in a timely
> manner.

On the load_module() code path passing the error up the stack would
cause the module to not be loaded, instead of being loaded with loss of
name information. I'd rather have the module not loaded and a
name=(null) record than it BE loaded and get name=(null)

You've sold me on why Yi Wang's patch is good, but not on why we
wouldn't propagate the error up the stack on load/delete. (even if we
may choose to delete the module on OOM)

-Eric

> > (also this seems like a good place to use kstrdup, instead of
> > kmalloc+strcpy)
> 
> Yes, I agree.  Yi Wang, could you submit a v2 of this patch using
> kstrdup()?
> 
> > On Tue, 2018-07-24 at 13:57 +0800, Yi Wang wrote:
> > > The variable 'context->module.name' may be null pointer when
> > > kmalloc return null, so it's better to check it before using
> > > to avoid null dereference.
> > > 
> > > Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> > > Reviewed-by: Jiang Biao <jiang.biao2@zte.com.cn>
> > > ---
> > >  kernel/auditsc.c | 11 ++++++++---
> > >  1 file changed, 8 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > > index e80459f..4830b83 100644
> > > --- a/kernel/auditsc.c
> > > +++ b/kernel/auditsc.c
> > > @@ -1272,8 +1272,12 @@ static void show_special(struct
> > > audit_context
> > > *context, int *call_panic)
> > >               break;
> > >       case AUDIT_KERN_MODULE:
> > >               audit_log_format(ab, "name=");
> > > -             audit_log_untrustedstring(ab, context-
> > > >module.name);
> > > -             kfree(context->module.name);
> > > +             if (context->module.name) {
> > > +                     audit_log_untrustedstring(ab, context-
> > > > module.name);
> > > 
> > > +                     kfree(context->module.name);
> > > +             } else
> > > +                     audit_log_format(ab, "(null)");
> > > +
> > >               break;
> > >       }
> > >       audit_log_end(ab);
> > > @@ -2409,7 +2413,8 @@ void __audit_log_kern_module(char *name)
> > >       struct audit_context *context = current->audit_context;
> > > 
> > >       context->module.name = kmalloc(strlen(name) + 1,
> > > GFP_KERNEL);
> > > -     strcpy(context->module.name, name);
> > > +     if (context->module.name)
> > > +             strcpy(context->module.name, name);
> > >       context->type = AUDIT_KERN_MODULE;
> > >  }
> > > 
> 
> 
> 
