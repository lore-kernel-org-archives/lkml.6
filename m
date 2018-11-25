Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3163CC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 17:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E38EB20868
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 17:11:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E38EB20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbeKZECy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 23:02:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36330 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbeKZECx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 23:02:53 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C14C3308FB8F;
        Sun, 25 Nov 2018 17:11:23 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-24.phx2.redhat.com [10.3.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 994761778D;
        Sun, 25 Nov 2018 17:11:18 +0000 (UTC)
Date:   Sun, 25 Nov 2018 12:11:15 -0500
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/3] audit: remove arch_f pointer from struct
 audit_krule
Message-ID: <20181125171115.su4kuu44lazqw56n@madcap2.tricolour.ca>
References: <cover.1518435853.git.rgb@redhat.com>
 <7289e57d94a0a13965e3dbd279cc8cd12dfb29a6.1518435853.git.rgb@redhat.com>
 <CAHC9VhRv_F=Gqs7EyTR2ZmLtJobyH9B8Cg-iiHE5hacTC-d=Pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhRv_F=Gqs7EyTR2ZmLtJobyH9B8Cg-iiHE5hacTC-d=Pw@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Sun, 25 Nov 2018 17:11:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-02-15 15:42, Paul Moore wrote:
> On Mon, Feb 12, 2018 at 7:29 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> > The arch_f pointer was added to the struct audit_krule in commit:
> > e54dc2431d740a79a6bd013babade99d71b1714f ("audit signal recipients")
> >
> > This is only used on addition and deletion of rules which isn't time
> > critical and the arch field is likely to be one of the first fields,
> > easily found iterating over the field type.  This isn't worth the
> > additional complexity and storage.  Delete the field.
> >
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> >  include/linux/audit.h |  1 -
> >  kernel/auditfilter.c  | 12 ++++++++----
> >  2 files changed, 8 insertions(+), 5 deletions(-)
> 
> I haven't decided if I like the removal of arch_f or not, but I think
> I might know where your oops/panic is coming from, thoughts below ...

Have you decided yet if you like the removal of the arch_f pointer or
not?  An updated v2 was provided the following day:
	https://www.redhat.com/archives/linux-audit/2018-February/msg00059.html

I will send an updated patch if it seems worthwhile.

> > diff --git a/include/linux/audit.h b/include/linux/audit.h
> > index af410d9..64a3b0e 100644
> > --- a/include/linux/audit.h
> > +++ b/include/linux/audit.h
> > @@ -58,7 +58,6 @@ struct audit_krule {
> >         u32                     field_count;
> >         char                    *filterkey; /* ties events to rules */
> >         struct audit_field      *fields;
> > -       struct audit_field      *arch_f; /* quick access to arch field */
> >         struct audit_field      *inode_f; /* quick access to an inode field */
> >         struct audit_watch      *watch; /* associated watch */
> >         struct audit_tree       *tree;  /* associated watched tree */
> > diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
> > index 739a6d2..3343d1c 100644
> > --- a/kernel/auditfilter.c
> > +++ b/kernel/auditfilter.c
> > @@ -220,7 +220,14 @@ static inline int audit_match_class_bits(int class, u32 *mask)
> >
> >  static int audit_match_signal(struct audit_entry *entry)
> >  {
> > -       struct audit_field *arch = entry->rule.arch_f;
> > +       int i;
> > +       struct audit_field *arch;
> > +
> > +       for (i = 0; i < entry->rule.field_count; i++)
> > +               if (entry->rule.fields[i].type == AUDIT_ARCH) {
> > +                       arch = &entry->rule.fields[i];
> > +                       break;
> > +               }
> 
> In the original code arch_f was initialized to NULL via the allocator
> so the arch local variable was guaranteed to have a valid value or
> NULL.  Unfortunately, in your code if there is no AUDIT_ARCH field
> arch could remain uninitialized which I believe could lead to the
> oops/panic you are seeing.
> 
> >         if (!arch) {
> >                 /* When arch is unspecified, we must check both masks on biarch
> > @@ -496,9 +503,6 @@ static struct audit_entry *audit_data_to_entry(struct audit_rule_data *data,
> >                         if (!gid_valid(f->gid))
> >                                 goto exit_free;
> >                         break;
> > -               case AUDIT_ARCH:
> > -                       entry->rule.arch_f = f;
> > -                       break;
> >                 case AUDIT_SUBJ_USER:
> >                 case AUDIT_SUBJ_ROLE:
> >                 case AUDIT_SUBJ_TYPE:
> > --
> > 1.8.3.1
> 
> -- 
> paul moore
> www.paul-moore.com
> 
> --
> Linux-audit mailing list
> Linux-audit@redhat.com
> https://www.redhat.com/mailman/listinfo/linux-audit

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
