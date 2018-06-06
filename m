Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A550160767
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linux.ee
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752086AbeFFNLd (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 09:11:33 -0400
Received: from smtp2.it.da.ut.ee ([193.40.5.67]:46951 "EHLO smtp2.it.da.ut.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751851AbeFFNLc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 09:11:32 -0400
Date: Wed, 6 Jun 2018 16:11:26 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: openipmi-developer@lists.sourceforge.net
cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix NULL device in ipmi_si error message
Message-ID: <alpine.LRH.2.21.1806061604580.20960@math.ut.ee>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that 4.17.0 logs the follwing during ipmi_si setup:

 ipmi_si 0000:01:04.6: probing via PCI
 (NULL device *): Could not setup I/O space
 ipmi_si 0000:01:04.6: [mem 0xf5ef0000-0xf5ef00ff] regsize 1 spacing 1 irq 21

Fix the "NULL device *) by moving io.dev assignment before its potential 
use by ipmi_pci_probe_regspacing().

Result:
 ipmi_si 0000:01:04.6: probing via PCI
 ipmi_si 0000:01:04.6: Could not setup I/O space
 ipmi_si 0000:01:04.6: [mem 0xf5ef0000-0xf5ef00ff] regsize 1 spacing 1 irq 21

Signed-off-by: Meelis Roos <mroos@linux.ee>

diff --git a/drivers/char/ipmi/ipmi_si_pci.c b/drivers/char/ipmi/ipmi_si_pci.c
index f54ca6869ed2..022e03634ce2 100644
--- a/drivers/char/ipmi/ipmi_si_pci.c
+++ b/drivers/char/ipmi/ipmi_si_pci.c
@@ -120,6 +120,8 @@ static int ipmi_pci_probe(struct pci_dev *pdev,
 	}
 	io.addr_data = pci_resource_start(pdev, 0);
 
+	io.dev = &pdev->dev;
+
 	io.regspacing = ipmi_pci_probe_regspacing(&io);
 	io.regsize = DEFAULT_REGSIZE;
 	io.regshift = 0;
@@ -128,8 +130,6 @@ static int ipmi_pci_probe(struct pci_dev *pdev,
 	if (io.irq)
 		io.irq_setup = ipmi_std_irq_setup;
 
-	io.dev = &pdev->dev;
-
 	dev_info(&pdev->dev, "%pR regsize %d spacing %d irq %d\n",
 		&pdev->resource[0], io.regsize, io.regspacing, io.irq);
 

-- 
Meelis Roos (mroos@linux.ee)
