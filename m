Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E27AC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 22:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0006720647
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 22:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0006720647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388845AbeG0Xvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 19:51:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41350 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730850AbeG0Xvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 19:51:33 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 35AB34025063;
        Fri, 27 Jul 2018 22:27:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-116.rdu2.redhat.com [10.10.120.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 408602156701;
        Fri, 27 Jul 2018 22:27:35 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CALCETrWDGa+ut=xsoki+XFKzdD7KruJJicfH1tKdBtywLuk7iQ@mail.gmail.com>
References: <CALCETrWDGa+ut=xsoki+XFKzdD7KruJJicfH1tKdBtywLuk7iQ@mail.gmail.com> <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk> <153271287586.9458.6001928723332685410.stgit@warthog.procyon.org.uk> <CALCETrUXsOexKcj+K_v_bsW6DkGFgyNOaEs_qVOAcdNGBbEb2w@mail.gmail.com> <7034.1532728300@warthog.procyon.org.uk>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 29/38] vfs: syscall: Add fsconfig() for configuring and managing a context [ver #10]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <11037.1532730454.1@warthog.procyon.org.uk>
Date:   Fri, 27 Jul 2018 23:27:34 +0100
Message-ID: <11038.1532730454@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 27 Jul 2018 22:27:36 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 27 Jul 2018 22:27:36 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski <luto@amacapital.net> wrote:

> > [*] Not without a 6-arg syscall or some other way of passing it.
> 
> Are there still architectures that have problems with 6-arg syscalls?

As I understand it, 6-arg syscalls are frowned upon.

> I suppose that, as long as there is never a case where fsconfig_set_path and
> fsconfig_set_fd both succeed, then it's not a big deal.

fsconfig_set_path/path_empty requires the 'value' argument to point to a
string, possibly "", and fsconfig_set_fd requires it to be NULL.

I can't stop you from doing:

	fd = open("/some/path", O_PATH);
	fsconfig(fsfd, fsconfig_set_fd, "fd", NULL, fd);

or:

	fd = open("/dev/sda6", O_RDWR);
	fsconfig(fsfd, fsconfig_set_path_empty, "foo", "", fd);

The first should fail because I'm using fget() not fget_raw() and the
second will pass the string and fd number to the filesystem, which will
presumably then call fs_lookup_param() to invoke pathwalk upon it - which will
likely also fail.

David
