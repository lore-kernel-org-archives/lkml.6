Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A90C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEAE7224C6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="Ra3bSb7u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEAE7224C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933978AbeGFRr1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:47:27 -0400
Received: from alln-iport-6.cisco.com ([173.37.142.93]:59300 "EHLO
        alln-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932895AbeGFRr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:47:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=736; q=dns/txt; s=iport;
  t=1530899246; x=1532108846;
  h=from:to:cc:subject:date:message-id;
  bh=VOkEMOnasABVk6w4/AXEel3N/8bUEXdjVLErUTbofj4=;
  b=Ra3bSb7uLA1fZFExcUatnibYFRxjKD/5E4yhtJU0Abuto4ftuc8JmS75
   HR7jjRcfd4VUUUP4KRydPK80J6pYT/xx6NGjSRNAfs7Iw1KczZ9QMMF+i
   e1Y+vVhSoftEpwTFNZI34haTQ9RW6WUiKs+62pQMgOjEXLF/T4xKsR9qT
   Q=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0D+AADM+T5b/5xdJa1cGgEBAQEBAgE?=
 =?us-ascii?q?BAQEIAQEBAYNJgWEoi36MNZc3gXoLhGyCLyE0GAECAQECAQECbSiGNoE+ARK?=
 =?us-ascii?q?DIIF/AatAhFuDdIE6FIhZgVY/jm4CjTyMEwmPFwuNWJILgUE4gVIzGggbFYM?=
 =?us-ascii?q?kkHJPj1IBAQ?=
X-IronPort-AV: E=Sophos;i="5.51,317,1526342400"; 
   d="scan'208";a="138976924"
Received: from rcdn-core-5.cisco.com ([173.37.93.156])
  by alln-iport-6.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jul 2018 17:47:25 +0000
Received: from sjc-ads-3734.cisco.com (sjc-ads-3734.cisco.com [171.68.250.181])
        by rcdn-core-5.cisco.com (8.14.5/8.14.5) with ESMTP id w66HlO2q012908;
        Fri, 6 Jul 2018 17:47:25 GMT
From:   Nikunj Kela <nkela@cisco.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     xe-kernel@external.cisco.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] arm64: add ARM64-specific support for flatmem
Date:   Fri,  6 Jul 2018 10:47:24 -0700
Message-Id: <20180706174724.44594-1-nkela@cisco.com>
X-Mailer: git-send-email 2.10.3.dirty
X-Auto-Response-Suppress: DR, OOF, AutoReply
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Flatmem is useful in reducing kernel memory usage.
One usecase is in kdump kernel. We are able to save
~14M by moving to flatmem scheme.

Cc: xe-kernel@external.cisco.com
Cc: Nikunj Kela <nkela@cisco.com>
Signed-off-by: Nikunj Kela <nkela@cisco.com>
---
 arch/arm64/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 42c090c..f5b4c49 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -775,6 +775,9 @@ config ARCH_SPARSEMEM_DEFAULT
 config ARCH_SELECT_MEMORY_MODEL
 	def_bool ARCH_SPARSEMEM_ENABLE
 
+config ARCH_FLATMEM_ENABLE
+	def_bool y
+
 config HAVE_ARCH_PFN_VALID
 	def_bool ARCH_HAS_HOLES_MEMORYMODEL || !SPARSEMEM
 
-- 
2.10.3.dirty

