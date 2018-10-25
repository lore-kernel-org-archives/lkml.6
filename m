Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F690ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9CA32083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zK8q5jgn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9CA32083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbeJYXIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 19:08:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:60102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729692AbeJYWuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:50:35 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 540672085A;
        Thu, 25 Oct 2018 14:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477058;
        bh=tlxkyPrLeyOUPfg2U6HghvcxflZaVsgDxO+ISGeUUJM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zK8q5jgnQ60fGNPHrSPxgoNV7CT1cbmm2fOq85MYIVaMStEPGCNTDaBZz2BexeeWW
         hm9ndtRBKc9Sqbzt+JtUjMYoxaJWD3YqdKBacX3vqJZd+ydsEPWdUzZroa33a9zBf9
         gLhZ/3p7c/djlympND7D8S4W9He0sqU0/TOovqv0=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 18/65] tpm: fix: return rc when devm_add_action() fails
Date:   Thu, 25 Oct 2018 10:16:18 -0400
Message-Id: <20181025141705.213937-18-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141705.213937-1-sashal@kernel.org>
References: <20181025141705.213937-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

[ Upstream commit 4f3b193dee4423d8c89c9a3e8e05f9197ea459a4 ]

Call put_device() and return error code if devm_add_action() fails.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Reported-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Fixes: 8e0ee3c9faed ("tpm: fix the cleanup of struct tpm_chip")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/tpm/tpm-chip.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index e759100e41a7..28894878dcd5 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -230,7 +230,11 @@ struct tpm_chip *tpmm_chip_alloc(struct device *dev,
 	chip->cdev.owner = dev->driver->owner;
 	chip->cdev.kobj.parent = &chip->dev.kobj;
 
-	devm_add_action(dev, (void (*)(void *)) put_device, &chip->dev);
+	rc = devm_add_action(dev, (void (*)(void *)) put_device, &chip->dev);
+	if (rc) {
+		put_device(&chip->dev);
+		return ERR_PTR(rc);
+	}
 
 	return chip;
 }
-- 
2.17.1

