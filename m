Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78709C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 08:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ACB421917
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 08:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549615149;
	bh=zbpTAV1zCFd+HtuoK14tUJcWM72s1KOdjutUJCUcVY4=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=p+ZmDGKWr2Nb18NbXgCaPLzZexcr0W+ZUZA7TOHbYmQ1EGbX1KFHq28y0UAMMK1P5
	 lG9cpDP4Sa7bNPoo3zr0fmC5yx3A2ozs/Jj6GxG2hPHCUqRlbanNlgJWro2z9WciGO
	 s1HvDg5pbeeuHMpzGAudXaCaNMrn+Tpeg1oxvaWo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbfBHIjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 03:39:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:37984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbfBHIjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 03:39:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 518D221917;
        Fri,  8 Feb 2019 08:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549615146;
        bh=zbpTAV1zCFd+HtuoK14tUJcWM72s1KOdjutUJCUcVY4=;
        h=Date:From:To:Cc:Subject:From;
        b=XcJ5VgdFvqPMJ+GXvO5nPUU8SiOMpYleI3RdZ2bo3Z/vFrFoU1rk8rJnnsOGElQeZ
         YSoSorO287Dwk6kVZHMsmP7mYeXhtWl3cMwTabNBrMjGj6FVyx5/Y72nRUn2yHfPKw
         3mOyaZuQyRrOMUK6sLn5gP9apj0EIKRvn5OqPujk=
Date:   Fri, 8 Feb 2019 09:39:04 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] Driver core fixes for 5.0-rc6
Message-ID: <20190208083904.GA27008@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 1c7fc5cbc33980acd13d668f1c8f0313d6ae9fd8:

  Linux 5.0-rc2 (2019-01-14 10:41:12 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.0-rc6

for you to fetch changes up to 36991ca68db9dd43bac7f3519f080ee3939263ef:

  blk-mq: protect debugfs_create_files() from failures (2019-01-31 14:07:59 +0100)

----------------------------------------------------------------
Driver core fixes for 5.0-rc6

Here are some driver core fixes for 5.0-rc6.

Well, not so much "driver core" as "debugfs".  There's a lot of
outstanding debugfs cleanup patches coming in through different
subsystem trees, and in that process the debugfs core was found that it
really should return errors when something bad happens, to prevent
random files from showing up in the root of debugfs afterward.  So
debugfs was fixed up to handle this properly, and then two fixes for
the relay and blk-mq code was needed as it was making invalid
assumptions about debugfs return values.

There's also a cacheinfo fix in here that resolves a tiny issue.

All of these have been in linux-next for over a week with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Greg Kroah-Hartman (5):
      debugfs: fix debugfs_rename parameter checking
      debugfs: return error values, not NULL
      debugfs: debugfs_lookup() should return NULL if not found
      relay: check return of create_buf_file() properly
      blk-mq: protect debugfs_create_files() from failures

Huacai Chen (1):
      cacheinfo: Keep the old value if of_property_read_u32 fails

 block/blk-mq-debugfs.c   |  3 +++
 drivers/base/cacheinfo.c |  6 ++----
 fs/debugfs/inode.c       | 36 ++++++++++++++++++++++++------------
 kernel/relay.c           |  4 +++-
 4 files changed, 32 insertions(+), 17 deletions(-)
