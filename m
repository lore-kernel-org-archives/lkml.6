Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067DDC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C46B020851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfAQXTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 18:19:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57918 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726811AbfAQXTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 18:19:00 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0426C804FB;
        Thu, 17 Jan 2019 23:19:00 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-19.phx2.redhat.com [10.3.112.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BDF9260BE8;
        Thu, 17 Jan 2019 23:18:41 +0000 (UTC)
Date:   Thu, 17 Jan 2019 18:18:38 -0500
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Steve Grubb <sgrubb@redhat.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH ghak59 V3 2/4] audit: add syscall information to
 CONFIG_CHANGE records
Message-ID: <20190117231838.im4nku57qxutjveh@madcap2.tricolour.ca>
References: <cover.1544477629.git.rgb@redhat.com>
 <43548fafdfa98ee64ecfd0d7a69a2f5cb2c31c50.1544477629.git.rgb@redhat.com>
 <CAHC9VhSaTvVgSWVWo42Ur2k6hVNJ1XBkLwrd-J4-SUuidwXUYg@mail.gmail.com>
 <20190117103255.1f640a42@ivy-bridge>
 <CAHC9VhQvk+6AFjVU_ygyn8Q6FGwVy_JqXj7wWSNYYp5zSiBcuw@mail.gmail.com>
 <20190117153430.olcpsdq67mozk35e@madcap2.tricolour.ca>
 <CAHC9VhRBA0k9Mo2_GuscaxOGigbUhytepQ_3O1HQRvwZOwmt_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhRBA0k9Mo2_GuscaxOGigbUhytepQ_3O1HQRvwZOwmt_A@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 17 Jan 2019 23:19:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-17 12:58, Paul Moore wrote:
> On Thu, Jan 17, 2019 at 10:34 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> >
> > On 2019-01-17 08:21, Paul Moore wrote:
> > > On Thu, Jan 17, 2019 at 4:33 AM Steve Grubb <sgrubb@redhat.com> wrote:
> > > > On Mon, 14 Jan 2019 17:58:58 -0500 Paul Moore <paul@paul-moore.com> wrote:
> > > > > On Mon, Dec 10, 2018 at 5:18 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > > > > Tie syscall information to all CONFIG_CHANGE calls since they are
> > > > > > all a result of user actions.
> > > >
> > > > Please don't tie syscall information to this. The syscall will be
> > > > sendto. We don't need that information, its implicit. Also, doing this
> > > > will possibly wreck things in libauparse. Please test the events with
> > > > ausearch --format csv and --format text. IFF the event looks better or
> > > > the same should we do this. If stuff disappears, the patch is
> > > > breaking things
> > >
> > > We've discussed this quite a bit already; connecting associated
> > > records into a single event is something that should happen, needs to
> > > happen, and will happen.  Conceptually it makes no sense to record the
> > > syscall (and any other associated records) which triggers the audit
> > > configuration change, and the configuration change record itself as
> > > two distinct events - they are the same event.  We've also heard from
> > > a prominent user that associating records in this way is desirable.
> > >
> > > If the ausearch csv and text audit log transformations can't handle
> > > this particular change, I would consider that a shortcoming of that
> > > code.  We have multi-record events now, and this is only going to
> > > increase in the future.
> > >
> > > Richard, if you can't make the requested changes to this patch and
> > > resubmit by ... let's say the middle of next week? that should be
> > > enough time, yes? ... please let me know and I'll make the changes and
> > > get this merged.
> >
> > I would do the change, which should be very trivial, but I'm dense
> > enough that I still don't know what you want.  In the last 6 months I've
> > asked a number of direct questions that have not been directly
> > addressed.  Perhaps I should be able to figure it out from the more
> > general or fundamental principles replies I've gotten (which have been
> > helpful, but perhaps incomplete), but I'm still having some trouble.
> > Perhaps I'm exposing my limitations.
> 
> Since code is unambiguous, let me just cut and paste what I was
> thinking (be warned, this is a cut-n-paste, so the whitespace is
> probably mangled):

Thank you.  Very clear.  I don't see the point of
audit_log_user_recv_msg() for reasons already stated but that's ok.

Since we're looking at these, here are the various field formats of the
AUDIT_CONFIG_CHANGE records.

