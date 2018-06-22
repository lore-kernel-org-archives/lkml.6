Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DE4C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFB5324665
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:07:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFB5324665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933649AbeFVRHE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 13:07:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35454 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754542AbeFVRGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 13:06:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5505540704AF;
        Fri, 22 Jun 2018 17:06:36 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 98E781C59F;
        Fri, 22 Jun 2018 17:06:34 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     x86@kernel.org
Cc:     devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
Subject: [PATCH 4/4] x86/hyper-v: trace PV IPI send
Date:   Fri, 22 Jun 2018 19:06:25 +0200
Message-Id: <20180622170625.30688-5-vkuznets@redhat.com>
In-Reply-To: <20180622170625.30688-1-vkuznets@redhat.com>
References: <20180622170625.30688-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 22 Jun 2018 17:06:36 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 22 Jun 2018 17:06:36 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trace Hyper-V PV IPIs the same way we do PV TLB flush.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/hyperv/hv_apic.c           |  4 ++++
 arch/x86/include/asm/trace/hyperv.h | 15 +++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index ee962784d25b..657a2b8c738a 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -31,6 +31,8 @@
 #include <asm/mshyperv.h>
 #include <asm/apic.h>
 
+#include <asm/trace/hyperv.h>
+
 static struct apic orig_apic;
 
 static u64 hv_apic_icr_read(void)
@@ -134,6 +136,8 @@ static bool __send_ipi_mask(const struct cpumask *mask, int vector)
 	struct ipi_arg_non_ex ipi_arg;
 	int ret = 1;
 
+	trace_hyperv_send_ipi_mask(mask, vector);
+
 	if (cpumask_empty(mask))
 		return true;
 
diff --git a/arch/x86/include/asm/trace/hyperv.h b/arch/x86/include/asm/trace/hyperv.h
index 4253bca99989..9c0d4b588e3f 100644
--- a/arch/x86/include/asm/trace/hyperv.h
+++ b/arch/x86/include/asm/trace/hyperv.h
@@ -28,6 +28,21 @@ TRACE_EVENT(hyperv_mmu_flush_tlb_others,
 		      __entry->addr, __entry->end)
 	);
 
+TRACE_EVENT(hyperv_send_ipi_mask,
+	    TP_PROTO(const struct cpumask *cpus,
+		     int vector),
+	    TP_ARGS(cpus, vector),
+	    TP_STRUCT__entry(
+		    __field(unsigned int, ncpus)
+		    __field(int, vector)
+		    ),
+	    TP_fast_assign(__entry->ncpus = cpumask_weight(cpus);
+			   __entry->vector = vector;
+		    ),
+	    TP_printk("ncpus %d vector %x",
+		      __entry->ncpus, __entry->vector)
+	);
+
 #endif /* CONFIG_HYPERV */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.14.4

