Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CBEC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F7D420811
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548693236;
	bh=p2kY+k1z/wTru5LpIlIQzRRmLPhnpR45rxSbIV5tulo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Gt0eUzmfbd80CLuvL9TQuJRS72yYi8P5D70iuR1kRErerEnWs0w/lGhEyGs83FFN5
	 yb4VgGGwfUMJdH4rHZq9d1w3qBYBy5gMSkrVYhhsA9l2yZXS/reS0PSbSpNZggpNpr
	 ugvYwiTHNpM6qwthQ6RbSy71gGV/QsmEnyxuGN0E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390362AbfA1Qdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:33:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:35510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731993AbfA1Q0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:26:17 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 827B32084A;
        Mon, 28 Jan 2019 16:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692777;
        bh=p2kY+k1z/wTru5LpIlIQzRRmLPhnpR45rxSbIV5tulo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fHGNTE7k8ecgeW113fzdYFAMZW+qwS+UOH/xozb/ak31uapTCIzDJdbyn8aC0As+k
         WTpE+y6Los+w5EIeNQEKiixRHrx8ilfsLhgjMx9l4Ho+zVv1PKXcM6Mn/dMgIXeohm
         Lvii84MEPP/xZsXv2sQLEAK7IAqVGGYpD3ymnOfU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>, Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 77/80] HID: lenovo: Add checks to fix of_led_classdev_register
Date:   Mon, 28 Jan 2019 11:23:58 -0500
Message-Id: <20190128162401.58841-77-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128162401.58841-1-sashal@kernel.org>
References: <20190128162401.58841-1-sashal@kernel.org>
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
index 8979f1fd5208..24a4a23bdc90 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -703,7 +703,9 @@ static int lenovo_probe_tpkbd(struct hid_device *hdev)
 	data_pointer->led_mute.brightness_get = lenovo_led_brightness_get_tpkbd;
 	data_pointer->led_mute.brightness_set = lenovo_led_brightness_set_tpkbd;
 	data_pointer->led_mute.dev = dev;
-	led_classdev_register(dev, &data_pointer->led_mute);
+	ret = led_classdev_register(dev, &data_pointer->led_mute);
+	if (ret < 0)
+		goto err;
 
 	data_pointer->led_micmute.name = name_micmute;
 	data_pointer->led_micmute.brightness_get =
@@ -711,7 +713,11 @@ static int lenovo_probe_tpkbd(struct hid_device *hdev)
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

