Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A647C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5831620645
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:05:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5831620645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbeJLViG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 17:38:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37066 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727556AbeJLViG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 17:38:06 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C540C307D985;
        Fri, 12 Oct 2018 14:05:30 +0000 (UTC)
Received: from plouf.redhat.com (ovpn-204-150.brq.redhat.com [10.40.204.150])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D139E2A198;
        Fri, 12 Oct 2018 14:05:28 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>, Masaki Ota <masaki.ota@jp.alps.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH] HID: alps: allow incoming reports when only the trackstick is opened
Date:   Fri, 12 Oct 2018 16:05:25 +0200
Message-Id: <20181012140525.24799-1-benjamin.tissoires@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 12 Oct 2018 14:05:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If userspace only reads the trackstick node, and no one is listening to
the touchpad nor the hidraw node then, the device is not powered on.

Add open/close callbacks to allow users to disable the touchpad in Gnome
while keeping the trackstick active.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=1559632
Link: https://gitlab.gnome.org/GNOME/mutter/issues/128
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-alps.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/hid/hid-alps.c b/drivers/hid/hid-alps.c
index aec253b44156..3cd7229b6e54 100644
--- a/drivers/hid/hid-alps.c
+++ b/drivers/hid/hid-alps.c
@@ -660,6 +660,20 @@ static int T4_init(struct hid_device *hdev, struct alps_dev *pri_data)
 	return ret;
 }
 
+static int alps_sp_open(struct input_dev *dev)
+{
+	struct hid_device *hid = input_get_drvdata(dev);
+
+	return hid_hw_open(hid);
+}
+
+static void alps_sp_close(struct input_dev *dev)
+{
+	struct hid_device *hid = input_get_drvdata(dev);
+
+	hid_hw_close(hid);
+}
+
 static int alps_input_configured(struct hid_device *hdev, struct hid_input *hi)
 {
 	struct alps_dev *data = hid_get_drvdata(hdev);
@@ -733,6 +747,10 @@ static int alps_input_configured(struct hid_device *hdev, struct hid_input *hi)
 		input2->id.version = input->id.version;
 		input2->dev.parent = input->dev.parent;
 
+		input_set_drvdata(input2, hdev);
+		input2->open = alps_sp_open;
+		input2->close = alps_sp_close;
+
 		__set_bit(EV_KEY, input2->evbit);
 		data->sp_btn_cnt = (data->sp_btn_info & 0x0F);
 		for (i = 0; i < data->sp_btn_cnt; i++)
-- 
2.14.3

