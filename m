Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DF5C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 193E0205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:15:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 193E0205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbeJBS64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 14:58:56 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35966 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727434AbeJBS6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 14:58:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC7BF15BF;
        Tue,  2 Oct 2018 05:15:53 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.1.117])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4032A3F5B7;
        Tue,  2 Oct 2018 05:15:50 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     suzuki.poulose@arm.com, punit.agrawal@arm.com, will.deacon@arm.com,
        Steven.Price@arm.com, catalin.marinas@arm.com, mhocko@kernel.org,
        mike.kravetz@oracle.com, n-horiguchi@ah.jp.nec.com
Subject: [PATCH 3/4] arm64/mm: Enable HugeTLB migration
Date:   Tue,  2 Oct 2018 17:45:30 +0530
Message-Id: <1538482531-26883-4-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538482531-26883-1-git-send-email-anshuman.khandual@arm.com>
References: <1538482531-26883-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let arm64 subscribe to generic HugeTLB page migration framework. Right now
this only works on the following PMD and PUD level HugeTLB page sizes with
various kernel base page size combinations.

       CONT PTE    PMD    CONT PMD    PUD
       --------    ---    --------    ---
4K:         NA     2M         NA      1G
16K:        NA    32M         NA
64K:        NA   512M         NA

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1b1a0e9..e54350f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1305,6 +1305,10 @@ config SYSVIPC_COMPAT
 	def_bool y
 	depends on COMPAT && SYSVIPC
 
+config ARCH_ENABLE_HUGEPAGE_MIGRATION
+	def_bool y
+	depends on HUGETLB_PAGE && MIGRATION
+
 menu "Power management options"
 
 source "kernel/power/Kconfig"
-- 
2.7.4

