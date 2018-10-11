Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC488C28CF8
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 23:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B89F2147C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 23:40:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B89F2147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbeJLHJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 03:09:42 -0400
Received: from mga06.intel.com ([134.134.136.31]:35467 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbeJLHJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 03:09:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2018 16:40:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,370,1534834800"; 
   d="scan'208";a="96792944"
Received: from rpedgeco-desk5.jf.intel.com ([10.54.75.168])
  by fmsmga004.fm.intel.com with ESMTP; 11 Oct 2018 16:40:05 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     kernel-hardening@lists.openwall.com, daniel@iogearbox.net,
        keescook@chromium.org, catalin.marinas@arm.com,
        will.deacon@arm.com, davem@davemloft.net, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, arnd@arndb.de,
        jeyu@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     kristen@linux.intel.com, dave.hansen@intel.com,
        arjan@linux.intel.com, deneen.t.dock@intel.com,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH v2 5/7] mips/modules: Add rlimit checking for mips modules
Date:   Thu, 11 Oct 2018 16:31:15 -0700
Message-Id: <20181011233117.7883-6-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181011233117.7883-1-rick.p.edgecombe@intel.com>
References: <20181011233117.7883-1-rick.p.edgecombe@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds in the rlimit checking for the mips module allocator.

This has not been tested.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/mips/kernel/module.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/module.c b/arch/mips/kernel/module.c
index 491605137b03..7a23392512d1 100644
--- a/arch/mips/kernel/module.c
+++ b/arch/mips/kernel/module.c
@@ -47,9 +47,18 @@ static DEFINE_SPINLOCK(dbe_lock);
 #ifdef MODULE_START
 void *module_alloc(unsigned long size)
 {
-	return __vmalloc_node_range(size, 1, MODULE_START, MODULE_END,
+	void *p;
+
+	if (check_inc_mod_rlimit(size))
+		return NULL;
+
+	p = __vmalloc_node_range(size, 1, MODULE_START, MODULE_END,
 				GFP_KERNEL, PAGE_KERNEL, 0, NUMA_NO_NODE,
 				__builtin_return_address(0));
+
+	update_mod_rlimit(p, size);
+
+	return p;
 }
 #endif
 
-- 
2.17.1

