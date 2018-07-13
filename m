Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B41ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 00:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 398642147E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 00:43:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 398642147E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387893AbeGMAz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 20:55:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37370 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387803AbeGMAz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 20:55:58 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C78E4402315B;
        Fri, 13 Jul 2018 00:43:52 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-10.rdu2.redhat.com [10.10.112.10])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C2122156889;
        Fri, 13 Jul 2018 00:43:51 +0000 (UTC)
Date:   Thu, 12 Jul 2018 20:41:22 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>, sgrubb@redhat.com,
        aviro@redhat.com
Subject: Re: [RFC PATCH ghak59 V1 1/6] audit: give a clue what CONFIG_CHANGE
 op was involved
Message-ID: <20180713004122.qlxdpkae4ihkxatg@madcap2.tricolour.ca>
References: <cover.1529003588.git.rgb@redhat.com>
 <17f22b579c28c6cd9475a57e792b5d4fb4dde1dc.1529003588.git.rgb@redhat.com>
 <CAHC9VhTxjcmJGEq6XQmRV0Ouk8oOyHO2C8+HVQOy1qxw9yKyXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhTxjcmJGEq6XQmRV0Ouk8oOyHO2C8+HVQOy1qxw9yKyXw@mail.gmail.com>
User-Agent: NeoMutt/20180512
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 13 Jul 2018 00:43:52 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 13 Jul 2018 00:43:52 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'rgb@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-28 15:41, Paul Moore wrote:
> On Thu, Jun 14, 2018 at 4:23 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > The failure to add an audit rule due to audit locked gives no clue
> > what CONFIG_CHANGE operation failed.
> > Similarly the set operation is the only other operation that doesn't
> > give the "op=" field to indicate the action.
> > All other CONFIG_CHANGE records include an op= field to give a clue as
> > to what sort of configuration change is being executed.
> >
> > Since these are the only CONFIG_CHANGE records that that do not have an
> > op= field, add them to bring them in line with the rest.
> 
> Normally this would be an immediate reject because this patch inserts
> a field into an existing record, but the CONFIG_CHANGE record is so
> variable (supposedly bad in its own right) that I don't this really
> matters.
> 
> With that out of the way, I think this patch is fine, but I don't
> think it is complete.  At the very least there is another
> CONFIG_CHANGE record in audit_watch_log_rule_change() that doesn't
> appear to include an "op" field.  If we want to make sure we have an
> "op" field in every CONFIG_CHANGE record, let's actually add them all
> :)

The version I'm looking at already had it when it was added in 2009.

This one doesn't add the auid and ses fields because they will be
covered by the linking of this record with the syscall record via the
audit_context() introduced in another patch.

> There appears to be another one in audit_mark_log_rule_change() ...

Same, 2015.

> and one more in audit_receive_msg().  There may be more.

I believe they're covered by other patches in the ghak59 set.

> > Old records:
> > type=CONFIG_CHANGE msg=audit(1519812997.781:374): pid=610 uid=0 auid=0 ses=1 subj=... audit_enabled=2 res=0
> > type=CONFIG_CHANGE msg=audit(2018-06-14 14:55:04.507:47) : audit_enabled=1 old=1 auid=unset ses=unset subj=... res=yes
> >
> > New records:
> > type=CONFIG_CHANGE msg=audit(1520958477.855:100): pid=610 uid=0 auid=0 ses=1 subj=... op=add_rule audit_enabled=2 res=0
> >
> > type=CONFIG_CHANGE msg=audit(2018-06-14 14:55:04.507:47) : op=set audit_enabled=1 old=1 auid=unset ses=unset subj=... res=yes
> >
> > See: https://github.com/linux-audit/audit-kernel/issues/59
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> >  kernel/audit.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/audit.c b/kernel/audit.c
> > index e7478cb..ad54339 100644
> > --- a/kernel/audit.c
> > +++ b/kernel/audit.c
> > @@ -403,7 +403,7 @@ static int audit_log_config_change(char *function_name, u32 new, u32 old,
> >         ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE);
> >         if (unlikely(!ab))
> >                 return rc;
> > -       audit_log_format(ab, "%s=%u old=%u", function_name, new, old);
> > +       audit_log_format(ab, "op=set %s=%u old=%u", function_name, new, old);
> >         audit_log_session_info(ab);
> >         rc = audit_log_task_context(ab);
> >         if (rc)
> > @@ -1365,7 +1365,9 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
> >                         return -EINVAL;
> >                 if (audit_enabled == AUDIT_LOCKED) {
> >                         audit_log_common_recv_msg(&ab, AUDIT_CONFIG_CHANGE);
> > -                       audit_log_format(ab, " audit_enabled=%d res=0", audit_enabled);
> > +                       audit_log_format(ab, " op=%s_rule audit_enabled=%d res=0",
> > +                                        msg_type == AUDIT_ADD_RULE ? "add" : "remove",
> > +                                        audit_enabled);
> >                         audit_log_end(ab);
> >                         return -EPERM;
> >                 }
> > --
> > 1.8.3.1
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
