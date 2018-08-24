Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC578C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 10:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5940D2173D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 10:47:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5940D2173D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbeHXOVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 10:21:30 -0400
Received: from foss.arm.com ([217.140.101.70]:55516 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727694AbeHXOUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 10:20:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 159A81682;
        Fri, 24 Aug 2018 03:46:13 -0700 (PDT)
Received: from melchizedek.Emea.Arm.com (melchizedek.emea.arm.com [10.4.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6D5FD3F5A0;
        Fri, 24 Aug 2018 03:46:11 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Vikas Shivappa <vikas.shivappa@linux.intel.com>
Subject: [RFC PATCH 07/20] x86/intel_rdt: Expose update_domains() as an arch helper
Date:   Fri, 24 Aug 2018 11:45:06 +0100
Message-Id: <20180824104519.11203-8-james.morse@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180824104519.11203-1-james.morse@arm.com>
References: <20180824104519.11203-1-james.morse@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update_domains() applies the staged configuration to the hw_dom's
configuration array and updates the hardware. Make it part of the
interface between resctrl and the arch code.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c | 4 ++--
 include/linux/resctrl.h                     | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
index ec3c15ee3473..766c3e62ad91 100644
--- a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
+++ b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
@@ -193,7 +193,7 @@ static void apply_config(struct rdt_hw_domain *hw_dom,
 	}
 }
 
-static int update_domains(struct rdt_resource *r)
+int resctrl_arch_update_domains(struct rdt_resource *r)
 {
 	struct resctrl_staged_config *cfg;
 	struct rdt_hw_domain *hw_dom;
@@ -312,7 +312,7 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 	}
 
 	for_each_alloc_enabled_rdt_resource(r) {
-		ret = update_domains(r);
+		ret = resctrl_arch_update_domains(r);
 		if (ret)
 			goto out;
 	}
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 03d9fbc230af..9fe7d7de53d7 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -125,6 +125,7 @@ struct rdt_resource {
 
 };
 
+int resctrl_arch_update_domains(struct rdt_resource *r);
 void resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
 			     u32 closid, u32 *value);
 
-- 
2.18.0

