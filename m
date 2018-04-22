Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+dlaFLapRfXymSYjjWp0RQi1DEeffuNbHBWGgg1FdRFdOd+SNWAJF2dBEkhK20PoUYVKT9
ARC-Seal: i=1; a=rsa-sha256; t=1524405716; cv=none;
        d=google.com; s=arc-20160816;
        b=FxvSBgqrnKq+XYLn6HRn1c1udfRKuQP4sIOe/XTlqbosWsmgubS1pTbTdE+SudVqHj
         gFZGCX+vjeQsROsKTfVDvthLEGafVmfcRiT7wqwGQGwMSvURg5XRHsdv65vK1R+yr0Ka
         sxxXavORAYZmCyYGPhNFYX9xp3iq/6L3+LvxC6tHwPehtPUf2AQiEyJoYVSgHUY1darg
         EVbYVAYx6uhHID56AJMIZypcEVkCEmkcBCVKWEHACgUZ3hDJ/aTCHLM/d4f3UbsniQ3u
         mUD4snQZ4slKRAqbUdOqNTIkqOfQZ28zJnP1rt6WT+48v5o57uPo0cMZs/Bp+5DbI21x
         Szqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=8etDOnFHcjB3Elo7wVER7gy6lklEh3/rmLIiSVtA+e8=;
        b=mPUHOIeTv8wl8/dclKfcMeGcR1HxOY7LnEvZD5ddVuym+lnpucJzXJPNGkzzKGJDsD
         TtGupin4X5T8ccQfKB1wAJ41xSJAp+4a0m6pzslbGfkJGTu4aIp9UeUXymTcYjCamhvu
         LESKqTbcO6KXHZZEc6JPKpmOcwGYc3Mc4E9lnkxYiEPZEGYmm+zfiW3LIaHRCRPKMGAo
         ManHmUTIk1N9arNWnEvzUrulVCmmYHwLqpPHlnlvBsYkYQx9KYIURbIeyVTV/TA5MCt7
         aI3b5u8u9s/3Gud5mrvJdqKOLFutMD/ZLBddhKkEkrv3lq3hsBbRe8mIjDCHOg3TO0Xx
         bukQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 4.16 169/196] HID: input: fix battery level reporting on BT mice
Date: Sun, 22 Apr 2018 15:53:09 +0200
Message-Id: <20180422135113.006362287@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455248353149624?=
X-GMAIL-MSGID: =?utf-8?q?1598455248353149624?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

commit 2e210bbb7429cdcf1a1a3ad00c1bf98bd9bf2452 upstream.

The commit 581c4484769e ("HID: input: map digitizer battery usage")
assumed that devices having input (qas opposed to feature) report for
battery strength would report the data on their own, without the need to
be polled by the kernel; unfortunately it is not so. Many wireless mice
do not send unsolicited reports with battery strength data and have to
be polled explicitly. As a complication, stylus devices on digitizers
are not normally connected to the base and thus can not be polled - the
base can only determine battery strength in the stylus when it is in
proximity.

To solve this issue, we add a special flag that tells the kernel
to avoid polling the device (and expect unsolicited reports) and set it
when report field with physical usage of digitizer stylus (HID_DG_STYLUS).
Unless this flag is set, and we have not seen the unsolicited reports,
the kernel will attempt to poll the device when userspace attempts to
read "capacity" and "state" attributes of power_supply object
corresponding to the devices battery.

Fixes: 581c4484769e ("HID: input: map digitizer battery usage")
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=198095
Cc: stable@vger.kernel.org
Reported-and-tested-by: Martin van Es <martin@mrvanes.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/hid-input.c |   24 +++++++++++++++++-------
 include/linux/hid.h     |    9 ++++++++-
 2 files changed, 25 insertions(+), 8 deletions(-)

--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -387,7 +387,8 @@ static int hidinput_get_battery_property
 		break;
 
 	case POWER_SUPPLY_PROP_CAPACITY:
-		if (dev->battery_report_type == HID_FEATURE_REPORT) {
+		if (dev->battery_status != HID_BATTERY_REPORTED &&
+		    !dev->battery_avoid_query) {
 			value = hidinput_query_battery_capacity(dev);
 			if (value < 0)
 				return value;
@@ -403,17 +404,17 @@ static int hidinput_get_battery_property
 		break;
 
 	case POWER_SUPPLY_PROP_STATUS:
-		if (!dev->battery_reported &&
-		    dev->battery_report_type == HID_FEATURE_REPORT) {
+		if (dev->battery_status != HID_BATTERY_REPORTED &&
+		    !dev->battery_avoid_query) {
 			value = hidinput_query_battery_capacity(dev);
 			if (value < 0)
 				return value;
 
 			dev->battery_capacity = value;
-			dev->battery_reported = true;
+			dev->battery_status = HID_BATTERY_QUERIED;
 		}
 
-		if (!dev->battery_reported)
+		if (dev->battery_status == HID_BATTERY_UNKNOWN)
 			val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
 		else if (dev->battery_capacity == 100)
 			val->intval = POWER_SUPPLY_STATUS_FULL;
@@ -486,6 +487,14 @@ static int hidinput_setup_battery(struct
 	dev->battery_report_type = report_type;
 	dev->battery_report_id = field->report->id;
 
+	/*
+	 * Stylus is normally not connected to the device and thus we
+	 * can't query the device and get meaningful battery strength.
+	 * We have to wait for the device to report it on its own.
+	 */
+	dev->battery_avoid_query = report_type == HID_INPUT_REPORT &&
+				   field->physical == HID_DG_STYLUS;
+
 	dev->battery = power_supply_register(&dev->dev, psy_desc, &psy_cfg);
 	if (IS_ERR(dev->battery)) {
 		error = PTR_ERR(dev->battery);
@@ -530,9 +539,10 @@ static void hidinput_update_battery(stru
 
 	capacity = hidinput_scale_battery_capacity(dev, value);
 
-	if (!dev->battery_reported || capacity != dev->battery_capacity) {
+	if (dev->battery_status != HID_BATTERY_REPORTED ||
+	    capacity != dev->battery_capacity) {
 		dev->battery_capacity = capacity;
-		dev->battery_reported = true;
+		dev->battery_status = HID_BATTERY_REPORTED;
 		power_supply_changed(dev->battery);
 	}
 }
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -515,6 +515,12 @@ enum hid_type {
 	HID_TYPE_USBNONE
 };
 
+enum hid_battery_status {
+	HID_BATTERY_UNKNOWN = 0,
+	HID_BATTERY_QUERIED,		/* Kernel explicitly queried battery strength */
+	HID_BATTERY_REPORTED,		/* Device sent unsolicited battery strength report */
+};
+
 struct hid_driver;
 struct hid_ll_driver;
 
@@ -557,7 +563,8 @@ struct hid_device {							/* device repo
 	__s32 battery_max;
 	__s32 battery_report_type;
 	__s32 battery_report_id;
-	bool battery_reported;
+	enum hid_battery_status battery_status;
+	bool battery_avoid_query;
 #endif
 
 	unsigned int status;						/* see STAT flags above */
