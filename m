Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C9EC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 00:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FA8F21927
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 00:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545437760;
	bh=mZfC7GdI6ibYlIxeNHfjh2ZpL23ahqOeMNCfr5RjwJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CoAQgrM9G8kQCRnMsfuxhMlesq3qQ8YjH/Cb7+Sbz0hxczbWHuDLciSYCK09KSAzO
	 fllEVYSfd1zLNWWRJUbCn7vsQEvYqB8sbHRPEYdWz36dyh/snexzjNVxgVdSxnSck8
	 ox4/69Z6FtkBd2CpQa4KP6GncLKSKjaK2RATEOmg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404827AbeLVAP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 19:15:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:45268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404721AbeLVAPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 19:15:09 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [13.82.132.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D40E21934;
        Sat, 22 Dec 2018 00:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545437708;
        bh=mZfC7GdI6ibYlIxeNHfjh2ZpL23ahqOeMNCfr5RjwJs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m3gpESN5YnYO3m6N33Dsr7CLGTnLaezkw6Q/PixHZjFIn2Hh8UENo/OH0hbcMg0XU
         eRuzChBZmmTQkj+/rc6FyUhfCDqv53JnTmP9xNbw4mgtQVHblA7HnbizzyJ2Tsrugj
         StoZdjR8/ihoHk8nS7MuHfMhq7ocVqbx2VequL4k=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-next@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 07/11] drivers: thermal: Hide PCI driver when CONFIG_PCI is unset
Date:   Sat, 22 Dec 2018 00:14:48 +0000
Message-Id: <20181222001452.7474-8-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181222001452.7474-1-okaya@kernel.org>
References: <20181222001452.7474-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is both a platform and PCI driver. Hide PCI specific pieces
when CONFIG_PCI is unset.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 .../intel/int340x_thermal/processor_thermal_device.c      | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
index 284cf2c5a8fd..b84a475a1162 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
@@ -374,6 +374,7 @@ static int int3401_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PCI
 static irqreturn_t proc_thermal_pci_msi_irq(int irq, void *devid)
 {
 	struct proc_thermal_device *proc_priv;
@@ -482,6 +483,7 @@ static struct pci_driver proc_thermal_pci_driver = {
 	.remove		= proc_thermal_pci_remove,
 	.id_table	= proc_thermal_pci_ids,
 };
+#endif
 
 static const struct acpi_device_id int3401_device_ids[] = {
 	{"INT3401", 0},
@@ -505,16 +507,18 @@ static int __init proc_thermal_init(void)
 	ret = platform_driver_register(&int3401_driver);
 	if (ret)
 		return ret;
-
+#ifdef CONFIG_PCI
 	ret = pci_register_driver(&proc_thermal_pci_driver);
-
+#endif
 	return ret;
 }
 
 static void __exit proc_thermal_exit(void)
 {
 	platform_driver_unregister(&int3401_driver);
+#ifdef CONFIG_PCI
 	pci_unregister_driver(&proc_thermal_pci_driver);
+#endif
 }
 
 module_init(proc_thermal_init);
-- 
2.19.0

