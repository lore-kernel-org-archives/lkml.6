Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C25C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 11:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 105A32083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 11:58:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 105A32083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389025AbeHANoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 09:44:01 -0400
Received: from bran.ispras.ru ([83.149.199.196]:30454 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388699AbeHANoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 09:44:00 -0400
Received: from myklebust.intra.ispras.ru (unknown [10.10.2.207])
        by smtp.ispras.ru (Postfix) with ESMTP id E4AEF203CC;
        Wed,  1 Aug 2018 14:58:31 +0300 (MSK)
From:   Anton Vasilyev <vasilyev@ispras.ru>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Anton Vasilyev <vasilyev@ispras.ru>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sinan Kaya <okaya@codeaurora.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Gaurav Pathak <gauravpathak129@gmail.com>,
        Hannes Reinecke <hare@suse.de>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: [PATCH v5] staging: rts5208: add error handling into rtsx_probe
Date:   Wed,  1 Aug 2018 14:55:57 +0300
Message-Id: <20180801115557.7086-1-vasilyev@ispras.ru>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <CAHp75VfktnjL+G0vjHNHr=8mbDXu+4BDogsnxrp_2Bo4em=r2Q@mail.gmail.com>
References: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If rtsx_probe() fails to allocate dev->chip, then release_everything()
will crash on uninitialized dev->cmnd_ready complete.

Patch adds an error handling into rtsx_probe.
Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
---
v5: fix mistype and remove superfluous pointers zeroing
v4: rename labels baced on Dan Carpenter's recommendation
v3: fix subject and commit message
v2: Add error handling into rtsx_probe based on Dan Carpenter's comment.
I do not have corresponding hardware, so patch was tested by compilation only.

I faced with inaccuracy at rtsx_remove() and original rtsx_probe():
there is quiesce_and_remove_host() call with scsi_remove_host() inside,
whereas release_everything() calls scsi_host_put() after this
scsi_remove_host() call. This is strange for me.
Also I do not know is it require to check result value of
rtsx_init_chip() call on rtsx_probe().
---
 drivers/staging/rts5208/rtsx.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx.c b/drivers/staging/rts5208/rtsx.c
index 70e0b8623110..6a5c670634b1 100644
--- a/drivers/staging/rts5208/rtsx.c
+++ b/drivers/staging/rts5208/rtsx.c
@@ -879,7 +879,7 @@ static int rtsx_probe(struct pci_dev *pci,
 	if (!dev->remap_addr) {
 		dev_err(&pci->dev, "ioremap error\n");
 		err = -ENXIO;
-		goto errout;
+		goto err_chip_free;
 	}
 
 	/*
@@ -894,7 +894,7 @@ static int rtsx_probe(struct pci_dev *pci,
 	if (!dev->rtsx_resv_buf) {
 		dev_err(&pci->dev, "alloc dma buffer fail\n");
 		err = -ENXIO;
-		goto errout;
+		goto err_addr_unmap;
 	}
 	dev->chip->host_cmds_ptr = dev->rtsx_resv_buf;
 	dev->chip->host_cmds_addr = dev->rtsx_resv_buf_addr;
@@ -915,7 +915,7 @@ static int rtsx_probe(struct pci_dev *pci,
 
 	if (rtsx_acquire_irq(dev) < 0) {
 		err = -EBUSY;
-		goto errout;
+		goto err_disable_msi;
 	}
 
 	pci_set_master(pci);
@@ -935,14 +935,14 @@ static int rtsx_probe(struct pci_dev *pci,
 	if (IS_ERR(th)) {
 		dev_err(&pci->dev, "Unable to start control thread\n");
 		err = PTR_ERR(th);
-		goto errout;
+		goto err_rtsx_release;
 	}
 	dev->ctl_thread = th;
 
 	err = scsi_add_host(host, &pci->dev);
 	if (err) {
 		dev_err(&pci->dev, "Unable to add the scsi host\n");
-		goto errout;
+		goto err_complete_control_thread;
 	}
 
 	/* Start up the thread for delayed SCSI-device scanning */
@@ -950,18 +950,16 @@ static int rtsx_probe(struct pci_dev *pci,
 	if (IS_ERR(th)) {
 		dev_err(&pci->dev, "Unable to start the device-scanning thread\n");
 		complete(&dev->scanning_done);
-		quiesce_and_remove_host(dev);
 		err = PTR_ERR(th);
-		goto errout;
+		goto err_stop_host;
 	}
 
 	/* Start up the thread for polling thread */
 	th = kthread_run(rtsx_polling_thread, dev, "rtsx-polling");
 	if (IS_ERR(th)) {
 		dev_err(&pci->dev, "Unable to start the device-polling thread\n");
-		quiesce_and_remove_host(dev);
 		err = PTR_ERR(th);
-		goto errout;
+		goto err_stop_host;
 	}
 	dev->polling_thread = th;
 
@@ -970,9 +968,23 @@ static int rtsx_probe(struct pci_dev *pci,
 	return 0;
 
 	/* We come here if there are any problems */
+err_stop_host:
+	quiesce_and_remove_host(dev);
+err_complete_control_thread:
+	complete(&dev->cmnd_ready);
+	wait_for_completion(&dev->control_exit);
+err_rtsx_release:
+	free_irq(dev->irq, (void *)dev);
+	rtsx_release_chip(dev->chip);
+err_disable_msi:
+	if (dev->chip->msi_en)
+		pci_disable_msi(dev->pci);
+err_addr_unmap:
+	iounmap(dev->remap_addr);
+err_chip_free:
+	kfree(dev->chip);
 errout:
 	dev_err(&pci->dev, "%s failed\n", __func__);
-	release_everything(dev);
 
 	return err;
 }
-- 
2.18.0

