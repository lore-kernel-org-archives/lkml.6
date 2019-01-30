Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DD1C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 455BF20833
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548848055;
	bh=X7dgAFBabR+QnvX77jUrsz39fLxT6c5fJ+To3GymdR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VXzsw93Gy7puR/uqmZrDdE8r0x86yRcGCboFOy0zci8plkyqMUkhA7mDhW9qT5ND8
	 bZRbG5O/SZ8Gkf+L1KE/0YZp/dawOojrLeVFtsar42u1Paq8W1ZXVo42kPr6M0huQk
	 tSkwBFv8f/ItOHy+fiEUduocNEwlmYcKmEjYXNog=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730711AbfA3LeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 06:34:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:41674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727136AbfA3LeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 06:34:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42BF72082F;
        Wed, 30 Jan 2019 11:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548848052;
        bh=X7dgAFBabR+QnvX77jUrsz39fLxT6c5fJ+To3GymdR8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E0y8eyMj9pCNpGrVp2660SflOZEeZV9wccZRBftwNgP+1LQZgV7IoGOykAOcUXvAV
         RfvxsZHjekFPbkE80L32p418qoxSYsxrTxziKUihV6d5rDLsP1dvpkhRNVM03un7bu
         SV4aQ36vzSOXVAqVUZ0WwiLJ6AooG1vuFsSeNyXc=
Date:   Wed, 30 Jan 2019 12:34:10 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Omar Sandoval <osandov@fb.com>,
        syzbot <syzbot+b382ba6a802a3d242790@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        Jens Axboe <axboe@fb.com>
Subject: Re: BUG: unable to handle kernel paging request in dput (2)
Message-ID: <20190130113410.GA30781@kroah.com>
References: <00000000000081e6cc0580aa76a2@google.com>
 <80e90ecd-77f5-00a3-4e91-5e9eea2aa117@I-love.SAKURA.ne.jp>
 <27008e5f-9dfc-a09a-cdb9-824d470fb9dd@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27008e5f-9dfc-a09a-cdb9-824d470fb9dd@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 08:26:24PM +0900, Tetsuo Handa wrote:
> On 2019/01/30 20:11, Tetsuo Handa wrote:
> > Hello, Omar.
> > 
> > syzbot is reporting a crash due to dput(-EINVAL) [1]. I think the location is
> > 
> >         dir = debugfs_lookup(buts->name, blk_debugfs_root);
> >         if (!dir)
> >                 bt->dir = dir = debugfs_create_dir(buts->name, blk_debugfs_root);
> > 
> > added by commit 6ac93117ab009d39 ("blktrace: use existing disk debugfs directory").
> > 
> > Currently, Greg Kroah-Hartman is posting patches:
> > 
> >   When calling debugfs functions, there is no need to ever check the
> >   return value.  The function can work or not, but the code logic should
> >   never do something different based on this.
> > 
> > Omar, what do you want to do for this case?
> > 
> > [1] https://syzkaller.appspot.com/bug?extid=b382ba6a802a3d242790
> > 
> 
> The function which returned -EINVAL instead of NULL seems to be debugfs_lookup()
> modified by commit ff9fb72bc07705c0 ("debugfs: return error values, not NULL").

Ah, my fault then, yes, debugfs_lookup() should return NULL if nothing
is found.  My patch was wrong, let me go fix this up, thanks for the
report.

greg k-h
