Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B45AC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C89AC2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690474;
	bh=LWe5T3FnuLi8FDdx6034raqSmyFhP7x+OGZF8mWDHJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fBu15TUycfUJYC6adjTJracFM+NOb7aMufKV0PJzu3tQYRFwLYgJ1/6BH+ChhmDgy
	 pRNOS+fJ4fA2xtvOZMCUtD3BgB4knSbWieGDWFnkrHHP9fKybLPsRDaHV6yMohEwIN
	 80GFhm8wNnkP6tFXePwtu1p0kpVAZ4xNX2LifIpQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbfA1Prx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:47:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:33148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728381AbfA1Prp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:47:45 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71ED520880;
        Mon, 28 Jan 2019 15:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690464;
        bh=LWe5T3FnuLi8FDdx6034raqSmyFhP7x+OGZF8mWDHJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yWAowZmS+0J/GT/Mn0yIrvmFXjUpzTektXRG5QGtS2/odBpFcZD9TeeW7YTNtJKDS
         hlp42LfejEu/gTZI4cP61AEbZvZYEUFdCMQuUZzP3/oK65+BEiAt7C7nJK2AtYVSyl
         Z93aMo7LeyEBZCN5yuJKup3Dsot5ic0gZUXlKHlE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nicholas Mc Guire <hofrat@osadl.org>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 098/304] perf: arm_spe: handle devm_kasprintf() failure
Date:   Mon, 28 Jan 2019 10:40:15 -0500
Message-Id: <20190128154341.47195-98-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Mc Guire <hofrat@osadl.org>

[ Upstream commit 754a58db6a556e6e5f5e32f3e84e7d67b5bf9c8e ]

devm_kasprintf() may return NULL on failure of internal allocation
thus the assignment to 'name' is not safe if unchecked. If NULL
is passed in for name then perf_pmu_register() would not fail
but rather silently jump to skip_type which is not the intent
here. As perf_pmu_register() may also return -ENOMEM returning
-ENOMEM in the (unlikely) failure case of devm_kasprintf() should
be fine here as well.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Fixes: d5d9696b0380 ("drivers/perf: Add support for ARMv8.2 Statistical Profiling Extension")
Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
[will: reworded error message]
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/perf/arm_spe_pmu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 54ec278d2fc4..e1a77b2de78a 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -927,6 +927,11 @@ static int arm_spe_pmu_perf_init(struct arm_spe_pmu *spe_pmu)
 
 	idx = atomic_inc_return(&pmu_idx);
 	name = devm_kasprintf(dev, GFP_KERNEL, "%s_%d", PMUNAME, idx);
+	if (!name) {
+		dev_err(dev, "failed to allocate name for pmu %d\n", idx);
+		return -ENOMEM;
+	}
+
 	return perf_pmu_register(&spe_pmu->pmu, name, -1);
 }
 
-- 
2.19.1

