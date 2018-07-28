Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F267CC28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 09:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B023120842
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 09:14:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B023120842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbeG1Kjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 06:39:53 -0400
Received: from mout.gmx.net ([212.227.15.15]:51301 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbeG1Kjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 06:39:53 -0400
Received: from homer.simpson.net ([185.221.150.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MY7dI-1fWA0C1kBM-00UvNX; Sat, 28
 Jul 2018 11:13:56 +0200
Message-ID: <1532769235.5926.0.camel@gmx.de>
Subject: [rt-patch 1/3] arm64/acpi/perf: move pmu allocation to an early CPU
 up hook
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Date:   Sat, 28 Jul 2018 11:13:55 +0200
In-Reply-To: <1532768831.9882.71.camel@gmx.de>
References: <20180727215710.zq6gkoqzlb4ca7qv@linutronix.de>
         <1532768831.9882.71.camel@gmx.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:1iOIBkkt/wVm1stzZwvxLCBMu5jvZJsc3AX5vMUFzgsM7rbLfe8
 KYbf4fJxfaPFQjQYwVbBPHdSxtfEyO9viMOBp7Rs6TIC2+D0eEtgWdvCzS+DpWrs2B7dS/V
 XPrjzyb+cWK7lAPW7goUPafyMfGZx7NljeGq+pco8IiGGrNYMHWwZ2znwZEnpTOsVpW9CPj
 kzhG1mu3EYew5FByWUHhA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pO0upheWy90=:cSykEr2cNm7d4UxdBtfGs+
 K9CkzrK4O37BCAbwRAzAp0SXF5FPzpr0e82zbu4WuIyleqWAPgFTYWq+JYAUCD8wc1Bz3baTa
 bEohnKmOEfsRqtG0cZkZ0wqh42Sb0aWkfJKG/cfYsInoEhxjbKoLydSuvlA1yBe6ENOU7uZZO
 aH3XAwV2f+V1L3wsgH0Bo2OwQ0z49qLYICP2Iz/l9sPPEZHgmMu1xnzL/eh9tWr6klj70HUKh
 1ggb+n8RACImsZZ6wqs+IZQ4Gct5CD/0zKYyrFOWe+ieTVBS+2Ujj9x2YCzTmIHbwPf4EBMZR
 aR1RTuADsOGJ/sYVMTdqi3D4h+H5q/bfTSMhnvAOY1rgi+L+LcnG+6gDUsLRIR24/57qzQywV
 asTS93iYvKQ1jNYufTN48q07W1u/UT0vwChjsdNBUsJdZuzy/sMHTnQPD6K0z5tDlmRMSiaeg
 8CeXSO6e1wYFagyz6ZHImBFdx6SkfFVxCux70sDuvBQyGLoXx67BO8AhkvQUZgwhwKOGOIAIC
 6NAvfb57MWGsZXZvnARhFMPQt46wYrzc9WSVDJG2Nc0qcYYkoa2k2D8T1x8def7S1EDJ9J1Jv
 uHVrVJeTUP6C3Pd/kv6QC7/oqA4ikktaM/WG6Gp3gwtjMsLaYgTihuaFykwUTIKSoxmY5YMAH
 il5TwgKId1e9gqenOVHTFbM2zboZoAo8F54UspEaZ6W7zYa71vVskHTW3lQ6bWb9Asls635fR
 asrXJSBNTom7ntWoi0edxQ+Mi9pKf3MydMkyEly6H9duGSQf0qNbmPDJN/ictruoWgmHRl/an
 F6KXWHv
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


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

Move the allocation to CPUHP_BP_PREPARE_DYN, where we'll be preemptible,
thus no longer needing GFP_ATOMIC.

Signed-off-by: Mike Galbraith <efault@gmx.de>
---
 drivers/perf/arm_pmu_acpi.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

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
 
@@ -283,7 +283,7 @@ static int arm_pmu_acpi_init(void)
 	if (ret)
 		return ret;
 
-	ret = cpuhp_setup_state(CPUHP_AP_PERF_ARM_ACPI_STARTING,
+	ret = cpuhp_setup_state(CPUHP_BP_PREPARE_DYN,
 				"perf/arm/pmu_acpi:starting",
 				arm_pmu_acpi_cpu_starting, NULL);
 
