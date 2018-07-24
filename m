Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39282C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 19:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E69D020856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 19:22:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E69D020856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388582AbeGXUar convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 16:30:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56096 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388448AbeGXUar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 16:30:47 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EAF4CDC43;
        Tue, 24 Jul 2018 19:22:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-116.rdu2.redhat.com [10.10.120.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C2A1B2166BA3;
        Tue, 24 Jul 2018 19:22:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <04b05dbd-0aa4-7789-1314-52108246291a@schaufler-ca.com>
References: <04b05dbd-0aa4-7789-1314-52108246291a@schaufler-ca.com> <675e5c24-36ef-4cc5-846c-1414c1195d85@schaufler-ca.com> <153235954191.32640.5792167066538704794.stgit@warthog.procyon.org.uk> <23894.1532448035@warthog.procyon.org.uk>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        ebiederm@xmission.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, raven@themaw.net,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 0/5] Mount, Filesystem and Keyrings notifications
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <14830.1532460169.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Tue, 24 Jul 2018 20:22:49 +0100
Message-ID: <14831.1532460169@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 24 Jul 2018 19:22:51 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 24 Jul 2018 19:22:51 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Casey Schaufler <casey@schaufler-ca.com> wrote:

> >>>  (1) Mount topology and reconfiguration change events.
> >> With the possibility of unprivileged mounting you're going to have to
> >> address access control on events.  If root in a user namespace mounts a
> >> filesystem you may have a case where the "real" user wouldn't want the
> >> listener to receive a notification.
> > Can you clarify who the listener is in this case?
> 
> That would be anyone with a watchpoint set.

I was wanting clarification on how you viewed events being generated inside
the namespace being seen by an external listener, vs events being generated
outside the namespace being seen by an internal listener.

Hmmm...  OTOH, maybe it's not a problem - can a mount namespace intersect with
two different user namespaces, given it has its own user_ns pointer?

> > But for each event, I can associate an object label, derived from the
> > source, and use f_cred on the notification queue to provide a subject
> > label.
> 
> ... or UID or groups.

Might not be useful if the watched object doesn't have UID or GID - a
superblock say.

Also, that raises an additional question: if someone triggers an event - say a
mount - there is an additional set of creds (that of the triggering process).
Do I need to consider that?

> >>    (4) User injected events
> >>
> >> at this point, but it's an obvious extension. That is going
> >> to require access controls (remember kdbus) so I think you'd
> >> do well to design them in now rather than have some security
> >> module hack like me come along later and "fix" it. 
> > Yeah - the thought had occurred to me, but there needs to be some way to
> > define a 'source' and a way to connect them.  Also, would you want a general
> > source that anyone can contribute through, specific sources where you have to
> > directly connect or namespace-restricted sources?
> 
> My guess is that the consensus would be "Yes" to all the above.

I thought you might say that.

David
