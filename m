Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7605EC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 22:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 377AB20671
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 22:06:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 377AB20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389523AbeG0XaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 19:30:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40848 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389155AbeG0XaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 19:30:14 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 582B84025063;
        Fri, 27 Jul 2018 22:06:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-116.rdu2.redhat.com [10.10.120.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6537F1C5B7;
        Fri, 27 Jul 2018 22:06:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <D09916DC-DA22-48AA-A62B-F874BB3C15BC@amacapital.net>
References: <D09916DC-DA22-48AA-A62B-F874BB3C15BC@amacapital.net> <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk> <153271288242.9458.18050138471208178879.stgit@warthog.procyon.org.uk>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-api@vger.kernel.org, torvalds@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 30/38] vfs: syscall: Add fsmount() to create a mount for a superblock [ver #10]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8834.1532729179.1@warthog.procyon.org.uk>
Date:   Fri, 27 Jul 2018 23:06:19 +0100
Message-ID: <8835.1532729179@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 27 Jul 2018 22:06:21 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 27 Jul 2018 22:06:21 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski <luto@amacapital.net> wrote:

> I have a potentially silly objection. For the old timers, "mount" means to
> stick a reel of tape or some similar object onto a reader, which seems to
> imply that "mount" means to start up the filesystem. For younguns, this
> meaning is probably lost, and the more obvious meaning is to "mount" it into
> some location in the VFS hierarchy a la vfsmount. The patch description
> doesn't disambiguate it, and obviously people used to mount(2)/mount(8) are
> just likely to be confused.

The problem is that inside the kernel it *is* a "mount".

How about I change the first paragraph to:

	Provide a system call by which a filesystem opened with fsopen() and
	configured by a series of fsconfig() calls can have a detached mount
	object created for it.  This mount object can then be attached to the
	VFS mount hierarchy using move_mount() by passing the returned file
	descriptor as the from directory fd.

> At the very least, your description should make it absolutely clear what you
> mean. Even better IMO would be to drop the use of the word "mount" entirely

I'm not sure that's a reasonable idea, given the "mounting" is how this is
done.

Can you suggest a word that encapsulates what it is that fsmount() returns?
It's almost, but not quite identical with what open(O_PATH) returns, since it
has to be torn down if not actually mounted somewhere when the fd is closed.

> and maybe rename the syscall.
> 
> From a very brief reading, I think you are giving it the meaning that would
> be implied by fsstart(2).

Do you have a reference for the manpage for that?  Google doesn't seem to find
it.

David
