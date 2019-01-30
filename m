Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46419C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1574F21852
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548847391;
	bh=4SIZQlJckML37BeNclnQXx/xsuQprfE2L3KdBzgn5wI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=U0KU4kip3n4409dudZZCtx7CvCKJ/rN1HxNrXvgq0CFWk2hjK50LCTATkqbFDYdRF
	 4vqnM5SF4DD1MJ9IvuhqRt6Xwv3IUlxk7qpPfTrnstEzeIYuOiyIlM+cbjb2GGpUnw
	 Fvf3fw1elSuRrTdGwirjftRWIr6JQsFPaaRgLqhg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730684AbfA3LXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 06:23:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:37484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbfA3LXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 06:23:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 447A520869;
        Wed, 30 Jan 2019 11:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548847388;
        bh=4SIZQlJckML37BeNclnQXx/xsuQprfE2L3KdBzgn5wI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xbVPjTJ6TH9dbz1GZy/Sm0TVV/d/V3O7ztHcW+hmx60vbSvHJ2v5hZu+ZW21F+Zlm
         ASXcBMUPpa338DUZoMrEmo+stzdmKQAhXrKJqEJT/WgXRkWUJQLXG9N7AkmIyHU1HU
         8P9y7UDvwwbc4xS5lvJoRZPD2eOE6BGePZ1JJeVk=
Date:   Wed, 30 Jan 2019 12:23:06 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Omar Sandoval <osandov@fb.com>,
        syzbot <syzbot+b382ba6a802a3d242790@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        Jens Axboe <axboe@fb.com>
Subject: Re: BUG: unable to handle kernel paging request in dput (2)
Message-ID: <20190130112306.GA28528@kroah.com>
References: <00000000000081e6cc0580aa76a2@google.com>
 <80e90ecd-77f5-00a3-4e91-5e9eea2aa117@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80e90ecd-77f5-00a3-4e91-5e9eea2aa117@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 08:11:17PM +0900, Tetsuo Handa wrote:
> Hello, Omar.
> 
> syzbot is reporting a crash due to dput(-EINVAL) [1]. I think the location is
> 
>         dir = debugfs_lookup(buts->name, blk_debugfs_root);
>         if (!dir)
>                 bt->dir = dir = debugfs_create_dir(buts->name, blk_debugfs_root);
> 
> added by commit 6ac93117ab009d39 ("blktrace: use existing disk debugfs directory").
> 
> Currently, Greg Kroah-Hartman is posting patches:
> 
>   When calling debugfs functions, there is no need to ever check the
>   return value.  The function can work or not, but the code logic should
>   never do something different based on this.
> 
> Omar, what do you want to do for this case?
> 
> [1] https://syzkaller.appspot.com/bug?extid=b382ba6a802a3d242790
> 

Obviously debugfs_lookup() should have its return value checked, so
that's fine :)

But how are we getting an error with dput()?  Are you sure this is a
debugfs issue and not a relayfs problem?

I'll send patches to clean up the tracing code's use of debugfs later,
as it is, I don't see anything obviously wrong with it.

thanks,

greg k-h
