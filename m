Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DCCC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F4A252CC
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:34:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2F4A252CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753625AbeGAQe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:34:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35684 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031009AbeGAQeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:34:50 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7B1E549B;
        Sun,  1 Jul 2018 16:34:49 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephane Eranian <eranian@google.com>,
        Kan Liang <kan.liang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, peterz@infradead.org,
        ak@linux.intel.com, "Jin, Yao" <yao.jin@linux.intel.com>
Subject: [PATCH 4.14 125/157] perf/x86/intel/uncore: Add event constraint for BDX PCU
Date:   Sun,  1 Jul 2018 18:23:17 +0200
Message-Id: <20180701160859.152136477@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160852.287307684@linuxfoundation.org>
References: <20180701160852.287307684@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kan Liang <kan.liang@intel.com>

commit bb9fbe1b57503f790dbbf9f06e72cb0fb9e60740 upstream.

Event select bit 7 'Use Occupancy' in PCU Box is not available for
counter 0 on BDX

Add a constraint to fix it.

Reported-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Kan Liang <kan.liang@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Stephane Eranian <eranian@google.com>
Cc: peterz@infradead.org
Cc: ak@linux.intel.com
Link: https://lkml.kernel.org/r/1510668400-301000-1-git-send-email-kan.liang@intel.com
Cc: "Jin, Yao" <yao.jin@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/events/intel/uncore_snbep.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -3035,11 +3035,19 @@ static struct intel_uncore_type *bdx_msr
 	NULL,
 };
 
+/* Bit 7 'Use Occupancy' is not available for counter 0 on BDX */
+static struct event_constraint bdx_uncore_pcu_constraints[] = {
+	EVENT_CONSTRAINT(0x80, 0xe, 0x80),
+	EVENT_CONSTRAINT_END
+};
+
 void bdx_uncore_cpu_init(void)
 {
 	if (bdx_uncore_cbox.num_boxes > boot_cpu_data.x86_max_cores)
 		bdx_uncore_cbox.num_boxes = boot_cpu_data.x86_max_cores;
 	uncore_msr_uncores = bdx_msr_uncores;
+
+	hswep_uncore_pcu.constraints = bdx_uncore_pcu_constraints;
 }
 
 static struct intel_uncore_type bdx_uncore_ha = {


