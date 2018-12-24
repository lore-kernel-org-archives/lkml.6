Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E67C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 10:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C24E820675
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 10:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbeLXKV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 05:21:26 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:37770 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbeLXKV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 05:21:26 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 5E72FF91688E4AA56276;
        Mon, 24 Dec 2018 18:21:24 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wBOALJP7067919;
        Mon, 24 Dec 2018 18:21:19 +0800 (GMT-8)
        (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018122418212639-18450520 ;
          Mon, 24 Dec 2018 18:21:26 +0800 
From:   Peng Hao <peng.hao2@zte.com.cn>
To:     christoffer.dall@arm.com, marc.zyngier@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH]  kvm/arm64 : reduce the size of kvm_vcpu
Date:   Mon, 24 Dec 2018 18:42:24 +0800
Message-Id: <1545648144-64778-1-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-12-24 18:21:26,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-12-24 18:21:18,
        Serialize complete at 2018-12-24 18:21:18
X-MAIL: mse01.zte.com.cn wBOALJP7067919
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to adjust the position of variables in kvm_vcpu_arch,
the size of kvm_vcpu can reduce 16 bytes.
before:
cat /proc/slabinfo | grep kvm
kvm_vcpu  252    252   9120   28  ...

after:
cat /proc/slabinfo | grep kvm
kvm_vcpu   28     28   9104   28  ...

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 arch/arm64/include/asm/kvm_host.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 52fbc82..e805b7e 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -287,16 +287,17 @@ struct kvm_vcpu_arch {
 	/* Cache some mmu pages needed inside spinlock regions */
 	struct kvm_mmu_memory_cache mmu_page_cache;
 
+	/* Virtual SError ESR to restore when HCR_EL2.VSE is set */
+	u64 vsesr_el2;
+
+	DECLARE_BITMAP(features, KVM_VCPU_MAX_FEATURES);
+
 	/* Target CPU and feature flags */
 	int target;
-	DECLARE_BITMAP(features, KVM_VCPU_MAX_FEATURES);
 
 	/* Detect first run of a vcpu */
 	bool has_run_once;
 
-	/* Virtual SError ESR to restore when HCR_EL2.VSE is set */
-	u64 vsesr_el2;
-
 	/* True when deferrable sysregs are loaded on the physical CPU,
 	 * see kvm_vcpu_load_sysregs and kvm_vcpu_put_sysregs. */
 	bool sysregs_loaded_on_cpu;
-- 
1.8.3.1

