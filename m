Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B652EFA3723
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 08:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6053520873
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 08:50:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6053520873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbeG2KTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 06:19:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58470 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726022AbeG2KTo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 06:19:44 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5260840201C9;
        Sun, 29 Jul 2018 08:50:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-116.rdu2.redhat.com [10.10.120.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 315B6111E412;
        Sun, 29 Jul 2018 08:50:01 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAG48ez2f+J+UeFN0u1Hpfq3tFXJbi7ckts8sua3eY4jDwnh6-Q@mail.gmail.com>
References: <CAG48ez2f+J+UeFN0u1Hpfq3tFXJbi7ckts8sua3eY4jDwnh6-Q@mail.gmail.com> <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk> <153271287586.9458.6001928723332685410.stgit@warthog.procyon.org.uk>
To:     Jann Horn <jannh@google.com>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 29/38] vfs: syscall: Add fsconfig() for configuring and managing a context [ver #10]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <19864.1532854200.1@warthog.procyon.org.uk>
Date:   Sun, 29 Jul 2018 09:50:00 +0100
Message-ID: <19865.1532854200@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Sun, 29 Jul 2018 08:50:02 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Sun, 29 Jul 2018 08:50:02 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jann Horn <jannh@google.com> wrote:

> [...]
> > +       case fsconfig_set_binary:
> > +               param.type = fs_value_is_blob;
> > +               param.size = aux;
> > +               param.blob = memdup_user_nul(_value, aux);
> > +               if (IS_ERR(param.blob)) {
> > +                       ret = PTR_ERR(param.blob);
> > +                       goto out_key;
> > +               }
> > +               break;
> 
> This means that a namespace admin (iow, an unprivileged user) can
> allocate 1MB of unswappable kmalloc memory per userspace task, right?
> Using userfaultfd or FUSE, you can then stall the task as long as you
> want while it has that allocation. Is that problematic, or is that
> normal?

That's not exactly the case.  A userspace task can make a temporary
allocation, but unless the filesystem grabs it, it's released again on exit
from the system call.

Note that I should probably use vmalloc() rather than kmalloc(), but that
doesn't really affect your point.  I could also pass the user pointer through
to the filesystem instead - I wanted to avoid that for this interface, but it
make sense in this instance.

David
