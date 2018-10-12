Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2E1C6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 19:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EA6E2087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 19:29:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EA6E2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbeJMDDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 23:03:40 -0400
Received: from foss.arm.com ([217.140.101.70]:56622 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbeJMDDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 23:03:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D14B2F;
        Fri, 12 Oct 2018 12:29:40 -0700 (PDT)
Received: from beelzebub.austin.arm.com (beelzebub.austin.arm.com [10.118.12.119])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 358C83F5BC;
        Fri, 12 Oct 2018 12:29:40 -0700 (PDT)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com,
        ard.biesheuvel@linaro.org, james.morse@arm.com,
        rafael.j.wysocki@intel.com, takahiro.akashi@linaro.org,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, ahs3@redhat.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH 2/2] arm64: acpi: Prepare for longer MADTs
Date:   Fri, 12 Oct 2018 14:29:37 -0500
Message-Id: <20181012192937.3819951-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BAD_MADT_GICC_ENTRY check is a little too strict because
it rejects MADT entries that don't match the currently known
lengths. We should remove this restriction to avoid problems
if the table length changes. Future code which might depend on
additional fields should be written to validate those fields
before using them, rather than trying to globally check
known MADT version lengths.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/include/asm/acpi.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index 709208dfdc8b..4d0946bd485a 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -22,12 +22,12 @@
 #include <asm/tlbflush.h>
 
 /* Macros for consistency checks of the GICC subtable of MADT */
-#define ACPI_MADT_GICC_LENGTH	\
-	(acpi_gbl_FADT.header.revision < 6 ? 76 : 80)
+#define ACPI_MADT_GICC_MIN_LENGTH   ACPI_OFFSET(  \
+	struct acpi_madt_generic_interrupt, efficiency_class)
 
 #define BAD_MADT_GICC_ENTRY(entry, end)					\
-	(!(entry) || (entry)->header.length != ACPI_MADT_GICC_LENGTH ||	\
-	(unsigned long)(entry) + ACPI_MADT_GICC_LENGTH > (end))
+	(!(entry) || (entry)->header.length < ACPI_MADT_GICC_MIN_LENGTH || \
+	(unsigned long)(entry) + (entry)->header.length > (end))
 
 /* Basic configuration for ACPI */
 #ifdef	CONFIG_ACPI
-- 
2.14.3

