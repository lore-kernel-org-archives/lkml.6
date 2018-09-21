Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D271ECE561
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE86521547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:46:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE86521547
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389022AbeIUHcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 03:32:35 -0400
Received: from mail1.windriver.com ([147.11.146.13]:39564 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbeIUHcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 03:32:35 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id w8L1jnqp026780
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Thu, 20 Sep 2018 18:45:49 -0700 (PDT)
Received: from yow-pgortmak-d1.corp.ad.wrs.com (128.224.56.57) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.408.0; Thu, 20 Sep 2018 18:45:49 -0700
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     <platform-driver-x86@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Peter Feuerer <peter@piie.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Subject: [PATCH 6/6] platform/x86: acerhdf: restructure to allow large BIOS table be __initconst
Date:   Thu, 20 Sep 2018 21:44:21 -0400
Message-ID: <20180921014421.30804-7-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20180921014421.30804-1-paul.gortmaker@windriver.com>
References: <20180921014421.30804-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a table of Vendor/Model/Version {control data} in this driver,
but outside of the initial probe, the V/M/V is never used again, and
neither are any of the entries for platforms other than the one which
matches the running target.

By simply storing the {control data} for the matched platform, we can
mark the large table __initconst, which reduces the loaded driver size
by 20 percent.

Before:
	root@gw:~/git/linux-head# lsmod
	Module                  Size  Used by
	acerhdf                20480  0
	root@gw:~/git/linux-head#

After:
	root@gw:~/git/linux-head# lsmod
	Module                  Size  Used by
	acerhdf                16384  0
	root@gw:~/git/linux-head#

Cc: Peter Feuerer <peter@piie.net>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Andy Shevchenko <andy@infradead.org>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/platform/x86/acerhdf.c | 41 ++++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
index 5f579fcde315..505224225378 100644
--- a/drivers/platform/x86/acerhdf.c
+++ b/drivers/platform/x86/acerhdf.c
@@ -133,7 +133,7 @@ static const struct manualcmd mcmd = {
 	.moff = 0xff,
 };
 
-/* BIOS settings */
+/* BIOS settings - only used during probe */
 struct bios_settings {
 	const char *vendor;
 	const char *product;
@@ -144,8 +144,18 @@ struct bios_settings {
 	int mcmd_enable;
 };
 
+/* This could be a daughter struct in the above, but not worth the redirect */
+struct ctrl_settings {
+	u8 fanreg;
+	u8 tempreg;
+	struct fancmd cmd;
+	int mcmd_enable;
+};
+
+static struct ctrl_settings ctrl_cfg __read_mostly;
+
 /* Register addresses and values for different BIOS versions */
-static const struct bios_settings bios_tbl[] = {
+static const struct bios_settings bios_tbl[] __initconst = {
 	/* AOA110 */
 	{"Acer", "AOA110", "v0.3109", 0x55, 0x58, {0x1f, 0x00}, 0},
 	{"Acer", "AOA110", "v0.3114", 0x55, 0x58, {0x1f, 0x00}, 0},
@@ -260,8 +270,6 @@ static const struct bios_settings bios_tbl[] = {
 	{"", "", "", 0, 0, {0, 0}, 0}
 };
 
-static const struct bios_settings *bios_cfg __read_mostly;
-
 /*
  * this struct is used to instruct thermal layer to use bang_bang instead of
  * default governor for acerhdf
@@ -274,7 +282,7 @@ static int acerhdf_get_temp(int *temp)
 {
 	u8 read_temp;
 
-	if (ec_read(bios_cfg->tempreg, &read_temp))
+	if (ec_read(ctrl_cfg.tempreg, &read_temp))
 		return -EINVAL;
 
 	*temp = read_temp * 1000;
@@ -286,10 +294,10 @@ static int acerhdf_get_fanstate(int *state)
 {
 	u8 fan;
 
-	if (ec_read(bios_cfg->fanreg, &fan))
+	if (ec_read(ctrl_cfg.fanreg, &fan))
 		return -EINVAL;
 
-	if (fan != bios_cfg->cmd.cmd_off)
+	if (fan != ctrl_cfg.cmd.cmd_off)
 		*state = ACERHDF_FAN_AUTO;
 	else
 		*state = ACERHDF_FAN_OFF;
@@ -310,13 +318,13 @@ static void acerhdf_change_fanstate(int state)
 		state = ACERHDF_FAN_AUTO;
 	}
 
-	cmd = (state == ACERHDF_FAN_OFF) ? bios_cfg->cmd.cmd_off
-					 : bios_cfg->cmd.cmd_auto;
+	cmd = (state == ACERHDF_FAN_OFF) ? ctrl_cfg.cmd.cmd_off
+					 : ctrl_cfg.cmd.cmd_auto;
 	fanstate = state;
 
-	ec_write(bios_cfg->fanreg, cmd);
+	ec_write(ctrl_cfg.fanreg, cmd);
 
-	if (bios_cfg->mcmd_enable && state == ACERHDF_FAN_OFF) {
+	if (ctrl_cfg.mcmd_enable && state == ACERHDF_FAN_OFF) {
 		if (verbose)
 			pr_notice("turning off fan manually\n");
 		ec_write(mcmd.mreg, mcmd.moff);
@@ -623,6 +631,7 @@ static int __init acerhdf_check_hardware(void)
 {
 	char const *vendor, *version, *product;
 	const struct bios_settings *bt = NULL;
+	int found = 0;
 
 	/* get BIOS data */
 	vendor  = dmi_get_system_info(DMI_SYS_VENDOR);
@@ -672,17 +681,23 @@ static int __init acerhdf_check_hardware(void)
 		if (str_starts_with(vendor, bt->vendor) &&
 				str_starts_with(product, bt->product) &&
 				str_starts_with(version, bt->version)) {
-			bios_cfg = bt;
+			found = 1;
 			break;
 		}
 	}
 
-	if (!bios_cfg) {
+	if (!found) {
 		pr_err("unknown (unsupported) BIOS version %s/%s/%s, please report, aborting!\n",
 		       vendor, product, version);
 		return -EINVAL;
 	}
 
+	/* Copy control settings from BIOS table before we free it. */
+	ctrl_cfg.fanreg = bt->fanreg;
+	ctrl_cfg.tempreg = bt->tempreg;
+	memcpy(&ctrl_cfg.cmd, &bt->cmd, sizeof(struct fancmd));
+	ctrl_cfg.mcmd_enable = bt->mcmd_enable;
+
 	/*
 	 * if started with kernel mode off, prevent the kernel from switching
 	 * off the fan
-- 
2.15.0

