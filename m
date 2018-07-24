Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C0CECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1858E20875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:05:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1858E20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388403AbeGXOL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 10:11:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38320 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388279AbeGXOL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 10:11:26 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 18DE7B798;
        Tue, 24 Jul 2018 13:05:01 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-54.rdu2.redhat.com [10.10.112.54])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7755E1C641;
        Tue, 24 Jul 2018 13:04:56 +0000 (UTC)
Date:   Tue, 24 Jul 2018 09:02:03 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Eric Paris <eparis@parisplace.org>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org, Steve Grubb <sgrubb@redhat.com>
Subject: Re: [RFC PATCH ghak59 V1 3/6] audit: exclude user records from
 syscall context
Message-ID: <20180724130203.by5ev4xhaixgzvq5@madcap2.tricolour.ca>
References: <cover.1529003588.git.rgb@redhat.com>
 <907e32319825bb6336a662f4f6f6d173f56f3226.1529003588.git.rgb@redhat.com>
 <CAHC9VhSKcxHScr-ZNQU3iVrqhU4CDKW7tpn3e+NBKAAmnpRP4g@mail.gmail.com>
 <20180712214608.ed4chli7mdc7ymin@madcap2.tricolour.ca>
 <20180723164035.wkazolpmpf3mvdxw@madcap2.tricolour.ca>
 <CAHC9VhQ3qxHQ6mHhs1JNMg5qr3qJJh2DpD147QWnfsXdM7=rGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhQ3qxHQ6mHhs1JNMg5qr3qJJh2DpD147QWnfsXdM7=rGA@mail.gmail.com>
User-Agent: NeoMutt/20180512
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 24 Jul 2018 13:05:01 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 24 Jul 2018 13:05:01 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'rgb@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-23 17:00, Paul Moore wrote:
> On Mon, Jul 23, 2018 at 12:43 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > On 2018-07-12 17:46, Richard Guy Briggs wrote:
> > > On 2018-06-28 18:11, Paul Moore wrote:
> > > > On Thu, Jun 14, 2018 at 4:23 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > > > Since the function audit_log_common_recv_msg() is shared by a number of
> > > > > AUDIT_CONFIG_CHANGE and the entire range of AUDIT_USER_* record types,
> > > > > and since the AUDIT_CONFIG_CHANGE message type has been converted to a
> > > > > syscall accompanied record type, special-case the AUDIT_USER_* range of
> > > > > messages so they remain standalone records.
> > > > >
> > > > > See: https://github.com/linux-audit/audit-kernel/issues/59
> > > > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > > > ---
> > > > >  kernel/audit.c | 12 +++++++++---
> > > > >  1 file changed, 9 insertions(+), 3 deletions(-)
> > > >
> > > > I think this is fine, but see my previous comment about combining 2/6
> > > > and 3/6 as a safety measure.
> > >
> > > This one I left as a seperate patch for discussion.  We'd previously
> > > talked about connecting all possible records with syscall records if
> > > they exist, but this one I'm unsure about, since we don't really care
> > > what userspace process is issuing this message.  It is just the message
> > > content itself that is important.  Or is it?  Are we concerned about
> > > CAP_AUDIT_WRITE holders/abusers and want as much info about them as we
> > > can get in case they go rogue or pear-shaped?
> >
> > I'm waiting on re-spinning this patchset because of this open question.
> >
> > Is connecting AUDIT_USER* records desirable or a liability?
> 
> Like I said, I think special casing the AUDIT_USER* records so they
> are *not* associated with other records is okay, and perhaps even the
> right thing to do.  The problem is that we don't have the necessary
> context (har har) to match any kernel events (and there is the
> possibility that there are none) to the userspace generated
> AUDIT_USER* event.  Further, I don't think this is something we would
> ever be able to solve in a reasonable manner.

Ok, having said that, I think I'd still prefer to keep this patch
seperate, partly to retain the simplicity of the previous patch and make
very clear what each one is doing, and partly if we decide to change our
mind in the future that these AUDIT_USER* records should be autonomous.

