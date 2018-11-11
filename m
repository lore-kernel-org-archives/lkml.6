Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29974C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E99A820869
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:06:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E99A820869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731060AbeKLFzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:55:50 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51954 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725905AbeKLFzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:55:50 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvt3-0000lG-DC; Sun, 11 Nov 2018 19:59:13 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsR-0001Wa-Ga; Sun, 11 Nov 2018 19:58:35 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Hans de Goede" <hdegoede@redhat.com>,
        "Thierry Reding" <thierry.reding@gmail.com>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.124930955@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 121/366] pwm: lpss: platform: Save/restore the ctrl
 register over a suspend/resume
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit 1d375b58c12f08d8570b30b865def4734517f04f upstream.

On some devices the contents of the ctrl register get lost over a
suspend/resume and the PWM comes back up disabled after the resume.

This is seen on some Bay Trail devices with the PWM in ACPI enumerated
mode, so it shows up as a platform device instead of a PCI device.

If we still think it is enabled and then try to change the duty-cycle
after this, we end up with a "PWM_SW_UPDATE was not cleared" error and
the PWM is stuck in that state from then on.

This commit adds suspend and resume pm callbacks to the pwm-lpss-platform
code, which save/restore the ctrl register over a suspend/resume, fixing
this.

Note that:

1) There is no need to do this over a runtime suspend, since we
only runtime suspend when disabled and then we properly set the enable
bit and reprogram the timings when we re-enable the PWM.

2) This may be happening on more systems then we realize, but has been
covered up sofar by a bug in the acpi-lpss.c code which was save/restoring
the regular device registers instead of the lpss private registers due to
lpss_device_desc.prv_offset not being set. This is fixed by a later patch
in this series.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
[bwh: Backported to 3.16:
 - pwm-lpss is a single module, so make the new functions static
 - Only one PWM per chip is supported; remove the npwm assertion and loops
 - Adjust filenames, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -39,6 +39,7 @@ struct pwm_lpss_chip {
 	void __iomem *regs;
 	struct clk *clk;
 	unsigned long clk_rate;
+	u32 saved_ctrl;
 };
 
 struct pwm_lpss_boardinfo {
@@ -177,6 +178,24 @@ static int pwm_lpss_remove(struct pwm_lp
 	return pwmchip_remove(&lpwm->chip);
 }
 
+static int pwm_lpss_suspend(struct device *dev)
+{
+	struct pwm_lpss_chip *lpwm = dev_get_drvdata(dev);
+
+	lpwm->saved_ctrl = readl(lpwm->regs + PWM);
+
+	return 0;
+}
+
+static int pwm_lpss_resume(struct device *dev)
+{
+	struct pwm_lpss_chip *lpwm = dev_get_drvdata(dev);
+
+	writel(lpwm->saved_ctrl, lpwm->regs + PWM);
+
+	return 0;
+}
+
 static int pwm_lpss_probe_pci(struct pci_dev *pdev,
 			      const struct pci_device_id *id)
 {
@@ -241,6 +260,10 @@ static int pwm_lpss_remove_platform(stru
 	return pwm_lpss_remove(lpwm);
 }
 
+static SIMPLE_DEV_PM_OPS(pwm_lpss_platform_pm_ops,
+			 pwm_lpss_suspend,
+			 pwm_lpss_resume);
+
 static const struct acpi_device_id pwm_lpss_acpi_match[] = {
 	{ "80860F09", 0 },
 	{ },
@@ -251,6 +274,7 @@ static struct platform_driver pwm_lpss_d
 	.driver = {
 		.name = "pwm-lpss",
 		.acpi_match_table = pwm_lpss_acpi_match,
+		.pm = &pwm_lpss_platform_pm_ops,
 	},
 	.probe = pwm_lpss_probe_platform,
 	.remove = pwm_lpss_remove_platform,

