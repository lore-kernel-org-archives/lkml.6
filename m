Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709EAC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 14:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2369A217C7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 14:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kkb7d4G9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2369A217C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729974AbeHMReR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 13:34:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:57552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728540AbeHMReR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 13:34:17 -0400
Received: from localhost (c-67-169-218-210.hsd1.or.comcast.net [67.169.218.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59FD421761;
        Mon, 13 Aug 2018 14:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534171901;
        bh=P3MuWMPMH1cRVg4bkmWEQw/GIIU/PpSixzAe7RU+Qj0=;
        h=Date:From:To:Cc:Subject:From;
        b=Kkb7d4G99gnzD7rs7bGJqckYpfC214Ij07WvA+I4jgklrF0Ry9PmkKo3yB1EkcT0i
         gDtHn0PjsKQXQ8Al32ltkfsKQApL+4oeH7EeI+IP6+y/h/uNo5M/xMUeElHe3exZAV
         m2ZEm2LZ8dJkb5+VjFKV8UKjKFDkNnBAvkQJCBUU=
Date:   Mon, 13 Aug 2018 07:51:40 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>, agruenba@redhat.com,
        Christoph Hellwig <hch@infradead.org>
Subject: [GIT PULL] xfs: 4.19 merge, part 1
Message-ID: <20180813145140.GD11750@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is the first part of the XFS changes for 4.19.  Christoph and
Andreas coordinated some refactoring work on the iomap code in
preparation for removing buffer heads from XFS and porting gfs2 to
iomap.  I'm sending this small pull request ahead of the main XFS merge
to avoid holding up gfs2 unnecessarily.

--D

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git iomap-4.19-merge

for you to fetch changes up to 806a1477b10a153cd01ee7ccba8ca2492df3e0b2:

  iomap: add inline data support to iomap_readpage_actor (2018-07-03 09:07:47 -0700)

----------------------------------------------------------------
Andreas Gruenbacher (6):
      iomap: mark newly allocated buffer heads as new
      iomap: complete partial direct I/O writes synchronously
      iomap: generic inline data handling
      iomap: add private pointer to struct iomap
      iomap: support direct I/O to inline data
      iomap: add inline data support to iomap_readpage_actor

Christoph Hellwig (5):
      fs: factor out a __generic_write_end helper
      iomap: add a page_done callback
      iomap: add an iomap-based readpage and readpages implementation
      iomap: add initial support for writes without buffer heads
      iomap: refactor iomap_dio_actor

 fs/buffer.c           |  76 ++++----
 fs/internal.h         |   2 +
 fs/iomap.c            | 532 ++++++++++++++++++++++++++++++++++++++++++++------
 fs/xfs/xfs_iomap.c    |   6 +-
 include/linux/iomap.h |  16 ++
 5 files changed, 536 insertions(+), 96 deletions(-)
