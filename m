Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F2EC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 456F620834
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:31:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 456F620834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbeHTTrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 15:47:24 -0400
Received: from mga05.intel.com ([192.55.52.43]:53414 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbeHTTrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 15:47:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2018 09:31:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,265,1531810800"; 
   d="scan'208";a="226167666"
Received: from agluck-desk.sc.intel.com ([10.3.52.160])
  by orsmga004.jf.intel.com with ESMTP; 20 Aug 2018 09:31:04 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Tomasz Nowicki <tn@semihalf.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH] ia64: Fix kernel BUG at lib/ioremap.c:72!
Date:   Mon, 20 Aug 2018 09:31:04 -0700
Message-Id: <20180820163104.12879-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAK8P3a0Jk_Q-9c7PizRF4HteigfiOprRszpaV9SCk-6tUYfVVQ@mail.gmail.com>
References: <CAK8P3a0Jk_Q-9c7PizRF4HteigfiOprRszpaV9SCk-6tUYfVVQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit:
  0bbf47eab469 ("ia64: use asm-generic/io.h")

results in a BUG while booting ia64.  This is because
asm-generic/io.h defines PCI_IOBASE, which results in
the function acpi_pci_root_remap_iospace() doing a lot
of unnecessary (and wrong) things.

I'd suggested an #if !CONFIG_IA64 in the functon, but Arnd
suggested keeping the fix inside the arch/ia64 tree.

Fixes: 0bbf47eab469 ("ia64: use asm-generic/io.h")
Suggested-by: Arnd Bergman <arnd@arndb.de>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/ia64/include/asm/io.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/ia64/include/asm/io.h b/arch/ia64/include/asm/io.h
index 6f952171abf9..1e6fef69bb01 100644
--- a/arch/ia64/include/asm/io.h
+++ b/arch/ia64/include/asm/io.h
@@ -454,6 +454,7 @@ extern void memset_io(volatile void __iomem *s, int c, long n);
 #define xlate_dev_kmem_ptr xlate_dev_kmem_ptr
 #define xlate_dev_mem_ptr xlate_dev_mem_ptr
 #include <asm-generic/io.h>
+#undef PCI_IOBASE
 
 # endif /* __KERNEL__ */
 
-- 
2.17.1

