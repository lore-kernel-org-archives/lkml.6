Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752457AbeFEUj1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 16:39:27 -0400
Received: from a2nlsmtp01-02.prod.iad2.secureserver.net ([198.71.225.36]:49476
        "EHLO a2nlsmtp01-02.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751989AbeFEUjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 16:39:01 -0400
x-originating-ip: 107.180.71.197
From: kys@linuxonhyperv.com
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com, vkuznets@redhat.com
Cc: Michael Kelley <mikelley@microsoft.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>
Subject: [PATCH 5/8] Drivers: hv: vmbus: Remove x86 MSR refs in arch independent code
Date: Tue,  5 Jun 2018 13:37:53 -0700
Message-Id: <20180605203756.29809-5-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180605203756.29809-1-kys@linuxonhyperv.com>
References: <20180605203536.29751-1-kys@linuxonhyperv.com>
 <20180605203756.29809-1-kys@linuxonhyperv.com>
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfBmPPXvR3AC73sWWSmoXjypNo3+5mZlASFGBmTxJXdkYZ46NrqUmluAu0+sbeDEibEfhlF7ezv7JJVuWqRU5QMs1li0vZBLLo8Kj5YZljCjiUM1yiTi0
 +Ldd/VwBSuEyx3T0Rf3eUubo6qvqZDUmmCB8IxMyy7JNpQW9LjpKE6S1gPtn6wX/gMrcrcqTziMlmeQsTuxSG5EpzvW07yUXxFIRjYwwz2ilVYAqJAnRnV2C
 lv8oZTOEHARzjR6wQXirv1e1C9xU7LNdTUp5c1aUzZR9IH9gNP9wermhQZYjoQfJZfyp7g/V14hMar3VW9Zh6RzQ69Vu4mNQ78KlhU+zdFHLxbINNwUSInej
 hD3HbW5xrbG/bxFak4EMkTTQ4MgQ0zQPFxElaRukzCp6qOujN6o9Kqa9EbaO43grgeqsVeJ1P2l+H9b9rI4tAYw80XeME1eo5AVj+nMxnNkGpbGvOIjt4vEd
 v3fcSi+7cikrdpUdxhBMujQSSHmtu+jxiHUBh4tQO/RXxBS08Elh5ypxl0hWl0P4ILPZHmGZD1M3Dr8QyzxCtJYEUwnl6WpAyHszyg==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Kelley <mikelley@microsoft.com>

In architecture independent code for manipulating Hyper-V synthetic timers
and synthetic interrupts, pass in an ordinal number identifying the timer
or interrupt, rather than an actual MSR register address.  Then in
x86/x64 specific code, map the ordinal number to the appropriate MSR.
This change facilitates the introduction of an ARM64 version of Hyper-V,
which uses the same synthetic timers and interrupts, but a different
mechanism for accessing them.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 arch/x86/include/asm/mshyperv.h | 12 ++++++++----
 drivers/hv/hv.c                 | 20 ++++++++------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index b90e79610cf7..caf9035a2758 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -75,8 +75,10 @@ static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
 	}
 }
 
-#define hv_init_timer(timer, tick) wrmsrl(timer, tick)
-#define hv_init_timer_config(config, val) wrmsrl(config, val)
+#define hv_init_timer(timer, tick) \
+	wrmsrl(HV_X64_MSR_STIMER0_COUNT + (2*timer), tick)
+#define hv_init_timer_config(timer, val) \
+	wrmsrl(HV_X64_MSR_STIMER0_CONFIG + (2*timer), val)
 
 #define hv_get_simp(val) rdmsrl(HV_X64_MSR_SIMP, val)
 #define hv_set_simp(val) wrmsrl(HV_X64_MSR_SIMP, val)
@@ -89,8 +91,10 @@ static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
 
 #define hv_get_vp_index(index) rdmsrl(HV_X64_MSR_VP_INDEX, index)
 
-#define hv_get_synint_state(int_num, val) rdmsrl(int_num, val)
-#define hv_set_synint_state(int_num, val) wrmsrl(int_num, val)
+#define hv_get_synint_state(int_num, val) \
+	rdmsrl(HV_X64_MSR_SINT0 + int_num, val)
+#define hv_set_synint_state(int_num, val) \
+	wrmsrl(HV_X64_MSR_SINT0 + int_num, val)
 
 void hyperv_callback_vector(void);
 void hyperv_reenlightenment_vector(void);
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 9b82549cbbc8..96c403a07906 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -127,14 +127,14 @@ static int hv_ce_set_next_event(unsigned long delta,
 
 	current_tick = hyperv_cs->read(NULL);
 	current_tick += delta;
-	hv_init_timer(HV_X64_MSR_STIMER0_COUNT, current_tick);
+	hv_init_timer(0, current_tick);
 	return 0;
 }
 
 static int hv_ce_shutdown(struct clock_event_device *evt)
 {
-	hv_init_timer(HV_X64_MSR_STIMER0_COUNT, 0);
-	hv_init_timer_config(HV_X64_MSR_STIMER0_CONFIG, 0);
+	hv_init_timer(0, 0);
+	hv_init_timer_config(0, 0);
 	if (direct_mode_enabled)
 		hv_disable_stimer0_percpu_irq(stimer0_irq);
 
@@ -164,7 +164,7 @@ static int hv_ce_set_oneshot(struct clock_event_device *evt)
 		timer_cfg.direct_mode = 0;
 		timer_cfg.sintx = VMBUS_MESSAGE_SINT;
 	}
-	hv_init_timer_config(HV_X64_MSR_STIMER0_CONFIG, timer_cfg.as_uint64);
+	hv_init_timer_config(0, timer_cfg.as_uint64);
 	return 0;
 }
 
@@ -298,8 +298,7 @@ int hv_synic_init(unsigned int cpu)
 	hv_set_siefp(siefp.as_uint64);
 
 	/* Setup the shared SINT. */
-	hv_get_synint_state(HV_X64_MSR_SINT0 + VMBUS_MESSAGE_SINT,
-			    shared_sint.as_uint64);
+	hv_get_synint_state(VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
 
 	shared_sint.vector = HYPERVISOR_CALLBACK_VECTOR;
 	shared_sint.masked = false;
@@ -308,8 +307,7 @@ int hv_synic_init(unsigned int cpu)
 	else
 		shared_sint.auto_eoi = true;
 
-	hv_set_synint_state(HV_X64_MSR_SINT0 + VMBUS_MESSAGE_SINT,
-			    shared_sint.as_uint64);
+	hv_set_synint_state(VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
 
 	/* Enable the global synic bit */
 	hv_get_synic_state(sctrl.as_uint64);
@@ -405,15 +403,13 @@ int hv_synic_cleanup(unsigned int cpu)
 		put_cpu_ptr(hv_cpu);
 	}
 
-	hv_get_synint_state(HV_X64_MSR_SINT0 + VMBUS_MESSAGE_SINT,
-			    shared_sint.as_uint64);
+	hv_get_synint_state(VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
 
 	shared_sint.masked = 1;
 
 	/* Need to correctly cleanup in the case of SMP!!! */
 	/* Disable the interrupt */
-	hv_set_synint_state(HV_X64_MSR_SINT0 + VMBUS_MESSAGE_SINT,
-			    shared_sint.as_uint64);
+	hv_set_synint_state(VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
 
 	hv_get_simp(simp.as_uint64);
 	simp.simp_enabled = 0;
-- 
2.17.1
