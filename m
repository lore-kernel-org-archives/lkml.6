Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 38A03C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 05:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A22A820891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 05:20:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A22A820891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754480AbeFMFUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 01:20:18 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:46691 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754430AbeFMFUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 01:20:17 -0400
X-IronPort-AV: E=Sophos;i="5.51,217,1526335200"; 
   d="scan'208";a="331558471"
Received: from palace.lip6.fr (HELO localhost.localdomain) ([132.227.105.202])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES128-SHA256; 13 Jun 2018 07:20:15 +0200
From:   Julia Lawall <Julia.Lawall@lip6.fr>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: kempld-core: constify variables that point to const structure
Date:   Wed, 13 Jun 2018 06:48:09 +0200
Message-Id: <1528865289-3875-1-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add const to the declaration of various local variables of type
kempld_platform_data for which the referenced value is always only
dereferenced or passed to a const parameter, to record the fact that
kempld_platform_data_generic is declared as const.

The semantic match that finds this issue is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@r@
identifier i,j;
@@
const struct i j = { ... };

@ok@
identifier r.i;
position p;
@@
const struct i@p *

@@
identifier r.i;
position p != ok.p;
@@
* struct i@p *
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/mfd/kempld-core.c |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/mfd/kempld-core.c b/drivers/mfd/kempld-core.c
index 390b27c..fb5a10b 100644
--- a/drivers/mfd/kempld-core.c
+++ b/drivers/mfd/kempld-core.c
@@ -143,7 +143,7 @@ static int kempld_register_cells_generic(struct kempld_device_data *pld)
 
 static int kempld_create_platform_device(const struct dmi_system_id *id)
 {
-	struct kempld_platform_data *pdata = id->driver_data;
+	const struct kempld_platform_data *pdata = id->driver_data;
 	int ret;
 
 	kempld_pdev = platform_device_alloc("kempld", -1);
@@ -259,7 +259,7 @@ void kempld_write32(struct kempld_device_data *pld, u8 index, u32 data)
  */
 void kempld_get_mutex(struct kempld_device_data *pld)
 {
-	struct kempld_platform_data *pdata = dev_get_platdata(pld->dev);
+	const struct kempld_platform_data *pdata = dev_get_platdata(pld->dev);
 
 	mutex_lock(&pld->lock);
 	pdata->get_hardware_mutex(pld);
@@ -272,7 +272,7 @@ void kempld_get_mutex(struct kempld_device_data *pld)
  */
 void kempld_release_mutex(struct kempld_device_data *pld)
 {
-	struct kempld_platform_data *pdata = dev_get_platdata(pld->dev);
+	const struct kempld_platform_data *pdata = dev_get_platdata(pld->dev);
 
 	pdata->release_hardware_mutex(pld);
 	mutex_unlock(&pld->lock);
@@ -290,7 +290,7 @@ void kempld_release_mutex(struct kempld_device_data *pld)
 static int kempld_get_info(struct kempld_device_data *pld)
 {
 	int ret;
-	struct kempld_platform_data *pdata = dev_get_platdata(pld->dev);
+	const struct kempld_platform_data *pdata = dev_get_platdata(pld->dev);
 	char major, minor;
 
 	ret = pdata->get_info(pld);
@@ -332,7 +332,7 @@ static int kempld_get_info(struct kempld_device_data *pld)
  */
 static int kempld_register_cells(struct kempld_device_data *pld)
 {
-	struct kempld_platform_data *pdata = dev_get_platdata(pld->dev);
+	const struct kempld_platform_data *pdata = dev_get_platdata(pld->dev);
 
 	return pdata->register_cells(pld);
 }
@@ -444,7 +444,8 @@ static int kempld_detect_device(struct kempld_device_data *pld)
 
 static int kempld_probe(struct platform_device *pdev)
 {
-	struct kempld_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	const struct kempld_platform_data *pdata =
+		dev_get_platdata(&pdev->dev);
 	struct device *dev = &pdev->dev;
 	struct kempld_device_data *pld;
 	struct resource *ioport;
@@ -476,7 +477,7 @@ static int kempld_probe(struct platform_device *pdev)
 static int kempld_remove(struct platform_device *pdev)
 {
 	struct kempld_device_data *pld = platform_get_drvdata(pdev);
-	struct kempld_platform_data *pdata = dev_get_platdata(pld->dev);
+	const struct kempld_platform_data *pdata = dev_get_platdata(pld->dev);
 
 	sysfs_remove_group(&pld->dev->kobj, &pld_attr_group);
 

