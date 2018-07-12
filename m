Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E2EECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D58342147C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:23:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D58342147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732542AbeGLUeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 16:34:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59282 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732391AbeGLUeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 16:34:23 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 23EB1401DE92;
        Thu, 12 Jul 2018 20:23:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EAB3F1102E24;
        Thu, 12 Jul 2018 20:23:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CA+55aFx+xm333ZZ7d2Z39QuhDu=0XM6nTMChbHvWQOXNk32yxw@mail.gmail.com>
References: <CA+55aFx+xm333ZZ7d2Z39QuhDu=0XM6nTMChbHvWQOXNk32yxw@mail.gmail.com> <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk> <153126264966.14533.3388004240803696769.stgit@warthog.procyon.org.uk> <686E805C-81F3-43D0-A096-50C644C57EE3@amacapital.net> <22370.1531293761@warthog.procyon.org.uk> <CALCETrU3kbh-ZRHDj7-Asq+OH-35dQ2p_erpHpYUvN5+BdAoVQ@mail.gmail.com> <7002.1531407244@warthog.procyon.org.uk>
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
Content-ID: <16698.1531426991.1@warthog.procyon.org.uk>
Date:   Thu, 12 Jul 2018 21:23:11 +0100
Message-ID: <16699.1531426991@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 12 Jul 2018 20:23:13 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 12 Jul 2018 20:23:13 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Don't play games with override_creds. It's wrong.
> 
> You have to use file->f_creds - no games, no garbage.

You missed the point.

It's all very well to say "use file->f_creds".  The problem is this has to be
handed down all the way through the filesystem and down into the block layer
as appropriate to anywhere there's an LSM call, a CAP_* check or a pathwalk -
but there's not currently any way to do that.

mount_bdev() and blkdev_get_by_path() are examples of this.  At the moment
there is no cred parameter there.  We'd also have to pass the creds down into
path_init() to store in struct nameidata and make sure that every permissions
call that might be invoked during pathwalk in every filesystem uses that, not
current_cred().

I made an attempt to do this a while ago and the patch got rather large before
I gave up.  In many ways, it's what we *should* do, but so many things need an
extra parameter...  If you really want, I can try that again.  It's possible I
can automate it with some perl scripting to parse the error messages from the
compiler.

My suggestion was to use override_creds() to impose the appropriate creds at
the top, be that file->f_creds or fs_context->creds (they would be the same in
any case).

If we want to go down the pass-the-creds-down route, then we can temporarily
do override_creds() until we've made the changes and then remove it later.

> But "write()" simply is *NOT* a good "command" interface. If you want
> to send a command, use an ioctl or a system call.

Okay.

> Because it's not just about credentials. It's not just about fooling a
> suid app into writing an error message to a descriptor you wrote. It's
> also about things like "splice()", which can write to your target
> using a kernel buffer, and thus trick you into doing a command while
> we have the context set to kernel addresses.
> 
> Are we trying to get away from that issue? Yes. But it's just another
> example of why "write()" IS NOT TO BE USED FOR COMMANDS.

Btw, do we protect sysfs, debugfs, tracefs, procfs, etc. writes against
splice?  Some of the things in debugfs are really icky, allowing you to muck
directly with hardware.

David
