Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF82C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B57221855
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="XDBBNqhm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbfAXP5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 10:57:21 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:1859 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728040AbfAXP5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 10:57:18 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c49e04c0000>; Thu, 24 Jan 2019 07:57:00 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 24 Jan 2019 07:57:18 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 24 Jan 2019 07:57:18 -0800
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 24 Jan
 2019 15:57:17 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Thu, 24 Jan 2019 15:57:17 +0000
Received: from linux.nvidia.com (Not Verified[10.24.34.185]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c49e05b0001>; Thu, 24 Jan 2019 07:57:16 -0800
From:   Sameer Pujar <spujar@nvidia.com>
To:     <perex@perex.cz>, <tiwai@suse.com>, <abhijeet.kumar@intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH] ALSA: hda: runtime PM is always active
Date:   Thu, 24 Jan 2019 21:27:11 +0530
Message-ID: <1548345432-11449-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548345420; bh=CCA1d88wlyttE+e3sWAPxmr4Xqb9QTlnFNTfOPlmE08=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:Content-Type;
        b=XDBBNqhmiL+ivMMiF029x2o9PHH0S+hPapcQK2xo/0CEhPPLUG+dsJ4j43WOO10kT
         6DVV/BWV6WYpxINDz43/LyvuRQmhH61zLRahToWNBjLiFu8o0CE/2a6SSSOL4IHpmM
         Yc5UwYgPtEx/h9pp70/WPrZYSPzzTXqJRLFIQ0ad7yMlv10ACr0/75tjV2C5mezWCP
         wjw24xZHUw2qSBLS1lsG6RuoWQjjKdPNgdW7vGD9Ze3s/AuHDx6+qCBxlRot1qGQVf
         DidHOg8GKVHtbAv26vue9CX5K5YS5TuEFqrRH6tIcwsL/cJvpBFNva8NgTcnILfuux
         /E5bv62HAooUw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The runtime PM count is incremented and set to active during hda codec
device init, but it is decremented and set to suspend during exit only.
Hence the runtime PM status is always active and hda device cannot be
put to runtime suspend. Keeping device usage active for entire period,
though nothing really happening on the device, seems unnecessary.

This patch avoides incrementing runtime PM usage count of the device.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
Reviewed-by: Ravindra Lokhande <rlokhande@nvidia.com>
Reviewed-by: Mohan Kumar D <mkumard@nvidia.com>
---
 sound/hda/hdac_device.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/hda/hdac_device.c b/sound/hda/hdac_device.c
index 95b073e..72aa342 100644
--- a/sound/hda/hdac_device.c
+++ b/sound/hda/hdac_device.c
@@ -31,9 +31,6 @@ static void default_release(struct device *dev)
  *
  * Returns zero for success or a negative error code.
  *
- * This function increments the runtime PM counter and marks it active.
- * The caller needs to turn it off appropriately later.
- *
  * The caller needs to set the device's release op properly by itself.
  */
 int snd_hdac_device_init(struct hdac_device *codec, struct hdac_bus *bus,
@@ -55,8 +52,6 @@ int snd_hdac_device_init(struct hdac_device *codec, struct hdac_bus *bus,
 	codec->bus = bus;
 	codec->addr = addr;
 	codec->type = HDA_DEV_CORE;
-	pm_runtime_set_active(&codec->dev);
-	pm_runtime_get_noresume(&codec->dev);
 	atomic_set(&codec->in_pm, 0);
 
 	err = snd_hdac_bus_add_device(bus, codec);
@@ -123,7 +118,6 @@ EXPORT_SYMBOL_GPL(snd_hdac_device_init);
  */
 void snd_hdac_device_exit(struct hdac_device *codec)
 {
-	pm_runtime_put_noidle(&codec->dev);
 	snd_hdac_bus_remove_device(codec->bus, codec);
 	kfree(codec->vendor_name);
 	kfree(codec->chip_name);
-- 
2.7.4

