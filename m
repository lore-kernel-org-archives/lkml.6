Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F460C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0BB0208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="w31nIj0a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0BB0208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387439AbeHAXd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 19:33:26 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:53924 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731935AbeHAXd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 19:33:26 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 3DCD3806AC;
        Thu,  2 Aug 2018 09:45:35 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail; t=1533159935;
        bh=nRgQHLbphVGaTp42weGTtbcAsKX3+i7oUtLtPlH6uIE=;
        h=From:To:Cc:Subject:Date;
        b=w31nIj0aiwtQHANYhvL8uo5ml8H2DsH8BtJ1Dy5ThU3Nd55OFd7WdAucQS24UTsU0
         qQvDDR1R/bEhyOlbbXtbnBgek7x/4ZBgO0ZCdrZznx0avj43inWcETtTe8jcPtbTIl
         4GbJd6jmclMleCDoavxH5jaCAAqb2+idPoyyAig4=
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5b6229fd0000>; Thu, 02 Aug 2018 09:45:33 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id 3D64813EEED;
        Thu,  2 Aug 2018 09:45:36 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 7D97C1E01D1; Thu,  2 Aug 2018 09:45:34 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     mark.rutland@arm.com, will.deacon@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] arm_pmu: fix compiler warning in arm_pmu_device_probe
Date:   Thu,  2 Aug 2018 09:45:26 +1200
Message-Id: <20180801214526.24599-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC warns

  arm_pmu_platform.c:234:5: error: 'err' may be used uninitialized in this function [-Werror=maybe-uninitialized]

This is because we rely on the for_each_cpu loop in armpmu_request_irqs
to initialise err. The warning is a little bogus because we know if
there were 0 CPUs this code would not be running.

Initialise err to 0 to avoid the warning.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
This has been reported before in https://lkml.org/lkml/2018/3/5/508 I'm not
sure if it was dismmissed as "meh, gcc is wrong" or if it was just wainting for
someone with some round tuits.


 drivers/perf/arm_pmu_platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/arm_pmu_platform.c b/drivers/perf/arm_pmu_platform.c
index 971ff336494a..96075cecb0ae 100644
--- a/drivers/perf/arm_pmu_platform.c
+++ b/drivers/perf/arm_pmu_platform.c
@@ -160,7 +160,7 @@ static int pmu_parse_irqs(struct arm_pmu *pmu)
 static int armpmu_request_irqs(struct arm_pmu *armpmu)
 {
 	struct pmu_hw_events __percpu *hw_events = armpmu->hw_events;
-	int cpu, err;
+	int cpu, err = 0;
 
 	for_each_cpu(cpu, &armpmu->supported_cpus) {
 		int irq = per_cpu(hw_events->irq, cpu);
-- 
2.18.0

