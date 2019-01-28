Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6249C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9A3820989
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548696139;
	bh=LWe5T3FnuLi8FDdx6034raqSmyFhP7x+OGZF8mWDHJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iiO/s4zWXJLanfwwyIEItfbSsi9yRj/yScit5hej8BwE2mT/61+YkAqMq3x1/45Xn
	 pVP4NE8JOqZt3h3mDv4/urDILDKKfKvDWAqenDeDf2Ysut9drQKg+ajRkC2wJF/j5V
	 QPUC79R9NvPWxo7W+blxjdmgcxCU//4O83dHhvMw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731671AbfA1RWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:22:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:48774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731057AbfA1QD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:03:26 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA4042082E;
        Mon, 28 Jan 2019 16:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691406;
        bh=LWe5T3FnuLi8FDdx6034raqSmyFhP7x+OGZF8mWDHJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1Muvf9BEytUX6RfOYaOSmf1tVXqCPzZ36A5+tlBVaLcqjwkUSZgZKZcEMenv7cgkB
         567VOz5ed1thFv7GUEzYBByhYiZGR2V0mR/YK4qyVoQDPihG6oaSCo9xjAr6629srw
         bN2BaLHNU4RQoWyca97yLO3P2upwY3SNpXkeOdU4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nicholas Mc Guire <hofrat@osadl.org>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 084/258] perf: arm_spe: handle devm_kasprintf() failure
Date:   Mon, 28 Jan 2019 10:56:30 -0500
Message-Id: <20190128155924.51521-84-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
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

