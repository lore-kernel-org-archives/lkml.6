Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A61CC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5838220877
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="WCb/68y3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5838220877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbeJEByw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 21:54:52 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35684 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727293AbeJEByw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 21:54:52 -0400
Received: by mail-wm1-f66.google.com with SMTP id e187-v6so2578819wmf.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 12:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=cZFFDDhsW4wW4ERmDdcXT/qMNbRqFaZtjnVcB7iXqn4=;
        b=WCb/68y39u7rO5wRwC1e9Nd0ZnuQl142ohlRZfACiM090aPWDjlIKhUPIhP7vI0LSU
         pQ3wxlIMStzY1zvEf8QRUSXsv03FnVkYX2bFJSkAwQhqEY3uIQTQNzOEUVt4s5xon9w1
         vXiEaBfQNdyJ5pFH225uB1MplQFZ8/5C0Ssxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=cZFFDDhsW4wW4ERmDdcXT/qMNbRqFaZtjnVcB7iXqn4=;
        b=O1vAtsWcLVq9/SquClk7qU8W44bguZOChpGiNzmpnIazbs32/9noYc3x7zapJTKcRl
         Ww7spDHkS557GaCKHVla1sLT6IPhn6QNLWuTcySZskWEB/ql2nN1jWeUs9fD+j/TypVn
         ZB0Xa9ywr48+s5C2HCO7M6Im8yxmwE+G5dsviXQVps/JgIAx77jFpzfJj1LI8pLqQVDh
         SIpv6I99EkDlTwFxlNP1aZLQyxXOasZIAe5BVjLiYpblLsQeVOehMXNWMFI6B0P22XOk
         C346e4zYne36QLRgsoXefDC53JVb0MLDRNR9V0CT6IbNFFajVSeZucUZJzZ8G8NfdMKm
         BTYA==
X-Gm-Message-State: ABuFfoiSrxuTZhsYMoUHt5IZwOKAhx6kNfjjQ9SoD590GrvHxy384bIJ
        SCmKnJ4GhvPguZ+WeX1VL6SIK55KBihlzg==
X-Google-Smtp-Source: ACcGV63FBbZ9++enRcSZ+hX4Oh0n9WglStmuD8da+ApztUMK5gIDk4WOEfPmjw4J1FqClBXHC//8OA==
X-Received: by 2002:a1c:ce02:: with SMTP id e2-v6mr5436262wmg.85.1538679616324;
        Thu, 04 Oct 2018 12:00:16 -0700 (PDT)
Received: from veci.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id h64-v6sm2753563wmh.27.2018.10.04.12.00.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 12:00:14 -0700 (PDT)
Date:   Thu, 4 Oct 2018 21:00:12 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: [GIT PULL] overlayfs fixes for 4.19-rc7
Message-ID: <20181004190012.GD23439@veci.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-fixes-4.19-rc7

This update fixes a couple of regressions in the stacked file update added
in this cycle, as well as some older bugs uncovered by syzkaller.

There's also one trivial naming change that touches other parts of the fs
subsystem.

Thanks,
Miklos

---
Amir Goldstein (5):
      ovl: fix memory leak on unlink of indexed file
      ovl: fix freeze protection bypass in ovl_write_iter()
      ovl: fix freeze protection bypass in ovl_clone_file_range()
      vfs: swap names of {do,vfs}_clone_file_range()
      ovl: fix access beyond unterminated strings

Miklos Szeredi (1):
      ovl: fix format of setxattr debug

Wei Yongjun (1):
      ovl: make symbol 'ovl_aops' static

---
 fs/ioctl.c               |  2 +-
 fs/nfsd/vfs.c            |  3 ++-
 fs/overlayfs/copy_up.c   |  2 +-
 fs/overlayfs/file.c      |  2 ++
 fs/overlayfs/inode.c     |  2 +-
 fs/overlayfs/namei.c     |  2 +-
 fs/overlayfs/overlayfs.h |  4 ++--
 fs/overlayfs/util.c      |  3 ++-
 fs/read_write.c          | 17 +++++++++++++++--
 include/linux/fs.h       | 17 +++--------------
 10 files changed, 30 insertions(+), 24 deletions(-)
