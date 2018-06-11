Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A4A23C07E80
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 19:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED8E2087E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 19:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnSKnVQt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ED8E2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934611AbeFKTJI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 15:09:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:59100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932987AbeFKTJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 15:09:07 -0400
Received: from localhost (unknown [104.132.1.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F35DD20839;
        Mon, 11 Jun 2018 19:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528744147;
        bh=wb38NQjKx+GFRJPXuTlmXc1RPiCyE5AaOJYDm/d603I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jnSKnVQtgBCE7xxWwjGFkBjbZ3DQzC8Lf0aXLqcC+zqLVvTY5xPJuqXmE/plldq+U
         vUm0Dj/z701RBHSSQmwk7MmSVZ5/bwBSxUng5+l43ANN4GpCh5++5GDLQciAoQ4Gr+
         KpIp8yVJUQbdbd7lPHiN5u3IpS5WycKMM67CZyL0=
Date:   Mon, 11 Jun 2018 12:09:06 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Matthew Wilcox <mawilcox@microsoft.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Linux F2FS DEV, Mailing List" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [GIT PULL] f2fs update for 4.18-rc1
Message-ID: <20180611190906.GA11994@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180611165212.GA6783@jaegeuk-macbookpro.roam.corp.google.com>
 <CA+55aFznP4aEy7DkVfeQ_e6eXgLnswVnSJS3C51UHD_k8qYZCA@mail.gmail.com>
 <DM5PR2101MB08880B2FEEE593857E9501BCCB780@DM5PR2101MB0888.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM5PR2101MB08880B2FEEE593857E9501BCCB780@DM5PR2101MB0888.namprd21.prod.outlook.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/11, Matthew Wilcox wrote:
> Argh, you used my Outlook email address, so you get top-posting 😉

:P

> 
> The radix tree does rely on constructors still.  One of the things on my todo list is to verify whether it actually makes sense to do that or not.  It may continue to make sense; the radix tree node is 576 bytes (9 cache lines) and the normal usage of a freshly allocated radix tree node will touch only one or two cachelines.  Radix tree nodes naturally come back to the cache zeroed, so there's no cache pollution when destroying them either.
> 
> We didn't send that patch upstream; instead we said that anybody who specifies __GFP_ZERO on a slab with constructors is crazy and fixed it with commits abc1be13fd113ddef5e2d807a466286b864caed3 and 128227e7fe4087b60f1bd31f762e61237eb23790
> 
> I don't really understand why Jaegeuk is changing f2fs now when we've just fixed the core kernel to make what he's doing perfectly legal.

Cause Sometimes I can't wait for propagation of MM-stable patches into old
-stable kernels, going into android common kernels [1], in order to resolve
huge number of kernel panic reports in time. Instead, since I keep backporting
mainline f2fs into them, I'd prefer to change f2fs to address it quickly in this
case -- not always tho.

[1] 3.18, 4.4, 4.9, and 4.14 in:
 https://android.googlesource.com/kernel/common/

> 
> > -----Original Message-----
> > From: Linus Torvalds <torvalds@linux-foundation.org>
> > Sent: Monday, June 11, 2018 1:28 PM
> > To: Jaegeuk Kim <jaegeuk@kernel.org>; Matthew Wilcox
> > <mawilcox@microsoft.com>
> > Cc: Linux F2FS DEV, Mailing List <linux-f2fs-devel@lists.sourceforge.net>; Linux
> > Kernel Mailing List <linux-kernel@vger.kernel.org>
> > Subject: Re: [GIT PULL] f2fs update for 4.18-rc1
> > 
> > On Mon, Jun 11, 2018 at 9:52 AM Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> > >
> > > In order to avoid old MM bug [1], we decided not to use __GFP_ZERO
> > > for the mapping for node and meta page caches.
> > >
> > > [1]
> > https://na01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org
> > %2Flkml%2F2018%2F4%2F8%2F661&data=02%7C01%7Cmawilcox%40microso
> > ft.com%7Ce69c1f9a8d6a44bda36e08d5cfc0b1a5%7C72f988bf86f141af91ab2d
> > 7cd011db47%7C1%7C0%7C636643348874608385&sdata=xbAg0cOMxyrY4NY
> > ysTj1X0DPTdxwT24oYu1cxO45nkQ%3D&reserved=0
> > 
> > Hmm. The patch there looks correct, and anybody who relies on slab
> > constructors is crazy.
> > 
> > That email from April says it should go into stable, but it never even
> > went upstream..
> > 
> > Adding Willy to the cc, for comments, since he's been active there and
> > is probably the maintainer even if the MAINTAINERS file doesn't say
> > so..
> > 
> > Willy?
> > 
> >              Linus
