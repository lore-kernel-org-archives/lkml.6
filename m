Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D0EC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D1252075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:45:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D1252075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030259AbeFSQpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:45:46 -0400
Received: from smtprelay0211.hostedemail.com ([216.40.44.211]:54303 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1030242AbeFSQpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:45:44 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 667BC18058ED1;
        Tue, 19 Jun 2018 16:45:43 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: crib39_6bd415231285a
X-Filterd-Recvd-Size: 3371
Received: from XPS-9350.home (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Tue, 19 Jun 2018 16:45:40 +0000 (UTC)
Message-ID: <e66cad5399b741b8d5c06c8ea772c8b84caf1150.camel@perches.com>
Subject: Re: [PATCH 03/13] selinux: Cleanup printk logging in policydb
From:   Joe Perches <joe@perches.com>
To:     Paul Moore <paul@paul-moore.com>, peter.enderborg@sony.com
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>, danielj@mellanox.com,
        dledford@redhat.com, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, serge@hallyn.com
Date:   Tue, 19 Jun 2018 09:45:39 -0700
In-Reply-To: <CAHC9VhTULXGAjbRSeriXm6g=aQbaG6XcfXtROVoJr632yis=Gw@mail.gmail.com>
References: <20180612080912.7827-1-peter.enderborg@sony.com>
         <20180612080912.7827-4-peter.enderborg@sony.com>
         <CAHC9VhTULXGAjbRSeriXm6g=aQbaG6XcfXtROVoJr632yis=Gw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-06-19 at 12:41 -0400, Paul Moore wrote:
> On Tue, Jun 12, 2018 at 4:09 AM Peter Enderborg
> <peter.enderborg@sony.com> wrote:
> > 
> > Replace printk with pr_* to avoid checkpatch warnings and
> > replace KERN_CONT with 2 longer prints.
> > 
> > Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
> > ---
> >  security/selinux/ss/policydb.c | 91 +++++++++++++++++++++---------------------
> >  1 file changed, 46 insertions(+), 45 deletions(-)
> 
> Merged, thank you.  While removing the separate KERN_CONT message
> introduces some duplication, I think that's the right thing to do.
> 
> > diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
[]
> > @@ -504,7 +504,7 @@ static void hash_eval(struct hashtab *h, const char *hash_name)
> >         struct hashtab_info info;
> > 
> >         hashtab_stat(h, &info);
> > -       printk(KERN_DEBUG "SELinux: %s:  %d entries and %d/%d buckets used, "
> > +       pr_debug("SELinux: %s:  %d entries and %d/%d buckets used, "
> >                "longest chain length %d\n", hash_name, h->nel,
> >                info.slots_used, h->size, info.max_chain_len);
> >  }
> > @@ -533,15 +533,17 @@ static int policydb_index(struct policydb *p)
> >  {
> >         int i, rc;
> > 
> > -       printk(KERN_DEBUG "SELinux:  %d users, %d roles, %d types, %d bools",
> > -              p->p_users.nprim, p->p_roles.nprim, p->p_types.nprim, p->p_bools.nprim);
> >         if (p->mls_enabled)
> > -               printk(KERN_CONT ", %d sens, %d cats", p->p_levels.nprim,
> > -                      p->p_cats.nprim);
> > -       printk(KERN_CONT "\n");
> > +               pr_debug("SELinux:  %d users, %d roles, %d types, %d bools, %d sens, %d cats",
> > +                        p->p_users.nprim, p->p_roles.nprim, p->p_types.nprim,
> > +                        p->p_bools.nprim, p->p_levels.nprim, p->p_cats.nprim);
> > +       else
> > +               pr_debug("SELinux:  %d users, %d roles, %d types, %d bools",
> > +                        p->p_users.nprim, p->p_roles.nprim, p->p_types.nprim,
> > +                        p->p_bools.nprim);

This lost the terminating newline on each pr_debug

