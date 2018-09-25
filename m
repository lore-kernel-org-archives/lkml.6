Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69A0C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F352089D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:19:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74F352089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbeIZC2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 22:28:32 -0400
Received: from mga18.intel.com ([134.134.136.126]:6617 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbeIZC2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 22:28:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2018 13:19:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,303,1534834800"; 
   d="scan'208";a="77230044"
Received: from ahduyck-mobl.amr.corp.intel.com (HELO localhost.localdomain) ([10.7.198.152])
  by orsmga006.jf.intel.com with ESMTP; 25 Sep 2018 13:19:15 -0700
Subject: [PATCH v5 1/4] mm: Remove now defunct NO_BOOTMEM from depends list
 for deferred init
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
Cc:     pavel.tatashin@microsoft.com, mhocko@suse.com,
        dave.jiang@intel.com, dave.hansen@intel.com, jglisse@redhat.com,
        rppt@linux.vnet.ibm.com, dan.j.williams@intel.com,
        logang@deltatee.com, mingo@kernel.org,
        kirill.shutemov@linux.intel.com
Date:   Tue, 25 Sep 2018 13:19:15 -0700
Message-ID: <20180925201814.3576.15105.stgit@localhost.localdomain>
In-Reply-To: <20180925200551.3576.18755.stgit@localhost.localdomain>
References: <20180925200551.3576.18755.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CONFIG_NO_BOOTMEM config option was recently removed by the patch "mm:
remove CONFIG_NO_BOOTMEM" (https://patchwork.kernel.org/patch/10600647/).
However it looks like it missed a few spots. The biggest one being the
dependency for deferred init. This patch goes through and removes the
remaining spots that appear to have been missed in the patch so that I am
able to build again with deferred memory initialization.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---

v5: New patch, added to fix regression found in latest linux-next

 arch/csky/Kconfig |    1 -
 mm/Kconfig        |    1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index fe2c94b94fe3..fb2a0ae84dd5 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -38,7 +38,6 @@ config CSKY
 	select HAVE_MEMBLOCK
 	select MAY_HAVE_SPARSE_IRQ
 	select MODULES_USE_ELF_RELA if MODULES
-	select NO_BOOTMEM
 	select OF
 	select OF_EARLY_FLATTREE
 	select OF_RESERVED_MEM
diff --git a/mm/Kconfig b/mm/Kconfig
index c6a0d82af45f..b4421aa608c4 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -631,7 +631,6 @@ config MAX_STACK_SIZE_MB
 config DEFERRED_STRUCT_PAGE_INIT
 	bool "Defer initialisation of struct pages to kthreads"
 	default n
-	depends on NO_BOOTMEM
 	depends on SPARSEMEM
 	depends on !NEED_PER_CPU_KM
 	depends on 64BIT

