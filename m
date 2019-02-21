Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B709FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78FD820838
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550759869;
	bh=8jckA824qGwV4mSIwMivLKV6Ce1ZiFg4aQ6pJxr7ffQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H69Nebyhfg3bkssWfDuSAuxFmvDWrjOnJybn4p7T23KMu1vFIFmSSGpoC8IS6ZinO
	 3o/LgI0l6+mvaqicZ2A/A83SLxUTDuKwerk+v8iJ7owKYLVzd6CI9FaDtI0QBs89nT
	 8jbHAcW+ktAmu58BY+ts1ECkpdm2tMWALnT16o+M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbfBUOhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:37:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:59006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbfBUOhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:37:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 786B220838;
        Thu, 21 Feb 2019 14:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550759860;
        bh=8jckA824qGwV4mSIwMivLKV6Ce1ZiFg4aQ6pJxr7ffQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KT2derndQGYdGzOwtTaJN8JnCGRwDpNiJRTckC/Ku4Hu//onq7XM1rcPyeBEC3Md7
         0Mdtu0wj8Rkoe2N+TIgSyrAsgkFjvQNhAQIzd5GDesB1mQxO9XEOgHxnFA0dVO29sU
         veZMs0eNJw2LCxsWwPm7XueiXndj6tfOoJWT/tew=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 4.4 15/20] mfd: as3722: Handle interrupts on suspend
Date:   Thu, 21 Feb 2019 15:35:45 +0100
Message-Id: <20190221141947.208324417@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221141946.772985220@linuxfoundation.org>
References: <20190221141946.772985220@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jon Hunter <jonathanh@nvidia.com>

commit 35deff7eb212b661b32177b6043f674fde6314d7 upstream.

The as3722 device is registered as an irqchip and the as3722-rtc interrupt
is one of it's interrupt sources. When using the as3722-rtc as a wake-up
device from suspend, the following is seen:

  PM: Syncing filesystems ... done.
  Freezing user space processes ... (elapsed 0.001 seconds) done.
  Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
  Suspending console(s) (use no_console_suspend to debug)
  PM: suspend of devices complete after 161.119 msecs
  PM: late suspend of devices complete after 1.048 msecs
  PM: noirq suspend of devices complete after 0.756 msecs
  Disabling non-boot CPUs ...
  CPU1: shutdown
  CPU2: shutdown
  CPU3: shutdown
  Entering suspend state LP1
  Enabling non-boot CPUs ...
  CPU1 is up
  CPU2 is up
  CPU3 is up
  PM: noirq resume of devices complete after 0.487 msecs
  as3722 4-0040: Failed to read IRQ status: -16
  as3722 4-0040: Failed to read IRQ status: -16
  as3722 4-0040: Failed to read IRQ status: -16
  as3722 4-0040: Failed to read IRQ status: -16
  ...

The reason why the as3722 interrupt status cannot be read is because the
as3722 interrupt is not masked during suspend and when the as3722-rtc
interrupt occurs, to wake-up the device, the interrupt is seen before the
i2c controller has been resumed in order to read the as3722 interrupt
status.

The as3722-rtc driver sets it's interrupt as a wake-up source during
suspend, which gets propagated to the parent as3722 interrupt. However,
the as3722-rtc driver cannot disable it's interrupt during suspend
otherwise we would never be woken up and so the as3722 must disable it's
interrupt instead.

Fix this by disabling the as3722 interrupt during suspend. To ensure that
a wake-up event from the as3722 is not missing, enable the as3722 interrupt
as a wake-up source before disabling the interrupt on entering suspend.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mfd/as3722.c |   30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

--- a/drivers/mfd/as3722.c
+++ b/drivers/mfd/as3722.c
@@ -405,6 +405,8 @@ static int as3722_i2c_probe(struct i2c_c
 		goto scrub;
 	}
 
+	device_init_wakeup(as3722->dev, true);
+
 	dev_dbg(as3722->dev, "AS3722 core driver initialized successfully\n");
 	return 0;
 
@@ -422,6 +424,29 @@ static int as3722_i2c_remove(struct i2c_
 	return 0;
 }
 
+static int as3722_i2c_suspend(struct device *dev)
+{
+	struct as3722 *as3722 = dev_get_drvdata(dev);
+
+	if (device_may_wakeup(dev))
+		enable_irq_wake(as3722->chip_irq);
+	disable_irq(as3722->chip_irq);
+
+	return 0;
+}
+
+static int as3722_i2c_resume(struct device *dev)
+{
+	struct as3722 *as3722 = dev_get_drvdata(dev);
+
+	enable_irq(as3722->chip_irq);
+
+	if (device_may_wakeup(dev))
+		disable_irq_wake(as3722->chip_irq);
+
+	return 0;
+}
+
 static const struct of_device_id as3722_of_match[] = {
 	{ .compatible = "ams,as3722", },
 	{},
@@ -434,10 +459,15 @@ static const struct i2c_device_id as3722
 };
 MODULE_DEVICE_TABLE(i2c, as3722_i2c_id);
 
+static const struct dev_pm_ops as3722_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(as3722_i2c_suspend, as3722_i2c_resume)
+};
+
 static struct i2c_driver as3722_i2c_driver = {
 	.driver = {
 		.name = "as3722",
 		.of_match_table = as3722_of_match,
+		.pm = &as3722_pm_ops,
 	},
 	.probe = as3722_i2c_probe,
 	.remove = as3722_i2c_remove,


