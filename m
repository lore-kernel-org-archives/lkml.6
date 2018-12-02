Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CD4C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B8342082F
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNwuKGjV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B8342082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725796AbeLBUNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 15:13:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:55542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbeLBUNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 15:13:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0874620672;
        Sun,  2 Dec 2018 20:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543781617;
        bh=mJVQTJas2JbkR/KMswP7ex6+NZt2CaUzagYTZRTC9Pk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lNwuKGjVvNPpoQOZjo2Sq1Js9pDTcTJWU/+yWL46lkqxpuZBTMAE3y5Ztg9nOruXF
         wj9Q6hkr/3o03ssjdIXve9lCrj9xVOeyMjZRSD0FE408eD8kvD5gG6kwpUOyw0zJ3s
         b6KXM0fVJvbPqVwf7/inTWYBntYhOpDFCRXLG8XE=
Date:   Sun, 2 Dec 2018 21:13:35 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tigran Aivazian <aivazian.tigran@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzbot <syzbot+71c6b5d68e91149fc8a4@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org,
        torvalds@linux-foundation.org
Subject: Re: [PATCH 4.19.6] BFS: static inode bitmap and extra sanity checking
Message-ID: <20181202201335.GB4314@kroah.com>
References: <20181129135921.231283053@linuxfoundation.org>
 <20181129135922.602882966@linuxfoundation.org>
 <CAK+_RLmVyVzL3G6++xOxfyEqEHL=bfZZx_Yj-TFNf5a7_oUoXw@mail.gmail.com>
 <20181129160722.GA31919@kroah.com>
 <CAK+_RLnbpu+nYsr8sVpHBVUcATDbqQoeH=+tu=tK1EKTHk6L9A@mail.gmail.com>
 <20181129171038.GA4651@kroah.com>
 <CAK+_RLk4cxamNasZyvLRunR23CTR-fASvF3=Ryt9WGeFoBVtqQ@mail.gmail.com>
 <CAK+_RLmt0ba_ARo+SrOGJph-SPn3kBRybRqncki=Oqz1TcF21Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK+_RLmt0ba_ARo+SrOGJph-SPn3kBRybRqncki=Oqz1TcF21Q@mail.gmail.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 02, 2018 at 06:57:10PM +0000, Tigran Aivazian wrote:
> Hello,
> 
> Please find a patch attached which contains the following changes:
> 
> 1. Simplifies inode bitmap allocation by making it static.
> 2. Supersedes the changes to BFS that went into 4.19.6 with stronger checking.
> 3. Other changes are trivial (like whitespace cleanup, warning messages etc).
> 
> Fully tested under 4.19.6 kernel.
> 
> Kind regards,
> Tigran

> From: Tigran Aivazian <aivazian.tigran@gmail.com>
> Subject: [PATCH 4.19.6] BFS: static inode bitmap and extra sanity checking
> 
> Strengthen validation of BFS superblock against corruption.
> Make in-core inode bitmap static part of superblock info structure.
> Print a warning when mounting a BFS filesystem created with "-N 512"
> option as only 510 files can be created in the root directory.
> Make the kernel messages more uniform. Update the 'prefix' passed to
> bfs_dump_imap() to match the current naming of operations.
> White space and comments cleanup.
> 
> Signed-off-by: Tigran Aivazian <aivazian.tigran@gmail.com>
> Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> 
>  fs/bfs/bfs.h                |   11 ++++++-
>  fs/bfs/dir.c                |    4 +-
>  fs/bfs/file.c               |    2 -
>  fs/bfs/inode.c              |   65 ++++++++++++++++++--------------------------
>  include/uapi/linux/bfs_fs.h |    2 -
>  5 files changed, 41 insertions(+), 43 deletions(-)

What is the git commit id of this patch in Linus's tree?

thanks,

greg k-h
