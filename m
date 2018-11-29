Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F01C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE96E20863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:59:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE96E20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbeK3AFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 19:05:13 -0500
Received: from www.osadl.org ([62.245.132.105]:47547 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727040AbeK3AFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 19:05:13 -0500
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id wATCwSXr028330;
        Thu, 29 Nov 2018 13:58:28 +0100
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH V2] perf: arm_spe: handle devm_kasprintf() failure
Date:   Thu, 29 Nov 2018 13:55:30 +0100
Message-Id: <1543496130-7727-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_kasprintf() may return NULL on failure of internal allocation
thus the assignment to  name  is not safe if unchecked. if NULL
is passed in for name then perf_pmu_register() would not fail
but rather silently jump to skip_type which is not the intent
here. As perf_pmu_register() may also return -ENOMEM returning 
-ENOMEM in the (unlikely) failure case of devm_kasprintf() should 
be fine here as well.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: d5d9696b0380 ("drivers/perf: Add support for ARMv8.2 Statistical Profiling Extension")
Acked-by: Mark Rutland <mark.rutland@arm.com>
---

V2: Changed error message to keep error messages consistent
    as suggested by Mark Rutland <mark.rutland@arm.com> - thanks !

Problem located with an experimental coccinelle script

The dev_err() might seem a bit much for this unlikely error but as 
perf_pmu_register() may also return -ENOMEM it would be hard to figure
out what went wrong without this message.

Patch was compile tested with: defconfig (ARCH=arm64) +
ARM_SPE_PMU=y

Patch is against 4.20-rc4 (localversion-next is next-20181129)

 drivers/perf/arm_spe_pmu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 54ec278..f1ea00c 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -927,6 +927,11 @@ static int arm_spe_pmu_perf_init(struct arm_spe_pmu *spe_pmu)
 
 	idx = atomic_inc_return(&pmu_idx);
 	name = devm_kasprintf(dev, GFP_KERNEL, "%s_%d", PMUNAME, idx);
+	if (!name) {
+		dev_err(dev, "failed to allocate spe_pmu name\n");
+		return -ENOMEM;
+	}
+
 	return perf_pmu_register(&spe_pmu->pmu, name, -1);
 }
 
-- 
2.1.4

