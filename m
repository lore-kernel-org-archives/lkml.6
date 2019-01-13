Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA073C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 10:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAAC720657
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 10:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547375051;
	bh=5slJnWfrAThA0Q/cWxY4mG8ZcTbKqts83B+Ve+ssNYI=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=VGAuulvWlvKDfNXAyxrl1Vh7wGGEdoMO3kFjAtCoyPAskzYG3Gozc0HzPjPkKf8vK
	 A1x1XqOp6LK8NW4CQRb5inWEOBk4W2F9C6Cs12CA4Ggqce052BBob09VQsX+cOX8ns
	 fZYoXtu9hWp1HpuTWUmBCGZVEC1NhB47C9b12Yrc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfAMKYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 05:24:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:57034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbfAMKYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 05:24:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6215F20657;
        Sun, 13 Jan 2019 10:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547375049;
        bh=5slJnWfrAThA0Q/cWxY4mG8ZcTbKqts83B+Ve+ssNYI=;
        h=Date:From:To:Cc:Subject:From;
        b=pprwCpk7+BJOp36+p0dJNOV/+Ts+ui3pXGJlDcMli11GN2FKy062gDPpCvxdocE++
         /Ixut2UFqTJVQ71KphHRAmBfaK/nw/IPpC1TLjd6ZPb29bvURZASUZE0L0Fu+VzYLo
         gXU5sdQuDMEYVS4TtjqIIXqqYJfNGBkefdPN8fmM=
Date:   Sun, 13 Jan 2019 11:24:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] Driver core fixes for 5.0-rc2
Message-ID: <20190113102407.GA31034@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git driver-core-5.0-rc2

for you to fetch changes up to 735df0ff6ece7b8759a744158f5d246fae4739f4:

  Documentation: driver core: remove use of BUS_ATTR (2019-01-08 15:17:45 +0100)

----------------------------------------------------------------
Driver core fixes for 5.0-rc2

Here is one small sysfs change, and a documentation update for 5.0-rc2

The sysfs change moves from using BUG_ON to WARN_ON, as discussed in an
email thread on lkml while trying to track down another driver bug.
sysfs should not be crashing and preventing people from seeing where
they went wrong.  Now it properly recovers and warns the developer.

The documentation update removes the use of BUS_ATTR() as the kernel is
moving away from this to use the specific BUS_ATTR_RW() and friends
instead.  There are pending patches in all of the different subsystems
to remove the last users of this macro, but for now, don't advertise it
should be used anymore to keep new ones from being introduced.

Both have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Greg Kroah-Hartman (2):
      sysfs: convert BUG_ON to WARN_ON
      Documentation: driver core: remove use of BUS_ATTR

 Documentation/driver-model/bus.txt  | 8 ++++----
 Documentation/filesystems/sysfs.txt | 4 +++-
 fs/sysfs/dir.c                      | 3 ++-
 fs/sysfs/file.c                     | 6 ++++--
 fs/sysfs/group.c                    | 3 ++-
 fs/sysfs/symlink.c                  | 3 ++-
 6 files changed, 17 insertions(+), 10 deletions(-)
