Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97706C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E2732081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:59:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E2732081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbeLKH7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 02:59:47 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:59755 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbeLKH7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 02:59:47 -0500
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1gWcxC-0004B1-BX; Tue, 11 Dec 2018 07:59:42 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     jeffrey.t.kirsher@intel.com
Cc:     davem@davemloft.net, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH 1/2] e1000e: Exclude device from suspend direct complete optimization
Date:   Tue, 11 Dec 2018 15:59:37 +0800
Message-Id: <20181211075938.32026-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

e1000e sets different WoL settings in system suspend callback and
runtime suspend callback.

The suspend direct complete optimization leaves e1000e in runtime
suspneded state with wrong WoL setting during system suspend.

To fix this, we need to disable suspend direct complete optimization to
let e1000e always use suspend callback to set correct WoL during system
suspend.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index e434a6a64966..4a22390f9f49 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -7351,6 +7351,8 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	e1000_print_device_info(adapter);
 
+	dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_NEVER_SKIP);
+
 	if (pci_dev_run_wake(pdev))
 		pm_runtime_put_noidle(&pdev->dev);
 
-- 
2.17.1

