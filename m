Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E98EC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 04:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10F3F214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 04:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JXKcEjp2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10F3F214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbeHVHu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 03:50:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57098 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbeHVHu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 03:50:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Sknjr2QawsuoiR+gCyAY1RVFHTFNeKCujwinzsr/mNI=; b=JXKcEjp2Igyw4mULR5tHmtQNC
        cQKku+XpY2w5c9vfSfyGJlW+vW+LVwBYeBcRZEh3P1js05BfABR6yGyYkkr3IeLyl2+aTZnNR34Co
        bXS3CLqmU4HNJi+KHFL8xLyeitvrmTnEP+137dAfkOHEcdrsRwKDHxPyKHRbVPPxNHEO136NHjL6M
        Sen8wfUFdyKsKBzV/iM2xRxvNXwEEABh7OO5Ts6P9JV+epj14JMoabV64oCYJa1+FLkPDSPPCnYBh
        4P8KLjc/YCeFpQifhLMJEI5Cr3yWd8s2uo+g8SO0VA2BLpcJv2mxyrVP0SWf2bEMdzWyMED+fxs49
        EiBvqagng==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fsKjq-0004cS-7J; Wed, 22 Aug 2018 04:27:22 +0000
Date:   Tue, 21 Aug 2018 21:27:22 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] IDA changes for 4.19
Message-ID: <20180822042722.GA29952@bombadil.infradead.org>
References: <20180813200003.GA5931@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180813200003.GA5931@bombadil.infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2018 at 01:00:03PM -0700, Matthew Wilcox wrote:
> 
> Hi Linus,
> 
> Please pull the IDA patchset.  It depends on the XArray patchset, so
> ignore this pull request if you've decided not to pull the XArray patches.
> The new IDA API is similar to ida_simple_get() but better named.  The
> internal restructuring of the IDA code removes the bitmap preallocation
> nonsense.

I've redone this patchset to not depend on the XArray.  It no longer
removes the bitmap preallocation because that was too entangled with the
rewrite to use the XArray.  But it does give us a better IDA API --
id = ida_alloc(ida, GFP_xxx); ida_free(ida, id); rather than the
cumbersome ida_simple_get(), ida_simple_remove().  The preallocation is
no longer visible to consumers, so removing it will be easier next round.

I hope the net -200 lines of code is convincing.

The following changes since commit 94710cac0ef4ee177a63b5227664b38c95bbf703:

  Linux 4.18 (2018-08-12 13:41:04 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/willy/linux-dax.git ida-4.19

for you to fetch changes up to 1df895190233fcc30d46beca4550bcafb7b959a6:

  ida: Change ida_get_new_above to return the id (2018-08-21 23:54:21 -0400)

----------------------------------------------------------------
Matthew Wilcox (28):
      radix tree test suite: Fix compilation
      radix tree test suite: Enable ubsan
      radix-tree: Fix UBSAN warning
      ida: Lock the IDA in ida_destroy
      ida: Add new API
      mtip32xx: Convert to new IDA API
      fs: Convert unnamed_dev_ida to new API
      fs: Convert namespace IDAs to new API
      devpts: Convert to new IDA API
      sd: Convert to new IDA API
      osd: Convert to new IDA API
      rsxx: Convert to new IDA API
      cb710: Convert to new IDA API
      Convert net_namespace to new IDA API
      ppc: Convert mmu context allocation to new IDA API
      media: Convert entity ID allocation to new IDA API
      ppc: Convert vas ID allocation to new IDA API
      dmaengine: Convert to new IDA API
      drm/vmwgfx: Convert to new IDA API
      target/iscsi: Allocate session IDs from an IDA
      ida: Start new test_ida module
      idr-test: Convert ida_check_nomem to new API
      test_ida: Move ida_check_leaf
      test_ida: Move ida_check_max
      test_ida: Convert check_ida_conv to new API
      test_ida: check_ida_destroy and check_ida_alloc
      ida: Remove old API
      ida: Change ida_get_new_above to return the id

Mike Christie (1):
      iscsi target: fix session creation failure handling

 arch/powerpc/mm/mmu_context_book3s64.c        |  44 +-----
 arch/powerpc/platforms/powernv/vas-window.c   |  26 +---
 drivers/block/mtip32xx/mtip32xx.c             |  29 +---
 drivers/block/rsxx/core.c                     |  21 +--
 drivers/dma/dmaengine.c                       |  23 +--
 drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c |  41 ++---
 drivers/media/media-device.c                  |  16 +-
 drivers/misc/cb710/core.c                     |  23 +--
 drivers/scsi/osd/osd_uld.c                    |  22 +--
 drivers/scsi/sd.c                             |  21 +--
 drivers/target/iscsi/iscsi_target.c           |  10 +-
 drivers/target/iscsi/iscsi_target.h           |   4 +-
 drivers/target/iscsi/iscsi_target_login.c     |  41 +++--
 fs/devpts/inode.c                             |  47 ++----
 fs/namespace.c                                |  50 ++----
 fs/super.c                                    |  67 +++-----
 include/linux/idr.h                           |  68 ++++++--
 lib/Kconfig.debug                             |   3 +
 lib/Makefile                                  |   1 +
 lib/idr.c                                     | 155 +++++++------------
 lib/radix-tree.c                              |  11 +-
 lib/test_ida.c                                | 177 +++++++++++++++++++++
 net/core/net_namespace.c                      |  16 +-
 tools/testing/radix-tree/Makefile             |   6 +-
 tools/testing/radix-tree/idr-test.c           | 214 +++++---------------------
 tools/testing/radix-tree/linux/xarray.h       |   2 +
 tools/testing/radix-tree/main.c               |  23 +--
 tools/testing/radix-tree/test.h               |   3 +-
 28 files changed, 485 insertions(+), 679 deletions(-)
 create mode 100644 lib/test_ida.c
 create mode 100644 tools/testing/radix-tree/linux/xarray.h

