Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B43FC3712F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 718792085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbfAUVnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 16:43:45 -0500
Received: from mga06.intel.com ([134.134.136.31]:12712 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727858AbfAUVni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 16:43:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2019 13:43:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,504,1539673200"; 
   d="scan'208";a="129583706"
Received: from otc-lr-04.jf.intel.com ([10.54.39.129])
  by orsmga001.jf.intel.com with ESMTP; 21 Jan 2019 13:43:37 -0800
From:   kan.liang@linux.intel.com
To:     x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        bp@alien8.de, peterz@infradead.org, mingo@redhat.com
Cc:     ak@linux.intel.com, eranian@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V6 5/5] perf/x86/intel: Add counter freezing quirk for Goldmont
Date:   Mon, 21 Jan 2019 13:42:31 -0800
Message-Id: <1548106951-4811-5-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548106951-4811-1-git-send-email-kan.liang@linux.intel.com>
References: <1548106951-4811-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

A microcode patch is also needed for Goldmont while counter freezing
feature is enabled. Otherwise, there will be some issues, e.g. PMI lost.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V5:
- Apply the new name

 arch/x86/events/intel/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index bad19a9..3eacdf6 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3918,8 +3918,12 @@ static __init void intel_nehalem_quirk(void)
 }
 
 static const struct x86_cpu_desc counter_freezing_ucodes[] = {
-	INTEL_CPU_DESC(INTEL_FAM6_ATOM_GOLDMONT_PLUS,	1, 0x00000028),
-	INTEL_CPU_DESC(INTEL_FAM6_ATOM_GOLDMONT_PLUS,	8, 0x00000006),
+	INTEL_CPU_DESC(INTEL_FAM6_ATOM_GOLDMONT,	 2, 0x0000000e),
+	INTEL_CPU_DESC(INTEL_FAM6_ATOM_GOLDMONT,	 9, 0x0000002e),
+	INTEL_CPU_DESC(INTEL_FAM6_ATOM_GOLDMONT,	10, 0x00000008),
+	INTEL_CPU_DESC(INTEL_FAM6_ATOM_GOLDMONT_X,	 1, 0x00000028),
+	INTEL_CPU_DESC(INTEL_FAM6_ATOM_GOLDMONT_PLUS,	 1, 0x00000028),
+	INTEL_CPU_DESC(INTEL_FAM6_ATOM_GOLDMONT_PLUS,	 8, 0x00000006),
 	{}
 };
 
@@ -4293,6 +4297,7 @@ __init int intel_pmu_init(void)
 
 	case INTEL_FAM6_ATOM_GOLDMONT:
 	case INTEL_FAM6_ATOM_GOLDMONT_X:
+		x86_add_quirk(intel_counter_freezing_quirk);
 		memcpy(hw_cache_event_ids, glm_hw_cache_event_ids,
 		       sizeof(hw_cache_event_ids));
 		memcpy(hw_cache_extra_regs, glm_hw_cache_extra_regs,
-- 
2.7.4

