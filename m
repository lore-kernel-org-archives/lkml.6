Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC32C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70B5721501
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:45:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70B5721501
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732350AbeHBPgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 11:36:41 -0400
Received: from mout.gmx.net ([212.227.17.20]:51757 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732173AbeHBPgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 11:36:40 -0400
Received: from homer.simpson.net ([185.221.150.28]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Ld4xA-1gBnDu2kGO-00iGM2; Thu, 02
 Aug 2018 15:45:14 +0200
Message-ID: <1533217513.11791.19.camel@gmx.de>
Subject: [rt-patch 1/3 v2] arm64/acpi/perf: move pmu allocation to an early
 CPU up hook
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Date:   Thu, 02 Aug 2018 15:45:13 +0200
In-Reply-To: <1532769235.5926.0.camel@gmx.de>
References: <20180727215710.zq6gkoqzlb4ca7qv@linutronix.de>
         <1532768831.9882.71.camel@gmx.de> <1532769235.5926.0.camel@gmx.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:0BBbcPfUjDhgNJZNmxVxIoo6X5EfQxwEWb9wCqLF9BCs0VOnABS
 ru/Zf6plepiuarw4UAtmIsdaeu0oQnH/mFIYYbRMVqv5k+V4aQ7vNXgzFq1UEidhQKQ0lip
 HBqOKK+2oFylbnOc7V6QQk2jSgwmkTT8T6h1bBg7oBNxS7ce2Dj9HWLfn9B25Gbv8Zcn/5e
 I2cUMR/fUlwlSc4zC5qMA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:24o2BDoI/14=:3I8PI1Nh2+VRadOqAeT6mr
 WkaE6Y10WoLE6EEGZ7kvfYsISiFS7n7yxgdPI4XyxNx31SUqHKPkyX2T9AaZwvMsmFpMdlb5G
 MjIQX2cgLRPM7VQBltNcJR8h+uqoBm3tDbW3bAgoDxmDxae3LtS3jnteppm8AhQ5XQ/YF3nle
 dY1dirHriMqW/SR//77VCnWwjfedTD99xEZBaTo4bxlIo9nB2Ruq8hmIAAwEwwht3/A4Lrj8e
 O4565MKGZVB+ZJI0+sq1Run7QSRt7nTSw7fyKdHurWiTLF9IW8KsM7f3HYSu4/RUiWYIe14UU
 9KV8KqI3WkxG3a3TFN9xu3+TZlYnMN8hXm3ulqvGncsbC83/NSo46j1YV1Q5r69Jjw+d8FUcp
 5jkI0CFRIRW8qOccgKDiHAfAR7I9teqVBfMWreoFFy482VSalBcXqmppNT4qWUN6N2R2M4Ore
 XvuLwcCntPcn9zUtjZu3nCMO2rpuww+liPNHP6xpUA1LCzFFXERwv30gCZmJ7b5y5vKrcs688
 rBoYtcJgCxJsAI8q3Q4EzA+1MFLaCG/fl8b+A8uVn/w8Z84hhClQLSZIjjOBHQg3mRcQIq0Vz
 yVNu1rRH7yhmxvLDY1ibJlVdYNKYozW/m9Zm0oYlBuP3bGzPXPoJRBpgaw/IzyYOqg6lYzwrW
 Vg5TwRxOoEK8hH89ICpWk5pPsMGU9lu0DcuOB5JxjKxXtVcMZM2mghEZ90n4hlgiuhD1CD1ez
 s6HgFVob4on3Id1ZOmeor8pHPT3dX1T+TcHwWndiUocIPuIH/q3K7h/I6S6fAfP3JtIwInAEp
 a00eUZn
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(bah, make a clean The End to adventures in arm-land)

RT cannot allocate while irqs are disabled.

  BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:974
  in_atomic(): 0, irqs_disabled(): 128, pid: 25, name: cpuhp/0
  CPU: 0 PID: 25 Comm: cpuhp/0 Not tainted 4.16.18-rt10-rt #2
  Hardware name: Huawei TaiShan 2280 /BC11SPCD, BIOS 1.32 08/22/2017
  Call trace:
   dump_backtrace+0x0/0x188
   show_stack+0x24/0x30
   dump_stack+0x9c/0xd0
   ___might_sleep+0x124/0x188
   rt_spin_lock+0x40/0x80
   pcpu_alloc+0x104/0x7a0
   __alloc_percpu_gfp+0x38/0x48
   __armpmu_alloc+0x44/0x168
   armpmu_alloc_atomic+0x1c/0x28
   arm_pmu_acpi_cpu_starting+0x1cc/0x210
   cpuhp_invoke_callback+0xb8/0x820
   cpuhp_thread_fun+0xc0/0x1e0
   smpboot_thread_fn+0x1ac/0x2c8
   kthread+0x134/0x138
   ret_from_fork+0x10/0x18

Do the allocation and other preparation for probe along with the other
CPUHP_PERF_{ARCH}_PREPARE stages, where we'll be preemptible, thus no
longer requiring a GFP_ATOMIC allocation either.

Signed-off-by: Mike Galbraith <efault@gmx.de>
---
 drivers/perf/arm_pmu_acpi.c |   12 ++++++------
 include/linux/cpuhotplug.h  |    2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

--- a/drivers/perf/arm_pmu_acpi.c
+++ b/drivers/perf/arm_pmu_acpi.c
@@ -135,10 +135,10 @@ static struct arm_pmu *arm_pmu_acpi_find
 		return pmu;
 	}
 
-	pmu = armpmu_alloc_atomic();
+	pmu = armpmu_alloc();
 	if (!pmu) {
 		pr_warn("Unable to allocate PMU for CPU%d\n",
-			smp_processor_id());
+			raw_smp_processor_id());
 		return NULL;
 	}
 
