Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E30EC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 08:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44F1C22360
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 08:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="GTtHfQE5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44F1C22360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731016AbeKMSxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 13:53:48 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:5287 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbeKMSxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 13:53:48 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bea91c20000>; Tue, 13 Nov 2018 00:56:34 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 13 Nov 2018 00:56:41 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 13 Nov 2018 00:56:41 -0800
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 13 Nov
 2018 08:56:40 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 13 Nov 2018 08:56:40 +0000
Received: from moonraker.nvidia.com (Not Verified[10.21.132.148]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5bea91c70001>; Tue, 13 Nov 2018 00:56:40 -0800
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        <stable@vger.kernel.org>
Subject: [RESEND PATCH] mfd: tps6586x: Handle interrupts on suspend
Date:   Tue, 13 Nov 2018 08:56:31 +0000
Message-ID: <1542099391-7338-1-git-send-email-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1542099394; bh=NK2ImQiyOwIwhfQ/Fnvw8XrWahGyWWTJDCMqfUu6rGQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=GTtHfQE581eEbyFpuUzCeKaKUaHKknLAH8ztRcUhyTsobSzHRnOrWyvWSi+PFN6w6
         bdEQJ3zIBNIPCQdnmqVbTCti55HqkKTEoXhfy6tdy3TdIaFN136+PxFkR9nM8Lh40P
         cNN3sH3NiZn6jeFkiFK3z0t2hrQZdY8kyFDspL4rzQ2dZqRAfwM2Ih3m3WJMt6KK1u
         gWLe3Sh8ViaMJqOveT38PRqnhNNJpmmHRdHeqMyqpP0cLFZutHUg6ZPA8loonr/w6j
         ycdfBqZpCwXlo+y4eDy227n+Xf8yPrEfBVxhSh8T9gFxhMVQTHzwDsy5WF/hjhoi3Z
         6KSYKppm0g99g==
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
Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Tested-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Thierry Reding <treding@nvidia.com>
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

