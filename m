Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E869C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E183C2081B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896603;
	bh=t+P0cjMIqUmXL6Am3GRj0ZJIXEQW7QdSf2CZV4HfqHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NPQijn2y8T741MFJz/aysoh2I/XtKbtG0sweae0fjbWgxwkMtzh/PuIuCGYsPE2Dz
	 RuWiEvN4Sff5B3Qpesy7gOEWiizvVjFBLR9KWznAToGHnCf75cz1ZST59LIUvZ4MGy
	 M1OI7hEixTxaimPXvtkJgBfrnWIcYJ8pWv7OH8MM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388002AbfBKOuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:50:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:35644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387975AbfBKOt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:49:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E081420700;
        Mon, 11 Feb 2019 14:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896597;
        bh=t+P0cjMIqUmXL6Am3GRj0ZJIXEQW7QdSf2CZV4HfqHg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XdCrinDj6JXOKiVUiuGJHUYfJ3NAvo7EbwSdNipBz33kvs86z/41MAxKCgtYMGCv2
         rDOK6caxbt6rv1HOVXI1wzY7zzjbLRUPGSVkPOvzkH6Aj4wbzXyPBe0oURxGrBwPZO
         2+MwjXUzEj2Sh3dheFMG3loQaFTIXcri1Rw8aaeg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 238/313] HID: lenovo: Add checks to fix of_led_classdev_register
Date:   Mon, 11 Feb 2019 15:18:38 +0100
Message-Id: <20190211141909.351316994@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 643b6eb54442..eacc76d2ab96 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -743,7 +743,9 @@ static int lenovo_probe_tpkbd(struct hid_device *hdev)
 	data_pointer->led_mute.brightness_get = lenovo_led_brightness_get_tpkbd;
 	data_pointer->led_mute.brightness_set = lenovo_led_brightness_set_tpkbd;
 	data_pointer->led_mute.dev = dev;
-	led_classdev_register(dev, &data_pointer->led_mute);
+	ret = led_classdev_register(dev, &data_pointer->led_mute);
+	if (ret < 0)
+		goto err;
 
 	data_pointer->led_micmute.name = name_micmute;
 	data_pointer->led_micmute.brightness_get =
@@ -751,7 +753,11 @@ static int lenovo_probe_tpkbd(struct hid_device *hdev)
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



