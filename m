Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEC2C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2A63216FC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="ReWWCqdM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2A63216FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933987AbeGFRCS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:02:18 -0400
Received: from rcdn-iport-4.cisco.com ([173.37.86.75]:26410 "EHLO
        rcdn-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933633AbeGFRCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:02:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=758; q=dns/txt; s=iport;
  t=1530896536; x=1532106136;
  h=from:to:cc:subject:date:message-id;
  bh=KcggRjJdx4fmHj2hrArU96li1Xa04sMQNVqDWZef9JI=;
  b=ReWWCqdM/8I9oBL3WH+/UOurD/d4efETLun6fabacfZa56BV9Sb0Y56J
   QdXQH36FeBh9ForQ7HoHw7OpLbdsUjtnYgAic43/XsO9RX0MsLIzl1fcN
   xh/bVsUFDeeJvg0bYtKhaychM0ZW1vSiEfY5X/5qMy29QVTGuDCdQUItp
   0=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0D+AADM+T5b/5JdJa1cGgEBAQEBAgE?=
 =?us-ascii?q?BAQEIAQEBAYNJgWEoi36MNZc3gXoLhGyCLyE0GAECAQECAQECbSiGNoE+ARK?=
 =?us-ascii?q?DIIF/AatAhFuDdIE6FIhZgVY/gQ+NXwKNPIwTCY8XC41YkguBQTiBUjMaCBs?=
 =?us-ascii?q?VgySQck+PUgEB?=
X-IronPort-AV: E=Sophos;i="5.51,317,1526342400"; 
   d="scan'208";a="420042355"
Received: from rcdn-core-10.cisco.com ([173.37.93.146])
  by rcdn-iport-4.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jul 2018 17:02:16 +0000
Received: from sjc-ads-3734.cisco.com (sjc-ads-3734.cisco.com [171.68.250.181])
        by rcdn-core-10.cisco.com (8.14.5/8.14.5) with ESMTP id w66H2F4a027907;
        Fri, 6 Jul 2018 17:02:15 GMT
From:   Nikunj Kela <nkela@cisco.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     xe-kernel@external.cisco.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: add ARM64-specific support for flatmem
Date:   Fri,  6 Jul 2018 10:02:15 -0700
Message-Id: <20180706170215.56116-1-nkela@cisco.com>
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
 arch/arm64/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 42c090c..96ab9a7 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -775,6 +775,10 @@ config ARCH_SPARSEMEM_DEFAULT
 config ARCH_SELECT_MEMORY_MODEL
 	def_bool ARCH_SPARSEMEM_ENABLE
 
+config ARCH_FLATMEM_ENABLE
+	def_bool y
+	depends on !NUMA
+
 config HAVE_ARCH_PFN_VALID
 	def_bool ARCH_HAS_HOLES_MEMORYMODEL || !SPARSEMEM
 
-- 
2.10.3.dirty

