Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5F8C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AED822087C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:42:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AED822087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732504AbeGKIps convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 04:45:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54120 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726280AbeGKIps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 04:45:48 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C27BB40200A7;
        Wed, 11 Jul 2018 08:42:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B7CDB2156891;
        Wed, 11 Jul 2018 08:42:34 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CA+55aFzknfBLjg4-pRSCUeBFY3DWq04zX3PPyc949M0OygHktw@mail.gmail.com>
References: <CA+55aFzknfBLjg4-pRSCUeBFY3DWq04zX3PPyc949M0OygHktw@mail.gmail.com> <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk> <153126264966.14533.3388004240803696769.stgit@warthog.procyon.org.uk> <686E805C-81F3-43D0-A096-50C644C57EE3@amacapital.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, Andy Lutomirski <luto@amacapital.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 24/32] vfs: syscall: Add fsopen() to prepare for superblock creation [ver #9]
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Date:   Wed, 11 Jul 2018 09:42:34 +0100
Message-ID: <24347.1531298554@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 11 Jul 2018 08:42:35 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 11 Jul 2018 08:42:35 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Yeah, Andy is right that we should *not* make "write()" have side effects.

Note that write() has side effects all over the place: procfs, sysfs, debugfs,
tracefs, ...  Though for the most part they're single-shot jobs and not
cumulative (I'm not sure this is always true for debugfs - there's a lot of
weird stuff in there).

> > (b) Keep the current structure but use a new syscall instead of write().
> >
> > (c) Keep using write() but literally just buffer the data. Then have a new
> > syscall to commit it.  In other words, replace “x” with a syscall and call
> > all the fs_context_operations helpers in that context instead of from
> > write().
> 
> But yeah, b-or-c sounds fine.

I would prefer to avoid the "let's buffer everything" but rather parse the
data as we go along.  What I currently do is store the parsed data in the
context and only actually *apply* it when someone sends the 'x' command.

There are two reasons for this:

 (1) mount()'s error handling is slight: it can only return an error code, but
     creating and mounting something has so many different and interesting
     ways of going wrong and I want to be able to give better error reporting.

     This gets more interesting if it happens inside a container where you
     can't see dmesg.

 (2) Parsing the data means you only need to store the result of the parse and
     can reject anything that's unknown or contradictory.

     Buffering till the end means you have to buffer *everything* - and,
     unless you limit your buffer, you risk running out of RAM.

Now, I can replace the 'x' command with an ioctl() so that just writing random
rubbish to the fd won't cause anything to actually happen.

	fd = fsopen("ext4");
	write(fd, "s /dev/sda1");
	write(fd, "o user_xattr");
	ioctl(fd, FSOPEN_IOC_CREATE_SB, 0);

or I could make a special syscall for it:

	fscommit(fd, FSCOMMIT_CREATE);

or:

	fscommit(fd, FSCOMMIT_RECONFIGURE);

and require that you have CAP_SYS_ADMIN to enact it.

David
