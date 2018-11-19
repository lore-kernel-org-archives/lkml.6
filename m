Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BAFC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A19DB2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qk7He4D3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A19DB2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389015AbeKTDLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:11:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:47080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728537AbeKTDLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:11:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88F8E206BA;
        Mon, 19 Nov 2018 16:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646026;
        bh=pFxouZyo2nMSuRz19ZvLm7xz8aZ0oKltXap9yCgJZHM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qk7He4D3j7JBTIbv7BM6wOmpbV13LrhpJy7FgyaEVzoftPf7gMkpawwBzX9QYdsyz
         wuy6Vf1yZu3we1uyWgFB7ZDK6isFC/hIQZaMjdSfN2JcN9mAAwF7uyrBvigsy+8Agb
         c+kEC9NHMaWlRoRppO0oQyqR55IGaTBuMYc/BxZM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 4.18 154/171] drm: panel-orientation-quirks: Add quirk for Acer One 10 (S1003)
Date:   Mon, 19 Nov 2018 17:29:10 +0100
Message-Id: <20181119162640.111582315@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162618.909354448@linuxfoundation.org>
References: <20181119162618.909354448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit 0e8afefd5da4875ddea9aa4ad17a2540a2bf9736 upstream.

The Acer One 10 uses a clamshell design with a detachable keyboard.
As such in normal operating mode, with the keyboard attach the device
is in landscape mode (and the Acer logo at boot also shows in landscape
mode).

But the device uses a portrait screen rotated 90 degrees (sigh). This
commit adds a quirk for this device so that we shown the fbcon the
right way up and that we hint userspace to also show e.g. plymouth and
gdm the right way up.

Cc: stable@vger.kernel.org
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20181012101610.29100-1-hdegoede@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/drm_panel_orientation_quirks.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -30,6 +30,12 @@ struct drm_dmi_panel_orientation_data {
 	int orientation;
 };
 
+static const struct drm_dmi_panel_orientation_data acer_s1003 = {
+	.width = 800,
+	.height = 1280,
+	.orientation = DRM_MODE_PANEL_ORIENTATION_RIGHT_UP,
+};
+
 static const struct drm_dmi_panel_orientation_data asus_t100ha = {
 	.width = 800,
 	.height = 1280,
@@ -67,7 +73,13 @@ static const struct drm_dmi_panel_orient
 };
 
 static const struct dmi_system_id orientation_data[] = {
-	{	/* Asus T100HA */
+	{	/* Acer One 10 (S1003) */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Acer"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "One S1003"),
+		},
+		.driver_data = (void *)&acer_s1003,
+	}, {	/* Asus T100HA */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "T100HAN"),


