Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC45BECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DBBE2147D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:00:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DBBE2147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732808AbeGLVLj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 17:11:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37344 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732341AbeGLVLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 17:11:39 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 05A3A9BB6A;
        Thu, 12 Jul 2018 21:00:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 991FE2026D6B;
        Thu, 12 Jul 2018 21:00:18 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <338BC3C4-F3E7-48F0-A82E-2C7295B6640E@amacapital.net>
References: <338BC3C4-F3E7-48F0-A82E-2C7295B6640E@amacapital.net> <CALCETrU3kbh-ZRHDj7-Asq+OH-35dQ2p_erpHpYUvN5+BdAoVQ@mail.gmail.com> <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk> <153126264966.14533.3388004240803696769.stgit@warthog.procyon.org.uk> <686E805C-81F3-43D0-A096-50C644C57EE3@amacapital.net> <22370.1531293761@warthog.procyon.org.uk> <7002.1531407244@warthog.procyon.org.uk>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     dhowells@redhat.com, Andy Lutomirski <luto@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>, tycho@tycho.ws
Subject: Re: [PATCH 24/32] vfs: syscall: Add fsopen() to prepare for superblock creation [ver #9]
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Date:   Thu, 12 Jul 2018 22:00:18 +0100
Message-ID: <17749.1531429218@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 12 Jul 2018 21:00:20 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 12 Jul 2018 21:00:20 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski <luto@amacapital.net> wrote:

> fsconfigure(contextfd, ADD_BLOCKDEV, dfd, path, flags);
> 
> fsconfigure(contextfd, ADD_OPTION, 0, “foo=bar”, flags);

That seems okayish.  I'm not sure we need the flags, but I do want to allow
for binary data in an option.  So perhaps something like:

	int fsconfig(int fd, unsigned int type,
		     const char *key, const void *val, size_t val_len);

for example:

	fd = fsopen("ext4", FSOPEN_CLOEXEC);
	fsconfig(fd, fsconfig_blockdev, "dev.data", "/dev/sda1", ...);
	fsconfig(fd, fsconfig_blockdev, "dev.journal", "/dev/sda2", ...);
	fsconfig(fd, fsconfig_option, "user_xattr", NULL, ...);
	fsconfig(fd, fsconfig_option, "errors", "continue", ...);
	fsconfig(fd, fsconfig_option, "data", "journal", ...);
	fsconfig(fd, fsconfig_security, "selinux.context", "unconfined_u:...");
	fsconfig(fd, fsconfig_create, NULL, NULL, 0);
	mfd = fsmount(fd, FSMOUNT_CLOEXEC, MS_NOEXEC);

or:

	fd = fsopen("nfs", FSOPEN_CLOEXEC);
	fsconfig(fd, fsconfig_namespace, "user", "<usernsfd>", ...);
	fsconfig(fd, fsconfig_namespace, "net", "<netnsfd>", ...);
	fsconfig(fd, fsconfig_option, "server", "foo.com", ...);
	fsconfig(fd, fsconfig_option, "root", "/bar", ...);
	fsconfig(fd, fsconfig_option, "soft", NULL, ...);
	fsconfig(fd, fsconfig_option, "retry", "3", ...);
	fsconfig(fd, fsconfig_option, "wsize", "4096", ...);
	fsconfig(fd, fsconfig_uidmap, "dhowells", "1234", ...);
	fsconfig(fd, fsconfig_security, "selinux.context", "unconfined_u:...");
	fsconfig(fd, fsconfig_create, NULL, NULL, 0);
	mfd = fsmount(fd, FSMOUNT_CLOEXEC, MS_NOEXEC);

This does mean that userspace has to work harder, though, but it would
simplify the LSM interface internally.

Al Viro <viro@ftp.linux.org.uk>

> First of all, block device *IS* a fucking option.

Whilst that is true, I still need to be able to separate it out for
unconverted filesystems.

David
