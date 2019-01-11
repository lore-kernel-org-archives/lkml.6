Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4126C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E38620652
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lUkPJa22"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389810AbfAKSGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 13:06:20 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:52074 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733103AbfAKSFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 13:05:37 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0BI5O11105129;
        Fri, 11 Jan 2019 12:05:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547229924;
        bh=dnoC4g4UoLezk5fZBwcNGVWjB6TZRXkCHV12ZWUV3rQ=;
        h=From:To:CC:Subject:Date;
        b=lUkPJa220ixfy85mQm3P9n0vHF4n3ARj9wIOT1NxHMfkz5wGZgO9MZBrmOZnmP/J4
         xavVKvGChOq66ZXDlpiZO5H0xKRA6ORxTKFOsYy/ljcX3qztTQpv3HcaF7hmEUjFkg
         6XXbPNmfOwCzlM+sMwSUBTiEu12DfAund87tkjyc=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0BI5Otj008931
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Jan 2019 12:05:24 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 11
 Jan 2019 12:05:24 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 11 Jan 2019 12:05:24 -0600
Received: from legion.dal.desgin.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0BI5Of4006329;
        Fri, 11 Jan 2019 12:05:24 -0600
Received: from localhost (uda0226330.dhcp.ti.com [172.22.109.196])
        by legion.dal.desgin.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id x0BI5NU07699;
        Fri, 11 Jan 2019 12:05:23 -0600 (CST)
From:   "Andrew F. Davis" <afd@ti.com>
To:     Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>
CC:     <devel@driverdev.osuosl.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH 00/14] Misc ION cleanups and adding unmapped heap
Date:   Fri, 11 Jan 2019 12:05:09 -0600
Message-ID: <20190111180523.27862-1-afd@ti.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

This is a set of (hopefully) non-controversial cleanups for the ION
framework and current set of heaps. These were found as I start to
familiarize myself with the framework to help in whatever way I
can in getting all this up to the standards needed for de-staging.

I would like to get some ideas of what is left to work on to get ION
out of staging. Has there been some kind of agreement on what ION should
eventually end up being? To me it looks like it is being whittled away at
to it's most core functions. To me that is looking like being a DMA-BUF
user-space front end, simply advertising available memory backings in a
system and providing allocations as DMA-BUF handles. If this is the case
then it looks close to being ready to me at least, but I would love to
hear any other opinions and concerns.

Back to this patchset, the last patch may be a bit different than the
others, it adds an unmapped heaps type and creation helper. I wanted to
get this in to show off another heap type and maybe some issues we may
have with the current ION framework. The unmapped heap is used when the
backing memory should not (or cannot) be touched. Currently this kind
of heap is used for firewalled secure memory that can be allocated like
normal heap memory but only used by secure devices (OP-TEE, crypto HW,
etc). It is basically just copied from the "carveout" heap type with the
only difference being it is not mappable to userspace and we do not clear
the memory (as we should not map it either). So should this really be a
new heap type? Or maybe advertised as a carveout heap but with an
additional allocation flag? Perhaps we do away with "types" altogether
and just have flags, coherent/non-coherent, mapped/unmapped, etc.

Maybe more thinking will be needed afterall..

Thanks,
Andrew

Andrew F. Davis (14):
  staging: android: ion: Add proper header information
  staging: android: ion: Remove empty ion_ioctl_dir() function
  staging: android: ion: Merge ion-ioctl.c into ion.c
  staging: android: ion: Remove leftover comment
  staging: android: ion: Remove struct ion_platform_heap
  staging: android: ion: Fixup some white-space issues
  staging: android: ion: Sync comment docs with struct ion_buffer
  staging: android: ion: Remove base from ion_carveout_heap
  staging: android: ion: Remove base from ion_chunk_heap
  staging: android: ion: Remove unused headers
  staging: android: ion: Allow heap name to be null
  staging: android: ion: Declare helpers for carveout and chunk heaps
  staging: android: ion: Do not sync CPU cache on map/unmap
  staging: android: ion: Add UNMAPPED heap type and helper

 drivers/staging/android/ion/Kconfig           |  10 ++
 drivers/staging/android/ion/Makefile          |   3 +-
 drivers/staging/android/ion/ion-ioctl.c       |  98 --------------
 drivers/staging/android/ion/ion.c             |  93 +++++++++++--
 drivers/staging/android/ion/ion.h             |  87 ++++++++-----
 .../staging/android/ion/ion_carveout_heap.c   |  19 +--
 drivers/staging/android/ion/ion_chunk_heap.c  |  25 ++--
 drivers/staging/android/ion/ion_cma_heap.c    |   6 +-
 drivers/staging/android/ion/ion_heap.c        |   8 +-
 drivers/staging/android/ion/ion_page_pool.c   |   2 +-
 drivers/staging/android/ion/ion_system_heap.c |   8 +-
 .../staging/android/ion/ion_unmapped_heap.c   | 123 ++++++++++++++++++
 drivers/staging/android/uapi/ion.h            |   3 +
 13 files changed, 307 insertions(+), 178 deletions(-)
 delete mode 100644 drivers/staging/android/ion/ion-ioctl.c
 create mode 100644 drivers/staging/android/ion/ion_unmapped_heap.c

-- 
2.19.1

