Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C9BC6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84E9625806
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:08:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84E9625806
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965490AbeGASIx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 14:08:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34284 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964984AbeGAQ2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:28:16 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 95BFDAA6;
        Sun,  1 Jul 2018 16:28:15 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 4.9 089/101] pwm: lpss: platform: Save/restore the ctrl register over a suspend/resume
Date:   Sun,  1 Jul 2018 18:22:15 +0200
Message-Id: <20180701160800.721318875@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160757.138608453@linuxfoundation.org>
References: <20180701160757.138608453@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

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

Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pwm/pwm-lpss-platform.c |    5 +++++
 drivers/pwm/pwm-lpss.c          |   30 ++++++++++++++++++++++++++++++
 drivers/pwm/pwm-lpss.h          |    2 ++
 3 files changed, 37 insertions(+)

--- a/drivers/pwm/pwm-lpss-platform.c
+++ b/drivers/pwm/pwm-lpss-platform.c
@@ -52,6 +52,10 @@ static int pwm_lpss_remove_platform(stru
 	return pwm_lpss_remove(lpwm);
 }
 
+static SIMPLE_DEV_PM_OPS(pwm_lpss_platform_pm_ops,
+			 pwm_lpss_suspend,
+			 pwm_lpss_resume);
+
 static const struct acpi_device_id pwm_lpss_acpi_match[] = {
 	{ "80860F09", (unsigned long)&pwm_lpss_byt_info },
 	{ "80862288", (unsigned long)&pwm_lpss_bsw_info },
@@ -64,6 +68,7 @@ static struct platform_driver pwm_lpss_d
 	.driver = {
 		.name = "pwm-lpss",
 		.acpi_match_table = pwm_lpss_acpi_match,
+		.pm = &pwm_lpss_platform_pm_ops,
 	},
 	.probe = pwm_lpss_probe_platform,
 	.remove = pwm_lpss_remove_platform,
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -31,10 +31,13 @@
 /* Size of each PWM register space if multiple */
 #define PWM_SIZE			0x400
 
+#define MAX_PWMS			4
+
 struct pwm_lpss_chip {
 	struct pwm_chip chip;
 	void __iomem *regs;
 	const struct pwm_lpss_boardinfo *info;
+	u32 saved_ctrl[MAX_PWMS];
 };
 
 /* BayTrail */
@@ -168,6 +171,9 @@ struct pwm_lpss_chip *pwm_lpss_probe(str
 	unsigned long c;
 	int ret;
 
+	if (WARN_ON(info->npwm > MAX_PWMS))
+		return ERR_PTR(-ENODEV);
+
 	lpwm = devm_kzalloc(dev, sizeof(*lpwm), GFP_KERNEL);
 	if (!lpwm)
 		return ERR_PTR(-ENOMEM);
@@ -203,6 +209,30 @@ int pwm_lpss_remove(struct pwm_lpss_chip
 }
 EXPORT_SYMBOL_GPL(pwm_lpss_remove);
 
+int pwm_lpss_suspend(struct device *dev)
+{
+	struct pwm_lpss_chip *lpwm = dev_get_drvdata(dev);
+	int i;
+
+	for (i = 0; i < lpwm->info->npwm; i++)
+		lpwm->saved_ctrl[i] = readl(lpwm->regs + i * PWM_SIZE + PWM);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pwm_lpss_suspend);
+
+int pwm_lpss_resume(struct device *dev)
+{
+	struct pwm_lpss_chip *lpwm = dev_get_drvdata(dev);
+	int i;
+
+	for (i = 0; i < lpwm->info->npwm; i++)
+		writel(lpwm->saved_ctrl[i], lpwm->regs + i * PWM_SIZE + PWM);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pwm_lpss_resume);
+
 MODULE_DESCRIPTION("PWM driver for Intel LPSS");
 MODULE_AUTHOR("Mika Westerberg <mika.westerberg@linux.intel.com>");
 MODULE_LICENSE("GPL v2");
--- a/drivers/pwm/pwm-lpss.h
+++ b/drivers/pwm/pwm-lpss.h
@@ -31,5 +31,7 @@ extern const struct pwm_lpss_boardinfo p
 struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, struct resource *r,
 				     const struct pwm_lpss_boardinfo *info);
 int pwm_lpss_remove(struct pwm_lpss_chip *lpwm);
+int pwm_lpss_suspend(struct device *dev);
+int pwm_lpss_resume(struct device *dev);
 
 #endif	/* __PWM_LPSS_H */


