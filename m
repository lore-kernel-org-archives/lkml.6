Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CAAC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E0AC21E23
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:25:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E0AC21E23
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732274AbeHIQuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 12:50:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59652 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730839AbeHIQuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 12:50:05 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3DB5F4023444;
        Thu,  9 Aug 2018 14:24:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-78.rdu2.redhat.com [10.10.120.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5EA862314E;
        Thu,  9 Aug 2018 14:24:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <87in4n9zg0.fsf@xmission.com>
References: <87in4n9zg0.fsf@xmission.com> <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk> <153313723557.13253.9055982745313603422.stgit@warthog.procyon.org.uk>
To:     ebiederm@xmission.com (Eric W. Biederman)
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-api@vger.kernel.org, torvalds@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 28/33] vfs: syscall: Add fsconfig() for configuring and managing a context [ver #11]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <27373.1533824694.1@warthog.procyon.org.uk>
Date:   Thu, 09 Aug 2018 15:24:54 +0100
Message-ID: <27374.1533824694@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 09 Aug 2018 14:24:56 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 09 Aug 2018 14:24:56 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman <ebiederm@xmission.com> wrote:

> First let me thank you for adding both FSCONFIG_CMD_CREATE and
> FSCONFIG_CMD_RECONFIGURE.  Unfortunately the implementation is currently
> broken.  So this patch gets my:
> 
> This is broken in two specific ways.
> ...
> 2) FSCONFIG_CMD_CREATE will succeed even if the superblock already
>    exists and it can not use all of the superblock parameters.
> 
>    This happens because vfs_get_super will only call fill_super
>    if the super block is created.  Which is reasonable on the face
>    of it.  But it in practice this introduces security problems.
> 
>    a) Either through reconfiguring a shared super block you did not
>       realize was shared (as we saw with devpts).
> 
>    b) Mounting a super block and not honoring it's mount options
>       because something has already mounted it.  As we see today
>       with proc.  Leaving userspace to think the filesystem will behave
>       one way when in fact it behaves another.
> 
> I have already explained this several times, and apparently I have been
> ignored.  This fundamental usability issue that leads to security
> problems.

I've also explained why you're wrong or at least only partially right.  I *do*
*not* want to implement sget() in userspace with the ability for userspace to
lock out other mount requests - which is what it appears that you've been
asking for.

However, as I have said, I *am* willing to add one of more flags to help with
this, but I can't make any "legacy" fs honour them as this requires the
fs_context to be passed down to sget_fc() and the filesystem - which is why I
was considering leaving it for later.

 (1) An FSOPEN_EXCL flag to tell sget_fc() to fail if the superblock already
     exists at all.

 (2) An FSOPEN_FAIL_ON_MISMATCH flag to explicitly say that we *don't* want a
     superblock with different parameters.

The implication of providing neither flag is that we are happy to accept a
superblock from the same source but with different parameters.

But it doesn't seem to be an absolute imperative to roll this out immediately,
since what I have exactly mirrors what the kernel currently does - and forcing
a change in that behaviour risks breaking userspace.  If it keeps you happy,
however, I can try and work one up.

David
