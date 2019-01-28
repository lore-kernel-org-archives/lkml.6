Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BEEC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDCC42087E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548693720;
	bh=WJsU1MnbQNDmxZxTnp/bb6H3l/XkJWnLbjTSfk6N/38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f1SIZzm4bDBwe1iAcTb8WLm7ZEBERdM3KM4Dg0ERVkh8ftWGdRbwZTWdy4Unja0IB
	 Z/9B7PAiK6Nn/4M2Fl+kikNXJ+hySNSw7uF3hc1Bpr5C9t31SZ0+1XpTf1+6ywrg63
	 ePN9qnXFNOjqMozugZCfXAPT2AZ2zqk7Gpw9DDsY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389865AbfA1Ql6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:41:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:60162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389529AbfA1QXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:23:49 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57F062147A;
        Mon, 28 Jan 2019 16:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692629;
        bh=WJsU1MnbQNDmxZxTnp/bb6H3l/XkJWnLbjTSfk6N/38=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CKZRZgutzy+2t82E7STBsWqnUPBHclucznzllcsO/i30qo4ANlrZr3z0mrWH6F+1K
         mRjzQkgAG/kaAYoagTad7GxeP1Gc3mgIToOT5Ta28E9VUpGw54Qe4A9uy2fue75oeI
         W2PWPC+LWvpSWi1EkJLLy0oEVdoQH0TCSMF5seF8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>, Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 102/107] HID: lenovo: Add checks to fix of_led_classdev_register
Date:   Mon, 28 Jan 2019 11:19:42 -0500
Message-Id: <20190128161947.57405-102-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161947.57405-1-sashal@kernel.org>
References: <20190128161947.57405-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aditya Pakki <pakki001@umn.edu>

[ Upstream commit 6ae16dfb61bce538d48b7fe98160fada446056c5 ]

In lenovo_probe_tpkbd(), the function of_led_classdev_register() could
return an error value that is unchecked. The fix adds these checks.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-lenovo.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index 1ac4ff4d57a6..d409cc8759fc 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -713,7 +713,9 @@ static int lenovo_probe_tpkbd(struct hid_device *hdev)
 	data_pointer->led_mute.brightness_get = lenovo_led_brightness_get_tpkbd;
 	data_pointer->led_mute.brightness_set = lenovo_led_brightness_set_tpkbd;
 	data_pointer->led_mute.dev = dev;
-	led_classdev_register(dev, &data_pointer->led_mute);
+	ret = led_classdev_register(dev, &data_pointer->led_mute);
+	if (ret < 0)
+		goto err;
 
 	data_pointer->led_micmute.name = name_micmute;
 	data_pointer->led_micmute.brightness_get =
@@ -721,7 +723,11 @@ static int lenovo_probe_tpkbd(struct hid_device *hdev)
 	data_pointer->led_micmute.brightness_set =
 		lenovo_led_brightness_set_tpkbd;
 	data_pointer->led_micmute.dev = dev;
-	led_classdev_register(dev, &data_pointer->led_micmute);
+	ret = led_classdev_register(dev, &data_pointer->led_micmute);
+	if (ret < 0) {
+		led_classdev_unregister(&data_pointer->led_mute);
+		goto err;
+	}
 
 	lenovo_features_set_tpkbd(hdev);
 
-- 
2.19.1

