Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB9DC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57C7A20839
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMl/RPaw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57C7A20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732641AbeKLJst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:48:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:34210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732353AbeKLISG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:18:06 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A3A4215EA;
        Sun, 11 Nov 2018 22:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975291;
        bh=AOz+cb/9ahYPTbIGc2KJT+9nZ7iddcKF4Rq0rmw2FqM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eMl/RPawAHuOKh9sEqY5/xH0+xxEUbLDag+tp2B/IcqpBoD/dSRWvDt9E+sGA7zWh
         rhHDSY+3bornd3+E8sKwDyqb09FvxqAb+dOIKFxUD7Kp4H2oZi5h6N3wDjGZB9o9vn
         FtX2dVNpwjePo+ZNuM2UM7sFux8MIZJm4S/dg4OI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jason Gerecke <jason.gerecke@wacom.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 4.19 232/361] HID: wacom: Work around HID descriptor bug in DTK-2451 and DTH-2452
Date:   Sun, 11 Nov 2018 14:19:39 -0800
Message-Id: <20181111221651.616099405@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Gerecke <killertofu@gmail.com>

commit 11db8173dbab7a94cf5ba5225fcedbfc0f3b7e54 upstream.

The DTK-2451 and DTH-2452 have a buggy HID descriptor which incorrectly
contains a Cintiq-like report, complete with pen tilt, rotation, twist, serial
number, etc. The hardware doesn't actually support this data but our driver
duitifully sets up the device as though it does. To ensure userspace has a
correct view of devices without updated firmware, we clean up this incorrect
data in wacom_setup_device_quirks.

We're also careful to clear the WACOM_QUIRK_TOOLSERIAL flag since its presence
causes the driver to wait for serial number information (via
wacom_wac_pen_serial_enforce) that never comes, resulting in
the pen being non-responsive.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
Fixes: 8341720642 ("HID: wacom: Queue events with missing type/serial data for later processing")
Cc: stable@vger.kernel.org # v4.16+
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/wacom_wac.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -3335,6 +3335,7 @@ static void wacom_setup_intuos(struct wa
 
 void wacom_setup_device_quirks(struct wacom *wacom)
 {
+	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
 	struct wacom_features *features = &wacom->wacom_wac.features;
 
 	/* The pen and pad share the same interface on most devices */
@@ -3464,6 +3465,24 @@ void wacom_setup_device_quirks(struct wa
 
 	if (features->type == REMOTE)
 		features->device_type |= WACOM_DEVICETYPE_WL_MONITOR;
+
+	/* HID descriptor for DTK-2451 / DTH-2452 claims to report lots
+	 * of things it shouldn't. Lets fix up the damage...
+	 */
+	if (wacom->hdev->product == 0x382 || wacom->hdev->product == 0x37d) {
+		features->quirks &= ~WACOM_QUIRK_TOOLSERIAL;
+		__clear_bit(BTN_TOOL_BRUSH, wacom_wac->pen_input->keybit);
+		__clear_bit(BTN_TOOL_PENCIL, wacom_wac->pen_input->keybit);
+		__clear_bit(BTN_TOOL_AIRBRUSH, wacom_wac->pen_input->keybit);
+		__clear_bit(ABS_Z, wacom_wac->pen_input->absbit);
+		__clear_bit(ABS_DISTANCE, wacom_wac->pen_input->absbit);
+		__clear_bit(ABS_TILT_X, wacom_wac->pen_input->absbit);
+		__clear_bit(ABS_TILT_Y, wacom_wac->pen_input->absbit);
+		__clear_bit(ABS_WHEEL, wacom_wac->pen_input->absbit);
+		__clear_bit(ABS_MISC, wacom_wac->pen_input->absbit);
+		__clear_bit(MSC_SERIAL, wacom_wac->pen_input->mscbit);
+		__clear_bit(EV_MSC, wacom_wac->pen_input->evbit);
+	}
 }
 
 int wacom_setup_pen_input_capabilities(struct input_dev *input_dev,


