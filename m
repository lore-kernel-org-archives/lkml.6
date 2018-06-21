Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3073DC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8C8421AA5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jJu9Cewq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8C8421AA5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933867AbeFUV2z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:28:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41714 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932899AbeFUV2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 17:28:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1FPq25PETmvt5KNrYdWbDZqapwumrQ4tY7zcjxRevkA=; b=jJu9CewqMUKzmiUHPM3bQce21
        Afz3Rveyld71fsuVI4S219oGWgCkEEvQoQh9fWAiwEA7nEbiNXPbTmEs5FTH7Wk3/U8nQozeTrgje
        3cgM7Q04TdyQvkE1FVvY34RaGYehKOKCuVdzlofY4a678ti7JlpO6isO/LIEWB8PC4W5XrNRY5PsN
        isRw3rUVIczlh7cj5PJnKNOmtQl//U0JBDQsZkzt+6xzhOOJFfz+mtY4Nyg352av0jpLinKDp0Q85
        OrmMUgMrrrXL6g+cax6Q//rF9t1Ygxq1zQ2hMtBhoLJ+2ubjxmn7NkIHEXV/cbJi6huSqNd93TBgR
        w+2b15oAw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fW78O-0001Z8-8v; Thu, 21 Jun 2018 21:28:52 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 00/26] New IDA API
Date:   Thu, 21 Jun 2018 14:28:09 -0700
Message-Id: <20180621212835.5636-1-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As threatened a few months ago https://lwn.net/Articles/750154/, here's a
patch series to convert all users of the non-simple IDA API to ida_alloc*.
Basically every driver is improved by doing this.  There are a long
list of people on the bcc for this cover letter, plus patches 2 and 3.
All patches are being sent to linux-kernel.  The entire series is also
available as a git tree at
	git://git.infradead.org/users/willy/linux-dax.git ida

Matthew Wilcox (26):
  radix tree test suite: fix build
  ida: Lock the IDA in ida_destroy
  ida: Add new API
  mtip32xx: Convert to new IDA API
  fs: Convert unnamed_dev_ida to new API
  fs: Convert namespace IDAs to new API
  devpts: Convert to new IDA API
  sd: Convert to new IDA interface
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

 arch/powerpc/mm/mmu_context_book3s64.c        |  44 +---
 arch/powerpc/platforms/powernv/vas-window.c   |  26 +--
 drivers/block/mtip32xx/mtip32xx.c             |  29 +--
 drivers/block/rsxx/core.c                     |  21 +-
 drivers/dma/dmaengine.c                       |  20 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c |  41 +---
 drivers/media/media-device.c                  |  16 +-
 drivers/misc/cb710/core.c                     |  23 +-
 drivers/scsi/osd/osd_uld.c                    |  22 +-
 drivers/scsi/sd.c                             |  21 +-
 drivers/target/iscsi/iscsi_target.c           |  10 +-
 drivers/target/iscsi/iscsi_target.h           |   4 +-
 drivers/target/iscsi/iscsi_target_login.c     |  20 +-
 fs/devpts/inode.c                             |  47 ++--
 fs/namespace.c                                |  50 +---
 fs/super.c                                    |  63 ++----
 include/linux/idr.h                           |  68 ++++--
 lib/Kconfig.debug                             |   3 +
 lib/Makefile                                  |   1 +
 lib/idr.c                                     | 155 +++++--------
 lib/radix-tree.c                              |   9 -
 lib/test_ida.c                                | 173 ++++++++++++++
 net/core/net_namespace.c                      |  16 +-
 tools/testing/radix-tree/Makefile             |   1 +
 tools/testing/radix-tree/idr-test.c           | 214 ++++--------------
 tools/testing/radix-tree/linux/xarray.h       |   2 +
 tools/testing/radix-tree/main.c               |   3 +-
 tools/testing/radix-tree/test.h               |   3 +-
 28 files changed, 450 insertions(+), 655 deletions(-)
 create mode 100644 lib/test_ida.c
 create mode 100644 tools/testing/radix-tree/linux/xarray.h

-- 
2.17.1

