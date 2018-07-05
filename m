Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDEA4C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 17:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A57D4240C6
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 17:34:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A57D4240C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753636AbeGERef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 13:34:35 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:14416 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753264AbeGERee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 13:34:34 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 93B3241385;
        Thu,  5 Jul 2018 19:34:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id aJzoIgsus57L; Thu,  5 Jul 2018 19:34:30 +0200 (CEST)
Date:   Thu, 5 Jul 2018 19:34:29 +0200
From:   Christian Brauner <christian@brauner.io>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     containers@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, seth.forshee@canonical.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        lennart@poettering.net
Subject: Re: [PATCH] Revert "vfs: Allow userns root to call mknod on owned
 filesystems."
Message-ID: <20180705173429.GA26968@mailbox.org>
References: <20180705155120.22102-1-christian@brauner.io>
 <87lgapwrw4.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87lgapwrw4.fsf@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 11:48:11AM -0500, Eric W. Biederman wrote:
> 
> Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> 
> Your description is usesless.
> 
> It needs to detail exactly what breaks, what regressions and why.
> All I see below is hand waving.
> 
> We need to know why this does not work so someone does not come in and try
> this again.  Or so that someone can fix this and then try again.
> 
> You do not include that kind of information in your commit log.

My commit log explicitly states that if you run systemd services in a
user namespace with PrivateDevices=true it will fail as soon as anything
tries to open such a device node. Before that change this worked just
fine. The commit log also leads to the related thread.
I can come up with a list of services that fail to start if that helps.

> 
> Calling mknod to create device nodes can not be widespread.  There are

Well, there are a few. There's the container runtimes (aka
systemd-nspawn, rkt, runC, LXC, LXD), udev, systemd, openrc to name just
a few.
Recently we even worked on udev being useable in user namespaces.

Please also note, that a lot of applications were also switched to
fallback to bind-mounts on mknod() permission failures since this was
the easiest and least costly way to deal with all of the LSMs, user
namespaces, capability dropping, and seccomp. They all would need way
more complex logic to decide whether to fallback to a bind-mount or not.

> not that many privileged processes and calling mknod outside of being
> a specialed process like udev is broken.
> 
> Therefore I refute your assertion that this is a widespread issue.
> 
> 
> I expect somewhere there is a reasonable argument for reverting this
> change on the basis that it causes a regression. You have not made it.

Fair enough, I can rewrite the commit message and focs on the container
workload and container runtime regressions as a clear example if that
seems a sufficient argument to you.

> 
> Until that time I am going to oppose this revert because your
> justfication for the revert is lacking.

I sympathize with you wanting a proper and thorough justification and
I'm sorry if I apparently did not provided exhaustive details.
However, I think (see above) that I've provided at least a sufficient
argument in my commit log to start a reasonable discussion about this
that doesn't end with "You're saying the kernel is broken. I'm saying
userspace is broken.".

> 
> 
> It has never been the case that mknod on a device node will guarantee
> that you even can open the device node.  The applications that regress
> are broken.  It doesn't mean we shouldn't be bug compatible, but we darn

It seems a fair assumption to me that an object you created (with the
_right permissions_) you can also interact with.
Also if I may retort, I see no good argument why the applications are
broken.

> well should document very clearly the bugs we are being bug compatible
> with.
> 
> Eric
> _______________________________________________
> Containers mailing list
> Containers@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/containers
