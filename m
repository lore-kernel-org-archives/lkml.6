Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DATE_IN_FUTURE_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2387EC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D989F206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:24:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D989F206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbeIGOEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 10:04:02 -0400
Received: from mga07.intel.com ([134.134.136.100]:64649 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727093AbeIGOEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 10:04:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Sep 2018 02:23:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,341,1531810800"; 
   d="scan'208";a="255286464"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 07 Sep 2018 02:23:58 -0700
Received: from dazhang1-ssd.sh.intel.com (unknown [10.239.48.163])
        by linux.intel.com (Postfix) with ESMTP id 3EBE25803DA;
        Fri,  7 Sep 2018 02:23:56 -0700 (PDT)
From:   Zhang Yi <yi.z.zhang@linux.intel.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, pbonzini@redhat.com,
        dan.j.williams@intel.com, dave.jiang@intel.com,
        yu.c.zhang@intel.com, pagupta@redhat.com, david@redhat.com,
        jack@suse.cz, hch@lst.de
Cc:     linux-mm@kvack.org, rkrcmar@redhat.com, jglisse@redhat.com,
        yi.z.zhang@intel.com, Zhang Yi <yi.z.zhang@linux.intel.com>
Subject: [PATCH V5 0/4] Fix kvm misconceives NVDIMM pages as reserved mmio
Date:   Sat,  8 Sep 2018 02:03:02 +0800
Message-Id: <cover.1536342881.git.yi.z.zhang@linux.intel.com>
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

V1:
https://lkml.org/lkml/2018/7/4/91

V2:
https://lkml.org/lkml/2018/7/10/135

V3:
https://lkml.org/lkml/2018/8/9/17

V4:
https://lkml.org/lkml/2018/8/22/17

V5:
[PATCH V3 1/4] Reviewed-by: David / Acked-by: Pankaj
[PATCH V3 2/4] Reviewed-by: Jan
[PATCH V3 3/4] Acked-by: Jan
[PATCH V3 4/4] Added "Acked-by: Pankaj", Added in-line comments: Dave

Zhang Yi (4):
  kvm: remove redundant reserved page check
  mm: introduce memory type MEMORY_DEVICE_DEV_DAX
  mm: add a function to differentiate the pages is from DAX device
    memory
  kvm: add a check if pfn is from NVDIMM pmem.

 drivers/dax/pmem.c       |  1 +
 include/linux/memremap.h |  8 ++++++++
 include/linux/mm.h       | 12 ++++++++++++
 virt/kvm/kvm_main.c      | 24 ++++++++++++++++--------
 4 files changed, 37 insertions(+), 8 deletions(-)

-- 
2.7.4

