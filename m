Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6C6C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 10:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 740352150F
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 10:21:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 740352150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbeJTSbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 14:31:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55504 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726817AbeJTSa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 14:30:59 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4C48B308FB90;
        Sat, 20 Oct 2018 10:21:03 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-58.ams2.redhat.com [10.36.116.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 262326B483;
        Sat, 20 Oct 2018 10:21:01 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: touchscreen_dmi: Add min-x and min-y settings for various models
Date:   Sat, 20 Oct 2018 12:21:00 +0200
Message-Id: <20181020102100.14111-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Sat, 20 Oct 2018 10:21:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add min-x and min-y settings now that we've support for this and for some
models also update the width/height settings with slighly more accurate
values.

This fixes touches along the edges registering at the wrong coordinates.

While at it also set max-fingers to 10 in a couple of cases where the
touchpad can handle 10 fingers (rather then the default 5) and that was
missing.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/touchscreen_dmi.c | 33 +++++++++++++++++++-------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
index f852009e0e30..3a65a37f8ac8 100644
--- a/drivers/platform/x86/touchscreen_dmi.c
+++ b/drivers/platform/x86/touchscreen_dmi.c
@@ -51,10 +51,13 @@ static const struct ts_dmi_data chuwi_hi8_data = {
 };
 
 static const struct property_entry chuwi_hi8_pro_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-min-x", 6),
+	PROPERTY_ENTRY_U32("touchscreen-min-y", 3),
 	PROPERTY_ENTRY_U32("touchscreen-size-x", 1728),
 	PROPERTY_ENTRY_U32("touchscreen-size-y", 1148),
 	PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
 	PROPERTY_ENTRY_STRING("firmware-name", "gsl3680-chuwi-hi8-pro.fw"),
+	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
 	PROPERTY_ENTRY_BOOL("silead,home-button"),
 	PROPERTY_ENTRY_BOOL("efi-embedded-firmware"),
 	{ }
@@ -75,6 +78,8 @@ static const struct ts_dmi_data chuwi_hi8_pro_data = {
 };
 
 static const struct property_entry chuwi_vi8_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-min-x", 4),
+	PROPERTY_ENTRY_U32("touchscreen-min-y", 6),
 	PROPERTY_ENTRY_U32("touchscreen-size-x", 1724),
 	PROPERTY_ENTRY_U32("touchscreen-size-y", 1140),
 	PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
@@ -121,9 +126,9 @@ static const struct ts_dmi_data chuwi_vi10_data = {
 
 static const struct property_entry connect_tablet9_props[] = {
 	PROPERTY_ENTRY_U32("touchscreen-min-x", 9),
-	PROPERTY_ENTRY_U32("touchscreen-min-y", 8),
+	PROPERTY_ENTRY_U32("touchscreen-min-y", 10),
 	PROPERTY_ENTRY_U32("touchscreen-size-x", 1664),
-	PROPERTY_ENTRY_U32("touchscreen-size-y", 878),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 880),
 	PROPERTY_ENTRY_BOOL("touchscreen-inverted-y"),
 	PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
 	PROPERTY_ENTRY_STRING("firmware-name", "gsl1680-connect-tablet9.fw"),
@@ -137,8 +142,10 @@ static const struct ts_dmi_data connect_tablet9_data = {
 };
 
 static const struct property_entry cube_iwork8_air_props[] = {
-	PROPERTY_ENTRY_U32("touchscreen-size-x", 1660),
-	PROPERTY_ENTRY_U32("touchscreen-size-y", 900),
+	PROPERTY_ENTRY_U32("touchscreen-min-x", 1),
+	PROPERTY_ENTRY_U32("touchscreen-min-y", 3),
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 1664),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 896),
 	PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
 	PROPERTY_ENTRY_STRING("firmware-name", "gsl3670-cube-iwork8-air.fw"),
 	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
@@ -222,11 +229,14 @@ static const struct ts_dmi_data gp_electronic_t701_data = {
 };
 
 static const struct property_entry itworks_tw891_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-min-x", 1),
+	PROPERTY_ENTRY_U32("touchscreen-min-y", 5),
 	PROPERTY_ENTRY_U32("touchscreen-size-x", 1600),
-	PROPERTY_ENTRY_U32("touchscreen-size-y", 890),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 896),
 	PROPERTY_ENTRY_BOOL("touchscreen-inverted-y"),
 	PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
 	PROPERTY_ENTRY_STRING("firmware-name", "gsl3670-itworks-tw891.fw"),
+	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
 	{ }
 };
 
@@ -250,8 +260,10 @@ static const struct ts_dmi_data jumper_ezpad_6_pro_data = {
 };
 
 static const struct property_entry jumper_ezpad_mini3_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-min-x", 23),
+	PROPERTY_ENTRY_U32("touchscreen-min-y", 16),
 	PROPERTY_ENTRY_U32("touchscreen-size-x", 1700),
-	PROPERTY_ENTRY_U32("touchscreen-size-y", 1150),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 1138),
 	PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
 	PROPERTY_ENTRY_STRING("firmware-name", "gsl3676-jumper-ezpad-mini3.fw"),
 	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
@@ -403,11 +415,14 @@ static const struct ts_dmi_data pov_mobii_wintab_p800w_v20_data = {
 };
 
 static const struct property_entry pov_mobii_wintab_p800w_v21_props[] = {
-	PROPERTY_ENTRY_U32("touchscreen-size-x", 1800),
-	PROPERTY_ENTRY_U32("touchscreen-size-y", 1150),
+	PROPERTY_ENTRY_U32("touchscreen-min-x", 1),
+	PROPERTY_ENTRY_U32("touchscreen-min-y", 8),
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 1794),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 1148),
 	PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
 	PROPERTY_ENTRY_STRING("firmware-name",
 			      "gsl3692-pov-mobii-wintab-p800w.fw"),
+	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
 	PROPERTY_ENTRY_BOOL("silead,home-button"),
 	{ }
 };
@@ -494,6 +509,8 @@ static const struct ts_dmi_data trekstor_surftab_twin_10_1_data = {
 };
 
 static const struct property_entry trekstor_surftab_wintron70_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-min-x", 12),
+	PROPERTY_ENTRY_U32("touchscreen-min-y", 8),
 	PROPERTY_ENTRY_U32("touchscreen-size-x", 884),
 	PROPERTY_ENTRY_U32("touchscreen-size-y", 632),
 	PROPERTY_ENTRY_STRING("firmware-name",
-- 
2.19.0

