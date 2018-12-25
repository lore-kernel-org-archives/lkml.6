Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1BEC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 07:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29F332229E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 07:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbeLYHO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 02:14:29 -0500
Received: from mail.windriver.com ([147.11.1.11]:50579 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbeLYHO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 02:14:28 -0500
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id wBP7EEuq016203
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Mon, 24 Dec 2018 23:14:14 -0800 (PST)
Received: from pek-lpggp3.wrs.com (128.224.153.76) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.408.0; Mon, 24 Dec 2018
 23:14:14 -0800
From:   Liwei Song <liwei.song@windriver.com>
To:     Boris <bp@alien8.de>, Mauro <mchehab@kernel.org>
CC:     <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <liwei.song@windriver.com>
Subject: [PATCH] edac: unregister the mci device before free the mci memory
Date:   Tue, 25 Dec 2018 02:13:04 -0500
Message-ID: <1545721984-183750-1-git-send-email-liwei.song@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this patch can fix the following kmemleak:

unreferenced object 0xffff881022b60ee0 (size 32):
  comm "udevd", pid 262, jiffies 4294709066 (age 1410.265s)
  hex dump (first 32 bytes):
    00 7c e8 18 10 88 ff ff 00 74 e8 18 10 88 ff ff .|.......t......
    00 70 e8 18 10 88 ff ff 00 00 00 00 00 00 00 00 .p..............
  backtrace:
    [<ffffffff819814b6>] kmemleak_alloc+0x26/0x50
    [<ffffffff8115b194>] __kmalloc+0x154/0x2f0
    [<ffffffff817ca848>] edac_mc_alloc+0x278/0x6d0
    [<ffffffffa0106f9d>] 0xffffffffa0106f9d
    [<ffffffff8140c9ae>] local_pci_probe+0x3e/0x70
    [<ffffffff8140cbb1>] pci_device_probe+0x121/0x130
    [<ffffffff8155be85>] driver_probe_device+0x105/0x260
    [<ffffffff8155c0b3>] __driver_attach+0x93/0xa0
    [<ffffffff81559ed3>] bus_for_each_dev+0x63/0xa0
    [<ffffffff8155b90e>] driver_attach+0x1e/0x20
    [<ffffffff8155b500>] bus_add_driver+0x1f0/0x290
    [<ffffffff8155c6e4>] driver_register+0x64/0xf0
    [<ffffffff8140c81c>] __pci_register_driver+0x4c/0x50
    [<ffffffffa010d050>] 0xffffffffa010d050
    [<ffffffff810002d2>] do_one_initcall+0x102/0x160
    [<ffffffff810a25e5>] load_module+0x1a65/0x2230

The kmemleak happened when run "rmmod sb_edac.ko".
In edac_mc_free, only after mci device is ungistered, it will do the mci
free task, or it will do the mci unregister action, adjust the sequence
of the free task to ungister the device first and then free the mci
struct, then all memory allocated(Include dimms, csrows, channels)by
edac_mc_alloc() will got freed by edac_mc_free();

Because all allocated memory was freed by edac_mc_free() and the release
hook in edac_mc_sysfs.c can not release all allocated memory of EDAC MC,
so remove the free fragment from it to aviod duplicated memory free.

Signed-off-by: Liwei Song <liwei.song@windriver.com>
---
 drivers/edac/edac_mc.c       |  7 ++++---
 drivers/edac/edac_mc_sysfs.c | 12 ------------
 2 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 7d3edd713932..12d9dc9cf85e 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -506,6 +506,10 @@ void edac_mc_free(struct mem_ctl_info *mci)
 {
 	edac_dbg(1, "\n");
 
+	/* the mci instance is freed here, when the sysfs object is dropped */
+	if (device_is_registered(&mci->dev))
+		edac_unregister_sysfs(mci);
+
 	/* If we're not yet registered with sysfs free only what was allocated
 	 * in edac_mc_alloc().
 	 */
@@ -513,9 +517,6 @@ void edac_mc_free(struct mem_ctl_info *mci)
 		_edac_mc_free(mci);
 		return;
 	}
-
-	/* the mci instance is freed here, when the sysfs object is dropped */
-	edac_unregister_sysfs(mci);
 }
 EXPORT_SYMBOL_GPL(edac_mc_free);
 
diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
index 20374b8248f0..20211b4ee2f1 100644
--- a/drivers/edac/edac_mc_sysfs.c
+++ b/drivers/edac/edac_mc_sysfs.c
@@ -276,10 +276,6 @@ static const struct attribute_group *csrow_attr_groups[] = {
 
 static void csrow_attr_release(struct device *dev)
 {
-	struct csrow_info *csrow = container_of(dev, struct csrow_info, dev);
-
-	edac_dbg(1, "Releasing csrow device %s\n", dev_name(dev));
-	kfree(csrow);
 }
 
 static const struct device_type csrow_attr_type = {
@@ -616,10 +612,6 @@ static const struct attribute_group *dimm_attr_groups[] = {
 
 static void dimm_attr_release(struct device *dev)
 {
-	struct dimm_info *dimm = container_of(dev, struct dimm_info, dev);
-
-	edac_dbg(1, "Releasing dimm device %s\n", dev_name(dev));
-	kfree(dimm);
 }
 
 static const struct device_type dimm_attr_type = {
@@ -892,10 +884,6 @@ static const struct attribute_group *mci_attr_groups[] = {
 
 static void mci_attr_release(struct device *dev)
 {
-	struct mem_ctl_info *mci = container_of(dev, struct mem_ctl_info, dev);
-
-	edac_dbg(1, "Releasing csrow device %s\n", dev_name(dev));
-	kfree(mci);
 }
 
 static const struct device_type mci_attr_type = {
-- 
2.7.4

