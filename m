Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F81BC04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 10:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF82B2146F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 10:05:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF82B2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbeLAVR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 16:17:29 -0500
Received: from www.osadl.org ([62.245.132.105]:50802 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726342AbeLAVR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 16:17:29 -0500
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id wB1A49Qa015563;
        Sat, 1 Dec 2018 11:04:09 +0100
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] i2c: mux: demux-pinctrl: handle failure case of devm_kstrdup()
Date:   Sat,  1 Dec 2018 11:01:10 +0100
Message-Id: <1543658470-20887-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_kstrdup() may return NULL if internal allocation failed.
Thus using  name, value  is unsafe without being checked. As
i2c_demux_pinctrl_probe() can return -ENOMEM in other cases
a dev_err() message is included to make the failure location
clear.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: e35478eac030 ("i2c: mux: demux-pinctrl: run properly with multiple instances")
---

Problem located with experimental coccinelle script

Q: The use of devm_kstrdup() seems a bit odd while technically not wrong,
   personally I think devm_kasprintf() would be more suitable here.

Patch was compile tested with: multi_v7_defconfig 
(implies I2C_DEMUX_PINCTRL=y)

Patch is against 4.20-rc4 (localversion-next is next-20181130)

 drivers/i2c/muxes/i2c-demux-pinctrl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/i2c/muxes/i2c-demux-pinctrl.c b/drivers/i2c/muxes/i2c-demux-pinctrl.c
index 035032e..c466999 100644
--- a/drivers/i2c/muxes/i2c-demux-pinctrl.c
+++ b/drivers/i2c/muxes/i2c-demux-pinctrl.c
@@ -244,6 +244,12 @@ static int i2c_demux_pinctrl_probe(struct platform_device *pdev)
 
 		props[i].name = devm_kstrdup(&pdev->dev, "status", GFP_KERNEL);
 		props[i].value = devm_kstrdup(&pdev->dev, "ok", GFP_KERNEL);
+		if (!props[i].name || !props[i].value) {
+			dev_err(&pdev->dev,
+				"chan %d name, value allocation failed\n", i);
+			err = -ENOMEM;
+			goto err_rollback;
+		}
 		props[i].length = 3;
 
 		of_changeset_init(&priv->chan[i].chgset);
-- 
2.1.4

