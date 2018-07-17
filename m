Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053DDECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A78B320C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:40:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A78B320C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730215AbeGQKM2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 06:12:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45644 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728610AbeGQKM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 06:12:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 48AC9814F0B7;
        Tue, 17 Jul 2018 09:40:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-116.rdu2.redhat.com [10.10.120.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AE0B67C3E;
        Tue, 17 Jul 2018 09:40:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <F80F34FD-CFD3-4A53-AECC-AEC8D9EF3EAE@amacapital.net>
References: <F80F34FD-CFD3-4A53-AECC-AEC8D9EF3EAE@amacapital.net> <CA+55aFzaTQJp6aHG_9+W2ShxeZncq7k9G3FkVFjFm7W=ECUiMw@mail.gmail.com> <CALCETrU3kbh-ZRHDj7-Asq+OH-35dQ2p_erpHpYUvN5+BdAoVQ@mail.gmail.com> <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk> <153126264966.14533.3388004240803696769.stgit@warthog.procyon.org.uk> <686E805C-81F3-43D0-A096-50C644C57EE3@amacapital.net> <22370.1531293761@warthog.procyon.org.uk> <7002.1531407244@warthog.procyon.org.uk> <338BC3C4-F3E7-48F0-A82E-2C7295B6640E@amacapital.net> <17749.1531429218@warthog.procyon.org.uk> <21131.1531488422@warthog.procyon.org.uk>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>
Subject: Re: [PATCH 24/32] vfs: syscall: Add fsopen() to prepare for superblock creation [ver #9]
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Date:   Tue, 17 Jul 2018 10:40:41 +0100
Message-ID: <11586.1531820441@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 17 Jul 2018 09:40:43 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 17 Jul 2018 09:40:43 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski <luto@amacapital.net> wrote:

> > Whilst I'm at it, do we want the option of doing the equivalent of
> > mountat()?  I.e. offering the option to open all the device files used by
> > a superblock with dfd and AT_* flags in combination with the filename?
> > 
> 
> Isn’t that more or less what I was suggesting?  I suggested dfd and path and I also suggested just an fd and letting the caller open the file itself.

Do we need AT_* flags?  There are three that we could use:

	AT_SYMLINK_NOFOLLOW
	AT_NO_AUTOMOUNT
	AT_EMPTY_PATH

AT_EMPTY_PATH I can see, but I don't see it as likely that we'd want to use
the other two for selecting a source?  Note that we can always do:

	fsfd = fsopen("ext4");
	sfd = open("/dev/", O_PATH);
	fsconfig(fsfd, fsconfig_set_path, "journal_path", "sda1", sfd);

or:

	fsfd = fsopen("ext4");
	sfd = open("/dev/sda1", O_PATH);
	fsconfig(fsfd, fsconfig_set_path_empty, "journal_path", "", sfd);

or:

	fsfd = fsopen("ext4");
	jfd = open("/dev/sda1", O_RDWR);
	fsconfig(fsfd, fsconfig_set_fd, "journal_path", NULL, jfd);

assuming the open on the latter doesn't exclude the use by the filesystem.

This way I don't need a second syscall or a 6-arg syscall to handle path
specification.

David
