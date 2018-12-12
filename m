Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A19FEC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F93020839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:42:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F93020839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbeLLPmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 10:42:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56426 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726325AbeLLPmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 10:42:18 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3095C89ACB;
        Wed, 12 Dec 2018 15:42:17 +0000 (UTC)
Received: from plouf.redhat.com (ovpn-116-24.ams2.redhat.com [10.36.116.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8876D60C5C;
        Wed, 12 Dec 2018 15:42:12 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>, kt.liao@emc.com.tw,
        Aaron Ma <aaron.ma@canonical.com>,
        Kai Heng Feng <kai.heng.feng@canonical.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        stable@vger.kernel.org
Subject: [PATCH] Input: elantech - Disable elan-i2c for P52 and P72
Date:   Wed, 12 Dec 2018 16:42:05 +0100
Message-Id: <20181212154205.24025-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 12 Dec 2018 15:42:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation of elan_i2c is known to not support those
2 laptops.

A proper fix is to tweak both elantech and elan_i2c to transmit the
correct information from PS/2, which would make a bad candidate for
stable.

So to give us some time for fixing the root of the problem, disable
elan_i2c for the devices we know are not behaving properly.

Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1803600
Link: https://bugs.archlinux.org/task/59714
Fixes: df077237cf55 Input: elantech - detect new ICs and setup Host Notify for them

Cc: stable@vger.kernel.org  # v4.18+
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/input/mouse/elantech.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 2d95e8d93cc7..830ae9f07045 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1767,6 +1767,18 @@ static int elantech_smbus = IS_ENABLED(CONFIG_MOUSE_ELAN_I2C_SMBUS) ?
 module_param_named(elantech_smbus, elantech_smbus, int, 0644);
 MODULE_PARM_DESC(elantech_smbus, "Use a secondary bus for the Elantech device.");
 
+static const char * const i2c_blacklist_pnp_ids[] = {
+	/*
+	 * these are known to not be working properly as bits are missing
+	 * in elan_i2c
+	 */
+	"LEN2131", /* ThinkPad P52 w/ NFC */
+	"LEN2132", /* ThinkPad P52 */
+	"LEN2133", /* ThinkPad P72 w/ NFC */
+	"LEN2134", /* ThinkPad P72 */
+	NULL
+};
+
 static int elantech_create_smbus(struct psmouse *psmouse,
 				 struct elantech_device_info *info,
 				 bool leave_breadcrumbs)
@@ -1802,10 +1814,12 @@ static int elantech_setup_smbus(struct psmouse *psmouse,
 
 	if (elantech_smbus == ELANTECH_SMBUS_NOT_SET) {
 		/*
-		 * New ICs are enabled by default.
+		 * New ICs are enabled by default, unless mentioned in
+		 * i2c_blacklist_pnp_ids.
 		 * Old ICs are up to the user to decide.
 		 */
-		if (!ETP_NEW_IC_SMBUS_HOST_NOTIFY(info->fw_version))
+		if (!ETP_NEW_IC_SMBUS_HOST_NOTIFY(info->fw_version) ||
+		    psmouse_matches_pnp_id(psmouse, i2c_blacklist_pnp_ids))
 			return -ENXIO;
 	}
 
-- 
2.19.2

