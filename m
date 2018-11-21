Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D91C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 449F121479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:12:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 449F121479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731141AbeKVBrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 20:47:46 -0500
Received: from www.osadl.org ([62.245.132.105]:40127 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726849AbeKVBrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 20:47:46 -0500
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id wALFBPGA000596;
        Wed, 21 Nov 2018 16:11:25 +0100
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Corey Minyard <minyard@acm.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] ipmi: kcs_bmc: handle devm_kasprintf() failure case
Date:   Wed, 21 Nov 2018 16:08:25 +0100
Message-Id: <1542812905-27337-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_kasprintf() may return NULL if internal allocation failed so this
assignment is not safe. Moved the error exit path and added the !NULL
which then allows the devres manager to take care of cleanup.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: cd2315d471f4 ("ipmi: kcs_bmc: don't change device name")
---

Problem located with experimental coccinelle script

Patch was compile tested with: aspeed_g5_defconfig (implies
CONFIG_IPMI_KCS_BMC=y)

Patch is against 4.20-rc3 (localversion-next is next-20181121)

 drivers/char/ipmi/kcs_bmc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/char/ipmi/kcs_bmc.c b/drivers/char/ipmi/kcs_bmc.c
index e6124bd..86d29d2 100644
--- a/drivers/char/ipmi/kcs_bmc.c
+++ b/drivers/char/ipmi/kcs_bmc.c
@@ -440,12 +440,13 @@ struct kcs_bmc *kcs_bmc_alloc(struct device *dev, int sizeof_priv, u32 channel)
 	kcs_bmc->data_in = devm_kmalloc(dev, KCS_MSG_BUFSIZ, GFP_KERNEL);
 	kcs_bmc->data_out = devm_kmalloc(dev, KCS_MSG_BUFSIZ, GFP_KERNEL);
 	kcs_bmc->kbuffer = devm_kmalloc(dev, KCS_MSG_BUFSIZ, GFP_KERNEL);
-	if (!kcs_bmc->data_in || !kcs_bmc->data_out || !kcs_bmc->kbuffer)
-		return NULL;
 
 	kcs_bmc->miscdev.minor = MISC_DYNAMIC_MINOR;
 	kcs_bmc->miscdev.name = devm_kasprintf(dev, GFP_KERNEL, "%s%u",
 					       DEVICE_NAME, channel);
+	if (!kcs_bmc->data_in || !kcs_bmc->data_out || !kcs_bmc->kbuffer ||
+	    !kcs_bmc->miscdev.name)
+		return NULL;
 	kcs_bmc->miscdev.fops = &kcs_bmc_fops;
 
 	return kcs_bmc;
-- 
2.1.4

