Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558AAC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 193002054F
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545500919;
	bh=rIbHg3p3DF2nNZFj9rexTMlc6QSq0pUNWbcn41uRH24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZzHqFST5xmCTEcOQckfPj7cqX91+ugs0LvP6s6p355muLlZxoCuz97dRg07vvRkrq
	 aHiwKPyM0NRiPLeh0U5y3VX4alJiK6B42pR3MhXpvzvRJLWQLFOHLNXCtweL6Ee/R9
	 4ZqYHlQcTz3PHj1z65and3oRbkA4gQ5Gvco9ADVs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390481AbeLVRsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:48:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:34174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389667AbeLVRrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:47:14 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [40.76.9.36])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65B65219B5;
        Sat, 22 Dec 2018 09:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545469651;
        bh=rIbHg3p3DF2nNZFj9rexTMlc6QSq0pUNWbcn41uRH24=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J9StYQR7VmCV18tL1fjR+w4TL84O6+r8h+Y4RSO7nLEXi/+4qI0SOHJXewul4i2aA
         /WefWziVKCfTwzEZKRxUDETr1qL+wZcDdbxfIhvnShf4wALwFm7xqmfhacN8uw1nfp
         B3pCKEuUXrkHq4PWYDra5RZz8i8yjFs6vP3fgqig=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-next@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        Zha Qipeng <qipeng.zha@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org (open list:INTEL PMC/P-Unit IPC
        DRIVER), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 05/11] platform/x86: intel_pmc: Hide PCI specific pieces behind CONFIG_PCI
Date:   Sat, 22 Dec 2018 09:07:14 +0000
Message-Id: <20181222090720.19234-6-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181222090720.19234-1-okaya@kernel.org>
References: <20181222090720.19234-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the configuration where CONFIG_PCI is unset, this driver is failing to
compile due to PCI framework dependencies. Hide these behind CONFIG_PCI
ifdef.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/platform/x86/intel_pmc_ipc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/platform/x86/intel_pmc_ipc.c b/drivers/platform/x86/intel_pmc_ipc.c
index 7964ba22ef8d..d85dfed3bf9c 100644
--- a/drivers/platform/x86/intel_pmc_ipc.c
+++ b/drivers/platform/x86/intel_pmc_ipc.c
@@ -504,6 +504,7 @@ static irqreturn_t ioc(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+#ifdef CONFIG_PCI
 static int ipc_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct intel_pmc_ipc_dev *pmc = &ipcdev;
@@ -556,6 +557,7 @@ static struct pci_driver ipc_pci_driver = {
 	.id_table = ipc_pci_ids,
 	.probe = ipc_pci_probe,
 };
+#endif
 
 static ssize_t intel_pmc_ipc_simple_cmd_store(struct device *dev,
 					      struct device_attribute *attr,
@@ -1007,18 +1009,22 @@ static int __init intel_pmc_ipc_init(void)
 		pr_err("Failed to register PMC ipc platform driver\n");
 		return ret;
 	}
+#ifdef CONFIG_PCI
 	ret = pci_register_driver(&ipc_pci_driver);
 	if (ret) {
 		pr_err("Failed to register PMC ipc pci driver\n");
 		platform_driver_unregister(&ipc_plat_driver);
 		return ret;
 	}
+#endif
 	return ret;
 }
 
 static void __exit intel_pmc_ipc_exit(void)
 {
+#ifdef CONFIG_PCI
 	pci_unregister_driver(&ipc_pci_driver);
+#endif
 	platform_driver_unregister(&ipc_plat_driver);
 }
 
-- 
2.19.0

