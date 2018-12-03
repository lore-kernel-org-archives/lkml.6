Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0966C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8273F214C1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:25:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8273F214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbeLCTZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 14:25:27 -0500
Received: from mga09.intel.com ([134.134.136.24]:12025 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbeLCTZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 14:25:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2018 11:25:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,311,1539673200"; 
   d="scan'208";a="115600452"
Received: from ahduyck-desk1.amr.corp.intel.com ([10.7.198.76])
  by orsmga001.jf.intel.com with ESMTP; 03 Dec 2018 11:25:20 -0800
Subject: [PATCH RFC 0/3] Fix KVM misinterpreting Reserved page as an MMIO
 page
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     dan.j.williams@intel.com, pbonzini@redhat.com,
        yi.z.zhang@linux.intel.com, brho@google.com, kvm@vger.kernel.org,
        linux-nvdimm@lists.01.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dave.jiang@intel.com, yu.c.zhang@intel.com, pagupta@redhat.com,
        david@redhat.com, jack@suse.cz, hch@lst.de, rkrcmar@redhat.com,
        jglisse@redhat.com
Date:   Mon, 03 Dec 2018 11:25:20 -0800
Message-ID: <154386493754.27193.1300965403157243427.stgit@ahduyck-desk1.amr.corp.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have loosely based this patch series off of the following patch series
from Zhang Yi:
https://lore.kernel.org/lkml/cover.1536342881.git.yi.z.zhang@linux.intel.com

The original set had attempted to address the fact that DAX pages were
treated like MMIO pages which had resulted in reduced performance. It
attempted to address this by ignoring the PageReserved flag if the page
was either a DEV_DAX or FS_DAX page.

I am proposing this as an alternative to that set. The main reason for this
is because I believe there are a few issues that were overlooked with that
original set. Specifically KVM seems to have two different uses for the
PageReserved flag. One being whether or not we can pin the memory, the other
being if we should be marking the pages as dirty or accessed. I believe
only the pinning really applies so I have split the uses of
kvm_is_reserved_pfn and updated the function uses to determine support for
page pinning to include a check of the pgmap to see if it supports pinning.

---

Alexander Duyck (3):
      kvm: Split use cases for kvm_is_reserved_pfn to kvm_is_refcounted_pfn
      mm: Add support for exposing if dev_pagemap supports refcount pinning
      kvm: Add additional check to determine if a page is refcounted


 arch/x86/kvm/mmu.c        |    6 +++---
 drivers/nvdimm/pfn_devs.c |    2 ++
 include/linux/kvm_host.h  |    2 +-
 include/linux/memremap.h  |    5 ++++-
 include/linux/mm.h        |   11 +++++++++++
 virt/kvm/kvm_main.c       |   34 +++++++++++++++++++++++++---------
 6 files changed, 46 insertions(+), 14 deletions(-)

--
