Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5647C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 17:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5723920645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 17:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sEDdcQLX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5723920645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbeJOBTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 21:19:06 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33027 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbeJOBTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 21:19:06 -0400
Received: by mail-wr1-f66.google.com with SMTP id e4-v6so18623562wrs.0;
        Sun, 14 Oct 2018 10:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pHwuCfdlrtnQFSLrnA5k3eaVMlLXgpxZM5L79HbS5hE=;
        b=sEDdcQLX5FBKU8ffiXZoZaPs13EDzICXunkPN4cq6OxG3zcrK8MxCYxlEo//JKVf9O
         rC0SfRD7u4+qhlbIELabtOSIldhkeJxvJIYthp/lijwhjEESR1omPt4udwFRbpkV9MNj
         fPRC0SMopPYd3lujVf2WrrcxcXa4EDT1rppl/EpGjsbjqj0hgOioFje9VzEKEKDxVtYy
         0w26KK/tvH1u7Es4Dimtzq5IagSoVkEewGcJ1JhDmWL/RVRBwsspnVRN7DkCup4Ez33A
         8zeoeEU6I94cayFrzQJvYI7b8CCod9gyHrN9STmvdCHbLEi5l9yuwTFK94EdiYvn25yE
         wmcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pHwuCfdlrtnQFSLrnA5k3eaVMlLXgpxZM5L79HbS5hE=;
        b=UmG7QBzHExFapqXs3J+fhgQibnUL5ESskQ+uc+oiTTXcNP8+fcL6z7w6v8U7HTm5Qd
         5ZT3+dMqmJJLAB3JRuNbqdF+ucXKQnhE8qOM/6W0hi1cdQxzeCVzq4gSC9M1BIH4ajud
         FjPey1CC9uu6PwB6fzREjYJh7syCGmct8uzw1tmczqVaDLVWi510gjuW4uJwBWr0aaXC
         gbQecYTtIdudtdvZFGDPPUtGS0fJVUVV0sYCdwltiIudNJzyFvpXr4L9iqrVXxV+Ni9o
         dnF/OPXdGZ+GFlhXi2g7LIWrQqZAbUbVg6mwA6LPkaj1JyTtvmuCyUsdhJFX/OVEpmzz
         RTrw==
X-Gm-Message-State: ABuFfojKaHnQy5B3LK+LX7JJDL2J9df0jCe8GFRG9yCEy0nERrY1nCi+
        CMrR5O21TAkDSrHLaz3EFFQ=
X-Google-Smtp-Source: ACcGV63aYABPhUosoK+Fx0gg9GRZTJ6ucmsEtvT1aILgW/rUigTX1kOQfnj8YiEFNbJ2MYfw70AXDA==
X-Received: by 2002:a5d:4151:: with SMTP id c17-v6mr11611821wrq.61.1539538638500;
        Sun, 14 Oct 2018 10:37:18 -0700 (PDT)
Received: from localhost.localdomain ([89.128.102.109])
        by smtp.gmail.com with ESMTPSA id z8-v6sm5932541wrp.63.2018.10.14.10.37.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 10:37:17 -0700 (PDT)
From:   Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>
Cc:     Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
Subject: [PATCH] HID: steam: remove input device when a hid client is running.
Date:   Sun, 14 Oct 2018 19:36:43 +0200
Message-Id: <20181014173643.9643-1-rodrigorivascosta@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, when a HID client such as the Steam Client was running, this
driver disabled its input device to avoid doubling the input events.

While it worked mostly fine, some games got confused by the idle gamepad,
and switched to two player mode, or asked the user to choose which gamepad
to use. Other games just crashed, probably a bug in Unity [1].

With this commit, when a HID client starts, the input device is removed;
when the HID client ends the input device is recreated.

[1]: https://github.com/ValveSoftware/steam-for-linux/issues/5645

Signed-off-by: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
---
 drivers/hid/hid-steam.c | 154 +++++++++++++++++++++++-----------------
 1 file changed, 90 insertions(+), 64 deletions(-)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index 0422ec2b13d2..dc4128bfe2ca 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -23,8 +23,9 @@
  * In order to avoid breaking them this driver creates a layered hidraw device,
  * so it can detect when the client is running and then:
  *  - it will not send any command to the controller.
- *  - this input device will be disabled, to avoid double input of the same
+ *  - this input device will be removed, to avoid double input of the same
  *    user action.
+ * When the client is closed, this input device will be created again.
  *
  * For additional functions, such as changing the right-pad margin or switching
  * the led, you can use the user-space tool at:
