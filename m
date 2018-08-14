Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB67C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF2D021727
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:37:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF2D021727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732087AbeHNUZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:25:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58068 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728249AbeHNUZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:25:24 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3A85ACBA;
        Tue, 14 Aug 2018 17:37:14 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 037/104] x86/topology: Provide topology_smt_supported()
Date:   Tue, 14 Aug 2018 19:16:51 +0200
Message-Id: <20180814171517.689000549@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171515.270692185@linuxfoundation.org>
References: <20180814171515.270692185@linuxfoundation.org>
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

From: Thomas Gleixner <tglx@linutronix.de>

commit f048c399e0f7490ab7296bc2c255d37eb14a9675 upstream

Provide information whether SMT is supoorted by the CPUs. Preparatory patch
for SMT control mechanism.

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/topology.h |    2 ++
 arch/x86/kernel/smpboot.c       |    8 ++++++++
 2 files changed, 10 insertions(+)

--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -125,6 +125,7 @@ static inline int topology_max_smt_threa
 int topology_update_package_map(unsigned int apicid, unsigned int cpu);
 int topology_phys_to_logical_pkg(unsigned int pkg);
 bool topology_is_primary_thread(unsigned int cpu);
+bool topology_smt_supported(void);
 #else
 #define topology_max_packages()			(1)
 static inline int
@@ -132,6 +133,7 @@ topology_update_package_map(unsigned int
 static inline int topology_phys_to_logical_pkg(unsigned int pkg) { return 0; }
 static inline int topology_max_smt_threads(void) { return 1; }
 static inline bool topology_is_primary_thread(unsigned int cpu) { return true; }
+static inline bool topology_smt_supported(void) { return false; }
 #endif
 
 static inline void arch_fix_phys_package_id(int num, u32 slot)
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -321,6 +321,14 @@ bool topology_is_primary_thread(unsigned
 }
 
 /**
+ * topology_smt_supported - Check whether SMT is supported by the CPUs
+ */
+bool topology_smt_supported(void)
+{
+	return smp_num_siblings > 1;
+}
+
+/**
  * topology_phys_to_logical_pkg - Map a physical package id to a logical
  *
  * Returns logical package id or -1 if not found


