Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3204C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FC3A26B88
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:59:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FC3A26B88
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754842AbeFZR7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:59:37 -0400
Received: from mga07.intel.com ([134.134.136.100]:23715 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752199AbeFZR7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:59:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2018 10:59:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,275,1526367600"; 
   d="scan'208";a="50086617"
Received: from theros.lm.intel.com ([10.232.112.164])
  by fmsmga007.fm.intel.com with ESMTP; 26 Jun 2018 10:59:34 -0700
From:   Ross Zwisler <ross.zwisler@linux.intel.com>
To:     Toshi Kani <toshi.kani@hpe.com>, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com
Cc:     Ross Zwisler <ross.zwisler@linux.intel.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-xfs@vger.kernel.org
Subject: [PATCH v3 0/3] Fix DM DAX handling
Date:   Tue, 26 Jun 2018 11:59:29 -0600
Message-Id: <20180626175932.8899-1-ross.zwisler@linux.intel.com>
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

Changes since v2:
  * Only set QUEUE_FLAG_DAX for fsdax mode PMEM namespaces. (Mike)
  * Check for QUEUE_FLAG_DAX in __bdev_dax_supported(). (Mike)
  * Get rid of DM_TYPE_DAX_BIO_BASED reworks. (Mike)
  * Dropped the first 2 prep patches of v2 since they were merged for
    v4.18-rc1.  (Thanks, Darrick!)

---

Mike, can you take this series through your tree?

Personally I think this should be treated as a bug fix and merged in the
v4.18-rc* series.

Ross Zwisler (3):
  pmem: only set QUEUE_FLAG_DAX for fsdax mode
  dax: bdev_dax_supported() check for QUEUE_FLAG_DAX
  dm: prevent DAX mounts if not supported

 drivers/dax/super.c           | 8 ++++++++
 drivers/md/dm-ioctl.c         | 5 +++++
 drivers/md/dm-table.c         | 7 +++----
 drivers/md/dm.c               | 3 +--
 drivers/nvdimm/pmem.c         | 3 ++-
 include/linux/device-mapper.h | 5 +++++
 6 files changed, 24 insertions(+), 7 deletions(-)

-- 
2.14.4

