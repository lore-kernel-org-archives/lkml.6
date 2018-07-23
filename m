Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48475ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0653320856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:48:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0653320856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388891AbeGWRup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 13:50:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50560 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388587AbeGWRuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 13:50:44 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9C88D7264D;
        Mon, 23 Jul 2018 16:48:39 +0000 (UTC)
Received: from x2.localnet (ovpn-122-239.rdu2.redhat.com [10.10.122.239])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8E62F2166BA0;
        Mon, 23 Jul 2018 16:48:38 +0000 (UTC)
From:   Steve Grubb <sgrubb@redhat.com>
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>, cgroups@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-audit@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        ebiederm@xmission.com, luto@kernel.org, carlos@redhat.com,
        dhowells@redhat.com, viro@zeniv.linux.org.uk, simo@redhat.com,
        Eric Paris <eparis@parisplace.org>, serge@hallyn.com
Subject: Re: [RFC PATCH ghak90 (was ghak32) V3 02/10] audit: log container info of syscalls
Date:   Mon, 23 Jul 2018 12:48:38 -0400
Message-ID: <2739536.aL1iVigTi9@x2>
Organization: Red Hat
In-Reply-To: <20180723151148.hyu4jqy2etp5afpt@madcap2.tricolour.ca>
References: <cover.1528304203.git.rgb@redhat.com> <3318670.y8SpQ3RC2W@x2> <20180723151148.hyu4jqy2etp5afpt@madcap2.tricolour.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 23 Jul 2018 16:48:39 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 23 Jul 2018 16:48:39 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'sgrubb@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, July 23, 2018 11:11:48 AM EDT Richard Guy Briggs wrote:
> On 2018-07-23 09:19, Steve Grubb wrote:
> > On Sunday, July 22, 2018 4:55:10 PM EDT Richard Guy Briggs wrote:
> > > On 2018-07-22 09:32, Steve Grubb wrote:
> > > > On Saturday, July 21, 2018 4:29:30 PM EDT Richard Guy Briggs wrote:
> > > > > > > + * audit_log_contid - report container info
> > > > > > > + * @tsk: task to be recorded
> > > > > > > + * @context: task or local context for record
> > > > > > > + * @op: contid string description
> > > > > > > + */
> > > > > > > +int audit_log_contid(struct task_struct *tsk,
> > > > > > > +                            struct audit_context *context,
> > > > > > > char
> > > > > > > *op)
> > > > > > > +{
> > > > > > > +       struct audit_buffer *ab;
> > > > > > > +
> > > > > > > +       if (!audit_contid_set(tsk))
> > > > > > > +               return 0;
> > > > > > > +       /* Generate AUDIT_CONTAINER record with container ID */
> > > > > > > +       ab = audit_log_start(context, GFP_KERNEL,
> > > > > > > AUDIT_CONTAINER);
> > > > > > > +       if (!ab)
> > > > > > > +               return -ENOMEM;
> > > > > > > +       audit_log_format(ab, "op=%s contid=%llu",
> > > > > > > +                        op, audit_get_contid(tsk));
> > > > > > 
> > > > > > Can you explain your reason for including an "op" field in this
> > > > > > record
> > > > > > type?  I've been looking at the rest of the patches in this
> > > > > > patchset
> > > > > > and it seems to be used more as an indicator of the record's
> > > > > > generating context rather than any sort of audit container ID
> > > > > > operation.
> > > > > 
> > > > > "action" might work, but that's netfilter and numeric... "kind"?
> > > > > Nothing else really seems to fit from a field name, type or lack of
> > > > > searchability perspective.
> > > > > 
> > > > > Steve, do you have an opinion?
> > > > 
> > > > We only have 1 sample event where we have op=task. What are the other
> > > > possible values?
> > > 
> > > For the AUDIT_CONTAINER record we have op= "task", "target" (from the
> > > ptrace and signals patch), "tty".
> > > 
> > > For the AUDIT_CONTAINER_ID record we have "op=set".
> > 
> > Since the purpose of this record is to log the container id, I think that
> > is all that is needed. We can get the context from the other records in
> > the event. I'd suggest dropping the "op" field.
> 
> Ok, the information above it for two different audit container
> identifier records.  Which one should drop the "op=" field?  Both?  Or
> just the AUDIT_CONTAINER record?  The AUDIT_CONTAINER_ID record (which
> might be renamed) could use it to distinguish a "set" record from a
> dropped audit container identifier that is no longer registered by any
> task or namespace.

Neither of them need it. All they need to do is state the container that is 
being acted upon.

-Steve



