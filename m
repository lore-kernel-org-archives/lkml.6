Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69C3C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E48725934
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:19:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E48725934
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753625AbeGASTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 14:19:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33654 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965152AbeGAQZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:25:19 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7B239ACD;
        Sun,  1 Jul 2018 16:25:18 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.9 028/101] cpuidle: powernv: Fix promotion from snooze if next state disabled
Date:   Sun,  1 Jul 2018 18:21:14 +0200
Message-Id: <20180701160758.272301221@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160757.138608453@linuxfoundation.org>
References: <20180701160757.138608453@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

commit 0a4ec6aa035a52c422eceb2ed51ed88392a3d6c2 upstream.

The commit 78eaa10f027c ("cpuidle: powernv/pseries: Auto-promotion of
snooze to deeper idle state") introduced a timeout for the snooze idle
state so that it could be eventually be promoted to a deeper idle
state. The snooze timeout value is static and set to the target
residency of the next idle state, which would train the cpuidle
governor to pick the next idle state eventually.

The unfortunate side-effect of this is that if the next idle state(s)
is disabled, the CPU will forever remain in snooze, despite the fact
that the system is completely idle, and other deeper idle states are
available.

This patch fixes the issue by dynamically setting the snooze timeout
to the target residency of the next enabled state on the device.

Before Patch:
  POWER8 : Only nap disabled.
  $ cpupower monitor sleep 30
  sleep took 30.01297 seconds and exited with status 0
                |Idle_Stats
  PKG |CORE|CPU | snoo | Nap  | Fast
     0|   8|   0| 96.41|  0.00|  0.00
     0|   8|   1| 96.43|  0.00|  0.00
     0|   8|   2| 96.47|  0.00|  0.00
     0|   8|   3| 96.35|  0.00|  0.00
     0|   8|   4| 96.37|  0.00|  0.00
     0|   8|   5| 96.37|  0.00|  0.00
     0|   8|   6| 96.47|  0.00|  0.00
     0|   8|   7| 96.47|  0.00|  0.00

  POWER9: Shallow states (stop0lite, stop1lite, stop2lite, stop0, stop1,
  stop2) disabled:
  $ cpupower monitor sleep 30
  sleep took 30.05033 seconds and exited with status 0
                |Idle_Stats
  PKG |CORE|CPU | snoo | stop | stop | stop | stop | stop | stop | stop | stop
     0|  16|   0| 89.79|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00
     0|  16|   1| 90.12|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00
     0|  16|   2| 90.21|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00
     0|  16|   3| 90.29|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00

After Patch:
  POWER8 : Only nap disabled.
  $ cpupower monitor sleep 30
  sleep took 30.01200 seconds and exited with status 0
                |Idle_Stats
  PKG |CORE|CPU | snoo | Nap  | Fast
     0|   8|   0| 16.58|  0.00| 77.21
     0|   8|   1| 18.42|  0.00| 75.38
     0|   8|   2|  4.70|  0.00| 94.09
     0|   8|   3| 17.06|  0.00| 81.73
     0|   8|   4|  3.06|  0.00| 95.73
     0|   8|   5|  7.00|  0.00| 96.80
     0|   8|   6|  1.00|  0.00| 98.79
     0|   8|   7|  5.62|  0.00| 94.17

  POWER9: Shallow states (stop0lite, stop1lite, stop2lite, stop0, stop1,
  stop2) disabled:

  $ cpupower monitor sleep 30
  sleep took 30.02110 seconds and exited with status 0
                |Idle_Stats
  PKG |CORE|CPU | snoo | stop | stop | stop | stop | stop | stop | stop | stop
     0|   0|   0|  0.69|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|  9.39| 89.70
     0|   0|   1|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|  0.05| 93.21
     0|   0|   2|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00| 89.93
     0|   0|   3|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00| 93.26

Fixes: 78eaa10f027c ("cpuidle: powernv/pseries: Auto-promotion of snooze to deeper idle state")
Cc: stable@vger.kernel.org # v4.2+
Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Reviewed-by: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/cpuidle/cpuidle-powernv.c |   32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -32,9 +32,31 @@ static struct cpuidle_state *cpuidle_sta
 
 static u64 stop_psscr_table[CPUIDLE_STATE_MAX];
 
-static u64 snooze_timeout;
+static u64 default_snooze_timeout;
 static bool snooze_timeout_en;
 
+static u64 get_snooze_timeout(struct cpuidle_device *dev,
+			      struct cpuidle_driver *drv,
+			      int index)
+{
+	int i;
+
+	if (unlikely(!snooze_timeout_en))
+		return default_snooze_timeout;
+
+	for (i = index + 1; i < drv->state_count; i++) {
+		struct cpuidle_state *s = &drv->states[i];
+		struct cpuidle_state_usage *su = &dev->states_usage[i];
+
+		if (s->disabled || su->disable)
+			continue;
+
+		return s->target_residency * tb_ticks_per_usec;
+	}
+
+	return default_snooze_timeout;
+}
+
 static int snooze_loop(struct cpuidle_device *dev,
 			struct cpuidle_driver *drv,
 			int index)
@@ -44,7 +66,7 @@ static int snooze_loop(struct cpuidle_de
 	local_irq_enable();
 	set_thread_flag(TIF_POLLING_NRFLAG);
 
-	snooze_exit_time = get_tb() + snooze_timeout;
+	snooze_exit_time = get_tb() + get_snooze_timeout(dev, drv, index);
 	ppc64_runlatch_off();
 	while (!need_resched()) {
 		HMT_low();
@@ -337,11 +359,9 @@ static int powernv_idle_probe(void)
 		cpuidle_state_table = powernv_states;
 		/* Device tree can indicate more idle states */
 		max_idle_state = powernv_add_idle_states();
-		if (max_idle_state > 1) {
+		default_snooze_timeout = TICK_USEC * tb_ticks_per_usec;
+		if (max_idle_state > 1)
 			snooze_timeout_en = true;
-			snooze_timeout = powernv_states[1].target_residency *
-					 tb_ticks_per_usec;
-		}
  	} else
  		return -ENODEV;
 


