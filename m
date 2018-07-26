Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720BAC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D20920685
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:36:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D20920685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730549AbeGZOxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 10:53:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47184 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729506AbeGZOxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 10:53:05 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 19A03402333A;
        Thu, 26 Jul 2018 13:36:09 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-17.rdu2.redhat.com [10.10.112.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A96722166BA3;
        Thu, 26 Jul 2018 13:36:05 +0000 (UTC)
Date:   Thu, 26 Jul 2018 09:33:08 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     cgroups@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org, linux-audit@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, ebiederm@xmission.com, luto@kernel.org,
        jlayton@redhat.com, carlos@redhat.com, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, simo@redhat.com,
        Eric Paris <eparis@parisplace.org>, serge@hallyn.com
Subject: Re: [RFC PATCH ghak90 (was ghak32) V3 07/10] audit: add support for
 containerid to network namespaces
Message-ID: <20180726133308.cb7x7yvdxek23eb3@madcap2.tricolour.ca>
References: <cover.1528304203.git.rgb@redhat.com>
 <562cfaf7629b64252aac7cf3cecdd70b471af5b5.1528304204.git.rgb@redhat.com>
 <CAHC9VhStmCOS=o2aM7zHLGUYyfuCu_d1so4Cp4T-qetGnJpUUg@mail.gmail.com>
 <20180724140309.i6o2yjdoif5krxtw@madcap2.tricolour.ca>
 <CAHC9VhSuczaFi49-3SrVM9vND=vT=U1Aj0G6kOyJ3rAFnvi6VA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhSuczaFi49-3SrVM9vND=vT=U1Aj0G6kOyJ3rAFnvi6VA@mail.gmail.com>
User-Agent: NeoMutt/20180512
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 26 Jul 2018 13:36:09 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 26 Jul 2018 13:36:09 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'rgb@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-24 16:33, Paul Moore wrote:
> On Tue, Jul 24, 2018 at 10:06 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> > On 2018-07-20 18:14, Paul Moore wrote:
> > > On Wed, Jun 6, 2018 at 1:03 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > > Audit events could happen in a network namespace outside of a task
> > > > context due to packets received from the net that trigger an auditing
> > > > rule prior to being associated with a running task.  The network
> > > > namespace could in use by multiple containers by association to the
> > > > tasks in that network namespace.  We still want a way to attribute
> > > > these events to any potential containers.  Keep a list per network
> > > > namespace to track these audit container identifiiers.
> > > >
> > > > Add/increment the audit container identifier on:
> > > > - initial setting of the audit container identifier via /proc
> > > > - clone/fork call that inherits an audit container identifier
> > > > - unshare call that inherits an audit container identifier
> > > > - setns call that inherits an audit container identifier
> > > > Delete/decrement the audit container identifier on:
> > > > - an inherited audit container identifier dropped when child set
> > > > - process exit
> > > > - unshare call that drops a net namespace
> > > > - setns call that drops a net namespace
> > > >
> > > > See: https://github.com/linux-audit/audit-kernel/issues/92
> > > > See: https://github.com/linux-audit/audit-testsuite/issues/64
> > > > See: https://github.com/linux-audit/audit-kernel/wiki/RFE-Audit-Container-ID
> > > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > > ---
> > > >  include/linux/audit.h | 23 ++++++++++++++++
> > > >  kernel/audit.c        | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++
> > > >  kernel/auditsc.c      |  5 ++++
> > > >  kernel/nsproxy.c      |  4 +++
> > > >  4 files changed, 104 insertions(+)
> 
> ...
> 
> > > > +                       }
> > > > +       if (!found)
> > > > +               return;
> > > > +       list_del(&cont->list);
> > > > +       if (refcount_dec_and_test(&cont->refcount))
> > > > +               kfree(cont);
> > >
> > > Don't you want to dec_and_test first and only remove it from the list
> > > if there are no other references?
> >
> > I don't think so.  Let me try to describe it in prose to see if I
> > understood this properly and see if this makes more sense: I want to
> > remove this audit_contid list member from this net's audit_contid list
> > and decrement unconditionally this member's refcount so it knows there
> > is one less thing pointing at it and when there is no longer anything
> > pointing at it, free it.
> 
> Yep, sorry, my mistake, I was thinking the other way around (netns
> going away) ... which actually, this patchset doesn't handle that does
> it (I don't see any new code in audit_net_exit())?  Is is in a later
> patch?  If so, it really should be in the same patch as this code to
> prevent bisect nasties.

I don't think any code is needed in audit_net_exit() other than a WARN()
that the contid list is empty, since if a netns is going away, all its
tasks would have exited (removing its contid from the list) or moved to
a new nstns (moving its contid from this list to another netns).
At worst, this is a memory leak and not a bad pointer dereference.

> paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
