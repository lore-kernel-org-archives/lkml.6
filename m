Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5965C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6302020844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wvmyNnVt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6302020844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730800AbeKIHih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:38:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:57940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727602AbeKIHig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:38:36 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 453DA21479;
        Thu,  8 Nov 2018 22:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714467;
        bh=71PEbRKgNwv6pIjyfPyAQhZwTsZq5Lhde5gPaYZoYtg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wvmyNnVtRLgl2X0vgzLwxHzSVU8/530Ur2ThMKeq8ohxz0EVnCywjZ0isde2lDqJ5
         X1klxB3vhXmlGoFEVzpkkYyR4/iAGp9ZD9edVZmUCxBDdeL4EwPpQ/HNpKnjtVXd7V
         ixLwy0nVjVCqGsgJhZirDz1HG8Le9cWf6o2xUgVg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Tejun Heo <tj@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 103/114] ahci: dont ignore result code of ahci_reset_controller()
Date:   Thu,  8 Nov 2018 13:51:58 -0800
Message-Id: <20181108215110.046988855@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215059.051093652@linuxfoundation.org>
References: <20181108215059.051093652@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit d312fefea8387503375f728855c9a62de20c9665 ]

ahci_pci_reset_controller() calls ahci_reset_controller(), which may
fail, but ignores the result code and always returns success. This
may result in failures like below

  ahci 0000:02:00.0: version 3.0
  ahci 0000:02:00.0: enabling device (0000 -> 0003)
  ahci 0000:02:00.0: SSS flag set, parallel bus scan disabled
  ahci 0000:02:00.0: controller reset failed (0xffffffff)
  ahci 0000:02:00.0: failed to stop engine (-5)
    ... repeated many times ...
  ahci 0000:02:00.0: failed to stop engine (-5)
  Unable to handle kernel paging request at virtual address ffff0000093f9018
    ...
  PC is at ahci_stop_engine+0x5c/0xd8 [libahci]
  LR is at ahci_deinit_port.constprop.12+0x1c/0xc0 [libahci]
    ...
  [<ffff000000a17014>] ahci_stop_engine+0x5c/0xd8 [libahci]
  [<ffff000000a196b4>] ahci_deinit_port.constprop.12+0x1c/0xc0 [libahci]
  [<ffff000000a197d8>] ahci_init_controller+0x80/0x168 [libahci]
  [<ffff000000a260f8>] ahci_pci_init_controller+0x60/0x68 [ahci]
  [<ffff000000a26f94>] ahci_init_one+0x75c/0xd88 [ahci]
  [<ffff000008430324>] local_pci_probe+0x3c/0xb8
  [<ffff000008431728>] pci_device_probe+0x138/0x170
  [<ffff000008585e54>] driver_probe_device+0x2dc/0x458
  [<ffff0000085860e4>] __driver_attach+0x114/0x118
  [<ffff000008583ca8>] bus_for_each_dev+0x60/0xa0
  [<ffff000008585638>] driver_attach+0x20/0x28
  [<ffff0000085850b0>] bus_add_driver+0x1f0/0x2a8
  [<ffff000008586ae0>] driver_register+0x60/0xf8
  [<ffff00000842f9b4>] __pci_register_driver+0x3c/0x48
  [<ffff000000a3001c>] ahci_pci_driver_init+0x1c/0x1000 [ahci]
  [<ffff000008083918>] do_one_initcall+0x38/0x120

where an obvious hardware level failure results in an unnecessary 15 second
delay and a subsequent crash.

So record the result code of ahci_reset_controller() and relay it, rather
than ignoring it.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/ahci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 34fdaa6e99ba..5f1f049063dd 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -619,8 +619,11 @@ static void ahci_pci_save_initial_config(struct pci_dev *pdev,
 static int ahci_pci_reset_controller(struct ata_host *host)
 {
 	struct pci_dev *pdev = to_pci_dev(host->dev);
+	int rc;
 
-	ahci_reset_controller(host);
+	rc = ahci_reset_controller(host);
+	if (rc)
+		return rc;
 
 	if (pdev->vendor == PCI_VENDOR_ID_INTEL) {
 		struct ahci_host_priv *hpriv = host->private_data;
-- 
2.17.1



