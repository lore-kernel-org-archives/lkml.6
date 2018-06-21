Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B38C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F80A20837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:43:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F80A20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932848AbeFUInh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 04:43:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:40749 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932459AbeFUInf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 04:43:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 35472AFA9;
        Thu, 21 Jun 2018 08:43:34 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org
Cc:     boris.ostrovsky@oracle.com, hpa@zytor.com, tglx@linutronix.de,
        mingo@redhat.com, Juergen Gross <jgross@suse.com>,
        stable@vger.kernel.org
Subject: [PATCH] x86/xen: add call of speculative_store_bypass_ht_init() to pv paths
Date:   Thu, 21 Jun 2018 10:43:31 +0200
Message-Id: <20180621084331.21228-1-jgross@suse.com>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 1f50ddb4f4189243c05926b842dc1a0332195f31 ("x86/speculation:
Handle HT correctly on AMD") added speculative_store_bypass_ht_init()
to the per-cpu initialization sequence.

speculative_store_bypass_ht_init() needs to be called on each cpu for
pv guests, too.

Reported-by: Brian Woods <brian.woods@amd.com>
Fixes: 1f50ddb4f4189243c05926b842dc1a0332195f31 ("x86/speculation: Handle HT correctly on AMD")
Cc: <stable@vger.kernel.org>
Signed-off-by: Juergen Gross <jgross@suse.com>
Tested-by: Brian Woods <brian.woods@amd.com>
---
 arch/x86/xen/smp_pv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index 2e20ae2fa2d6..e3b18ad49889 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -32,6 +32,7 @@
 #include <xen/interface/vcpu.h>
 #include <xen/interface/xenpmu.h>
 
+#include <asm/spec-ctrl.h>
 #include <asm/xen/interface.h>
 #include <asm/xen/hypercall.h>
 
@@ -70,6 +71,8 @@ static void cpu_bringup(void)
 	cpu_data(cpu).x86_max_cores = 1;
 	set_cpu_sibling_map(cpu);
 
+	speculative_store_bypass_ht_init();
+
 	xen_setup_cpu_clockevents();
 
 	notify_cpu_starting(cpu);
@@ -250,6 +253,8 @@ static void __init xen_pv_smp_prepare_cpus(unsigned int max_cpus)
 	}
 	set_cpu_sibling_map(0);
 
+	speculative_store_bypass_ht_init();
+
 	xen_pmu_init(0);
 
 	if (xen_smp_intr_init(0) || xen_smp_intr_init_pv(0))
-- 
2.13.7

