Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B2CC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 02:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18B6D23C73
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 02:57:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18B6D23C73
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934255AbeFVC5c (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 22:57:32 -0400
Received: from mga07.intel.com ([134.134.136.100]:51301 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934071AbeFVC5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 22:57:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jun 2018 19:57:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,255,1526367600"; 
   d="scan'208";a="66240339"
Received: from dpdk-haiyue-s2600wfp.sh.intel.com ([10.67.111.114])
  by fmsmga001.fm.intel.com with ESMTP; 21 Jun 2018 19:57:28 -0700
From:   Haiyue Wang <haiyue.wang@linux.intel.com>
To:     minyard@acm.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     Haiyue Wang <haiyue.wang@linux.intel.com>, luis.a.silva@dell.com,
        avi.fishman@nuvoton.com, openbmc@lists.ozlabs.org
Subject: [PATCH ] ipmi: kcs_bmc: fix IRQ exception if the channel is not open
Date:   Fri, 22 Jun 2018 10:56:58 +0800
Message-Id: <1529636218-280096-1-git-send-email-haiyue.wang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original core KCS IRQ handling function 'kcs_bmc_handle_event' had
a wrong logical desgin, it should force abort the KCS transaction only
if the IBF flag is set, because multiple KCS channels share the same
handle function; and it should return 0, which indicates that event of
current channel is handled. An negative value -ENODATA will cause the
IRQ handler of BMC KCS controller return IRQ_NONE, then IRQ moudle will
treat this IRQ 'nobody cared', it will trigger IRQ exception.

   irq 30: nobody cared (try booting with the "irqpoll" option)
   CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.10.15-npcm750 #1
   Hardware name: NPCMX50 Chip family
   [<c010b264>] (unwind_backtrace) from [<c0106930>] (show_stack+0x20/0x24)
   [<c0106930>] (show_stack) from [<c03dad38>] (dump_stack+0x8c/0xa0)
   [<c03dad38>] (dump_stack) from [<c0168810>] (__report_bad_irq+0x3c/0xdc)
   [<c0168810>] (__report_bad_irq) from [<c0168c34>] (note_interrupt+0x29c/0x2ec)
   [<c0168c34>] (note_interrupt) from [<c0165c80>] (handle_irq_event_percpu+0x5c/0x68)
   [<c0165c80>] (handle_irq_event_percpu) from [<c0165cd4>] (handle_irq_event+0x48/0x6c)
   [<c0165cd4>] (handle_irq_event) from [<c0169664>] (handle_fasteoi_irq+0xc8/0x198)
   [<c0169664>] (handle_fasteoi_irq) from [<c016529c>] (__handle_domain_irq+0x90/0xe8)
   [<c016529c>] (__handle_domain_irq) from [<c01014bc>] (gic_handle_irq+0x58/0x9c)
   [<c01014bc>] (gic_handle_irq) from [<c010752c>] (__irq_svc+0x6c/0x90)
   Exception stack(0xc0a01de8 to 0xc0a01e30)
   1de0:                   00002080 c0a6fbc0 00000000 00000000 00000000 c096d294
   1e00: 00000000 00000001 dc406400 f03ff100 00000082 c0a01e94 c0a6fbc0 c0a01e38
   1e20: 00200102 c01015bc 60000113 ffffffff
   [<c010752c>] (__irq_svc) from [<c01015bc>] (__do_softirq+0xbc/0x358)
   [<c01015bc>] (__do_softirq) from [<c011c798>] (irq_exit+0xb8/0xec)
   [<c011c798>] (irq_exit) from [<c01652a0>] (__handle_domain_irq+0x94/0xe8)
   [<c01652a0>] (__handle_domain_irq) from [<c01014bc>] (gic_handle_irq+0x58/0x9c)
   [<c01014bc>] (gic_handle_irq) from [<c010752c>] (__irq_svc+0x6c/0x90)
   Exception stack(0xc0a01ef8 to 0xc0a01f40)
   1ee0:                                                       00000000 000003ae
   1f00: dcc0f338 c0111060 c0a00000 c0a0cc44 c0a0cbe4 c0a1c22b c07bc218 00000001
   1f20: dcffca40 c0a01f54 c0a01f58 c0a01f48 c0103524 c0103528 60000013 ffffffff
   [<c010752c>] (__irq_svc) from [<c0103528>] (arch_cpu_idle+0x48/0x4c)
   [<c0103528>] (arch_cpu_idle) from [<c0681390>] (default_idle_call+0x30/0x3c)
   [<c0681390>] (default_idle_call) from [<c0156f24>] (do_idle+0xc8/0x134)
   [<c0156f24>] (do_idle) from [<c015722c>] (cpu_startup_entry+0x28/0x2c)
   [<c015722c>] (cpu_startup_entry) from [<c067ad74>] (rest_init+0x84/0x88)
   [<c067ad74>] (rest_init) from [<c0900d44>] (start_kernel+0x388/0x394)
   [<c0900d44>] (start_kernel) from [<0000807c>] (0x807c)
   handlers:
   [<c041c5dc>] npcm7xx_kcs_irq
   Disabling IRQ #30

Signed-off-by: Haiyue Wang <haiyue.wang@linux.intel.com>
---
Hi Corey,

This patch looks introducing BIG modification, it should be easily
understandable, and makes code clean & fix an error design, which
is introduced by misunderstanding the IRQ return value.

BR,
Haiyue 
---
 drivers/char/ipmi/kcs_bmc.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/drivers/char/ipmi/kcs_bmc.c b/drivers/char/ipmi/kcs_bmc.c
index fbfc05e..bb882ab1 100644
--- a/drivers/char/ipmi/kcs_bmc.c
+++ b/drivers/char/ipmi/kcs_bmc.c
@@ -210,34 +210,23 @@ static void kcs_bmc_handle_cmd(struct kcs_bmc *kcs_bmc)
 int kcs_bmc_handle_event(struct kcs_bmc *kcs_bmc)
 {
 	unsigned long flags;
-	int ret = 0;
+	int ret = -ENODATA;
 	u8 status;
 
 	spin_lock_irqsave(&kcs_bmc->lock, flags);
 
-	if (!kcs_bmc->running) {
-		kcs_force_abort(kcs_bmc);
-		ret = -ENODEV;
-		goto out_unlock;
-	}
-
-	status = read_status(kcs_bmc) & (KCS_STATUS_IBF | KCS_STATUS_CMD_DAT);
-
-	switch (status) {
-	case KCS_STATUS_IBF | KCS_STATUS_CMD_DAT:
-		kcs_bmc_handle_cmd(kcs_bmc);
-		break;
-
-	case KCS_STATUS_IBF:
-		kcs_bmc_handle_data(kcs_bmc);
-		break;
+	status = read_status(kcs_bmc);
+	if (status & KCS_STATUS_IBF) {
+		if (!kcs_bmc->running)
+			kcs_force_abort(kcs_bmc);
+		else if (status & KCS_STATUS_CMD_DAT)
+			kcs_bmc_handle_cmd(kcs_bmc);
+		else
+			kcs_bmc_handle_data(kcs_bmc);
 
-	default:
-		ret = -ENODATA;
-		break;
+		ret = 0;
 	}
 
-out_unlock:
 	spin_unlock_irqrestore(&kcs_bmc->lock, flags);
 
 	return ret;
-- 
2.7.4

