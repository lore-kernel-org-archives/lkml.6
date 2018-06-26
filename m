Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A2DC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 22:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE8A326B41
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 22:31:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE8A326B41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933542AbeFZWbK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 18:31:10 -0400
Received: from mga06.intel.com ([134.134.136.31]:65177 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752136AbeFZWbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 18:31:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2018 15:31:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,276,1526367600"; 
   d="scan'208";a="235840883"
Received: from theros.lm.intel.com ([10.232.112.164])
  by orsmga005.jf.intel.com with ESMTP; 26 Jun 2018 15:31:07 -0700
From:   Ross Zwisler <ross.zwisler@linux.intel.com>
To:     Toshi Kani <toshi.kani@hpe.com>, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com
Cc:     Ross Zwisler <ross.zwisler@linux.intel.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Subject: [PATCH v5 0/3] Fix DM DAX handling
Date:   Tue, 26 Jun 2018 16:30:38 -0600
Message-Id: <20180626223041.15653-1-ross.zwisler@linux.intel.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes a few issues that I found with DM's handling of DAX
devices.  Here are some of the issues I found:

 * We can create a dm-stripe or dm-linear device which is made up of an
   fsdax PMEM namespace and a raw PMEM namespace but which can hold a
   filesystem mounted with the -o dax mount option.  DAX operations to
   the raw PMEM namespace part lack struct page and can fail in
   interesting/unexpected ways when doing things like fork(), examining
   memory with gdb, etc.

 * We can create a dm-stripe or dm-linear device which is made up of an
   fsdax PMEM namespace and a BRD ramdisk which can hold a filesystem
   mounted with the -o dax mount option.  All I/O to this filesystem
   will fail.

---

Changes since v4:
 * No code changes.
 * Updated the changelogs for patches 1 and 3.
 * Removed the Cc: stable from patch 1.
 * Added a Fixes: tag to patch 2.

Ross Zwisler (3):
  pmem: only set QUEUE_FLAG_DAX for fsdax mode
  dax: bdev_dax_supported() check for QUEUE_FLAG_DAX
  dm: prevent DAX mounts if not supported

 drivers/dax/super.c   | 8 ++++++++
 drivers/md/dm-table.c | 7 ++++---
 drivers/md/dm.c       | 3 +--
 drivers/nvdimm/pmem.c | 3 ++-
 4 files changed, 15 insertions(+), 6 deletions(-)

-- 
2.14.4

