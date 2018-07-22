Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D81FC6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 21:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9B0C2075B
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 21:06:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9B0C2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730414AbeGVWEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 18:04:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52236 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730081AbeGVWEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 18:04:37 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 124A5401EF05;
        Sun, 22 Jul 2018 21:06:37 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-54.rdu2.redhat.com [10.10.112.54])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F2372026D66;
        Sun, 22 Jul 2018 21:06:33 +0000 (UTC)
Date:   Sun, 22 Jul 2018 17:03:44 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Steve Grubb <sgrubb@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>, cgroups@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-audit@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        ebiederm@xmission.com, luto@kernel.org, carlos@redhat.com,
        dhowells@redhat.com, viro@zeniv.linux.org.uk, simo@redhat.com,
        Eric Paris <eparis@parisplace.org>, serge@hallyn.com
Subject: Re: [RFC PATCH ghak90 (was ghak32) V3 02/10] audit: log container
 info of syscalls
Message-ID: <20180722210344.kram6l7vvxniv2se@madcap2.tricolour.ca>
References: <cover.1528304203.git.rgb@redhat.com>
 <CAHC9VhS0-4XSEFFPLrOvAiSYv-XDLG-yGyB4ULRGz=AnwE6diQ@mail.gmail.com>
 <20180721202930.a7rypxc5rxi3hyiv@madcap2.tricolour.ca>
 <5467262.rd0RIe6TW9@x2>
 <20180722205510.eh2n7bcd52454dwj@madcap2.tricolour.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180722205510.eh2n7bcd52454dwj@madcap2.tricolour.ca>
User-Agent: NeoMutt/20180512
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Sun, 22 Jul 2018 21:06:37 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Sun, 22 Jul 2018 21:06:37 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'rgb@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-22 16:55, Richard Guy Briggs wrote:
> On 2018-07-22 09:32, Steve Grubb wrote:
> > On Saturday, July 21, 2018 4:29:30 PM EDT Richard Guy Briggs wrote:
> > > > > + * audit_log_contid - report container info
> > > > > + * @tsk: task to be recorded
> > > > > + * @context: task or local context for record
> > > > > + * @op: contid string description
> > > > > + */
> > > > > +int audit_log_contid(struct task_struct *tsk,
> > > > > +                            struct audit_context *context, char *op)
> > > > > +{
> > > > > +       struct audit_buffer *ab;
> > > > > +
> > > > > +       if (!audit_contid_set(tsk))
> > > > > +               return 0;
> > > > > +       /* Generate AUDIT_CONTAINER record with container ID */
> > > > > +       ab = audit_log_start(context, GFP_KERNEL, AUDIT_CONTAINER);
> > > > > +       if (!ab)
> > > > > +               return -ENOMEM;
> > > > > +       audit_log_format(ab, "op=%s contid=%llu",
> > > > > +                        op, audit_get_contid(tsk));
> > > > 
> > > > Can you explain your reason for including an "op" field in this record
> > > > type?  I've been looking at the rest of the patches in this patchset
> > > > and it seems to be used more as an indicator of the record's
> > > > generating context rather than any sort of audit container ID
> > > > operation.
> > > 
> > > "action" might work, but that's netfilter and numeric... "kind"?
> > > Nothing else really seems to fit from a field name, type or lack of
> > > searchability perspective.
> > > 
> > > Steve, do you have an opinion?
> > 
> > We only have 1 sample event where we have op=task. What are the other 
> > possible values?
> 
> For the AUDIT_CONTAINER record we have op= "task", "target" (from the
> ptrace and signals patch), "tty".

Sorry, pressed "send" too quickly.  Also "aux0x%x" (also from the
ptrace/signals patch), "net%u" (from the AUDIT_NETFILTER_PKT patch).

> For the AUDIT_CONTAINER_ID record we have "op=set".
> 
> > -Steve
> 
> - RGB

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
