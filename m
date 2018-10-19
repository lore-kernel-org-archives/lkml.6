Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA08ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 13:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E50C21476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 13:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="W2Fi8Ntv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E50C21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbeJSV3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 17:29:07 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:14116 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbeJSV3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 17:29:06 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bc9daae0000>; Fri, 19 Oct 2018 06:22:54 -0700
Received: from HQMAIL103.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 19 Oct 2018 06:22:59 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 19 Oct 2018 06:22:59 -0700
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 19 Oct
 2018 13:22:59 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 19 Oct
 2018 13:22:58 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Fri, 19 Oct 2018 13:22:58 +0000
Received: from moonraker.nvidia.com (Not Verified[10.26.11.35]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5bc9dab10000>; Fri, 19 Oct 2018 06:22:58 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        "Dmitry Osipenko" <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        <stable@vger.kernel.org>
Subject: [PATCH] mfd: tps6586x: Handle interrupts on suspend
Date:   Fri, 19 Oct 2018 14:22:53 +0100
Message-ID: <1539955373-13735-1-git-send-email-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1539955374; bh=D1OzL+Krrnfn/sN8NoMgBPfPYz55geZZmrN5sdOs2C8=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=W2Fi8NtvVr9iN2BQiD0MUIioUTgl6jT1azwBC7SE1gClNiNLMUumAbvZsXyCV19eI
         m2wJXsiY70JBBmm2pR/eZGVI+S6hcKTuJSQD791z/0sfCfSh6J7fXMEIlgAkCSEyLG
         MlqzaLOoTciQOB9Vuj2beq9dlnX8uBu0WwvDqMO67nCAHmdE5V+zgVFa7tGfQ7fgRS
         uEF/S/MdgcAfORWNi06JEpmLkSnm7op2doeBTESq6homHNV4aMM9T93zyddCg9Hf4M
         zhM4PEiNqnViYQh+NXqm4RfiCcXoU22JfHlYCaszKZJgRC2FPHOpNpoDI1w7rqzMNl
         tXEhgiQ0OSplQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Hunter <jonathanh@nvidia.com>

The tps6586x driver creates an irqchip that is used by its various child
devices for managing interrupts. The tps6586x-rtc device is one of its
children that uses the tps6586x irqchip. When using the tps6586x-rtc as
a wake-up device from suspend, the following is seen:

 PM: Syncing filesystems ... done.
 Freezing user space processes ... (elapsed 0.001 seconds) done.
 OOM killer disabled.
 Freezing remaining freezable tasks ... (elapsed 0.000 seconds) done.
 Disabling non-boot CPUs ...
 Entering suspend state LP1
 Enabling non-boot CPUs ...
 CPU1 is up
 tps6586x 3-0034: failed to read interrupt status
 tps6586x 3-0034: failed to read interrupt status

The reason why the tps6586x interrupt status cannot be read is because
the tps6586x interrupt is not masked during suspend and when the
tps6586x-rtc interrupt occurs, to wake-up the device, the interrupt is
seen before the i2c controller has been resumed in order to read the
tps6586x interrupt status.

The tps6586x-rtc driver sets it's interrupt as a wake-up source during
suspend, which gets propagated to the parent tps6586x interrupt.
However, the tps6586x-rtc driver cannot disable it's interrupt during
suspend otherwise we would never be woken up and so the tps6586x must
disable it's interrupt instead.

Prevent the tps6586x interrupt handler from executing on exiting suspend
before the i2c controller has been resumed by disabling the tps6586x
interrupt on entering suspend and re-enabling it on resuming from
suspend.

Cc: stable@vger.kernel.org

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/mfd/tps6586x.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/mfd/tps6586x.c b/drivers/mfd/tps6586x.c
index b89379782741..9c7925ca13cf 100644
--- a/drivers/mfd/tps6586x.c
+++ b/drivers/mfd/tps6586x.c
@@ -592,6 +592,29 @@ static int tps6586x_i2c_remove(struct i2c_client *client)
 	return 0;
 }
 
+static int __maybe_unused tps6586x_i2c_suspend(struct device *dev)
+{
+	struct tps6586x *tps6586x = dev_get_drvdata(dev);
+
+	if (tps6586x->client->irq)
+		disable_irq(tps6586x->client->irq);
+
+	return 0;
+}
+
+static int __maybe_unused tps6586x_i2c_resume(struct device *dev)
+{
+	struct tps6586x *tps6586x = dev_get_drvdata(dev);
+
+	if (tps6586x->client->irq)
+		enable_irq(tps6586x->client->irq);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(tps6586x_pm_ops, tps6586x_i2c_suspend,
+			 tps6586x_i2c_resume);
+
 static const struct i2c_device_id tps6586x_id_table[] = {
 	{ "tps6586x", 0 },
 	{ },
@@ -602,6 +625,7 @@ static struct i2c_driver tps6586x_driver = {
 	.driver	= {
 		.name	= "tps6586x",
 		.of_match_table = of_match_ptr(tps6586x_of_match),
+		.pm	= &tps6586x_pm_ops,
 	},
 	.probe		= tps6586x_i2c_probe,
 	.remove		= tps6586x_i2c_remove,
-- 
2.7.4

