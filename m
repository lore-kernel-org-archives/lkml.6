Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FFAC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F21AD24710
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:51:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F21AD24710
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933488AbeGDGvs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 02:51:48 -0400
Received: from mga04.intel.com ([192.55.52.120]:47104 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753518AbeGDGvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 02:51:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2018 23:51:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,306,1526367600"; 
   d="scan'208";a="62137584"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Jul 2018 23:51:46 -0700
Received: from dazhang1-ssd.sh.intel.com (unknown [10.239.48.78])
        by linux.intel.com (Postfix) with ESMTP id 07517580116;
        Tue,  3 Jul 2018 23:51:43 -0700 (PDT)
From:   Zhang Yi <yi.z.zhang@linux.intel.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, pbonzini@redhat.com,
        dan.j.williams@intel.com, jack@suse.cz, hch@lst.de,
        yu.c.zhang@intel.com
Cc:     linux-mm@kvack.org, rkrcmar@redhat.com, yi.z.zhang@intel.com,
        Zhang Yi <yi.z.zhang@linux.intel.com>
Subject: [PATCH 0/3] Fix kvm misconceives NVDIMM pages as reserved mmio
Date:   Wed,  4 Jul 2018 23:30:03 +0800
Message-Id: <cover.1530716899.git.yi.z.zhang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For device specific memory space, when we move these area of pfn to
memory zone, we will set the page reserved flag at that time, some of
these reserved for device mmio, and some of these are not, such as
NVDIMM pmem.

Now, we map these dev_dax or fs_dax pages to kvm for DIMM/NVDIMM
backend, since these pages are reserved. the check of
kvm_is_reserved_pfn() misconceives those pages as MMIO. Therefor, we
introduce 2 page map types, MEMORY_DEVICE_FS_DAX/MEMORY_DEVICE_DEV_DAX,
to indentify these pages are from NVDIMM pmem. and let kvm treat these
as normal pages.

Without this patch, Many operations will be missed due to this
mistreatment to pmem pages. For example, a page may not have chance to
be unpinned for KVM guest(in kvm_release_pfn_clean); not able to be
marked as dirty/accessed(in kvm_set_pfn_dirty/accessed) etc.

Zhang Yi (3):
  kvm: remove redundant reserved page check
  mm: introduce memory type MEMORY_DEVICE_DEV_DAX
  kvm: add a function to check if page is from NVDIMM pmem.

 drivers/dax/pmem.c       |  1 +
 include/linux/memremap.h |  1 +
 virt/kvm/kvm_main.c      | 25 +++++++++++++++++--------
 3 files changed, 19 insertions(+), 8 deletions(-)

-- 
2.7.4

