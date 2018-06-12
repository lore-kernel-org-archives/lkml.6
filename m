Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id EBB3DC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D87B20693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D87B20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754427AbeFLUrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 16:47:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53650 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754302AbeFLUrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 16:47:13 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BAC57400138A;
        Tue, 12 Jun 2018 20:47:12 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-57.rdu2.redhat.com [10.10.112.57])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6DF8D111CB82;
        Tue, 12 Jun 2018 20:47:06 +0000 (UTC)
Date:   Tue, 12 Jun 2018 16:45:40 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux NetDev Upstream Mailing List <netdev@vger.kernel.org>,
        Netfilter Devel List <netfilter-devel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Eric Paris <eparis@redhat.com>, Steve Grubb <sgrubb@redhat.com>
Subject: Re: [RFC PATCH ghak86 V1] audit: eliminate audit_enabled magic
 number comparison
Message-ID: <20180612204539.ccvlox67annsikmw@madcap2.tricolour.ca>
References: <490a00a7902582823fe8c532f5dd995a1da61fb1.1528214962.git.rgb@redhat.com>
 <CAHC9VhQuLbbRp4ETzonD0XYQ3oQP9fuq-f7zrytQY7BQ0ANCZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhQuLbbRp4ETzonD0XYQ3oQP9fuq-f7zrytQY7BQ0ANCZA@mail.gmail.com>
User-Agent: NeoMutt/20180512
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 12 Jun 2018 20:47:12 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 12 Jun 2018 20:47:12 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'rgb@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-12 16:33, Paul Moore wrote:
> On Tue, Jun 5, 2018 at 7:20 PM, Richard Guy Briggs <rgb@redhat.com> wrote:
> > Remove comparison of audit_enabled to magic numbers outside of audit.
> >
> > Related: https://github.com/linux-audit/audit-kernel/issues/86
> >
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> >  drivers/tty/tty_audit.c      | 2 +-
> >  include/linux/audit.h        | 5 ++++-
> >  include/net/xfrm.h           | 2 +-
> >  kernel/audit.c               | 3 ---
> >  net/netfilter/xt_AUDIT.c     | 2 +-
> >  net/netlabel/netlabel_user.c | 2 +-
> >  6 files changed, 8 insertions(+), 8 deletions(-)
> 
> An improvement, thank you.  Thankfully there are no tariffs on patches
> so I've queued this up for after the merge window.

Check with the So Called Ruler Of The United States first just to be
sure.  I'll dress it up in a kurta if that helps.

> > diff --git a/drivers/tty/tty_audit.c b/drivers/tty/tty_audit.c
> > index e30aa6b..50f567b 100644
> > --- a/drivers/tty/tty_audit.c
> > +++ b/drivers/tty/tty_audit.c
> > @@ -92,7 +92,7 @@ static void tty_audit_buf_push(struct tty_audit_buf *buf)
> >  {
> >         if (buf->valid == 0)
> >                 return;
> > -       if (audit_enabled == 0) {
> > +       if (audit_enabled == AUDIT_OFF) {
> >                 buf->valid = 0;
> >                 return;
> >         }
> > diff --git a/include/linux/audit.h b/include/linux/audit.h
> > index 69c7847..9334fbe 100644
> > --- a/include/linux/audit.h
> > +++ b/include/linux/audit.h
> > @@ -117,6 +117,9 @@ struct audit_field {
> >
> >  extern void audit_log_session_info(struct audit_buffer *ab);
> >
> > +#define AUDIT_OFF      0
> > +#define AUDIT_ON       1
> > +#define AUDIT_LOCKED   2
> >  #ifdef CONFIG_AUDIT
> >  /* These are defined in audit.c */
> >                                 /* Public API */
> > @@ -202,7 +205,7 @@ static inline int audit_log_task_context(struct audit_buffer *ab)
> >  static inline void audit_log_task_info(struct audit_buffer *ab,
> >                                        struct task_struct *tsk)
> >  { }
> > -#define audit_enabled 0
> > +#define audit_enabled AUDIT_OFF
> >  #endif /* CONFIG_AUDIT */
> >
> >  #ifdef CONFIG_AUDIT_COMPAT_GENERIC
> > diff --git a/include/net/xfrm.h b/include/net/xfrm.h
> > index 7f2e31a..ce995a1 100644
> > --- a/include/net/xfrm.h
> > +++ b/include/net/xfrm.h
> > @@ -734,7 +734,7 @@ static inline struct audit_buffer *xfrm_audit_start(const char *op)
> >  {
> >         struct audit_buffer *audit_buf = NULL;
> >
> > -       if (audit_enabled == 0)
> > +       if (audit_enabled == AUDIT_OFF)
> >                 return NULL;
> >         audit_buf = audit_log_start(audit_context(), GFP_ATOMIC,
> >                                     AUDIT_MAC_IPSEC_EVENT);
> > diff --git a/kernel/audit.c b/kernel/audit.c
> > index e7478cb..8442c65 100644
> > --- a/kernel/audit.c
> > +++ b/kernel/audit.c
> > @@ -83,9 +83,6 @@
> >  #define AUDIT_INITIALIZED      1
> >  static int     audit_initialized;
> >
> > -#define AUDIT_OFF      0
> > -#define AUDIT_ON       1
> > -#define AUDIT_LOCKED   2
> >  u32            audit_enabled = AUDIT_OFF;
> >  bool           audit_ever_enabled = !!AUDIT_OFF;
> >
> > diff --git a/net/netfilter/xt_AUDIT.c b/net/netfilter/xt_AUDIT.c
> > index f368ee6..af883f1 100644
> > --- a/net/netfilter/xt_AUDIT.c
> > +++ b/net/netfilter/xt_AUDIT.c
> > @@ -72,7 +72,7 @@ static bool audit_ip6(struct audit_buffer *ab, struct sk_buff *skb)
> >         struct audit_buffer *ab;
> >         int fam = -1;
> >
> > -       if (audit_enabled == 0)
> > +       if (audit_enabled == AUDIT_OFF)
> >                 goto errout;
> >         ab = audit_log_start(NULL, GFP_ATOMIC, AUDIT_NETFILTER_PKT);
> >         if (ab == NULL)
> > diff --git a/net/netlabel/netlabel_user.c b/net/netlabel/netlabel_user.c
> > index 2f328af..4676f5b 100644
> > --- a/net/netlabel/netlabel_user.c
> > +++ b/net/netlabel/netlabel_user.c
> > @@ -101,7 +101,7 @@ struct audit_buffer *netlbl_audit_start_common(int type,
> >         char *secctx;
> >         u32 secctx_len;
> >
> > -       if (audit_enabled == 0)
> > +       if (audit_enabled == AUDIT_OFF)
> >                 return NULL;
> >
> >         audit_buf = audit_log_start(audit_context(), GFP_ATOMIC, type);
> 
> paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
