Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37333C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 181E921773
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbfBTQmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 11:42:08 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:59226 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfBTQmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 11:42:06 -0500
Received: from [194.204.107.10] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <aaron.ma@canonical.com>)
        id 1gwUwe-0002E2-Bw; Wed, 20 Feb 2019 16:42:04 +0000
From:   Aaron Ma <aaron.ma@canonical.com>
To:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Cheiny@synaptics.com,
        aduggan@synaptics.com, benjamin.tissoires@redhat.com,
        aaron.ma@canonical.com
Subject: [PATCH 1/2] Input: synaptics-rmi4 - clear irqs before set irqs
Date:   Wed, 20 Feb 2019 17:41:59 +0100
Message-Id: <20190220164200.31044-1-aaron.ma@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rmi4 got spam data after S3 resume on some ThinkPads.
Then TrackPoint lost when be detected by psmouse.
Clear irqs status before set irqs will make TrackPoint back.

BugLink: https://bugs.launchpad.net/bugs/1791427
Cc: <stable@vger.kernel.org>
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 drivers/input/rmi4/rmi_driver.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index fc3ab93b7aea..20631b272f43 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -374,6 +374,17 @@ static int rmi_driver_set_irq_bits(struct rmi_device *rmi_dev,
 	struct device *dev = &rmi_dev->dev;
 
 	mutex_lock(&data->irq_mutex);
+
+	/* Dummy read in order to clear irqs */
+	error = rmi_read_block(rmi_dev,
+			data->f01_container->fd.data_base_addr + 1,
+			data->irq_status, data->num_of_irq_regs);
+	if (error < 0) {
+		dev_err(dev, "%s: Failed to read interrupt status!",
+							__func__);
+		goto error_unlock;
+	}
+
 	bitmap_or(data->new_irq_mask,
 		  data->current_irq_mask, mask, data->irq_count);
 
-- 
2.17.1

