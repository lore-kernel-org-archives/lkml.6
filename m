Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8535EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53DAC20862
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zw73wdLq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53DAC20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbeK0EaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 23:30:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:58676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727230AbeK0EaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 23:30:21 -0500
Received: from localhost.localdomain (unknown [136.62.81.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CE1E2086E;
        Mon, 26 Nov 2018 17:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543253733;
        bh=8GoyMStWSG0K1oP7b3yoj0568x0DzW+5deCx3E/oU/c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zw73wdLq+CiS45UXUl/5OP09jxizFWdSXDuh2ncwBTjm2rBcqgQZ9QreCy3t6S5ZF
         OkkfWMnSrVUbFllnVV/6mtM4jq0Et85CcR3U/doeC3Fr0ycMIJEZVwCEuB6MT6jq7o
         zVfH8AeSWVeTXV6i39IWgOo2ZfGFfRgoLytuTk3A=
From:   Alan Tull <atull@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        Anatolij Gustschin <agust@denx.de>
Subject: [PATCH 1/2] fpga: altera-cvp: fix probing for multiple FPGAs on the bus
Date:   Mon, 26 Nov 2018 11:35:27 -0600
Message-Id: <1543253728-26542-2-git-send-email-atull@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543253728-26542-1-git-send-email-atull@kernel.org>
References: <1543253728-26542-1-git-send-email-atull@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anatolij Gustschin <agust@denx.de>

Currently registering CvP managers works only for first probed CvP
device, for all other devices it is refused due to duplicated chkcfg
sysfs entry:

fpga_manager fpga3: Altera CvP FPGA Manager @0000:0c:00.0 registered
sysfs: cannot create duplicate filename '/bus/pci/drivers/altera-cvp/chkcfg'
CPU: 0 PID: 3808 Comm: bash Tainted: G           O      4.19.0-custom+ #5
Call Trace:
  dump_stack+0x46/0x5b
  sysfs_warn_dup+0x53/0x60
  sysfs_add_file_mode_ns+0x16d/0x180
  sysfs_create_file_ns+0x51/0x60
  altera_cvp_probe+0x16f/0x2a0 [altera_cvp]
  local_pci_probe+0x3f/0xa0
  ? pci_match_device+0xb1/0xf0
  pci_device_probe+0x116/0x170
  really_probe+0x21b/0x2c0
  driver_probe_device+0x4b/0xe0
  bind_store+0xcb/0x130
  kernfs_fop_write+0xfd/0x180
  __vfs_write+0x21/0x150
  ? selinux_file_permission+0xdc/0x130
  vfs_write+0xa8/0x1a0
  ? find_vma+0xd/0x60
  ksys_write+0x3d/0x90
  do_syscall_64+0x44/0xf0
  entry_SYSCALL_64_after_hwframe+0x44/0xa9
  ...
 altera-cvp 0000:0c:00.0: Can't create sysfs chkcfg file
 fpga_manager fpga3: fpga_mgr_unregister Altera CvP FPGA Manager @0000:0c:00.0

Move chkcfg creation to module init as suggested by Alan.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
Acked-by: Alan Tull <atull@kernel.org>
---
 drivers/fpga/altera-cvp.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index 7395085..35c3aa5 100644
--- a/drivers/fpga/altera-cvp.c
+++ b/drivers/fpga/altera-cvp.c
@@ -475,14 +475,6 @@ static int altera_cvp_probe(struct pci_dev *pdev,
 	if (ret)
 		goto err_unmap;
 
-	ret = driver_create_file(&altera_cvp_driver.driver,
-				 &driver_attr_chkcfg);
-	if (ret) {
-		dev_err(&pdev->dev, "Can't create sysfs chkcfg file\n");
-		fpga_mgr_unregister(mgr);
-		goto err_unmap;
-	}
-
 	return 0;
 
 err_unmap:
@@ -501,7 +493,6 @@ static void altera_cvp_remove(struct pci_dev *pdev)
 	struct altera_cvp_conf *conf = mgr->priv;
 	u16 cmd;
 
-	driver_remove_file(&altera_cvp_driver.driver, &driver_attr_chkcfg);
 	fpga_mgr_unregister(mgr);
 	if (conf->map)
 		pci_iounmap(pdev, conf->map);
@@ -511,7 +502,30 @@ static void altera_cvp_remove(struct pci_dev *pdev)
 	pci_write_config_word(pdev, PCI_COMMAND, cmd);
 }
 
-module_pci_driver(altera_cvp_driver);
+static int __init altera_cvp_init(void)
+{
+	int ret;
+
+	ret = pci_register_driver(&altera_cvp_driver);
+	if (ret)
+		return ret;
+
+	ret = driver_create_file(&altera_cvp_driver.driver,
+				 &driver_attr_chkcfg);
+	if (ret)
+		pr_warn("Can't create sysfs chkcfg file\n");
+
+	return 0;
+}
+
+static void __exit altera_cvp_exit(void)
+{
+	driver_remove_file(&altera_cvp_driver.driver, &driver_attr_chkcfg);
+	pci_unregister_driver(&altera_cvp_driver);
+}
+
+module_init(altera_cvp_init);
+module_exit(altera_cvp_exit);
 
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Anatolij Gustschin <agust@denx.de>");
-- 
2.7.4

