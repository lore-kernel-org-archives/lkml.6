Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 936C3C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CAC6206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546977298;
	bh=y9fdjQkjE9+c7DaqTjZtjZlUqNLD3HLgD3TVbXbmaKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QF5naq7PPpOv1qZDilXP1iRzCS1bNl/3ZNOxOOlEKm8pRYwuww6jPFCm1vaQ13DWD
	 cHvKtOExkvQwvE+f0rXgI71TWtIiVo4rVU7skrwi4QfhKG/9hv6zjbUQ42BsphNq1a
	 sxzCpxulygh7dSmk5qJMBEeF3pfJUGTj6MAre2O4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732984AbfAHTy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:54:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:38216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730768AbfAHTa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:30:27 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F49520883;
        Tue,  8 Jan 2019 19:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975826;
        bh=y9fdjQkjE9+c7DaqTjZtjZlUqNLD3HLgD3TVbXbmaKE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HuJQKAHa0DR351EDtHF2zQ+D/7XdrwdTvK6zXvZYBIEguzjciFi01J7YRYZU0w4CO
         w/RNsaDsIG9woxaxi8MCV8uMaUE9SbuKnaijKp28Ol8ce8UDtSp+90w+Wsz9hvzYdp
         7S7EMmPPKlaBG8od/SIxDURUI89OzEvTftY5LmWk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Anatolij Gustschin <agust@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-fpga@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 24/97] fpga: altera-cvp: fix probing for multiple FPGAs on the bus
Date:   Tue,  8 Jan 2019 14:28:33 -0500
Message-Id: <20190108192949.122407-24-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192949.122407-1-sashal@kernel.org>
References: <20190108192949.122407-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anatolij Gustschin <agust@denx.de>

[ Upstream commit 30522a951f9d02f261d0697c35cb42205b1fae17 ]

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/fpga/altera-cvp.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index 7fa793672a7a..68e4b2b98c8f 100644
--- a/drivers/fpga/altera-cvp.c
+++ b/drivers/fpga/altera-cvp.c
@@ -468,14 +468,6 @@ static int altera_cvp_probe(struct pci_dev *pdev,
 		goto err_unmap;
 	}
 
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
@@ -493,7 +485,6 @@ static void altera_cvp_remove(struct pci_dev *pdev)
 	struct altera_cvp_conf *conf = mgr->priv;
 	u16 cmd;
 
-	driver_remove_file(&altera_cvp_driver.driver, &driver_attr_chkcfg);
 	fpga_mgr_unregister(mgr);
 	pci_iounmap(pdev, conf->map);
 	pci_release_region(pdev, CVP_BAR);
@@ -502,7 +493,30 @@ static void altera_cvp_remove(struct pci_dev *pdev)
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
2.19.1

