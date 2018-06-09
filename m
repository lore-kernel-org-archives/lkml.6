Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ZXSBJWADHFvAcAAAmS7hNA
	; Sat, 09 Jun 2018 16:44:20 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id DF29C608C1; Sat,  9 Jun 2018 16:44:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 79255605A2;
	Sat,  9 Jun 2018 16:44:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 79255605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=ispras.ru
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753437AbeFIQoP (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 12:44:15 -0400
Received: from bran.ispras.ru ([83.149.199.196]:23747 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753357AbeFIQoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 12:44:14 -0400
X-Greylist: delayed 320 seconds by postgrey-1.27 at vger.kernel.org; Sat, 09 Jun 2018 12:44:14 EDT
Received: from myklebust.intra.ispras.ru (unknown [10.10.2.207])
        by smtp.ispras.ru (Postfix) with ESMTP id 56976203BF;
        Sat,  9 Jun 2018 11:11:59 +0300 (MSK)
From: Anton Vasilyev <vasilyev@ispras.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Anton Vasilyev <vasilyev@ispras.ru>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Gaurav Pathak <gauravpathak129@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        Sinan Kaya <okaya@codeaurora.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: [PATCH] staging: rts5208: add check on NULL before dereference
Date: Sat,  9 Jun 2018 19:38:29 +0300
Message-Id: <20180609163829.30619-1-vasilyev@ispras.ru>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If rtsx_probe fails to allocate dev->chip, then NULL pointer
dereference occurs at rtsx_release_resources().

Patch adds checks chip on NULL before its dereference at
rtsx_release_resources and passing with dereference inside
rtsx_release_chip.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
---
 drivers/staging/rts5208/rtsx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx.c b/drivers/staging/rts5208/rtsx.c
index 70e0b8623110..952dd0d580cf 100644
--- a/drivers/staging/rts5208/rtsx.c
+++ b/drivers/staging/rts5208/rtsx.c
@@ -623,12 +623,13 @@ static void rtsx_release_resources(struct rtsx_dev *dev)
 
 	if (dev->irq > 0)
 		free_irq(dev->irq, (void *)dev);
-	if (dev->chip->msi_en)
+	if (dev->chip && dev->chip->msi_en)
 		pci_disable_msi(dev->pci);
 	if (dev->remap_addr)
 		iounmap(dev->remap_addr);
+	if (dev->chip)
+		rtsx_release_chip(dev->chip);
 
-	rtsx_release_chip(dev->chip);
 	kfree(dev->chip);
 }
 
-- 
2.17.1
