Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653ACC6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DEF320854
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:39:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DEF320854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730252AbeGVRgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 13:36:25 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:52208 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729936AbeGVRgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 13:36:25 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fhHO1-0000xY-QW; Sun, 22 Jul 2018 16:39:09 +0000
Date:   Sun, 22 Jul 2018 17:39:09 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] vfs.git assorted fixes
Message-ID: <20180722163909.GG30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Fix several places that screw up cleanups after failures halfway
through opening a file (one open-coding filp_clone_open() and getting
it wrong, two misusing alloc_file()).  That part is -stable fodder from
#work.open.
	And Christoph's regression fix for uapi breakage in aio series;
include/uapi/linux/aio_abi.h shouldn't be pulling in the kernel definition
of sigset_t, the reason for doing so in the first place had been bogus - 
there's no need to expose struct __aio_sigset in aio_abi.h at all.

The following changes since commit 877f919e192a09e77962a13d7165783027dee5fd:

  proc: add proc_seq_release (2018-06-27 20:44:38 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

for you to fetch changes up to 9ba546c01976a426292af99e682a557075d6c010:

  aio: don't expose __aio_sigset in uapi (2018-07-17 23:26:58 -0400)

----------------------------------------------------------------
Al Viro (3):
      drm_mode_create_lease_ioctl(): fix open-coded filp_clone_open()
      cxl_getfile(): fix double-iput() on alloc_file() failures
      ocxlflash_getfile(): fix double-iput() on alloc_file() failures

Christoph Hellwig (1):
      aio: don't expose __aio_sigset in uapi

 drivers/gpu/drm/drm_lease.c     | 16 +---------------
 drivers/misc/cxl/api.c          |  8 ++++----
 drivers/scsi/cxlflash/ocxl_hw.c |  5 ++---
 fs/aio.c                        |  5 +++++
 fs/internal.h                   |  1 -
 include/linux/fs.h              |  1 +
 include/linux/syscalls.h        |  1 +
 include/uapi/linux/aio_abi.h    |  6 ------
 8 files changed, 14 insertions(+), 29 deletions(-)
