Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39978C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 077C32081B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896123;
	bh=LVN46QSgiE1BsG/xkGXkbULJN8GVxa8DZHuyswgKXDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MZvReGUozgbnftIFbyAAguv0+6QvYlwbvvb+sUiUrmHipP6RT5Ykg5aLr677tHlew
	 sQDPJ5Yq1j2PURVYq+7lBXLykUkJt/hxhpnxfjEyy5AI8+0Yzkecec2z5adyJKE/j5
	 bRsTnpeSUV1YPs432RLEE8/3UbfXGyjp135QiWc4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732342AbfBKOmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:42:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:53600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732329AbfBKOl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:41:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB9AF20700;
        Mon, 11 Feb 2019 14:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896117;
        bh=LVN46QSgiE1BsG/xkGXkbULJN8GVxa8DZHuyswgKXDU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yqX3Yg3orY40CABhimhITdkoOarDZJjjK5gdQYr12vegVSsc8J7GluBBPlLiG6Y3S
         Jyh6ZcWYYPu+tTxfID0NB1RWt8a+OgJ7WPzXx4YKzUEWaQqTvtDJrd6qK925/BMVO1
         B8f5ktrfvmEkBBKMAs0P/+tH6g0wxTsahA6884lo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Nicholas Mc Guire <hofrat@osadl.org>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 078/313] perf: arm_spe: handle devm_kasprintf() failure
Date:   Mon, 11 Feb 2019 15:15:58 +0100
Message-Id: <20190211141859.095011657@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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