@@ -185,7 +185,7 @@ static bool pmu_irq_matches(struct arm_p
  * coming up. The perf core won't open events while a hotplug event is in
  * progress.
  */
-static int arm_pmu_acpi_cpu_starting(unsigned int cpu)
+static int arm_pmu_acpi_cpu_prepare(unsigned int cpu)
 {
 	struct arm_pmu *pmu;
 	struct pmu_hw_events __percpu *hw_events;
@@ -283,9 +283,9 @@ static int arm_pmu_acpi_init(void)
 	if (ret)
 		return ret;
 
-	ret = cpuhp_setup_state(CPUHP_AP_PERF_ARM_ACPI_STARTING,
-				"perf/arm/pmu_acpi:starting",
-				arm_pmu_acpi_cpu_starting, NULL);
+	ret = cpuhp_setup_state(CPUHP_PERF_ARM_PMU_ACPI_PREPARE,
+				"perf/arm/pmu_acpi:prepare",
+				arm_pmu_acpi_cpu_prepare, NULL);
 
 	return ret;
 }
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -29,6 +29,7 @@ enum cpuhp_state {
 	CPUHP_PERF_PREPARE,
 	CPUHP_PERF_X86_PREPARE,
 	CPUHP_PERF_X86_AMD_UNCORE_PREP,
+	CPUHP_PERF_ARM_PMU_ACPI_PREPARE,
 	CPUHP_PERF_BFIN,
 	CPUHP_PERF_POWER,
 	CPUHP_PERF_SUPERH,
@@ -114,7 +115,6 @@ enum cpuhp_state {
 	CPUHP_AP_ARM_VFP_STARTING,
 	CPUHP_AP_ARM64_DEBUG_MONITORS_STARTING,
 	CPUHP_AP_PERF_ARM_HW_BREAKPOINT_STARTING,
-	CPUHP_AP_PERF_ARM_ACPI_STARTING,
 	CPUHP_AP_PERF_ARM_STARTING,
 	CPUHP_AP_ARM_L2X0_STARTING,
 	CPUHP_AP_ARM_ARCH_TIMER_STARTING,
