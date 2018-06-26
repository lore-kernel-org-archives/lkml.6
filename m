Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166A4C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 02:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C821F23C92
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 02:41:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C821F23C92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755870AbeFZCle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 22:41:34 -0400
Received: from mga06.intel.com ([134.134.136.31]:31481 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754175AbeFZClc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 22:41:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2018 19:41:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,272,1526367600"; 
   d="scan'208";a="51891100"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.145])
  by orsmga007.jf.intel.com with ESMTP; 25 Jun 2018 19:41:31 -0700
From:   Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sai Praneeth <sai.praneeth.prakhya@intel.com>,
        Lee Chun-Yi <jlee@suse.com>, Borislav Petkov <bp@alien8.de>,
        Dave Young <dyoung@redhat.com>,
        Laszlo Ersek <lersek@redhat.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH] efi: Free existing memory map before installing new memory map
Date:   Mon, 25 Jun 2018 19:41:32 -0700
Message-Id: <1529980892-11833-1-git-send-email-sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sai Praneeth <sai.praneeth.prakhya@intel.com>

efi_memmap_install(), unmaps the existing memory map and installs the
new memory map but doesn't free the memory allocated to the existing
memory map. Fortunately, the details about the existing memory map are
stored in efi.memmap. Hence, use them to free the memory.

Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Reported-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Lee Chun-Yi <jlee@suse.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Young <dyoung@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>
Cc: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Ricardo Neri <ricardo.neri@intel.com>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---

Note: Patch based on efi tree @https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git

 drivers/firmware/efi/memmap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memmap.c
index 678e85704054..68b27b14fe94 100644
--- a/drivers/firmware/efi/memmap.c
+++ b/drivers/firmware/efi/memmap.c
@@ -229,6 +229,9 @@ int __init efi_memmap_install(phys_addr_t addr, unsigned int nr_map)
 
 	efi_memmap_unmap();
 
+	/* Free the memory allocated to the existing memory map */
+	efi_memmap_free(efi.memmap.phys_map, efi.memmap.nr_map, efi.memmap.late);
+
 	data.phys_map = addr;
 	data.size = efi.memmap.desc_size * nr_map;
 	data.desc_version = efi.memmap.desc_version;
-- 
2.7.4

