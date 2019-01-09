Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D636DC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE481206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfAIQ6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 11:58:02 -0500
Received: from mga07.intel.com ([134.134.136.100]:59123 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfAIQ6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 11:58:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2019 08:57:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,458,1539673200"; 
   d="scan'208";a="136781574"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 09 Jan 2019 08:57:56 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7F06D40C; Wed,  9 Jan 2019 18:57:55 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v2 3/3] ACPI / x86: utils: Get rid of custom ICPU() macro
Date:   Wed,  9 Jan 2019 18:57:54 +0200
Message-Id: <20190109165754.90072-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190109165754.90072-1-andriy.shevchenko@linux.intel.com>
References: <20190109165754.90072-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace custom grown macro with generic INTEL_CPU_FAM6_NODATA() one.

No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/x86/utils.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index 9a8e286dd86f..408131bcc1fa 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -40,8 +40,6 @@ struct always_present_id {
 	const char *uid;
 };
 
-#define ICPU(model)	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, }
-
 #define ENTRY(hid, uid, cpu_models, dmi...) {				\
 	{ { hid, }, {} },						\
 	{ cpu_models, {} },						\
@@ -54,24 +52,24 @@ static const struct always_present_id always_present_ids[] = {
 	 * Bay / Cherry Trail PWM directly poked by GPU driver in win10,
 	 * but Linux uses a separate PWM driver, harmless if not used.
 	 */
-	ENTRY("80860F09", "1", ICPU(INTEL_FAM6_ATOM_SILVERMONT), {}),
-	ENTRY("80862288", "1", ICPU(INTEL_FAM6_ATOM_AIRMONT), {}),
+	ENTRY("80860F09", "1", INTEL_CPU_FAM6_NODATA(ATOM_SILVERMONT), {}),
+	ENTRY("80862288", "1", INTEL_CPU_FAM6_NODATA(ATOM_AIRMONT), {}),
 	/*
 	 * The INT0002 device is necessary to clear wakeup interrupt sources
 	 * on Cherry Trail devices, without it we get nobody cared IRQ msgs.
 	 */
-	ENTRY("INT0002", "1", ICPU(INTEL_FAM6_ATOM_AIRMONT), {}),
+	ENTRY("INT0002", "1", INTEL_CPU_FAM6_NODATA(ATOM_AIRMONT), {}),
 	/*
 	 * On the Dell Venue 11 Pro 7130 and 7139, the DSDT hides
 	 * the touchscreen ACPI device until a certain time
 	 * after _SB.PCI0.GFX0.LCD.LCD1._ON gets called has passed
 	 * *and* _STA has been called at least 3 times since.
 	 */
-	ENTRY("SYNA7500", "1", ICPU(INTEL_FAM6_HASWELL_ULT), {
+	ENTRY("SYNA7500", "1", INTEL_CPU_FAM6_NODATA(HASWELL_ULT), {
 		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 		DMI_MATCH(DMI_PRODUCT_NAME, "Venue 11 Pro 7130"),
 	      }),
-	ENTRY("SYNA7500", "1", ICPU(INTEL_FAM6_HASWELL_ULT), {
+	ENTRY("SYNA7500", "1", INTEL_CPU_FAM6_NODATA(HASWELL_ULT), {
 		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 		DMI_MATCH(DMI_PRODUCT_NAME, "Venue 11 Pro 7139"),
 	      }),
@@ -87,19 +85,19 @@ static const struct always_present_id always_present_ids[] = {
 	 * was copy-pasted from the GPD win, so it has a disabled KIOX000A
 	 * node which we should not enable, thus we also check the BIOS date.
 	 */
-	ENTRY("KIOX000A", "1", ICPU(INTEL_FAM6_ATOM_AIRMONT), {
+	ENTRY("KIOX000A", "1", INTEL_CPU_FAM6_NODATA(ATOM_AIRMONT), {
 		DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
 		DMI_MATCH(DMI_BOARD_NAME, "Default string"),
 		DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),
 		DMI_MATCH(DMI_BIOS_DATE, "02/21/2017")
 	      }),
-	ENTRY("KIOX000A", "1", ICPU(INTEL_FAM6_ATOM_AIRMONT), {
+	ENTRY("KIOX000A", "1", INTEL_CPU_FAM6_NODATA(ATOM_AIRMONT), {
 		DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
 		DMI_MATCH(DMI_BOARD_NAME, "Default string"),
 		DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),
 		DMI_MATCH(DMI_BIOS_DATE, "03/20/2017")
 	      }),
-	ENTRY("KIOX000A", "1", ICPU(INTEL_FAM6_ATOM_AIRMONT), {
+	ENTRY("KIOX000A", "1", INTEL_CPU_FAM6_NODATA(ATOM_AIRMONT), {
 		DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
 		DMI_MATCH(DMI_BOARD_NAME, "Default string"),
 		DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),
-- 
2.20.1