> > > > > diff --git a/kernel/audit.c b/kernel/audit.c
> > > > > index e469234..c8c2efc 100644
> > > > > --- a/kernel/audit.c
> > > > > +++ b/kernel/audit.c
> > > > > @@ -1057,7 +1057,8 @@ static int audit_netlink_ok(struct sk_buff *skb, u16 msg_type)
> > > > >         return err;
> > > > >  }
> > > > >
> > > > > -static void audit_log_common_recv_msg(struct audit_buffer **ab, u16 msg_type)
> > > > > +static void __audit_log_common_recv_msg(struct audit_context *context,
> > > > > +                                       struct audit_buffer **ab, u16 msg_type)
> > > > >  {
> > > > >         uid_t uid = from_kuid(&init_user_ns, current_uid());
> > > > >         pid_t pid = task_tgid_nr(current);
> > > > > @@ -1067,7 +1068,7 @@ static void audit_log_common_recv_msg(struct audit_buffer **ab, u16 msg_type)
> > > > >                 return;
> > > > >         }
> > > > >
> > > > > -       *ab = audit_log_start(audit_context(), GFP_KERNEL, msg_type);
> > > > > +       *ab = audit_log_start(context, GFP_KERNEL, msg_type);
> > > > >         if (unlikely(!*ab))
> > > > >                 return;
> > > > >         audit_log_format(*ab, "pid=%d uid=%u", pid, uid);
> > > > > @@ -1075,6 +1076,11 @@ static void audit_log_common_recv_msg(struct audit_buffer **ab, u16 msg_type)
> > > > >         audit_log_task_context(*ab);
> > > > >  }
> > > > >
> > > > > +static inline void audit_log_common_recv_msg(struct audit_buffer **ab, u16 msg_type)
> > > > > +{
> > > > > +       __audit_log_common_recv_msg(audit_context(), ab, msg_type);
> > > > > +}
> > > > > +
> > > > >  int is_audit_feature_set(int i)
> > > > >  {
> > > > >         return af.features & AUDIT_FEATURE_TO_MASK(i);
> > > > > @@ -1341,7 +1347,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
> > > > >                                 if (err)
> > > > >                                         break;
> > > > >                         }
> > > > > -                       audit_log_common_recv_msg(&ab, msg_type);
> > > > > +                       __audit_log_common_recv_msg(NULL, &ab, msg_type);
> > > > >                         if (msg_type != AUDIT_USER_TTY)
> > > > >                                 audit_log_format(ab, " msg='%.*s'",
> > > > >                                                  AUDIT_MESSAGE_TEXT_MAX,
> > > > > --
> > > > > 1.8.3.1
> > > > >
> > > >
> > > >
> > > > --
> > > > paul moore
> > > > www.paul-moore.com
> > > >
> > > > --
> > > > Linux-audit mailing list
> > > > Linux-audit@redhat.com
> > > > https://www.redhat.com/mailman/listinfo/linux-audit
> > >
> > > - RGB
> > >
> > > --
> > > Richard Guy Briggs <rgb@redhat.com>
> > > Sr. S/W Engineer, Kernel Security, Base Operating Systems
> > > Remote, Ottawa, Red Hat Canada
> > > IRC: rgb, SunRaycer
> > > Voice: +1.647.777.2635, Internal: (81) 32635
> > >
> > > --
> > > Linux-audit mailing list
> > > Linux-audit@redhat.com
> > > https://www.redhat.com/mailman/listinfo/linux-audit
> >
> > - RGB
> >
> > --
> > Richard Guy Briggs <rgb@redhat.com>
> > Sr. S/W Engineer, Kernel Security, Base Operating Systems
> > Remote, Ottawa, Red Hat Canada
> > IRC: rgb, SunRaycer
> > Voice: +1.647.777.2635, Internal: (81) 32635
> 
> 
> 
> -- 
> paul moore
> www.paul-moore.com

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
