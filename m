Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4352AC2F420
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10B982084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="dUJysieo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbfAUOlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:41:20 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:44104 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729230AbfAUOlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:41:17 -0500
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 6DAA95C0DDF;
        Mon, 21 Jan 2019 15:41:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1548081674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=36Vgv2tUCbEBYJlFXjiAD+zVk0oMuY2Xq3ip8++bE/s=;
        b=dUJysieoDiEUtcIs+lEiSQKyps7pp42edC07GPnmkBIDMuT8kTHFRIxKelGGB3ypV4RWLp
        +H++7J0Za+RXsQ9UZhFcJK9CF/EvCWgZFgEro3Xe5AILegKwvf88kNBstiikJKBIu7Cmsx
        acNW4wjSxt1fheT3udJy7OIqPcco4Lo=
From:   Stefan Agner <stefan@agner.ch>
To:     will.deacon@arm.com, mark.rutland@arm.com
Cc:     shawnguo@kernel.org, l.stach@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH] drivers/perf: handle multiple CPUs with single interrupts
Date:   Mon, 21 Jan 2019 15:41:11 +0100
Message-Id: <20190121144111.22716-1-stefan@agner.ch>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, if only a single interrupt is available, the code assigns
this single interrupt to the first CPU. All other CPUs are left
unsupported. This allows to use perf events only on processes using
the first CPU. This is not obvious to the user.

Instead, disable interrupts but support all CPUs. This allows to use
the PMU on all CPUs for all events other than sampling events which do
require interrupt support.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
This has been observed and tested on a i.MX 6DualLite, but is probably
valid for i.MX 6Quad as well.

It seems that ux500 once had support for single IRQ on a SMP system,
however this got removed with:
Commit 2b05f6ae1ee5 ("ARM: ux500: remove PMU IRQ bouncer")

I noticed that with this patch I get an error when trying to use perf stat:
  # perf top
  Error:
  cycles: PMU Hardware doesn't support sampling/overflow-interrupts. Try 'perf stat'

Without this patch perf top seems to work, but it seems not to use any
sampling events (?):
  # perf top
PerfTop:    7215 irqs/sec  kernel:100.0%  exact:  0.0% [4000Hz cpu-clock:pppH], (all, 2 CPUs)
....

Also starting perf top and explicitly selecting cpu-clock seems to work
and show the same data as before this change.
  # perf top -e cpu-clock:pppH
PerfTop:    7214 irqs/sec  kernel:100.0%  exact:  0.0% [4000Hz cpu-clock:pppH], (all, 2 CPUs)

It seems that perf top falls back to cpu-clock in the old case, but not
once sampling events are not supported...

--
Stefan


 drivers/perf/arm_pmu_platform.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/perf/arm_pmu_platform.c b/drivers/perf/arm_pmu_platform.c
index 933bd8410fc2..80b991417b6e 100644
--- a/drivers/perf/arm_pmu_platform.c
+++ b/drivers/perf/arm_pmu_platform.c
@@ -105,23 +105,26 @@ static int pmu_parse_irqs(struct arm_pmu *pmu)
 		return num_irqs;
 	}
 
+	if (num_irqs == 1) {
+		int irq = platform_get_irq(pdev, 0);
+		if (irq && irq_is_percpu_devid(irq))
+			return pmu_parse_percpu_irq(pmu, irq);
+	}
+
 	/*
 	 * In this case we have no idea which CPUs are covered by the PMU.
 	 * To match our prior behaviour, we assume all CPUs in this case.
+	 * Multiple CPUs with a single PMU irq are currently not handled.
+	 * Rather than supporting only the first CPU, support all CPUs but
+	 * without interrupt capability.
 	 */
-	if (num_irqs == 0) {
-		pr_warn("no irqs for PMU, sampling events not supported\n");
+	if (num_irqs == 0 || (nr_cpu_ids > 1 && num_irqs == 1)) {
+		pr_info("No per CPU irqs for PMU, sampling events not supported\n");
 		pmu->pmu.capabilities |= PERF_PMU_CAP_NO_INTERRUPT;
 		cpumask_setall(&pmu->supported_cpus);
 		return 0;
 	}
 
-	if (num_irqs == 1) {
-		int irq = platform_get_irq(pdev, 0);
-		if (irq && irq_is_percpu_devid(irq))
-			return pmu_parse_percpu_irq(pmu, irq);
-	}
-
 	if (nr_cpu_ids != 1 && !pmu_has_irq_affinity(pdev->dev.of_node)) {
 		pr_warn("no interrupt-affinity property for %pOF, guessing.\n",
 			pdev->dev.of_node);
-- 
2.20.1

