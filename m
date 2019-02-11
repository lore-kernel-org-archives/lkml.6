Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59EBC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9183521855
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549900245;
	bh=vph0gZXDCzAwkAbNftUzRycquqFT3Jru9aT1NusNUvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F/pdRCMefad1za+2wq7o9ZUcmz1WdO/iRLbGQBVHzcvGAXe8jrOlaf+EXoBeuBJta
	 p2jeARW5Gihs2MpHYuguBHlk5c4BHk98B1h9icvhDbcyHj4SS2+LRRis4eL1t4ra4z
	 XI8Hh1TcipJ5YvR4t2Gz4CnDofA0I0go8iSojJt8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732874AbfBKPuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:50:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:48970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731759AbfBKOiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:38:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF8412054F;
        Mon, 11 Feb 2019 14:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895934;
        bh=vph0gZXDCzAwkAbNftUzRycquqFT3Jru9aT1NusNUvs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AbsmdxDUsBjDxpqilLqJCVOuixrQGCT9ExRRsYrSM+Q1NrRYbBsTfE14fv8ia4e5f
         2VnWuu4k3JffnACTywQ4pw+QKyNRmHGNDhhpcA12kTnFtkDUVOWtcWMUFGiI3aCtMG
         0MUml6drx08zRmF2iaw1SzSkn2tGYx7zGIJncSBI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yufen Wang <wangyufen@huawei.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 019/313] ARM: 8808/1: kexec:offline panic_smp_self_stop CPU
Date:   Mon, 11 Feb 2019 15:14:59 +0100
Message-Id: <20190211141854.605455371@linuxfoundation.org>
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
index 0978282d5fc2..f574a5e0d589 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -693,6 +693,21 @@ void smp_send_stop(void)
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



