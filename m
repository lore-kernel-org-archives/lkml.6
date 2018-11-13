Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D72C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 15:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C96BF223C8
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 15:22:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C96BF223C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387917AbeKNBVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 20:21:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48724 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387812AbeKNBVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 20:21:02 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 59CB7308213C;
        Tue, 13 Nov 2018 15:22:27 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.34.244.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 05CF0100034A;
        Tue, 13 Nov 2018 15:22:23 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>, x86@kernel.org,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
Subject: [PATCH 2/3] x86/kvm/hyper-v: use stimer config definition from hyperv-tlfs.h
Date:   Tue, 13 Nov 2018 16:22:15 +0100
Message-Id: <20181113152218.22049-3-vkuznets@redhat.com>
In-Reply-To: <20181113152218.22049-1-vkuznets@redhat.com>
References: <20181113152218.22049-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Tue, 13 Nov 2018 15:22:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a preparation to implementing Direct Mode for Hyper-V synthetic
timers switch to using stimer config definition from hyperv-tlfs.h.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/include/asm/hyperv-tlfs.h |  6 ------
 arch/x86/include/asm/kvm_host.h    |  2 +-
 arch/x86/kvm/hyperv.c              | 33 +++++++++++++++---------------
 3 files changed, 18 insertions(+), 23 deletions(-)

diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index b032c05cd3ee..ebfed56976d2 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -725,12 +725,6 @@ struct hv_enlightened_vmcs {
 
 #define HV_VMX_ENLIGHTENED_CLEAN_FIELD_ALL			0xFFFF
 
-#define HV_STIMER_ENABLE		(1ULL << 0)
-#define HV_STIMER_PERIODIC		(1ULL << 1)
-#define HV_STIMER_LAZY			(1ULL << 2)
-#define HV_STIMER_AUTOENABLE		(1ULL << 3)
-#define HV_STIMER_SINT(config)		(__u8)(((config) >> 16) & 0x0F)
-
 /* Define synthetic interrupt controller flag constants. */
 #define HV_EVENT_FLAGS_COUNT		(256 * 8)
 #define HV_EVENT_FLAGS_LONG_COUNT	(256 / sizeof(unsigned long))
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 55e51ff7e421..e1a40e649cdc 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -497,7 +497,7 @@ struct kvm_mtrr {
 struct kvm_vcpu_hv_stimer {
 	struct hrtimer timer;
 	int index;
-	u64 config;
+	union hv_stimer_config config;
 	u64 count;
 	u64 exp_time;
 	struct hv_message msg;
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 4e80080f277a..eaec15c738df 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -201,9 +201,8 @@ static void kvm_hv_notify_acked_sint(struct kvm_vcpu *vcpu, u32 sint)
 	stimers_pending = 0;
 	for (idx = 0; idx < ARRAY_SIZE(hv_vcpu->stimer); idx++) {
 		stimer = &hv_vcpu->stimer[idx];
-		if (stimer->msg_pending &&
-		    (stimer->config & HV_STIMER_ENABLE) &&
-		    HV_STIMER_SINT(stimer->config) == sint) {
+		if (stimer->msg_pending && stimer->config.enable &&
+		    stimer->config.sintx == sint) {
 			set_bit(stimer->index,
 				hv_vcpu->stimer_pending_bitmap);
 			stimers_pending++;
@@ -497,7 +496,7 @@ static int stimer_start(struct kvm_vcpu_hv_stimer *stimer)
 	time_now = get_time_ref_counter(stimer_to_vcpu(stimer)->kvm);
 	ktime_now = ktime_get();
 
-	if (stimer->config & HV_STIMER_PERIODIC) {
+	if (stimer->config.periodic) {
 		if (stimer->exp_time) {
 			if (time_now >= stimer->exp_time) {
 				u64 remainder;
@@ -546,13 +545,15 @@ static int stimer_start(struct kvm_vcpu_hv_stimer *stimer)
 static int stimer_set_config(struct kvm_vcpu_hv_stimer *stimer, u64 config,
 			     bool host)
 {
+	union hv_stimer_config new_config = {.as_uint64 = config};
+
 	trace_kvm_hv_stimer_set_config(stimer_to_vcpu(stimer)->vcpu_id,
 				       stimer->index, config, host);
 
 	stimer_cleanup(stimer);
-	if ((stimer->config & HV_STIMER_ENABLE) && HV_STIMER_SINT(config) == 0)
-		config &= ~HV_STIMER_ENABLE;
-	stimer->config = config;
+	if (stimer->config.enable && new_config.sintx == 0)
+		new_config.enable = 0;
+	stimer->config.as_uint64 = new_config.as_uint64;
 	stimer_mark_pending(stimer, false);
 	return 0;
 }
@@ -566,16 +567,16 @@ static int stimer_set_count(struct kvm_vcpu_hv_stimer *stimer, u64 count,
 	stimer_cleanup(stimer);
 	stimer->count = count;
 	if (stimer->count == 0)
-		stimer->config &= ~HV_STIMER_ENABLE;
-	else if (stimer->config & HV_STIMER_AUTOENABLE)
-		stimer->config |= HV_STIMER_ENABLE;
+		stimer->config.enable = 0;
+	else if (stimer->config.auto_enable)
+		stimer->config.enable = 1;
 	stimer_mark_pending(stimer, false);
 	return 0;
 }
 
 static int stimer_get_config(struct kvm_vcpu_hv_stimer *stimer, u64 *pconfig)
 {
-	*pconfig = stimer->config;
+	*pconfig = stimer->config.as_uint64;
 	return 0;
 }
 
@@ -636,7 +637,7 @@ static int stimer_send_msg(struct kvm_vcpu_hv_stimer *stimer)
 	payload->expiration_time = stimer->exp_time;
 	payload->delivery_time = get_time_ref_counter(vcpu->kvm);
 	return synic_deliver_msg(vcpu_to_synic(vcpu),
-				 HV_STIMER_SINT(stimer->config), msg);
+				 stimer->config.sintx, msg);
 }
 
 static void stimer_expiration(struct kvm_vcpu_hv_stimer *stimer)
@@ -649,8 +650,8 @@ static void stimer_expiration(struct kvm_vcpu_hv_stimer *stimer)
 				       stimer->index, r);
 	if (!r) {
 		stimer->msg_pending = false;
-		if (!(stimer->config & HV_STIMER_PERIODIC))
-			stimer->config &= ~HV_STIMER_ENABLE;
+		if (!(stimer->config.periodic))
+			stimer->config.enable = 0;
 	}
 }
 
@@ -664,7 +665,7 @@ void kvm_hv_process_stimers(struct kvm_vcpu *vcpu)
 	for (i = 0; i < ARRAY_SIZE(hv_vcpu->stimer); i++)
 		if (test_and_clear_bit(i, hv_vcpu->stimer_pending_bitmap)) {
 			stimer = &hv_vcpu->stimer[i];
-			if (stimer->config & HV_STIMER_ENABLE) {
+			if (stimer->config.enable) {
 				exp_time = stimer->exp_time;
 
 				if (exp_time) {
@@ -674,7 +675,7 @@ void kvm_hv_process_stimers(struct kvm_vcpu *vcpu)
 						stimer_expiration(stimer);
 				}
 
-				if ((stimer->config & HV_STIMER_ENABLE) &&
+				if ((stimer->config.enable) &&
 				    stimer->count) {
 					if (!stimer->msg_pending)
 						stimer_start(stimer);
-- 
2.17.2

