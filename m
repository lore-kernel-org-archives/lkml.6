Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA38C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8D1C25772
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:50:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8D1C25772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030436AbeGARuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:50:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35204 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030629AbeGAQci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:32:38 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F17CB92B;
        Sun,  1 Jul 2018 16:32:37 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14 040/157] powerpc/powernv/cpuidle: Init all present cpus for deep states
Date:   Sun,  1 Jul 2018 18:21:52 +0200
Message-Id: <20180701160854.470397930@linuxfoundation.org>
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

From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>

commit ac9816dcbab53c57bcf1d7b15370b08f1e284318 upstream.

Init all present cpus for deep states instead of "all possible" cpus.
Init fails if a possible cpu is guarded. Resulting in making only
non-deep states available for cpuidle/hotplug.

Stewart says, this means that for single threaded workloads, if you
guard out a CPU core you'll not get WoF (Workload Optimised
Frequency), which means that performance goes down when you wouldn't
expect it to.

Fixes: 77b54e9f213f ("powernv/powerpc: Add winkle support for offline cpus")
Cc: stable@vger.kernel.org # v3.19+
Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/platforms/powernv/idle.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -78,7 +78,7 @@ static int pnv_save_sprs_for_deep_states
 	uint64_t msr_val = MSR_IDLE;
 	uint64_t psscr_val = pnv_deepest_stop_psscr_val;
 
-	for_each_possible_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		uint64_t pir = get_hard_smp_processor_id(cpu);
 		uint64_t hsprg0_val = (uint64_t)&paca[cpu];
 
@@ -741,7 +741,7 @@ static int __init pnv_init_idle_states(v
 		int cpu;
 
 		pr_info("powernv: idle: Saving PACA pointers of all CPUs in their thread sibling PACA\n");
-		for_each_possible_cpu(cpu) {
+		for_each_present_cpu(cpu) {
 			int base_cpu = cpu_first_thread_sibling(cpu);
 			int idx = cpu_thread_in_core(cpu);
 			int i;


