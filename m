Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FEFC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1793C22AAE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="FJTiOeCk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1793C22AAE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933458AbeGFP4a (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 11:56:30 -0400
Received: from rcdn-iport-5.cisco.com ([173.37.86.76]:1065 "EHLO
        rcdn-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932944AbeGFP43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 11:56:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=625; q=dns/txt; s=iport;
  t=1530892589; x=1532102189;
  h=from:to:cc:subject:date:message-id;
  bh=JNJmpL6/5U3ijWvhGmxn2uT8ExJBxBHHN1+cUnd73MU=;
  b=FJTiOeCkTe9HrQspx6Wk4/pEPjrZVDAjPS4t9+q5cX1ho3ydA7cIUtTe
   Sa+QOVp2Nq7n24PtY+vnHDDO/kyRBqHGJ8DEOOg7x5M7HUPg83gqd07/E
   jKG+6R7ZYA1tajI3rN7vv5nJcGICLXnU79lfmydjDpNCBeQm+C/fsOxXo
   4=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0D+AADM+T5b/4wNJK1cGgEBAQEBAgE?=
 =?us-ascii?q?BAQEIAQEBAYNJgWEoi36MNZc3gXoLhGyCLyE0GAECAQECAQECbSiGNoE+ARK?=
 =?us-ascii?q?DIIF/AatAhFuDdIE6FIhZgVY/gQ+NXwKNPIwTCY8XC4EyjCUBkguBQTiBUjM?=
 =?us-ascii?q?aCBsVgySQck+PUgEB?=
X-IronPort-AV: E=Sophos;i="5.51,316,1526342400"; 
   d="scan'208";a="202127561"
Received: from alln-core-7.cisco.com ([173.36.13.140])
  by rcdn-iport-5.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jul 2018 15:56:28 +0000
Received: from sjc-ads-3734.cisco.com (sjc-ads-3734.cisco.com [171.68.250.181])
        by alln-core-7.cisco.com (8.14.5/8.14.5) with ESMTP id w66FuSF7004832;
        Fri, 6 Jul 2018 15:56:28 GMT
From:   Nikunj Kela <nkela@cisco.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     xe-kernel@external.cisco.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: add ARM64-specific support for flatmem
Date:   Fri,  6 Jul 2018 08:56:27 -0700
Message-Id: <20180706155627.23937-1-nkela@cisco.com>
X-Mailer: git-send-email 2.10.3.dirty
X-Auto-Response-Suppress: DR, OOF, AutoReply
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: xe-kernel@external.cisco.com
Cc: Nikunj Kela <nkela@cisco.com>
Signed-off-by: Nikunj Kela <nkela@cisco.com>
---
 arch/arm64/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 42c090c..5e791f0 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -775,6 +775,10 @@ config ARCH_SPARSEMEM_DEFAULT
 config ARCH_SELECT_MEMORY_MODEL
 	def_bool ARCH_SPARSEMEM_ENABLE
 
+config ARCH_FLATMEM_ENABLE
+	def_bool y
+	depends on ARM64 && !NUMA
+
 config HAVE_ARCH_PFN_VALID
 	def_bool ARCH_HAS_HOLES_MEMORYMODEL || !SPARSEMEM
 
-- 
2.10.3.dirty

