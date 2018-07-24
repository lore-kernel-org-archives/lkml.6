Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C53C28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2F5820875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:58:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2F5820875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388841AbeGXWG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 18:06:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54590 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388792AbeGXWG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 18:06:58 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9190F40241C1;
        Tue, 24 Jul 2018 20:58:39 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-17.rdu2.redhat.com [10.10.112.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 32D912156897;
        Tue, 24 Jul 2018 20:58:36 +0000 (UTC)
Date:   Tue, 24 Jul 2018 16:55:42 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     sgrubb@redhat.com, simo@redhat.com, jlayton@redhat.com,
        linux-api@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        dhowells@redhat.com, carlos@redhat.com, linux-audit@redhat.com,
        ebiederm@xmission.com, luto@kernel.org, netdev@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        serge@hallyn.com, viro@zeniv.linux.org.uk
Subject: Re: [RFC PATCH ghak90 (was ghak32) V3 08/10] audit: NETFILTER_PKT:
 record each container ID associated with a netNS
Message-ID: <20180724205542.j36vxlbgzsoot6wn@madcap2.tricolour.ca>
References: <cover.1528304203.git.rgb@redhat.com>
 <c6b64f6540e2e531636142ced36d51f0744d0e1f.1528304204.git.rgb@redhat.com>
 <CAHC9VhQCxdOzcYHFtJ8eTLkNQxwvdAnuLOEguqHT_zU4V9d0OA@mail.gmail.com>
 <1748819.SHaROlQLoH@x2>
 <CAHC9VhRiqp5ttCfh1EttLgbpPowr5P_B7nC6sP4pq=XBfEYqJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhRiqp5ttCfh1EttLgbpPowr5P_B7nC6sP4pq=XBfEYqJg@mail.gmail.com>
User-Agent: NeoMutt/20180512
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 24 Jul 2018 20:58:39 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 24 Jul 2018 20:58:39 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'rgb@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-24 16:22, Paul Moore wrote:
> On Tue, Jul 24, 2018 at 3:48 PM Steve Grubb <sgrubb@redhat.com> wrote:
> > On Friday, July 20, 2018 6:15:00 PM EDT Paul Moore wrote:
> > > On Wed, Jun 6, 2018 at 1:03 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > > Add audit container identifier auxiliary record(s) to NETFILTER_PKT
> > > > event standalone records.  Iterate through all potential audit container
> > > > identifiers associated with a network namespace.
> > > >
> > > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > > ---
> > > > include/linux/audit.h    |  5 +++++
> > > > kernel/audit.c           | 20 +++++++++++++++++++-
> > > > kernel/auditsc.c         |  2 ++
> > > > net/netfilter/xt_AUDIT.c | 12 ++++++++++--
> > > > 4 files changed, 36 insertions(+), 3 deletions(-)
> > >
> > > ...
> > >
> > > > diff --git a/include/linux/audit.h b/include/linux/audit.h
> > > > index 7e2e51c..4560a4e 100644
> > > > --- a/include/linux/audit.h
> > > > +++ b/include/linux/audit.h
> > > > @@ -167,6 +167,8 @@ extern int audit_log_contid(struct audit_context
> > > > *context, extern void audit_contid_add(struct net *net, u64 contid);
> > > > extern void audit_contid_del(struct net *net, u64 contid);
> > > > extern void audit_switch_task_namespaces(struct nsproxy *ns, struct
> > > > task_struct *p); +extern void audit_log_contid_list(struct net *net,
> > > > +                                struct audit_context *context);
> > >
> > > See my comment in previous patches about changing the function name to
> > > better indicate it's dedicate use for network namespaces.
> > >
> > > > extern int                 audit_update_lsm_rules(void);
> > > >
> > > > @@ -231,6 +233,9 @@ static inline void audit_contid_del(struct net *net,
> > > > u64 contid) { }
> > > > static inline void audit_switch_task_namespaces(struct nsproxy *ns,
> > > > struct task_struct *p) { }
> > > > +static inline void audit_log_contid_list(struct net *net,
> > > > +                                       struct audit_context *context)
> > > > +{ }
> > > >
> > > > #define audit_enabled 0
> > > > #endif /* CONFIG_AUDIT */
> > > > diff --git a/kernel/audit.c b/kernel/audit.c
> > > > index ecd2de4..8cca41a 100644
> > > > --- a/kernel/audit.c
> > > > +++ b/kernel/audit.c
> > > > @@ -382,6 +382,20 @@ void audit_switch_task_namespaces(struct nsproxy
> > > > *ns, struct task_struct *p) audit_contid_add(new->net_ns, contid);
> > > > }
> > > >
> > > > +void audit_log_contid_list(struct net *net, struct audit_context
> > > > *context) +{
> > > > +       struct audit_contid *cont;
> > > > +       int i = 0;
> > > > +
> > > > +       list_for_each_entry(cont, audit_get_contid_list(net), list) {
> > > > +               char buf[14];
> > > > +
> > > > +               sprintf(buf, "net%u", i++);
> > > > +               audit_log_contid(context, buf, cont->id);
> > >
> > > Hmm.  It looks like this will generate multiple audit container ID
> > > records with "op=netX contid=Y" (X=netns number, Y=audit container
> > > ID), is that what we want?  I've mentioned my concern around the "op"
> > > values in these records earlier in the patchset, that still applies
> > > here, but now I'm also concerned about the multiple records.  I'm
> > > thinking we might be better served with a single record with either
> > > multiple "contid" fields, or a single "contid" field with a set of
> > > comma separated values (or some other delimiter that Steve's tools
> > > will tolerate).
> > >
> > > Steve, thoughts?
> >
> > A single record is best. Maybe pattern this after the args listed in an
> > execve record.
> 
> I'm concerned that an execve-like approach might not scale very well
> as would could potentially have a lot of containers sharing a single
> network namespace ("a%d=%d" vs ",%d").  Further, with execve we log
> the argument position in addition to the argument itself, that isn't
> something we need to worry about with the audit container IDs.

I think a comma-separated list would be most efficient, but could
potentially overload one record.  The "netX" labels are pretty
meaningless unless they are that netNS' inode number (with qualifying
dev, of course), but that would be elsewhere in another record.

> paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
