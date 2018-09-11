Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EABC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D875120866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:38:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D875120866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbeIKWjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 18:39:16 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57350 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbeIKWjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 18:39:16 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fzmcm-00012j-AH; Tue, 11 Sep 2018 17:38:52 +0000
From:   Colin King <colin.king@canonical.com>
To:     Aditya Shankar <aditya.shankar@microchip.com>,
        Ganesh Krishna <ganesh.krishna@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-wireless@vger.kernel.org, devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: wilc1000: fix null checks on wilc
Date:   Tue, 11 Sep 2018 18:38:51 +0100
Message-Id: <20180911173851.17567-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the pointer wilc is being null checked several times
and yet not checked for the final workqueue flush and destroy
(which can lead to a null pointer dereference if wilc is null);
these missing null checks were overlooked in an earlier core
refactoring commit.

Clean up the code by checking wilc at the start and bailing out
early if it is null allowing the subsequent null checks to be
removed, this also fixes the potential null pointer deferences
on the workqueue flush and destroy calls.

Detected by CoverityScan, CID#1473305 ("Dereference after null check")

Fixes: b3ee105c332e ("staging: wilc1000: refactor code to move initilization in wilc_netdev_init()")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/wilc1000/linux_wlan.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/wilc1000/linux_wlan.c b/drivers/staging/wilc1000/linux_wlan.c
index a498321c908b..49afda669393 100644
--- a/drivers/staging/wilc1000/linux_wlan.c
+++ b/drivers/staging/wilc1000/linux_wlan.c
@@ -1015,15 +1015,18 @@ void wilc_netdev_cleanup(struct wilc *wilc)
 {
 	int i;
 
-	if (wilc && (wilc->vif[0]->ndev || wilc->vif[1]->ndev))
+	if (!wilc)
+		return;
+
+	if (wilc->vif[0]->ndev || wilc->vif[1]->ndev)
 		unregister_inetaddr_notifier(&g_dev_notifier);
 
-	if (wilc && wilc->firmware) {
+	if (wilc->firmware) {
 		release_firmware(wilc->firmware);
 		wilc->firmware = NULL;
 	}
 
-	if (wilc && (wilc->vif[0]->ndev || wilc->vif[1]->ndev)) {
+	if (wilc->vif[0]->ndev || wilc->vif[1]->ndev) {
 		for (i = 0; i < NUM_CONCURRENT_IFC; i++)
 			if (wilc->vif[i]->ndev)
 				if (wilc->vif[i]->mac_opened)
-- 
2.17.1

