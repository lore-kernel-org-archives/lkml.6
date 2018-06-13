Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7C676C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 17:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D421208D4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 17:35:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D421208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935474AbeFMRfC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 13:35:02 -0400
Received: from bran.ispras.ru ([83.149.199.196]:22881 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934979AbeFMRfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 13:35:00 -0400
Received: from myklebust.intra.ispras.ru (unknown [10.10.2.207])
        by smtp.ispras.ru (Postfix) with ESMTP id EF82F203CD;
        Wed, 13 Jun 2018 12:08:06 +0300 (MSK)
From:   Anton Vasilyev <vasilyev@ispras.ru>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Anton Vasilyev <vasilyev@ispras.ru>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Gaurav Pathak <gauravpathak129@gmail.com>,
        Hannes Reinecke <hare@suse.de>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: [PATCH v3] staging: rts5208: add error handling into rtsx_probe
Date:   Wed, 13 Jun 2018 20:34:43 +0300
Message-Id: <20180613173443.32488-1-vasilyev@ispras.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAHp75VetOuS+H4GU9UW-Ekczs22-Ju++jXWdvkMJGktbumDzwQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If rtsx_probe() fails to allocate dev->chip, then release_everything()
will crash on uninitialized dev->cmnd_ready complete.

Patch adds error handling into rtsx_probe.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
---
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
 drivers/staging/rts5208/rtsx.c | 38 +++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx.c b/drivers/staging/rts5208/rtsx.c
index 70e0b8623110..69e6abe14abf 100644
--- a/drivers/staging/rts5208/rtsx.c
+++ b/drivers/staging/rts5208/rtsx.c
@@ -857,7 +857,7 @@ static int rtsx_probe(struct pci_dev *pci,
 	dev->chip = kzalloc(sizeof(*dev->chip), GFP_KERNEL);
 	if (!dev->chip) {
 		err = -ENOMEM;
-		goto errout;
+		goto chip_alloc_fail;
 	}
 
 	spin_lock_init(&dev->reg_lock);
@@ -879,7 +879,7 @@ static int rtsx_probe(struct pci_dev *pci,
 	if (!dev->remap_addr) {
 		dev_err(&pci->dev, "ioremap error\n");
 		err = -ENXIO;
-		goto errout;
+		goto ioremap_fail;
 	}
 
 	/*
@@ -894,7 +894,7 @@ static int rtsx_probe(struct pci_dev *pci,
 	if (!dev->rtsx_resv_buf) {
 		dev_err(&pci->dev, "alloc dma buffer fail\n");
 		err = -ENXIO;
-		goto errout;
+		goto dma_alloc_fail;
 	}
 	dev->chip->host_cmds_ptr = dev->rtsx_resv_buf;
 	dev->chip->host_cmds_addr = dev->rtsx_resv_buf_addr;
@@ -915,7 +915,7 @@ static int rtsx_probe(struct pci_dev *pci,
 
 	if (rtsx_acquire_irq(dev) < 0) {
 		err = -EBUSY;
-		goto errout;
+		goto irq_acquire_fail;
 	}
 
 	pci_set_master(pci);
@@ -935,14 +935,14 @@ static int rtsx_probe(struct pci_dev *pci,
 	if (IS_ERR(th)) {
 		dev_err(&pci->dev, "Unable to start control thread\n");
 		err = PTR_ERR(th);
-		goto errout;
+		goto control_thread_fail;
 	}
 	dev->ctl_thread = th;
 
 	err = scsi_add_host(host, &pci->dev);
 	if (err) {
 		dev_err(&pci->dev, "Unable to add the scsi host\n");
-		goto errout;
+		goto scsi_add_host_fail;
 	}
 
 	/* Start up the thread for delayed SCSI-device scanning */
@@ -950,18 +950,16 @@ static int rtsx_probe(struct pci_dev *pci,
 	if (IS_ERR(th)) {
 		dev_err(&pci->dev, "Unable to start the device-scanning thread\n");
 		complete(&dev->scanning_done);
-		quiesce_and_remove_host(dev);
 		err = PTR_ERR(th);
-		goto errout;
+		goto scan_thread_fail;
 	}
 
 	/* Start up the thread for polling thread */
 	th = kthread_run(rtsx_polling_thread, dev, "rtsx-polling");
 	if (IS_ERR(th)) {
 		dev_err(&pci->dev, "Unable to start the device-polling thread\n");
-		quiesce_and_remove_host(dev);
 		err = PTR_ERR(th);
-		goto errout;
+		goto scan_thread_fail;
 	}
 	dev->polling_thread = th;
 
@@ -970,9 +968,25 @@ static int rtsx_probe(struct pci_dev *pci,
 	return 0;
 
 	/* We come here if there are any problems */
-errout:
+scan_thread_fail:
+	quiesce_and_remove_host(dev);
+scsi_add_host_fail:
+	complete(&dev->cmnd_ready);
+	wait_for_completion(&dev->control_exit);
+control_thread_fail:
+	free_irq(dev->irq, (void *)dev);
+	rtsx_release_chip(dev->chip);
+irq_acquire_fail:
+	dev->chip->host_cmds_ptr = NULL;
+	dev->chip->host_sg_tbl_ptr = NULL;
+	if (dev->chip->msi_en)
+		pci_disable_msi(dev->pci);
+dma_alloc_fail:
+	iounmap(dev->remap_addr);
+ioremap_fail:
+	kfree(dev->chip);
+chip_alloc_fail:
 	dev_err(&pci->dev, "%s failed\n", __func__);
-	release_everything(dev);
 
 	return err;
 }
-- 
2.17.1