Steve and Paul, are they worth attempting to normalize?  Some can't
because there are two parameters changed in the same record.
I'm pretty sure some of the suggestions will break Steve's parsers, but I'm
also certain that some are already broken in their current state or were never
coded in.  I've tried triggering all of these, but failed on a couple and have
pinged Al Viro a couple of times for some clues how to do so and had no reply.

If it isn't worth it, I'll leave them as they are.

audit_log_config_change                 op %s old auid ses subj res
                                        op %s old res

audit_log_rule_change                   auid ses subj op key list res
                                        op key list res

audit_log_common_recv_msg ADD/DEL_RULE  pid uid auid ses subj op audit_enabled res
                                        op audit_enabled res

audit_log_common_recv_msg TRIM          pid uid auid ses subj op res
                                        op res

audit_log_common_recv_msg MAKE_EQUIV    pid uid auid ses subj op old new res
                                        op dir old res  (order/label change)

audit_log_common_recv_msg TTY_SET       pid uid auid ses subj op old-enabled new-enabled old-log_passwd new-log_passwd res
                                        op enabled old-enabled log_passwd old-log_passwd res (order/label change)

audit_mark_log_rule_change              auid ses op path key list res
                                        op path key list res

audit_tree_log_remove_rule              op dir key list res
                                        op dir key list res

audit_watch_log_rule_change             auid ses op path key list res
                                        op path key list res

audit_seccomp_actions_logged            op actions old-actions res
                                        op actions old res (label change)

