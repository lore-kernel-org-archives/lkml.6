Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7C4C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0240208B0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:45:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0240208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388791AbeG0RIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 13:08:17 -0400
Received: from bran.ispras.ru ([83.149.199.196]:11131 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732981AbeG0RIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 13:08:17 -0400
Received: from myklebust.intra.ispras.ru (unknown [10.10.2.207])
        by smtp.ispras.ru (Postfix) with ESMTP id 2CE39203B2;
        Fri, 27 Jul 2018 18:45:46 +0300 (MSK)
From:   Anton Vasilyev <vasilyev@ispras.ru>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Anton Vasilyev <vasilyev@ispras.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: [PATCH] misc: ti-st: Fix memory leak in the error path of probe()
Date:   Fri, 27 Jul 2018 18:45:36 +0300
Message-Id: <20180727154536.24316-1-vasilyev@ispras.ru>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Free resources instead of direct return of the error code if kim_probe
fails.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
---
 drivers/misc/ti-st/st_kim.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/ti-st/st_kim.c b/drivers/misc/ti-st/st_kim.c
index 5ec3f5a43718..14a5e9da32bd 100644
--- a/drivers/misc/ti-st/st_kim.c
+++ b/drivers/misc/ti-st/st_kim.c
@@ -756,14 +756,14 @@ static int kim_probe(struct platform_device *pdev)
 	err = gpio_request(kim_gdata->nshutdown, "kim");
 	if (unlikely(err)) {
 		pr_err(" gpio %d request failed ", kim_gdata->nshutdown);
-		return err;
+		goto err_sysfs_group;
 	}
 
 	/* Configure nShutdown GPIO as output=0 */
 	err = gpio_direction_output(kim_gdata->nshutdown, 0);
 	if (unlikely(err)) {
 		pr_err(" unable to configure gpio %d", kim_gdata->nshutdown);
-		return err;
+		goto err_sysfs_group;
 	}
 	/* get reference of pdev for request_firmware
 	 */
-- 
2.18.0

