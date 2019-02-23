Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51A1C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7513020651
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550956376;
	bh=kqphpKdYkQJw8lOwHH/DEhez3AtMfynWVBXXFTqctvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UHizwPz6cgCB1QEyRF7He/Uo5Fu9QvQRxBNgHYAE0OklHRizSX/A0j8p5vekSqxlA
	 TTu0xoVon9XY7OoVQKeQQhQkXmI+mgSqJloARLkOK/N/GYwDUV7DDmnjz0mmd9tLw4
	 ixruDwBmWKuuYEuiyLs5f4O8UX0n1v8SZRu55Azs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729910AbfBWVMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:12:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:48528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730071AbfBWVLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:11:52 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E57422085A;
        Sat, 23 Feb 2019 21:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550956311;
        bh=kqphpKdYkQJw8lOwHH/DEhez3AtMfynWVBXXFTqctvQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BaNVFkPdjrYQ1+oagm4K5zShBPaSChJNQrFKbOIMWP8LlUwSXtw0Zs57ZNNXpT+uj
         uC8nJ3oMOvKvs1+iGITaRxtSfDMXDU7Nj8sYRRde9/bt6MrC375lDrEPLxBdBy507z
         tXN/nGbnNKlOCQXLz5WPgqIplLh7GB8/jyJjP1Rw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Max Filippov <jcmvbkbc@gmail.com>, Sasha Levin <sashal@kernel.org>,
        linux-xtensa@linux-xtensa.org
Subject: [PATCH AUTOSEL 3.18 09/18] xtensa: SMP: limit number of possible CPUs by NR_CPUS
Date:   Sat, 23 Feb 2019 16:11:26 -0500
Message-Id: <20190223211135.203082-9-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223211135.203082-1-sashal@kernel.org>
References: <20190223211135.203082-1-sashal@kernel.org>
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
index 0e34c1ed4aa8f..54bb8e0473a06 100644
--- a/arch/xtensa/kernel/smp.c
+++ b/arch/xtensa/kernel/smp.c
@@ -93,6 +93,11 @@ void __init smp_init_cpus(void)
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

