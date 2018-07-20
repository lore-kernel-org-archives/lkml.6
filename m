Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99811ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EB0120652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:46:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EB0120652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390448AbeGTNeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:34:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56570 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389332AbeGTNeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:34:13 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DDAC8D93;
        Fri, 20 Jul 2018 12:40:24 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 4.17 067/101] PCI: hv: Disable/enable IRQs rather than BH in hv_compose_msi_msg()
Date:   Fri, 20 Jul 2018 14:14:13 +0200
Message-Id: <20180720121426.160586921@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121422.837870592@linuxfoundation.org>
References: <20180720121422.837870592@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dexuan Cui <decui@microsoft.com>

commit 35a88a18d7ea58600e11590405bc93b08e16e7f5 upstream.

Commit de0aa7b2f97d ("PCI: hv: Fix 2 hang issues in hv_compose_msi_msg()")
uses local_bh_disable()/enable(), because hv_pci_onchannelcallback() can
also run in tasklet context as the channel event callback, so bottom halves
should be disabled to prevent a race condition.

With CONFIG_PROVE_LOCKING=y in the recent mainline, or old kernels that
don't have commit f71b74bca637 ("irq/softirqs: Use lockdep to assert IRQs
are disabled/enabled"), when the upper layer IRQ code calls
hv_compose_msi_msg() with local IRQs disabled, we'll see a warning at the
beginning of __local_bh_enable_ip():

  IRQs not enabled as expected
    WARNING: CPU: 0 PID: 408 at kernel/softirq.c:162 __local_bh_enable_ip

The warning exposes an issue in de0aa7b2f97d: local_bh_enable() can
potentially call do_softirq(), which is not supposed to run when local IRQs
are disabled. Let's fix this by using local_irq_save()/restore() instead.

Note: hv_pci_onchannelcallback() is not a hot path because it's only called
when the PCI device is hot added and removed, which is infrequent.

Fixes: de0aa7b2f97d ("PCI: hv: Fix 2 hang issues in hv_compose_msi_msg()")
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Cc: stable@vger.kernel.org
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/host/pci-hyperv.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -1077,6 +1077,7 @@ static void hv_compose_msi_msg(struct ir
 	struct pci_bus *pbus;
 	struct pci_dev *pdev;
 	struct cpumask *dest;
+	unsigned long flags;
 	struct compose_comp_ctxt comp;
 	struct tran_int_desc *int_desc;
 	struct {
@@ -1168,14 +1169,15 @@ static void hv_compose_msi_msg(struct ir
 		 * the channel callback directly when channel->target_cpu is
 		 * the current CPU. When the higher level interrupt code
 		 * calls us with interrupt enabled, let's add the
-		 * local_bh_disable()/enable() to avoid race.
+		 * local_irq_save()/restore() to avoid race:
+		 * hv_pci_onchannelcallback() can also run in tasklet.
 		 */
-		local_bh_disable();
+		local_irq_save(flags);
 
 		if (hbus->hdev->channel->target_cpu == smp_processor_id())
 			hv_pci_onchannelcallback(hbus);
 
-		local_bh_enable();
+		local_irq_restore(flags);
 
 		if (hpdev->state == hv_pcichild_ejecting) {
 			dev_err_once(&hbus->hdev->device,


