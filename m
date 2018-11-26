Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5FFC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 22:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53BA1208E7
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 22:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GIz3UoTn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53BA1208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbeK0JSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 04:18:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:51930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726367AbeK0JSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 04:18:35 -0500
Received: from localhost (unknown [104.132.1.80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B65F7208E4;
        Mon, 26 Nov 2018 22:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543270978;
        bh=bjvXADUVVJQKZElpwThbXakDORseQfgWtl70sFlzSPM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GIz3UoTn7BRmb+ILngefvGsY3mLp40NlhpGnClldYh5o8yjjgd/H99l92R9purEb/
         KAewcHUGNyd3pHV7QHTOeXSUtt6vdl52/6GyLg9JmKGNX7iDVSZcPrqI8QqweMLmgI
         hwlpQ3uU30BZGlz1nwP5lojgFvHkLPiU9qe7FGMM=
Date:   Mon, 26 Nov 2018 14:22:57 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Kees Cook <keescook@google.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: linux-next: build warning after merge of the f2fs tree
Message-ID: <20181126222257.GB55960@jaegeuk-macbookpro.roam.corp.google.com>
References: <20181126111933.1b0fb324@canb.auug.org.au>
 <20181126215924.GA55960@jaegeuk-macbookpro.roam.corp.google.com>
 <20181127091747.4830d123@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127091747.4830d123@canb.auug.org.au>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27, Stephen Rothwell wrote:
> Hi Jaegeuk,
> 
> On Mon, 26 Nov 2018 13:59:24 -0800 Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> >
> > On 11/26, Stephen Rothwell wrote:
> > > 
> > > After merging the f2fs tree, today's linux-next build
> > > (x86_64_allmodconfig) produced this warning:
> > > 
> > > In file included from fs/f2fs/dir.c:11:
> > > fs/f2fs/f2fs.h: In function '__mark_inode_dirty_flag':
> > > fs/f2fs/f2fs.h:2388:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
> > >    if (set)
> > >       ^
> > > fs/f2fs/f2fs.h:2390:2: note: here
> > >   case FI_DATA_EXIST:
> > >   ^~~~
> > > 
> > > Exposed by my use of -Wimplicit-fallthrough
> > > 
> > > I am not sure why this has turned up now (as opposed to earlier today).  
> > 
> > The above change had been there for a long time, as an intended behavior.
> 
> Yeah, it popped up due to line number changes in that file and the way
> I was filtering new warnings.
> 
> > Hmm, I'm not sure how to avoid this.
> 
> if you add a comment
> 	/* fall through */
> at the point the fall through occurs, then the warning is suppressed
> (and it documents that it is deliberate).

Oh, thanks~
Is this okay?

From 79e24f1509e5b6a07069be9cc8163969da78c57a Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Mon, 26 Nov 2018 14:20:32 -0800
Subject: [PATCH] f2fs: avoid build warn of fall_through

After merging the f2fs tree, today's linux-next build
 (x86_64_allmodconfig) produced this warning:

 In file included from fs/f2fs/dir.c:11:
 fs/f2fs/f2fs.h: In function '__mark_inode_dirty_flag':
 fs/f2fs/f2fs.h:2388:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
    if (set)
       ^
 fs/f2fs/f2fs.h:2390:2: note: here
   case FI_DATA_EXIST:
   ^~~~

 Exposed by my use of -Wimplicit-fallthrough

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 26ad1de8641c..b3fe6803d4c6 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2387,6 +2387,7 @@ static inline void __mark_inode_dirty_flag(struct inode *inode,
 	case FI_NEW_INODE:
 		if (set)
 			return;
+		/* fall through */
 	case FI_DATA_EXIST:
 	case FI_INLINE_DOTS:
 	case FI_PIN_FILE:
-- 
2.19.0.605.g01d371f741-goog

