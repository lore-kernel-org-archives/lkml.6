Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DA6C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35AA5218D9
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358943;
	bh=kdFyAp5g3lGGkCspYJb13cx2eWwfPUhO5UoRLys4JII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0xYdpQzoWHbSdiMAStygso4ek3KMp2evC9Rx1ue+Bhn5u6Qdvxz3EqWZf5+bhfEdh
	 9AZdilwp269tNLP4+JTH9iuYn8PC6JwPdAuCCOpsyfuC/n4X7tLqv++dEdLPJledQy
	 Oi9XdS4L2oZmGkuvJW5fIEFk6oPI17NPwpY3DDfY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387765AbfAXTmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:42:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:42648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387741AbfAXTmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:42:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F28B3218D9;
        Thu, 24 Jan 2019 19:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358931;
        bh=kdFyAp5g3lGGkCspYJb13cx2eWwfPUhO5UoRLys4JII=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rWzPwKthlfj0ArMj85i8Cwa4EO8dKFY6Mh4Aul1hS5ZEY3et18xK1irAu+/am85CF
         FzgUHoCHPWOlbNCx4C10KDDULO3v25wBC1V32yWfX46Ciw65VoF8Ru0Truzw9KNBjx
         M2P5MYO/e6hV6pJXV+1s4fBsNBWMfIxYy9HqNIyQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anatolij Gustschin <agust@denx.de>,
        Alan Tull <atull@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 042/127] fpga: altera-cvp: fix probing for multiple FPGAs on the bus
Date:   Thu, 24 Jan 2019 20:19:48 +0100
Message-Id: <20190124190214.063749243@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190211.984305387@linuxfoundation.org>
References: <20190124190211.984305387@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 610a1558e0ed..d9fa7d4bf11f 100644
--- a/drivers/fpga/altera-cvp.c
+++ b/drivers/fpga/altera-cvp.c
@@ -466,14 +466,6 @@ static int altera_cvp_probe(struct pci_dev *pdev,
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
@@ -491,7 +483,6 @@ static void altera_cvp_remove(struct pci_dev *pdev)
 	struct altera_cvp_conf *conf = mgr->priv;
 	u16 cmd;
 
-	driver_remove_file(&altera_cvp_driver.driver, &driver_attr_chkcfg);
 	fpga_mgr_unregister(mgr);
 	pci_iounmap(pdev, conf->map);
 	pci_release_region(pdev, CVP_BAR);
@@ -500,7 +491,30 @@ static void altera_cvp_remove(struct pci_dev *pdev)
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



