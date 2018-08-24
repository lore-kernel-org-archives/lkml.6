Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F41DC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 10:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E18BE2157C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 10:46:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E18BE2157C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbeHXOUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 10:20:45 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55660 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727997AbeHXOUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 10:20:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2EA6F15A2;
        Fri, 24 Aug 2018 03:46:40 -0700 (PDT)
Received: from melchizedek.Emea.Arm.com (melchizedek.emea.arm.com [10.4.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 86A283F5A0;
        Fri, 24 Aug 2018 03:46:38 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Vikas Shivappa <vikas.shivappa@linux.intel.com>
Subject: [RFC PATCH 18/20] x86/intel_rdt: Remove the CODE/DATA illusionary caches
Date:   Fri, 24 Aug 2018 11:45:17 +0100
Message-Id: <20180824104519.11203-19-james.morse@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180824104519.11203-1-james.morse@arm.com>
References: <20180824104519.11203-1-james.morse@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that nothing uses these caches, remove them.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/intel_rdt.c | 69 ---------------------------------
 arch/x86/kernel/cpu/intel_rdt.h |  4 --
 2 files changed, 73 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt.c b/arch/x86/kernel/cpu/intel_rdt.c
index 96b1aab36053..f6f1eceb366f 100644
--- a/arch/x86/kernel/cpu/intel_rdt.c
+++ b/arch/x86/kernel/cpu/intel_rdt.c
@@ -84,41 +84,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
 		.msr_base		= IA32_L3_CBM_BASE,
 		.msr_update		= cat_wrmsr,
 	},
-	[RDT_RESOURCE_L3DATA] =
-	{
-		.rid			= RDT_RESOURCE_L3DATA,
-		.resctrl = {
-			.name			= "L3DATA",
-			.cache_level		= 3,
-			.cache = {
-				.min_cbm_bits	= 1,
-			},
-			.domains		= domain_init(RDT_RESOURCE_L3DATA),
-			.parse_ctrlval		= parse_cbm,
-			.format_str		= "%d=%0*x",
-			.fflags			= RFTYPE_RES_CACHE,
-		},
-		.msr_base		= IA32_L3_CBM_BASE,
-		.msr_update		= cat_wrmsr,
-
-	},
-	[RDT_RESOURCE_L3CODE] =
-	{
-		.rid			= RDT_RESOURCE_L3CODE,
-		.resctrl = {
-			.name			= "L3CODE",
-			.cache_level		= 3,
-			.cache = {
-				.min_cbm_bits	= 1,
-			},
-			.domains		= domain_init(RDT_RESOURCE_L3CODE),
-			.parse_ctrlval		= parse_cbm,
-			.format_str		= "%d=%0*x",
-			.fflags			= RFTYPE_RES_CACHE,
-		},
-		.msr_base		= IA32_L3_CBM_BASE,
-		.msr_update		= cat_wrmsr,
-	},
 	[RDT_RESOURCE_L2] =
 	{
 		.rid			= RDT_RESOURCE_L2,
@@ -136,40 +101,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
 		.msr_base		= IA32_L2_CBM_BASE,
 		.msr_update		= cat_wrmsr,
 	},
-	[RDT_RESOURCE_L2DATA] =
-	{
-		.rid			= RDT_RESOURCE_L2DATA,
-		.resctrl = {
-			.name			= "L2DATA",
-			.cache_level		= 2,
-			.cache = {
-				.min_cbm_bits	= 1,
-			},
-			.domains		= domain_init(RDT_RESOURCE_L2DATA),
-			.parse_ctrlval		= parse_cbm,
-			.format_str		= "%d=%0*x",
-			.fflags			= RFTYPE_RES_CACHE,
-		},
-		.msr_base		= IA32_L2_CBM_BASE,
-		.msr_update		= cat_wrmsr,
-	},
-	[RDT_RESOURCE_L2CODE] =
-	{
-		.rid			= RDT_RESOURCE_L2CODE,
-		.resctrl = {
-			.name			= "L2CODE",
-			.cache_level		= 2,
-			.cache = {
-				.min_cbm_bits	= 1,
-			},
-			.domains		= domain_init(RDT_RESOURCE_L2CODE),
-			.parse_ctrlval		= parse_cbm,
-			.format_str		= "%d=%0*x",
-			.fflags			= RFTYPE_RES_CACHE,
-		},
-		.msr_base		= IA32_L2_CBM_BASE,
-		.msr_update		= cat_wrmsr,
-	},
 	[RDT_RESOURCE_MBA] =
 	{
 		.rid			= RDT_RESOURCE_MBA,
diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index fd5c0b3dc797..a4aba005cfea 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -311,11 +311,7 @@ int __init rdtgroup_init(void);
 
 enum {
 	RDT_RESOURCE_L3,
-	RDT_RESOURCE_L3DATA,
-	RDT_RESOURCE_L3CODE,
 	RDT_RESOURCE_L2,
-	RDT_RESOURCE_L2DATA,
-	RDT_RESOURCE_L2CODE,
 	RDT_RESOURCE_MBA,
 
 	/* Must be the last */
-- 
2.18.0

