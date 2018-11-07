Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C276AC32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 03:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73DB82085B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 03:03:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73DB82085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nerdbynature.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389348AbeKGMcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 07:32:22 -0500
Received: from trent.utfs.org ([94.185.90.103]:50490 "EHLO trent.utfs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727749AbeKGMcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 07:32:22 -0500
X-Greylist: delayed 343 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Nov 2018 07:32:21 EST
Received: from localhost (localhost [IPv6:::1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by trent.utfs.org (Postfix) with ESMTPS id 5DCA25FA7B;
        Wed,  7 Nov 2018 03:58:13 +0100 (CET)
Date:   Tue, 6 Nov 2018 18:58:13 -0800 (PST)
From:   Christian Kujau <lists@nerdbynature.de>
To:     Brian Norris <briannorris@chromium.org>
cc:     Genki Sky <sky@genki.is>, Guenter Roeck <linux@roeck-us.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "scripts/setlocalversion: git: Make -dirty check
 more robust"
In-Reply-To: <20181107022156.GA254567@google.com>
Message-ID: <alpine.DEB.2.21.999.1811061845161.5308@trent.utfs.org>
References: <1541527838-4585-1-git-send-email-linux@roeck-us.net> <20181106.192305.406697677@genki.is> <20181107022156.GA254567@google.com>
User-Agent: Alpine 2.21.999 (DEB 277 2018-05-20)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Nov 2018, Brian Norris wrote:
> > Perhaps both scenarios could be satisfied by having
> > scripts/setlocalversion first check if .git has write permissions, and
> > acting accordingly. Looking into history, this actually used to be
> > done, but cdf2bc632ebc ("scripts/setlocalversion on write-protected
> > source tree", 2013-06-14) removed the updating of the index.
> 
> A "writeable" check (e.g., [ -w . ]) would be sufficient for our case.
> But I'm not so sure about that older NFS report, and I'm also not sure
> that we should be writing to the source tree at all in this case. Maybe
> we can also check whether there's a build output directory specified?

FWIW, the issue I reported back in 2013[0] was not an ill-configured NFS 
export, but a read-only NFS export (and then a read-write exported NFS 
export, but the user compiling the kernel did not have write permission) 
and so "test -w .git" did not help in determining if the source tree can 
actually written to. And depending on the user's shell[1], this may or may 
not still be the case.

So I'm all for the $(touch .git/some-file-here) test to decide if the 
kernel has to be modified during build.

Christian. 

[0] https://lkml.org/lkml/2013/6/14/574
[1] https://manpages.debian.org/unstable/dash/dash.1.en.html

> > However, I admit I don't understand the justification in that commit
> > from 2013. I'm no NFS expert, but perhaps the real problem there is an
> > incorrectly configured NFS setup (uid/gid mismatch between NFS
> > client/server, or permissions mismatch between mount options and NFS
> > server?). Christian Kujau: can you speak to that?
> > 
> > Well, we could also make our check $(touch .git/some-file-here
> > 2>/dev/null && ...) instead of $(test -w .git) to handle misconfigured
> > NFS setups. But not sure if that has its own problems.
> 
> Trying to 'touch' the source tree will also break us. No matter whether
> you redirect stderr, our sandbox will still notice the build is doing
> something fishy and complain.

-- 
BOFH excuse #192:

runaway cat on system.
