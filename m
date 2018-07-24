Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94AF4C28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 19:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E16020874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 19:48:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E16020874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388708AbeGXU4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 16:56:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40120 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388537AbeGXU4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 16:56:19 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B8C2630832D8;
        Tue, 24 Jul 2018 19:48:18 +0000 (UTC)
Received: from x2.localnet (ovpn-122-92.rdu2.redhat.com [10.10.122.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0C0F2CD0CE;
        Tue, 24 Jul 2018 19:48:08 +0000 (UTC)
From:   Steve Grubb <sgrubb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     rgb@redhat.com, cgroups@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-audit@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        ebiederm@xmission.com, luto@kernel.org, jlayton@redhat.com,
        carlos@redhat.com, dhowells@redhat.com, viro@zeniv.linux.org.uk,
        simo@redhat.com, Eric Paris <eparis@parisplace.org>,
        serge@hallyn.com
Subject: Re: [RFC PATCH ghak90 (was ghak32) V3 08/10] audit: NETFILTER_PKT: record each container ID associated with a netNS
Date:   Tue, 24 Jul 2018 15:48:03 -0400
Message-ID: <1748819.SHaROlQLoH@x2>
Organization: Red Hat
In-Reply-To: <CAHC9VhQCxdOzcYHFtJ8eTLkNQxwvdAnuLOEguqHT_zU4V9d0OA@mail.gmail.com>
References: <cover.1528304203.git.rgb@redhat.com> <c6b64f6540e2e531636142ced36d51f0744d0e1f.1528304204.git.rgb@redhat.com> <CAHC9VhQCxdOzcYHFtJ8eTLkNQxwvdAnuLOEguqHT_zU4V9d0OA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Tue, 24 Jul 2018 19:48:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, July 20, 2018 6:15:00 PM EDT Paul Moore wrote:
> On Wed, Jun 6, 2018 at 1:03 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > Add audit container identifier auxiliary record(s) to NETFILTER_PKT
> > event standalone records.  Iterate through all potential audit container
> > identifiers associated with a network namespace.
> > 
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> > include/linux/audit.h    |  5 +++++
> > kernel/audit.c           | 20 +++++++++++++++++++-
> > kernel/auditsc.c         |  2 ++
> > net/netfilter/xt_AUDIT.c | 12 ++++++++++--
> > 4 files changed, 36 insertions(+), 3 deletions(-)
> 
> ...
> 
> > diff --git a/include/linux/audit.h b/include/linux/audit.h
> > index 7e2e51c..4560a4e 100644
> > --- a/include/linux/audit.h
> > +++ b/include/linux/audit.h
> > @@ -167,6 +167,8 @@ extern int audit_log_contid(struct audit_context
> > *context, extern void audit_contid_add(struct net *net, u64 contid);
> > extern void audit_contid_del(struct net *net, u64 contid);
> > extern void audit_switch_task_namespaces(struct nsproxy *ns, struct
> > task_struct *p); +extern void audit_log_contid_list(struct net *net,
> > +                                struct audit_context *context);
> 
> See my comment in previous patches about changing the function name to
> better indicate it's dedicate use for network namespaces.
> 
> > extern int                 audit_update_lsm_rules(void);
> > 
> > @@ -231,6 +233,9 @@ static inline void audit_contid_del(struct net *net,
> > u64 contid) { }
> > static inline void audit_switch_task_namespaces(struct nsproxy *ns,
> > struct task_struct *p) { }
> > +static inline void audit_log_contid_list(struct net *net,
> > +                                       struct audit_context *context)
> > +{ }
> > 
> > #define audit_enabled 0
> > #endif /* CONFIG_AUDIT */
> > diff --git a/kernel/audit.c b/kernel/audit.c
> > index ecd2de4..8cca41a 100644
> > --- a/kernel/audit.c
> > +++ b/kernel/audit.c
> > @@ -382,6 +382,20 @@ void audit_switch_task_namespaces(struct nsproxy
> > *ns, struct task_struct *p) audit_contid_add(new->net_ns, contid);
> > }
> > 
> > +void audit_log_contid_list(struct net *net, struct audit_context
> > *context) +{
> > +       struct audit_contid *cont;
> > +       int i = 0;
> > +
> > +       list_for_each_entry(cont, audit_get_contid_list(net), list) {
> > +               char buf[14];
> > +
> > +               sprintf(buf, "net%u", i++);
> > +               audit_log_contid(context, buf, cont->id);
> 
> Hmm.  It looks like this will generate multiple audit container ID
> records with "op=netX contid=Y" (X=netns number, Y=audit container
> ID), is that what we want?  I've mentioned my concern around the "op"
> values in these records earlier in the patchset, that still applies
> here, but now I'm also concerned about the multiple records.  I'm
> thinking we might be better served with a single record with either
> multiple "contid" fields, or a single "contid" field with a set of
> comma separated values (or some other delimiter that Steve's tools
> will tolerate).
> 
> Steve, thoughts?

A single record is best. Maybe pattern this after the args listed in an 
execve record.

-Steve



