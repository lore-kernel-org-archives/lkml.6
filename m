Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BABC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA6C520842
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:51:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA6C520842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389876AbeG0XPc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 19:15:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35534 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389804AbeG0XPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 19:15:31 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2FFA77DAC3;
        Fri, 27 Jul 2018 21:51:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-116.rdu2.redhat.com [10.10.120.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 333FA111AF20;
        Fri, 27 Jul 2018 21:51:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CALCETrUXsOexKcj+K_v_bsW6DkGFgyNOaEs_qVOAcdNGBbEb2w@mail.gmail.com>
References: <CALCETrUXsOexKcj+K_v_bsW6DkGFgyNOaEs_qVOAcdNGBbEb2w@mail.gmail.com> <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk> <153271287586.9458.6001928723332685410.stgit@warthog.procyon.org.uk>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 29/38] vfs: syscall: Add fsconfig() for configuring and managing a context [ver #10]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7033.1532728300.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Fri, 27 Jul 2018 22:51:40 +0100
Message-ID: <7034.1532728300@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 27 Jul 2018 21:51:42 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 27 Jul 2018 21:51:42 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski <luto@amacapital.net> wrote:

> Unless I'm rather confused, you have two or possibly three ways to
> pass in an open fd.  Can you clarify what the difference is and/or
> remove all but one of them?

No, they're not equivalent.

> >  (*) fsconfig_set_path: A non-empty path is specified.  The parameter must
> >      be expecting a path object.  value points to a NUL-terminated string
> >      that is the path and aux is a file descriptor at which to start a
> >      relative lookup or AT_FDCWD.

So, an example:

	fsconfig(fd, fsconfig_set_path, "source", "/dev/sda1", AT_FDCWD);

I don't want to require that the caller open /dev/sda1 and pass in an fd as
that might prevent the filesystem from "holding" it exclusively.

> >  (*) fsconfig_set_path_empty: As fsconfig_set_path, but with AT_EMPTY_PATH
> >      implied.

You can't do:

	fsconfig(fd, fsconfig_set_path, "source", "", dir_fd);

because AT_EMPTY_PATH cannot be specified directly[*].  What you do instead is:

	fsconfig(fd, fsconfig_set_path_empty, "source", "", dir_fd);

[*] Not without a 6-arg syscall or some other way of passing it.

I *could* require that the caller must call open(O_PATH) or openat(O_PATH)
before calling fsconfig() - so you don't pass a string, but only a path-fd.

> >  (*) fsconfig_set_fd: An open file descriptor is specified.  value must
> >      be NULL and aux indicates the file descriptor.

See fd=%u on fuse.  I think it's cleaner to do:

	fsconfig(fd, fsconfig_set_fd, "source", NULL, control_fd);

saying explicitly that there's an open file to be passed rather than:

	fsconfig(fd, fsconfig_set_path, "source", NULL, control_fd);

which indicates that you are actually providing a path.

David