@@ -113,7 +114,7 @@ struct steam_device {
 	spinlock_t lock;
 	struct hid_device *hdev, *client_hdev;
 	struct mutex mutex;
-	bool client_opened, input_opened;
+	bool client_opened;
 	struct input_dev __rcu *input;
 	unsigned long quirks;
 	struct work_struct work_connect;
@@ -279,18 +280,6 @@ static void steam_set_lizard_mode(struct steam_device *steam, bool enable)
 	}
 }
 
-static void steam_update_lizard_mode(struct steam_device *steam)
-{
-	mutex_lock(&steam->mutex);
-	if (!steam->client_opened) {
-		if (steam->input_opened)
-			steam_set_lizard_mode(steam, false);
-		else
-			steam_set_lizard_mode(steam, lizard_mode);
-	}
-	mutex_unlock(&steam->mutex);
-}
-
 static int steam_input_open(struct input_dev *dev)
 {
 	struct steam_device *steam = input_get_drvdata(dev);
@@ -301,7 +290,6 @@ static int steam_input_open(struct input_dev *dev)
 		return ret;
 
 	mutex_lock(&steam->mutex);
-	steam->input_opened = true;
 	if (!steam->client_opened && lizard_mode)
 		steam_set_lizard_mode(steam, false);
 	mutex_unlock(&steam->mutex);
@@ -313,7 +301,6 @@ static void steam_input_close(struct input_dev *dev)
 	struct steam_device *steam = input_get_drvdata(dev);
 
 	mutex_lock(&steam->mutex);
-	steam->input_opened = false;
 	if (!steam->client_opened && lizard_mode)
 		steam_set_lizard_mode(steam, true);
 	mutex_unlock(&steam->mutex);
@@ -400,7 +387,7 @@ static int steam_battery_register(struct steam_device *steam)
 	return 0;
 }
 
-static int steam_register(struct steam_device *steam)
+static int steam_input_register(struct steam_device *steam)
 {
 	struct hid_device *hdev = steam->hdev;
 	struct input_dev *input;
@@ -414,17 +401,6 @@ static int steam_register(struct steam_device *steam)
 		return 0;
 	}
 
-	/*
-	 * Unlikely, but getting the serial could fail, and it is not so
-	 * important, so make up a serial number and go on.
-	 */
-	if (steam_get_serial(steam) < 0)
-		strlcpy(steam->serial_no, "XXXXXXXXXX",
-				sizeof(steam->serial_no));
-
-	hid_info(hdev, "Steam Controller '%s' connected",
-			steam->serial_no);
-
 	input = input_allocate_device();
 	if (!input)
 		return -ENOMEM;
@@ -492,11 +468,6 @@ static int steam_register(struct steam_device *steam)
 		goto input_register_fail;
 
 	rcu_assign_pointer(steam->input, input);
-
-	/* ignore battery errors, we can live without it */
-	if (steam->quirks & STEAM_QUIRK_WIRELESS)
-		steam_battery_register(steam);
-
 	return 0;
 
 input_register_fail:
@@ -504,27 +475,88 @@ static int steam_register(struct steam_device *steam)
 	return ret;
 }
 
