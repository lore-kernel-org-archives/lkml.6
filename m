Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB06EC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E56120661
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550957187;
	bh=yTah129EW3wyDfxl/DTuSQfJD7GLsX0rKpVnLrOPBPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CNwTIwphOrHneq1Qgs05ENxnR28hLZYRReJ7n7vjJHhNbC5TE2lFrpAlqW0mLltz9
	 o5Oc8GVfJXhmD1mlUOu1bqskT9K9EZ0HzocDZ/Lvjl4BMRWlDtBO/+BqsXEcPIkTPV
	 Vmu0tfI5pCJphmYlt5UEG3Y/5B/uDMmAqHAb5F6k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbfBWVHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:07:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:42718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729044AbfBWVH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:07:28 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9DB920861;
        Sat, 23 Feb 2019 21:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550956047;
        bh=yTah129EW3wyDfxl/DTuSQfJD7GLsX0rKpVnLrOPBPI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HUb90e6OJk4RW0/AF4h29PS4hkK2I+OPbkY/bNtlzNr47RWa1bHc2yTMH2Uj3Ff80
         tr1Oh3QYamHahh3TgBZdyLMhAPD1CKvRXjPP73MNwWMikEgVKMnWiYSR7aKgPlmLvZ
         c+0LamEwRs6wSkI+V+dOpqNBMMIgPD3wP+codA7M=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Max Filippov <jcmvbkbc@gmail.com>, Sasha Levin <sashal@kernel.org>,
        linux-xtensa@linux-xtensa.org
Subject: [PATCH AUTOSEL 4.19 27/65] xtensa: SMP: limit number of possible CPUs by NR_CPUS
Date:   Sat, 23 Feb 2019 16:06:02 -0500
Message-Id: <20190223210640.200911-27-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223210640.200911-1-sashal@kernel.org>
References: <20190223210640.200911-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Filippov <jcmvbkbc@gmail.com>

[ Upstream commit 25384ce5f9530def39421597b1457d9462df6455 ]

This fixes the following warning at boot when the kernel is booted on a
board with more CPU cores than was configured in NR_CPUS:

  smp_init_cpus: Core Count = 8
  smp_init_cpus: Core Id = 0
  ------------[ cut here ]------------
  WARNING: CPU: 0 PID: 0 at include/linux/cpumask.h:121 smp_init_cpus+0x54/0x74
  Modules linked in:
  CPU: 0 PID: 0 Comm: swapper Not tainted 5.0.0-rc3-00015-g1459333f88a0 #124
  Call Trace:
    __warn$part$3+0x6a/0x7c
    warn_slowpath_null+0x35/0x3c
    smp_init_cpus+0x54/0x74
    setup_arch+0x1c0/0x1d0
    start_kernel+0x44/0x310
    _startup+0x107/0x107

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/xtensa/kernel/smp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/xtensa/kernel/smp.c b/arch/xtensa/kernel/smp.c
index 80be6449c497e..be1f280c322cd 100644
--- a/arch/xtensa/kernel/smp.c
+++ b/arch/xtensa/kernel/smp.c
@@ -96,6 +96,11 @@ void __init smp_init_cpus(void)
 	pr_info("%s: Core Count = %d\n", __func__, ncpus);
 	pr_info("%s: Core Id = %d\n", __func__, core_id);
 
+	if (ncpus > NR_CPUS) {
+		ncpus = NR_CPUS;
+		pr_info("%s: limiting core count by %d\n", __func__, ncpus);
+	}
+
 	for (i = 0; i < ncpus; ++i)
 		set_cpu_possible(i, true);
 }
-- 
2.19.1

