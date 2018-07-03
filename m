Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC77C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78DC422464
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:42:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78DC422464
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932413AbeGCNmz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 09:42:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48628 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932234AbeGCNmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 09:42:23 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4A002C320;
        Tue,  3 Jul 2018 13:42:22 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F12C1117629;
        Tue,  3 Jul 2018 13:42:20 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>,
        Cathy Avery <cavery@redhat.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/5] x86/hyper-v: rename ipi_arg_{ex,non_ex} structures
Date:   Tue,  3 Jul 2018 15:42:05 +0200
Message-Id: <20180703134206.27240-5-vkuznets@redhat.com>
In-Reply-To: <20180703134206.27240-1-vkuznets@redhat.com>
References: <20180703134206.27240-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 03 Jul 2018 13:42:22 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 03 Jul 2018 13:42:22 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These structures are going to be used from KVM code so let's make
their names reflect their Hyper-V origin.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/hyperv/hv_apic.c          | 12 ++++++------
 arch/x86/include/asm/hyperv-tlfs.h | 16 +++++++++-------
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index f68855499391..cb17168e6263 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -93,14 +93,14 @@ static void hv_apic_eoi_write(u32 reg, u32 val)
  */
 static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector)
 {
-	struct ipi_arg_ex **arg;
-	struct ipi_arg_ex *ipi_arg;
+	struct hv_send_ipi_ex **arg;
+	struct hv_send_ipi_ex *ipi_arg;
 	unsigned long flags;
 	int nr_bank = 0;
 	int ret = 1;
 
 	local_irq_save(flags);
-	arg = (struct ipi_arg_ex **)this_cpu_ptr(hyperv_pcpu_input_arg);
+	arg = (struct hv_send_ipi_ex **)this_cpu_ptr(hyperv_pcpu_input_arg);
 
 	ipi_arg = *arg;
 	if (unlikely(!ipi_arg))
@@ -128,8 +128,8 @@ static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector)
 static bool __send_ipi_mask(const struct cpumask *mask, int vector)
 {
 	int cur_cpu, vcpu;
-	struct ipi_arg_non_ex **arg;
-	struct ipi_arg_non_ex *ipi_arg;
+	struct hv_send_ipi **arg;
+	struct hv_send_ipi *ipi_arg;
 	int ret = 1;
 	unsigned long flags;
 
@@ -146,7 +146,7 @@ static bool __send_ipi_mask(const struct cpumask *mask, int vector)
 		return __send_ipi_mask_ex(mask, vector);
 
 	local_irq_save(flags);
-	arg = (struct ipi_arg_non_ex **)this_cpu_ptr(hyperv_pcpu_input_arg);
+	arg = (struct hv_send_ipi **)this_cpu_ptr(hyperv_pcpu_input_arg);
 
 	ipi_arg = *arg;
 	if (unlikely(!ipi_arg))
diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index b8c89265baf0..b52c9604b20d 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -723,19 +723,21 @@ struct hv_enlightened_vmcs {
 #define HV_STIMER_AUTOENABLE		(1ULL << 3)
 #define HV_STIMER_SINT(config)		(__u8)(((config) >> 16) & 0x0F)
 
-struct ipi_arg_non_ex {
-	u32 vector;
-	u32 reserved;
-	u64 cpu_mask;
-};
-
 struct hv_vpset {
 	u64 format;
 	u64 valid_bank_mask;
 	u64 bank_contents[];
 };
 
-struct ipi_arg_ex {
+/* HvCallSendSyntheticClusterIpi hypercall */
+struct hv_send_ipi {
+	u32 vector;
+	u32 reserved;
+	u64 cpu_mask;
+};
+
+/* HvCallSendSyntheticClusterIpiEx hypercall */
+struct hv_send_ipi_ex {
 	u32 vector;
 	u32 reserved;
 	struct hv_vpset vp_set;
-- 
2.14.4

