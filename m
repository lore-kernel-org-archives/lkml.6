Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763ADECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F6BE208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:26:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F6BE208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733010AbeGLViD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 17:38:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37370 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732710AbeGLViD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 17:38:03 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BEAEF818BAF3;
        Thu, 12 Jul 2018 21:26:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B2FCF1102E24;
        Thu, 12 Jul 2018 21:26:37 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CA+55aFw1WyKY+-2dg62M-QT_F0-waCTCrba1DW4dStYz-f_fjA@mail.gmail.com>
References: <CA+55aFw1WyKY+-2dg62M-QT_F0-waCTCrba1DW4dStYz-f_fjA@mail.gmail.com> <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk> <153126264966.14533.3388004240803696769.stgit@warthog.procyon.org.uk> <686E805C-81F3-43D0-A096-50C644C57EE3@amacapital.net> <22370.1531293761@warthog.procyon.org.uk> <CALCETrU3kbh-ZRHDj7-Asq+OH-35dQ2p_erpHpYUvN5+BdAoVQ@mail.gmail.com> <7002.1531407244@warthog.procyon.org.uk> <CA+55aFx+xm333ZZ7d2Z39QuhDu=0XM6nTMChbHvWQOXNk32yxw@mail.gmail.com> <16699.1531426991@warthog.procyon.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, Andrew Lutomirski <luto@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 24/32] vfs: syscall: Add fsopen() to prepare for superblock creation [ver #9]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <18232.1531430797.1@warthog.procyon.org.uk>
Date:   Thu, 12 Jul 2018 22:26:37 +0100
Message-ID: <18233.1531430797@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 12 Jul 2018 21:26:38 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 12 Jul 2018 21:26:38 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> The unix semantics are that credentials are checked at open time.

Sigh.

The problem is that there's more than one actual "open" involved.

	fd = fsopen("ext4");				<--- #1
	whatever_interface(fd, "s /dev/sda1");
	whatever_interface(fd, "o journal_path=/dev/sda2");
	do_the_create_thing(fd);			<--- #2 and #3

The initial check to see whether you can mount or not is done at #1.

But later there are two nested file opens.  Internally, deep down inside the
block layer, /dev/sda1 and /dev/sda2 are opened and further permissions checks
are done, whether you like it or not.  But these have no access to the creds
attached to fd as things currently stand.

So we have three choices:

 (1) Pass the creds from ->get_tree() all the way down into pathwalk and make
     sure *every* check that pathwalk does uses it.

 (2) When do_the_create_thing() is invoked, it wraps the call to ->get_tree()
     with override_creds(file->f_cred).

 (3) Forget using an fd to refer to the context.  fsopen() takes absolutely
     everything, perhaps as a kv array and spits out an O_PATH fd.  You don't
     get improved error reporting, you don't get a chance for interaction -
     say with the server, to construct an ID mapping table - and you don't get
     the chance to query the superblock before creating a mount.

     So, something like:

	struct fsopen_param {
		unsigned int type,
		const char *key;
		const void *val;
		unsigned int val_len;
	};

	mfd = fsopen(const char *fs_type,
		     unsigned int flags, /* CLOEXEC */
		     const struct fsopen_param *params,
		     unsigned int param_count,
		     unsigned int ms_flags /* eg. MNT_NOEXEC */);

     For example:

	struct fsopen_param params[] = {
		{ fsopen_source, "dev.fs", "/dev/sda1" }
		{ fsopen_source, "dev.journal", "/dev/sda2" }
		{ fsopen_option, "user_xattr" }
		{ fsopen_option, "data", "journal" }
		{ fsopen_option, "jqfmt", "vfsv1" }
		{ fsopen_security, "selinux.context", "unconfined_u..." }
	};

	mfd = fsopen("ext4", FSOPEN_CLOEXEC, params, ARRAY_SIZE(params),
		     MNT_NOEXEC);

     There would need to be an fsreconfig() also in a similar vein.

David
