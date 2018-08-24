Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56FDC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 10:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EFFA21776
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 10:46:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EFFA21776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbeHXOUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 10:20:32 -0400
Received: from foss.arm.com ([217.140.101.70]:55598 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbeHXOUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 10:20:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28D5F1688;
        Fri, 24 Aug 2018 03:46:27 -0700 (PDT)
Received: from melchizedek.Emea.Arm.com (melchizedek.emea.arm.com [10.4.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 80CA43F5A0;
        Fri, 24 Aug 2018 03:46:25 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Vikas Shivappa <vikas.shivappa@linux.intel.com>
Subject: [RFC PATCH 13/20] x86/intel_rdt: Allow different CODE/DATA configurations to be staged
Date:   Fri, 24 Aug 2018 11:45:12 +0100
Message-Id: <20180824104519.11203-14-james.morse@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180824104519.11203-1-james.morse@arm.com>
References: <20180824104519.11203-1-james.morse@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the staged configuration holds its CDP type and hardware
closid, allow resctrl to stage more than configuration at a time for
a single resource.

To detect the same schema being specified twice when the schemata file
is written, the same slot in the staged_configuration array must be
used for each schema. Use the cdp_type enum directly as an index.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c | 4 ++--
 include/linux/resctrl.h                     | 4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
index 05c14d9f797c..f80a838cc36d 100644
--- a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
+++ b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
@@ -78,7 +78,7 @@ int parse_bw(char *buf, struct rdt_resource *r, struct rdt_domain *d,
 	     enum resctrl_conf_type t, u32 closid)
 {
 	unsigned long data;
-	struct resctrl_staged_config *cfg = &d->staged_config[0];
+	struct resctrl_staged_config *cfg = &d->staged_config[t];
 
 	if (cfg->have_new_ctrl) {
 		rdt_last_cmd_printf("duplicate domain %d\n", d->id);
@@ -144,7 +144,7 @@ int parse_cbm(char *buf, struct rdt_resource *r, struct rdt_domain *d,
 	      enum resctrl_conf_type t, u32 closid)
 {
 	unsigned long data;
-	struct resctrl_staged_config *cfg = &d->staged_config[0];
+	struct resctrl_staged_config *cfg = &d->staged_config[t];
 
 	if (cfg->have_new_ctrl) {
 		rdt_last_cmd_printf("duplicate domain %d\n", d->id);
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index dad266f9b0fe..ede5c40756b4 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -12,6 +12,8 @@ enum resctrl_conf_type {
 	CDP_CODE,
 	CDP_DATA,
 };
+#define NUM_CDP_TYPES	CDP_DATA + 1
+
 
 /**
  * struct resctrl_staged_config - parsed configuration to be applied
@@ -39,7 +41,7 @@ struct rdt_domain {
 	int			id;
 	struct cpumask		cpu_mask;
 
-	struct resctrl_staged_config	staged_config[1];
+	struct resctrl_staged_config	staged_config[NUM_CDP_TYPES];
 };
 
 /**
-- 
2.18.0

