Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6179813F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1825420881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1825420881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729523AbeG3OHX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 10:07:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47746 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728740AbeG3OHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 10:07:23 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8F1F2CFB44;
        Mon, 30 Jul 2018 12:32:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-116.rdu2.redhat.com [10.10.120.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD03F2026D68;
        Mon, 30 Jul 2018 12:32:35 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAG48ez3HY6UuOgo1gM9L=WwyOqifKSs6sFu7f2qqBZQg6hy96g@mail.gmail.com>
References: <CAG48ez3HY6UuOgo1gM9L=WwyOqifKSs6sFu7f2qqBZQg6hy96g@mail.gmail.com> <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk> <153271287586.9458.6001928723332685410.stgit@warthog.procyon.org.uk> <CAG48ez2f+J+UeFN0u1Hpfq3tFXJbi7ckts8sua3eY4jDwnh6-Q@mail.gmail.com> <19865.1532854200@warthog.procyon.org.uk>
To:     Jann Horn <jannh@google.com>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 29/38] vfs: syscall: Add fsconfig() for configuring and managing a context [ver #10]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <26454.1532953955.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Mon, 30 Jul 2018 13:32:35 +0100
Message-ID: <26455.1532953955@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 30 Jul 2018 12:32:36 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 30 Jul 2018 12:32:36 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jann Horn <jannh@google.com> wrote:

> > > This means that a namespace admin (iow, an unprivileged user) can
> > > allocate 1MB of unswappable kmalloc memory per userspace task, right?
> > > Using userfaultfd or FUSE, you can then stall the task as long as you
> > > want while it has that allocation. Is that problematic, or is that
> > > normal?
> >
> > That's not exactly the case.  A userspace task can make a temporary
> > allocation, but unless the filesystem grabs it, it's released again on exit
> > from the system call.
> 
> That's what I said.

Sorry, I wasn't clear what you meant.  I assumed you were thinking it was then
automatically attached to the context, say:

	fd = fsopen("fuse", 0);
	fsconfig(fd, fsconfig_set_binary, "foo", buffer, size);

> Each userspace task can make a 1MB allocation by calling this syscall, and
> this temporary allocation stays allocated until the end of the syscall. But
> the runtime of the syscall is unbounded - even just the memdup_user_nul()
> can stall forever if the copy_from_user() call inside it faults on e.g. a
> userfault region or a memory-mapped file from a FUSE filesystem.

Okay, I see what you're getting at.  Note that this affects other syscalls
too, keyctl, module loading and read() with readahead for example.  Not sure
what the answer should be.

David
