Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822C4C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ED0E20852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:15:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ED0E20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388278AbeGXKVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 06:21:00 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:62535 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388178AbeGXKVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 06:21:00 -0400
Received: from 79.184.255.17.ipv4.supernova.orange.pl (79.184.255.17) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id 2dc0f29057384274; Tue, 24 Jul 2018 11:15:27 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Kai Heng Feng <kai.heng.feng@canonical.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        P HeLiOn <perryhelionsemail@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] ACPI / LPSS: Avoid PM quirks on suspend and resume from S3
Date:   Tue, 24 Jul 2018 11:13:42 +0200
Message-ID: <4689933.j1ecWYeVj2@aspire.rjw.lan>
In-Reply-To: <ABABA247-9C33-4311-ADA5-D0D00B810C6C@canonical.com>
References: <DEA1AE84-B0FD-481E-8E0D-788CD4EF59AE@canonical.com> <1568228.RgPNub1osy@aspire.rjw.lan> <ABABA247-9C33-4311-ADA5-D0D00B810C6C@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, July 24, 2018 10:46:09 AM CEST Kai Heng Feng wrote:
> Hi Rafael,
> 
> > On Jun 13, 2018, at 7:17 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > It is reported that commit a192aa923b66a (ACPI / LPSS: Consolidate
> > runtime PM and system sleep handling) introduced a system suspend
> > regression on some machines, but the only functional change made by
> > it was to cause the PM quirks in the LPSS to also be used during
> > system suspend and resume.  While that should always work for
> > suspend-to-idle, it turns out to be problematic for S3
> > (suspend-to-RAM).
> >
> > To address that issue restore the previous S3 suspend and resume
> > behavior of the LPSS to avoid applying PM quirks then.
> 
> The users reported that this patch does fix the S3 issue, but the S4 still  
> fails.
> 
> Please refer to [1] for more for user's testing result.
> 
> [1] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1774950/comments/60

Please ask the users to test the patch below, then, on top of the $subject one.

---
 drivers/acpi/acpi_lpss.c |   24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

Index: linux-pm/drivers/acpi/acpi_lpss.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpi_lpss.c
+++ linux-pm/drivers/acpi/acpi_lpss.c
@@ -879,6 +879,7 @@ static void acpi_lpss_dismiss(struct dev
 #define LPSS_GPIODEF0_DMA_LLP		BIT(13)
 
 static DEFINE_MUTEX(lpss_iosf_mutex);
+static bool lpss_iosf_d3_entered;
 
 static void lpss_iosf_enter_d3_state(void)
 {
@@ -921,6 +922,9 @@ static void lpss_iosf_enter_d3_state(voi
 
 	iosf_mbi_modify(LPSS_IOSF_UNIT_LPIOEP, MBI_CR_WRITE,
 			LPSS_IOSF_GPIODEF0, value1, mask1);
+
+	lpss_iosf_d3_entered = true;
+
 exit:
 	mutex_unlock(&lpss_iosf_mutex);
 }
@@ -935,6 +939,9 @@ static void lpss_iosf_exit_d3_state(void
 
 	mutex_lock(&lpss_iosf_mutex);
 
+	if (!lpss_iosf_d3_entered)
+		goto exit;
+
 	iosf_mbi_modify(LPSS_IOSF_UNIT_LPIOEP, MBI_CR_WRITE,
 			LPSS_IOSF_GPIODEF0, value1, mask1);
 
@@ -944,13 +951,13 @@ static void lpss_iosf_exit_d3_state(void
 	iosf_mbi_modify(LPSS_IOSF_UNIT_LPIO1, MBI_CFG_WRITE,
 			LPSS_IOSF_PMCSR, value2, mask2);
 
+exit:
 	mutex_unlock(&lpss_iosf_mutex);
 }
 
-static int acpi_lpss_suspend(struct device *dev, bool runtime)
+static int acpi_lpss_suspend(struct device *dev, bool wakeup)
 {
 	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
-	bool wakeup = runtime || device_may_wakeup(dev);
 	int ret;
 
 	if (pdata->dev_desc->flags & LPSS_SAVE_CTX)
@@ -963,14 +970,14 @@ static int acpi_lpss_suspend(struct devi
 	 * wrong status for devices being about to be powered off. See
 	 * lpss_iosf_enter_d3_state() for further information.
 	 */
-	if ((runtime || !pm_suspend_via_firmware()) &&
+	if (acpi_target_system_state() == ACPI_STATE_S0 &&
 	    lpss_quirks & LPSS_QUIRK_ALWAYS_POWER_ON && iosf_mbi_available())
 		lpss_iosf_enter_d3_state();
 
 	return ret;
 }
 
-static int acpi_lpss_resume(struct device *dev, bool runtime)
+static int acpi_lpss_resume(struct device *dev)
 {
 	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
 	int ret;
@@ -979,8 +986,7 @@ static int acpi_lpss_resume(struct devic
 	 * This call is kept first to be in symmetry with
 	 * acpi_lpss_runtime_suspend() one.
 	 */
-	if ((runtime || !pm_resume_via_firmware()) &&
-	    lpss_quirks & LPSS_QUIRK_ALWAYS_POWER_ON && iosf_mbi_available())
+	if (lpss_quirks & LPSS_QUIRK_ALWAYS_POWER_ON && iosf_mbi_available())
 		lpss_iosf_exit_d3_state();
 
 	ret = acpi_dev_resume(dev);
@@ -1004,12 +1010,12 @@ static int acpi_lpss_suspend_late(struct
 		return 0;
 
 	ret = pm_generic_suspend_late(dev);
-	return ret ? ret : acpi_lpss_suspend(dev, false);
+	return ret ? ret : acpi_lpss_suspend(dev, device_may_wakeup(dev));
 }
 
 static int acpi_lpss_resume_early(struct device *dev)
 {
-	int ret = acpi_lpss_resume(dev, false);
+	int ret = acpi_lpss_resume(dev);
 
 	return ret ? ret : pm_generic_resume_early(dev);
 }
@@ -1024,7 +1030,7 @@ static int acpi_lpss_runtime_suspend(str
 
 static int acpi_lpss_runtime_resume(struct device *dev)
 {
-	int ret = acpi_lpss_resume(dev, true);
+	int ret = acpi_lpss_resume(dev);
 
 	return ret ? ret : pm_generic_runtime_resume(dev);
 }