-static void steam_unregister(struct steam_device *steam)
+static void steam_input_unregister(struct steam_device *steam)
 {
 	struct input_dev *input;
+	rcu_read_lock();
+	input = rcu_dereference(steam->input);
+	rcu_read_unlock();
+	if (!input)
+		return;
+	RCU_INIT_POINTER(steam->input, NULL);
+	synchronize_rcu();
+	input_unregister_device(input);
+}
+
+static void steam_battery_unregister(struct steam_device *steam)
+{
 	struct power_supply *battery;
 
 	rcu_read_lock();
-	input = rcu_dereference(steam->input);
 	battery = rcu_dereference(steam->battery);
 	rcu_read_unlock();
 
-	if (battery) {
-		RCU_INIT_POINTER(steam->battery, NULL);
-		synchronize_rcu();
-		power_supply_unregister(battery);
+	if (!battery)
+		return;
+	RCU_INIT_POINTER(steam->battery, NULL);
+	synchronize_rcu();
+	power_supply_unregister(battery);
+}
+
+static int steam_register(struct steam_device *steam)
+{
+	int ret;
+
+	/*
+	 * This function can be called several times in a row with the
+	 * wireless adaptor, without steam_unregister() between them, because
+	 * another client send a get_connection_status command, for example.
+	 * The battery and serial number are set just once per device.
+	 */
+	if (!steam->serial_no[0]) {
+		/*
+		 * Unlikely, but getting the serial could fail, and it is not so
+		 * important, so make up a serial number and go on.
+		 */
+		if (steam_get_serial(steam) < 0)
+			strlcpy(steam->serial_no, "XXXXXXXXXX",
+					sizeof(steam->serial_no));
+
+		hid_info(steam->hdev, "Steam Controller '%s' connected",
+				steam->serial_no);
+
+		/* ignore battery errors, we can live without it */
+		if (steam->quirks & STEAM_QUIRK_WIRELESS)
+			steam_battery_register(steam);
+
+		mutex_lock(&steam_devices_lock);
+		list_add(&steam->list, &steam_devices);
+		mutex_unlock(&steam_devices_lock);
 	}
-	if (input) {
-		RCU_INIT_POINTER(steam->input, NULL);
-		synchronize_rcu();
+
+	mutex_lock(&steam->mutex);
+	if (!steam->client_opened) {
+		steam_set_lizard_mode(steam, lizard_mode);
+		ret = steam_input_register(steam);
+	} else {
+		ret = 0;
+	}
+	mutex_unlock(&steam->mutex);
+
+	return ret;
+}
+
+static void steam_unregister(struct steam_device *steam)
+{
+	steam_battery_unregister(steam);
+	steam_input_unregister(steam);
+	if (steam->serial_no[0]) {
 		hid_info(steam->hdev, "Steam Controller '%s' disconnected",
 				steam->serial_no);
-		input_unregister_device(input);
+		mutex_lock(&steam_devices_lock);
+		list_del(&steam->list);
+		mutex_unlock(&steam_devices_lock);
+		steam->serial_no[0] = 0;
 	}
 }
 
@@ -600,6 +632,9 @@ static int steam_client_ll_open(struct hid_device *hdev)
 	mutex_lock(&steam->mutex);
 	steam->client_opened = true;
 	mutex_unlock(&steam->mutex);
+
+	steam_input_unregister(steam);
+
 	return ret;
 }
 
@@ -609,13 +644,13 @@ static void steam_client_ll_close(struct hid_device *hdev)
 
 	mutex_lock(&steam->mutex);
 	steam->client_opened = false;
-	if (steam->input_opened)
-		steam_set_lizard_mode(steam, false);
-	else
-		steam_set_lizard_mode(steam, lizard_mode);
 	mutex_unlock(&steam->mutex);
 
 	hid_hw_close(steam->hdev);
+	if (steam->connected) {
+		steam_set_lizard_mode(steam, lizard_mode);
+		steam_input_register(steam);
+	}
 }
 
 static int steam_client_ll_raw_request(struct hid_device *hdev,
@@ -744,11 +779,6 @@ static int steam_probe(struct hid_device *hdev,
 		}
 	}
 
-	mutex_lock(&steam_devices_lock);
-	steam_update_lizard_mode(steam);
-	list_add(&steam->list, &steam_devices);
-	mutex_unlock(&steam_devices_lock);
-
 	return 0;
 
 hid_hw_open_fail:
@@ -774,10 +804,6 @@ static void steam_remove(struct hid_device *hdev)
 		return;
 	}
 
-	mutex_lock(&steam_devices_lock);
-	list_del(&steam->list);
-	mutex_unlock(&steam_devices_lock);
-
 	hid_destroy_device(steam->client_hdev);
 	steam->client_opened = false;
 	cancel_work_sync(&steam->work_connect);
@@ -792,12 +818,14 @@ static void steam_remove(struct hid_device *hdev)
 static void steam_do_connect_event(struct steam_device *steam, bool connected)
 {
 	unsigned long flags;
+	bool changed;
 
 	spin_lock_irqsave(&steam->lock, flags);
+	changed = steam->connected != connected;
 	steam->connected = connected;
 	spin_unlock_irqrestore(&steam->lock, flags);
 
-	if (schedule_work(&steam->work_connect) == 0)
+	if (changed && schedule_work(&steam->work_connect) == 0)
 		dbg_hid("%s: connected=%d event already queued\n",
 				__func__, connected);
 }
@@ -1019,13 +1047,8 @@ static int steam_raw_event(struct hid_device *hdev,
 			return 0;
 		rcu_read_lock();
 		input = rcu_dereference(steam->input);
-		if (likely(input)) {
+		if (likely(input))
 			steam_do_input_event(steam, input, data);
-		} else {
-			dbg_hid("%s: input data without connect event\n",
-					__func__);
-			steam_do_connect_event(steam, true);
-		}
 		rcu_read_unlock();
 		break;
 	case STEAM_EV_CONNECT:
@@ -1074,7 +1097,10 @@ static int steam_param_set_lizard_mode(const char *val,
 
 	mutex_lock(&steam_devices_lock);
 	list_for_each_entry(steam, &steam_devices, list) {
-		steam_update_lizard_mode(steam);
+		mutex_lock(&steam->mutex);
+		if (!steam->client_opened)
+			steam_set_lizard_mode(steam, lizard_mode);
+		mutex_unlock(&steam->mutex);
 	}
 	mutex_unlock(&steam_devices_lock);
 	return 0;
-- 
2.19.1