> diff --git a/kernel/audit.c b/kernel/audit.c
> index d412fb4ae6d5..d2caef6ef09e 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -396,7 +396,7 @@ static int audit_log_config_change(char
> *function_name, u32 new, u32 old,
>        struct audit_buffer *ab;
>        int rc = 0;
> 
> -       ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE);
> +       ab = audit_log_start(audit_context(), GFP_KERNEL, AUDIT_CONFIG_CHANGE);
>        if (unlikely(!ab))
>                return rc;
>        audit_log_format(ab, "op=set %s=%u old=%u ", function_name, new, old);
> @@ -1053,7 +1053,8 @@ static int audit_netlink_ok(struct sk_buff *skb,
> u16 msg_type)
>        return err;
> }
> 
> -static void audit_log_common_recv_msg(struct audit_buffer **ab, u16 msg_type)
> +static void audit_log_common_recv_msg(struct audit_context *context,
> +                                       struct audit_buffer **ab, u16 msg_type)
> {
>        uid_t uid = from_kuid(&init_user_ns, current_uid());
>        pid_t pid = task_tgid_nr(current);
> @@ -1063,7 +1064,7 @@ static void audit_log_common_recv_msg(struct
> audit_buffer **ab, u16 msg_type)
>                return;
>        }
> 
> -       *ab = audit_log_start(NULL, GFP_KERNEL, msg_type);
> +       *ab = audit_log_start(context, GFP_KERNEL, msg_type);
>        if (unlikely(!*ab))
>                return;
>        audit_log_format(*ab, "pid=%d uid=%u ", pid, uid);
> @@ -1071,6 +1072,11 @@ static void audit_log_common_recv_msg(struct
> audit_buffer **ab, u16 msg_type)
>        audit_log_task_context(*ab);
> }
> 
> +static inline void audit_log_user_recv_msg(struct audit_buffer **ab,
> u16 msg_type)
> +{
> +       audit_log_common_recv_msg(NULL, ab, msg_type);
> +}
> +
> int is_audit_feature_set(int i)
> {
>        return af.features & AUDIT_FEATURE_TO_MASK(i);
> @@ -1338,7 +1344,7 @@ static int audit_receive_msg(struct sk_buff
> *skb, struct nlmsghdr *nlh)
>                                if (err)
>                                        break;
>                        }
> -                       audit_log_common_recv_msg(&ab, msg_type);
> +                       audit_log_user_recv_msg(&ab, msg_type);
>                        if (msg_type != AUDIT_USER_TTY)
>                                audit_log_format(ab, " msg='%.*s'",
>                                                 AUDIT_MESSAGE_TEXT_MAX,
> @@ -1361,7 +1367,8 @@ static int audit_receive_msg(struct sk_buff
> *skb, struct nlmsghdr *nlh)
>                if (nlmsg_len(nlh) < sizeof(struct audit_rule_data))
>                        return -EINVAL;
>                if (audit_enabled == AUDIT_LOCKED) {
> -                       audit_log_common_recv_msg(&ab, AUDIT_CONFIG_CHANGE);
> +                       audit_log_common_recv_msg(audit_context(), &ab,
> +                                                 AUDIT_CONFIG_CHANGE);
>                        audit_log_format(ab, " op=%s audit_enabled=%d res=0",
>                                         msg_type == AUDIT_ADD_RULE ?
>                                                "add_rule" : "remove_rule",
> @@ -1376,7 +1383,8 @@ static int audit_receive_msg(struct sk_buff
> *skb, struct nlmsghdr *nlh)
>                break;
>        case AUDIT_TRIM:
>                audit_trim_trees();
> -               audit_log_common_recv_msg(&ab, AUDIT_CONFIG_CHANGE);
> +               audit_log_common_recv_msg(audit_context(), &ab,
> +                                         AUDIT_CONFIG_CHANGE);
>                audit_log_format(ab, " op=trim res=1");
>                audit_log_end(ab);
>                break;
> @@ -1406,7 +1414,8 @@ static int audit_receive_msg(struct sk_buff
> *skb, struct nlmsghdr *nlh)
>                /* OK, here comes... */
>                err = audit_tag_tree(old, new);
> 
> -               audit_log_common_recv_msg(&ab, AUDIT_CONFIG_CHANGE);
> +               audit_log_common_recv_msg(audit_context(), &ab,
> +                                         AUDIT_CONFIG_CHANGE);
> 
>                audit_log_format(ab, " op=make_equiv old=");
>                audit_log_untrustedstring(ab, old);
> @@ -1474,7 +1483,8 @@ static int audit_receive_msg(struct sk_buff
> *skb, struct nlmsghdr *nlh)
>                old.enabled = t & AUDIT_TTY_ENABLE;
>                old.log_passwd = !!(t & AUDIT_TTY_LOG_PASSWD);
> 
> -               audit_log_common_recv_msg(&ab, AUDIT_CONFIG_CHANGE);
> +               audit_log_common_recv_msg(audit_context(), &ab,
> +                                         AUDIT_CONFIG_CHANGE);
>                audit_log_format(ab, " op=tty_set old-enabled=%d new-enabled=%d"
>                                 " old-log_passwd=%d new-log_passwd=%d res=%d",
>                                 old.enabled, s.enabled, old.log_passwd,
> diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
> index cf4512a33675..37ae95cfb7f4 100644
> --- a/kernel/audit_fsnotify.c
> +++ b/kernel/audit_fsnotify.c
> @@ -127,7 +127,7 @@ static void audit_mark_log_rule_change(struct
> audit_fsnotify_mark *audit_mark, c
> 
>        if (!audit_enabled)
>                return;
> -       ab = audit_log_start(NULL, GFP_NOFS, AUDIT_CONFIG_CHANGE);
> +       ab = audit_log_start(audit_context(), GFP_NOFS, AUDIT_CONFIG_CHANGE);
>        if (unlikely(!ab))
>                return;
>        audit_log_session_info(ab);
> diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
> index 20ef9ba134b0..e8d1adeb2223 100644
> --- a/kernel/audit_watch.c
> +++ b/kernel/audit_watch.c
> @@ -242,7 +242,7 @@ static void audit_watch_log_rule_change(struct
> audit_krule *r, struct audit_watc
> 
>        if (!audit_enabled)
>                return;
> -       ab = audit_log_start(NULL, GFP_NOFS, AUDIT_CONFIG_CHANGE);
> +       ab = audit_log_start(audit_context(), GFP_NOFS, AUDIT_CONFIG_CHANGE);
>        if (!ab)
>                return;
>        audit_log_session_info(ab);
> diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
> index bf309f2592c4..26a80a9d43a9 100644
> --- a/kernel/auditfilter.c
> +++ b/kernel/auditfilter.c
> @@ -1091,7 +1091,7 @@ static void audit_log_rule_change(char *action,
> struct audit_krule *rule, int re
>        if (!audit_enabled)
>                return;
> 
> -       ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE);
> +       ab = audit_log_start(audit_context(), GFP_KERNEL, AUDIT_CONFIG_CHANGE);
>        if (!ab)
>                return;
>        audit_log_session_info(ab);
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
