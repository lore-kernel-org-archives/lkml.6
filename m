Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37484C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE8FC2083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:23:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE8FC2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733032AbeHAUKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:10:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46150 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404366AbeHATDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:03:38 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8606B12E4;
        Wed,  1 Aug 2018 17:11:15 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 4.17 335/336] ACPI / LPSS: Avoid PM quirks on suspend and resume from hibernation
Date:   Wed,  1 Aug 2018 18:51:10 +0200
Message-Id: <20180801165041.847264201@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

commit 12864ff8545f6b8144fdf1bb89b5663357f29ec4 upstream.

Commit a09c59130688 (ACPI / LPSS: Avoid PM quirks on suspend and
resume from S3) modified the ACPI driver for Intel SoCs (LPSS) to
avoid applying PM quirks on suspend and resume from S3 to address
system-wide suspend and resume problems on some systems, but it is
reported that the same issue also affects hibernation, so extend
the approach used by that commit to cover hibernation as well.

Fixes: a09c59130688 (ACPI / LPSS: Avoid PM quirks on suspend and resume from S3)
Link: https://bugs.launchpad.net/bugs/1774950
Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: 4.15+ <stable@vger.kernel.org> # 4.15+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/acpi_lpss.c |   26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
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
@@ -935,6 +939,11 @@ static void lpss_iosf_exit_d3_state(void
 
 	mutex_lock(&lpss_iosf_mutex);
 
+	if (!lpss_iosf_d3_entered)
+		goto exit;
+
+	lpss_iosf_d3_entered = false;
+
 	iosf_mbi_modify(LPSS_IOSF_UNIT_LPIOEP, MBI_CR_WRITE,
 			LPSS_IOSF_GPIODEF0, value1, mask1);
 
@@ -944,13 +953,13 @@ static void lpss_iosf_exit_d3_state(void
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
@@ -963,14 +972,14 @@ static int acpi_lpss_suspend(struct devi
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
@@ -979,8 +988,7 @@ static int acpi_lpss_resume(struct devic
 	 * This call is kept first to be in symmetry with
 	 * acpi_lpss_runtime_suspend() one.
 	 */
-	if ((runtime || !pm_resume_via_firmware()) &&
-	    lpss_quirks & LPSS_QUIRK_ALWAYS_POWER_ON && iosf_mbi_available())
+	if (lpss_quirks & LPSS_QUIRK_ALWAYS_POWER_ON && iosf_mbi_available())
 		lpss_iosf_exit_d3_state();
 
 	ret = acpi_dev_resume(dev);
@@ -1004,12 +1012,12 @@ static int acpi_lpss_suspend_late(struct
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
@@ -1024,7 +1032,7 @@ static int acpi_lpss_runtime_suspend(str
 
 static int acpi_lpss_runtime_resume(struct device *dev)
 {
-	int ret = acpi_lpss_resume(dev, true);
+	int ret = acpi_lpss_resume(dev);
 
 	return ret ? ret : pm_generic_runtime_resume(dev);
 }


