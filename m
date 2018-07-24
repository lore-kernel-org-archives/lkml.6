Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B2BC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEF2D205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:10:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEF2D205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388465AbeGXPQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 11:16:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44226 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388320AbeGXPQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 11:16:58 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E085A401EF17;
        Tue, 24 Jul 2018 14:10:17 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-54.rdu2.redhat.com [10.10.112.54])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A1D952027047;
        Tue, 24 Jul 2018 14:10:14 +0000 (UTC)
Date:   Tue, 24 Jul 2018 10:07:21 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     cgroups@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org, linux-audit@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, ebiederm@xmission.com, luto@kernel.org,
        jlayton@redhat.com, carlos@redhat.com, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, simo@redhat.com,
        Eric Paris <eparis@parisplace.org>, serge@hallyn.com
Subject: Re: [RFC PATCH ghak90 (was ghak32) V3 05/10] audit: add containerid
 support for tty_audit
Message-ID: <20180724140721.yyi5e7y3czxsjwug@madcap2.tricolour.ca>
References: <cover.1528304203.git.rgb@redhat.com>
 <28ab8ad3c4e5de6f61b928eeb2af030b04a8820b.1528304204.git.rgb@redhat.com>
 <CAHC9VhTTJVbFq_Cmu8E7EzQD-JXjkbDz7P1EY8ePVrXpQAqPdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhTTJVbFq_Cmu8E7EzQD-JXjkbDz7P1EY8ePVrXpQAqPdw@mail.gmail.com>
User-Agent: NeoMutt/20180512
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 24 Jul 2018 14:10:17 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 24 Jul 2018 14:10:17 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'rgb@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-20 18:14, Paul Moore wrote:
> On Wed, Jun 6, 2018 at 1:04 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > Add audit container identifier auxiliary record to tty logging rule
> > event standalone records.
> >
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> >  drivers/tty/tty_audit.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/tty/tty_audit.c b/drivers/tty/tty_audit.c
> > index e30aa6b..66bd850 100644
> > --- a/drivers/tty/tty_audit.c
> > +++ b/drivers/tty/tty_audit.c
> > @@ -66,8 +66,9 @@ static void tty_audit_log(const char *description, dev_t dev,
> >         uid_t uid = from_kuid(&init_user_ns, task_uid(tsk));
> >         uid_t loginuid = from_kuid(&init_user_ns, audit_get_loginuid(tsk));
> >         unsigned int sessionid = audit_get_sessionid(tsk);
> > +       struct audit_context *context = audit_alloc_local();
> 
> We should be using current's audit_context in tty_audit_log().
> Actually, we should probably just get rid of the tsk variable in
> tty_audit_log() and use current directly to make things a bit more
> obvious.

Ok, agreed.  At this point, it it current passed in anyways so no harm
other than efficiency.

> <time passes>
> 
> I did some digging and I have a two year old, half-baked patch that
> cleans up this tsk/current usage as well as a few others.  I just
> rebased it against audit/next and surprisingly it seems to pass a
> basic smoke test (kernel boots and audit-testsuite passes); I'll post
> it to the list as a RFC once I'm done reviewing these patches.

I'll leave this patch the way it is since there should be no difference
and trust this other patch will work its way through the system and
solve that.

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
