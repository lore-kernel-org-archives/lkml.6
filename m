Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16994C282CF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED3E2173C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548694214;
	bh=ASDMg/4epFmYnhML5aDcH927KPsDPUNDWyQNH9oXQr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b+UxLVRoe8AaT03pS3t5N3klyQ5dwTdFKS9UCzHTl7sRpIBqACBHCwUASJhsawG87
	 HlSet3PwqUi3biELbdV8yIqTQUZWNOnDZwj41tarxqo3EzaZKvfjw+HE/mTw0+VZjS
	 jcWbXo0a+yB1mlLolWEnbSOBJ4aj3/g5P14TykOg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387730AbfA1QUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:20:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:55414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388735AbfA1QUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:20:09 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D53C2147A;
        Mon, 28 Jan 2019 16:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692408;
        bh=ASDMg/4epFmYnhML5aDcH927KPsDPUNDWyQNH9oXQr4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SbwMBheWxRejZNGHgNqsiSBoNqIjfCF2n0YvFZdM6VJbuOentKIARv4BW6UHT9m4h
         G/MYmox7tTkuiIcABwRLz0LhAv8n3kiRlTbQqRAs5XnDKnaQm1WDJDepVoeAtaTrpU
         vzl1FYyzg8p3OvmQQ6KqU5u5Wu8w9/5pW6d+w/lA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yufen Wang <wangyufen@huawei.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 008/107] ARM: 8808/1: kexec:offline panic_smp_self_stop CPU
Date:   Mon, 28 Jan 2019 11:18:08 -0500
Message-Id: <20190128161947.57405-8-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161947.57405-1-sashal@kernel.org>
References: <20190128161947.57405-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yufen Wang <wangyufen@huawei.com>

[ Upstream commit 82c08c3e7f171aa7f579b231d0abbc1d62e91974 ]

In case panic() and panic() called at the same time on different CPUS.
For example:
CPU 0:
  panic()
     __crash_kexec
       machine_crash_shutdown
         crash_smp_send_stop
       machine_kexec
         BUG_ON(num_online_cpus() > 1);

CPU 1:
  panic()
    local_irq_disable
    panic_smp_self_stop

If CPU 1 calls panic_smp_self_stop() before crash_smp_send_stop(), kdump
fails. CPU1 can't receive the ipi irq, CPU1 will be always online.
To fix this problem, this patch split out the panic_smp_self_stop()
and add set_cpu_online(smp_processor_id(), false).

Signed-off-by: Yufen Wang <wangyufen@huawei.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/kernel/smp.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index d2ce37da87d8..4b129aac7233 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -690,6 +690,21 @@ void smp_send_stop(void)
 		pr_warn("SMP: failed to stop secondary CPUs\n");
 }
 
+/* In case panic() and panic() called at the same time on CPU1 and CPU2,
+ * and CPU 1 calls panic_smp_self_stop() before crash_smp_send_stop()
+ * CPU1 can't receive the ipi irqs from CPU2, CPU1 will be always online,
+ * kdump fails. So split out the panic_smp_self_stop() and add
+ * set_cpu_online(smp_processor_id(), false).
+ */
+void panic_smp_self_stop(void)
+{
+	pr_debug("CPU %u will stop doing anything useful since another CPU has paniced\n",
+	         smp_processor_id());
+	set_cpu_online(smp_processor_id(), false);
+	while (1)
+		cpu_relax();
+}
+
 /*
  * not supported here
  */
-- 
2.19.1

