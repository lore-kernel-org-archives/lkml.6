Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B44C43444
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 22:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF4082147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 22:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfAGWfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 17:35:11 -0500
Received: from mga17.intel.com ([192.55.52.151]:34117 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727161AbfAGWfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 17:35:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jan 2019 14:35:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,451,1539673200"; 
   d="scan'208";a="124985872"
Received: from otc-lr-04.jf.intel.com ([10.54.39.135])
  by orsmga001.jf.intel.com with ESMTP; 07 Jan 2019 14:35:09 -0800
From:   kan.liang@linux.intel.com
To:     x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        bp@alien8.de, peterz@infradead.org, mingo@redhat.com
Cc:     ak@linux.intel.com, eranian@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V5 4/4] perf/x86/intel: Add counter freezing quirk for Goldmont
Date:   Mon,  7 Jan 2019 14:34:25 -0800
Message-Id: <1546900465-5121-4-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546900465-5121-1-git-send-email-kan.liang@linux.intel.com>
References: <1546900465-5121-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

A ucode patch is also needed for Goldmont while counter freezing feature
is enabled. Otherwise, there will be some issues, e.g. PMI lost.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

- New patch, merged from https://lkml.org/lkml/2018/10/3/25

 arch/x86/events/intel/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index e94731e..99be2d5 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3939,6 +3939,10 @@ static __init void intel_nehalem_quirk(void)
 }
 
 static const struct x86_cpu_check counter_freezing_ucodes[] = {
+	INTEL_CHECK_UCODE(INTEL_FAM6_ATOM_GOLDMONT,		2, 0x0000000e),
+	INTEL_CHECK_UCODE(INTEL_FAM6_ATOM_GOLDMONT,		9, 0x0000002e),
+	INTEL_CHECK_UCODE(INTEL_FAM6_ATOM_GOLDMONT,		10, 0x00000008),
+	INTEL_CHECK_UCODE(INTEL_FAM6_ATOM_GOLDMONT_X,		1, 0x00000028),
 	INTEL_CHECK_UCODE(INTEL_FAM6_ATOM_GOLDMONT_PLUS,	1, 0x00000028),
 	INTEL_CHECK_UCODE(INTEL_FAM6_ATOM_GOLDMONT_PLUS,	8, 0x00000006),
 	{}
@@ -4310,6 +4314,7 @@ __init int intel_pmu_init(void)
 
 	case INTEL_FAM6_ATOM_GOLDMONT:
 	case INTEL_FAM6_ATOM_GOLDMONT_X:
+		x86_add_quirk(intel_counter_freezing_quirk);
 		memcpy(hw_cache_event_ids, glm_hw_cache_event_ids,
 		       sizeof(hw_cache_event_ids));
 		memcpy(hw_cache_extra_regs, glm_hw_cache_extra_regs,
-- 
2.7.4

