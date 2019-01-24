Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8876C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74C92218D9
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548357742;
	bh=Oh2Gn4bSz/EXg3srTOhGmNXCwuA4zMoFbSfkcGBKeOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BK25DtZiF6tNAZFx5xDcaB36FaKcypHlI3p/UDdgC8GH+3HBkUXmu/RCyKWX9DOtu
	 JEt9bMIXOY8d9i6S+7PWPiq6VZYS7tmfS9T5grwJTm0P5NIwOdcdPrpJQrfPBs10pU
	 WWwB+xvJPRatOXt08aceHLL3khyx9HeyxYfL62N8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729518AbfAXTWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:22:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:46844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729436AbfAXTWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:22:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60661218D9;
        Thu, 24 Jan 2019 19:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548357737;
        bh=Oh2Gn4bSz/EXg3srTOhGmNXCwuA4zMoFbSfkcGBKeOE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aIzLUwZJ03hv87LqmhlWMBbUPk0yjFCHKk58omJFOBRU38wCWSHIF7bBRc4H4+iRl
         lyp9Pa580Vn5ncW99EvtHWGqL83Y5D4BQZFzlYPZkWVeQinJ6pHqzgUoipT05Unvn5
         LCsTW6O4KWLOBAx5h4M6t78mN0VrUUNamdLPujqA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 3.18 22/52] mfd: tps6586x: Handle interrupts on suspend
Date:   Thu, 24 Jan 2019 20:19:46 +0100
Message-Id: <20190124190144.859675725@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190140.879495253@linuxfoundation.org>
References: <20190124190140.879495253@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jonathan Hunter <jonathanh@nvidia.com>

commit ac4ca4b9f4623ba5e1ea7a582f286567c611e027 upstream.

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
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mfd/tps6586x.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

--- a/drivers/mfd/tps6586x.c
+++ b/drivers/mfd/tps6586x.c
@@ -601,6 +601,29 @@ static int tps6586x_i2c_remove(struct i2
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
@@ -612,6 +635,7 @@ static struct i2c_driver tps6586x_driver
 		.name	= "tps6586x",
 		.owner	= THIS_MODULE,
 		.of_match_table = of_match_ptr(tps6586x_of_match),
+		.pm	= &tps6586x_pm_ops,
 	},
 	.probe		= tps6586x_i2c_probe,
 	.remove		= tps6586x_i2c_remove,


