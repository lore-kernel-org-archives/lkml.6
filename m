Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BDFC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 15:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7B73223C8
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 15:22:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7B73223C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387864AbeKNBU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 20:20:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52096 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732028AbeKNBU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 20:20:58 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B23493078AA3;
        Tue, 13 Nov 2018 15:22:23 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.34.244.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8FEBB1019635;
        Tue, 13 Nov 2018 15:22:21 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>, x86@kernel.org,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
Subject: [PATCH 1/3] x86/hyper-v: move synic/stimer control structures definitions to hyperv-tlfs.h
Date:   Tue, 13 Nov 2018 16:22:14 +0100
Message-Id: <20181113152218.22049-2-vkuznets@redhat.com>
In-Reply-To: <20181113152218.22049-1-vkuznets@redhat.com>
References: <20181113152218.22049-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 13 Nov 2018 15:22:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We implement Hyper-V SynIC and synthetic timers in KVM too so there's some
room for code sharing.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/include/asm/hyperv-tlfs.h | 69 ++++++++++++++++++++++++++++++
 drivers/hv/hv.c                    |  2 +-
 drivers/hv/hyperv_vmbus.h          | 68 -----------------------------
 3 files changed, 70 insertions(+), 69 deletions(-)

diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 4139f7650fe5..b032c05cd3ee 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -731,6 +731,75 @@ struct hv_enlightened_vmcs {
 #define HV_STIMER_AUTOENABLE		(1ULL << 3)
 #define HV_STIMER_SINT(config)		(__u8)(((config) >> 16) & 0x0F)
 
+/* Define synthetic interrupt controller flag constants. */
+#define HV_EVENT_FLAGS_COUNT		(256 * 8)
+#define HV_EVENT_FLAGS_LONG_COUNT	(256 / sizeof(unsigned long))
+
+/*
+ * Synthetic timer configuration.
+ */
+union hv_stimer_config {
+	u64 as_uint64;
+	struct {
+		u64 enable:1;
+		u64 periodic:1;
+		u64 lazy:1;
+		u64 auto_enable:1;
+		u64 apic_vector:8;
+		u64 direct_mode:1;
+		u64 reserved_z0:3;
+		u64 sintx:4;
+		u64 reserved_z1:44;
+	};
+};
+
+
+/* Define the synthetic interrupt controller event flags format. */
+union hv_synic_event_flags {
+	unsigned long flags[HV_EVENT_FLAGS_LONG_COUNT];
+};
+
+/* Define SynIC control register. */
+union hv_synic_scontrol {
+	u64 as_uint64;
+	struct {
+		u64 enable:1;
+		u64 reserved:63;
+	};
+};
+
+/* Define synthetic interrupt source. */
+union hv_synic_sint {
+	u64 as_uint64;
+	struct {
+		u64 vector:8;
+		u64 reserved1:8;
+		u64 masked:1;
+		u64 auto_eoi:1;
+		u64 reserved2:46;
+	};
+};
+
+/* Define the format of the SIMP register */
+union hv_synic_simp {
+	u64 as_uint64;
+	struct {
+		u64 simp_enabled:1;
+		u64 preserved:11;
+		u64 base_simp_gpa:52;
+	};
+};
+
+/* Define the format of the SIEFP register */
+union hv_synic_siefp {
+	u64 as_uint64;
+	struct {
+		u64 siefp_enabled:1;
+		u64 preserved:11;
+		u64 base_siefp_gpa:52;
+	};
+};
+
 struct hv_vpset {
 	u64 format;
 	u64 valid_bank_mask;
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 332d7c34be5c..11273cd384d6 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -143,7 +143,7 @@ static int hv_ce_shutdown(struct clock_event_device *evt)
 
 static int hv_ce_set_oneshot(struct clock_event_device *evt)
 {
-	union hv_timer_config timer_cfg;
+	union hv_stimer_config timer_cfg;
 
 	timer_cfg.as_uint64 = 0;
 	timer_cfg.enable = 1;
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 72eaba3d50fc..8df4f45f4b6d 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -44,74 +44,6 @@
  */
 #define HV_UTIL_NEGO_TIMEOUT 55
 
-/* Define synthetic interrupt controller flag constants. */
-#define HV_EVENT_FLAGS_COUNT		(256 * 8)
-#define HV_EVENT_FLAGS_LONG_COUNT	(256 / sizeof(unsigned long))
-
-/*
- * Timer configuration register.
- */
-union hv_timer_config {
-	u64 as_uint64;
-	struct {
-		u64 enable:1;
-		u64 periodic:1;
-		u64 lazy:1;
-		u64 auto_enable:1;
-		u64 apic_vector:8;
-		u64 direct_mode:1;
-		u64 reserved_z0:3;
-		u64 sintx:4;
-		u64 reserved_z1:44;
-	};
-};
-
-
-/* Define the synthetic interrupt controller event flags format. */
-union hv_synic_event_flags {
-	unsigned long flags[HV_EVENT_FLAGS_LONG_COUNT];
-};
-
-/* Define SynIC control register. */
-union hv_synic_scontrol {
-	u64 as_uint64;
-	struct {
-		u64 enable:1;
-		u64 reserved:63;
-	};
-};
-
-/* Define synthetic interrupt source. */
-union hv_synic_sint {
-	u64 as_uint64;
-	struct {
-		u64 vector:8;
-		u64 reserved1:8;
-		u64 masked:1;
-		u64 auto_eoi:1;
-		u64 reserved2:46;
-	};
-};
-
-/* Define the format of the SIMP register */
-union hv_synic_simp {
-	u64 as_uint64;
-	struct {
-		u64 simp_enabled:1;
-		u64 preserved:11;
-		u64 base_simp_gpa:52;
-	};
-};
-
-/* Define the format of the SIEFP register */
-union hv_synic_siefp {
-	u64 as_uint64;
-	struct {
-		u64 siefp_enabled:1;
-		u64 preserved:11;
-		u64 base_siefp_gpa:52;
-	};
-};
 
 /* Definitions for the monitored notification facility */
 union hv_monitor_trigger_group {
-- 
2.17.2

