Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/EVOQXwk3YA4sSTulQq4Z1kpoXSrcsgZFj/VzWZ39qMnuLP7wmh3cu+trNFu7mcftHMYtX
ARC-Seal: i=1; a=rsa-sha256; t=1524405721; cv=none;
        d=google.com; s=arc-20160816;
        b=ehyZSiKlYWs2p17b4mTGen45DgsbjYkZAnqRGMQMwC589epQbJcgtgjphn0Uu5wfma
         elPQtMYlFYxKVjJ+FaeZFDPeNK7jLtBoO9eAU2MFvTUG8lmt39wkaQe89D4CZnA74Zyt
         05xr0hoiRdvcvmd3YT2TjldIvp6oxwlxA1bwK4X+Mhd9WntF+7bonbOPPtrunVMw7V06
         MkRcm/hzFUqU9QbmhYrHmGYFJbHXAZYPWoxPdeyw1f6YMbejey82SmPyRFEkUYDIVzwg
         qvZaMolspaP7uhoxfkAwpjeL551JwXZMzB+nl49qc+JXEHcVsA1Ye0BH11EpFmVoTTwY
         /FXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=txbRmqX7XuHhb1cJ5rAzPnb/OyZe91EIkTddocRnvp8=;
        b=JGJx/h/GLHLy4FJKC5J50I7xlleFzRhXDicH9VXN+eWgVTMCMayRI9O+xRCPsU2AMd
         LOdld9mAUztpksto0R7N7A+K4lEZeuQWcW+f56Mzxcw6pqt/+X98vwKjOhNmxmStW8se
         QWlaIdKTAJcq+5ACIRHzJLXtb5nRkKXTufA3t9o+0TIOmiRzicMuiSAO/eHYeUdk8Opq
         /rWUUkarVNjpmFUwdW5mG6eF5RxZHV3VTlv9RzdLUIPfGsfCFIIXDq31Mb9JVecOctQl
         LC6n86Ypqh/G4rgd7iZa/91wiOZdkKfZtgZzjKmbz770bLLI93A9kIlmYkg3kvyllKYo
         NIbA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Aaron Armstrong Skomra <aaron.skomra@wacom.com>,
	Ping Cheng <ping.cheng@wacom.com>,
	Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 4.16 171/196] HID: wacom: bluetooth: send exit report for recent Bluetooth devices
Date: Sun, 22 Apr 2018 15:53:11 +0200
Message-Id: <20180422135113.095020360@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455253524097699?=
X-GMAIL-MSGID: =?utf-8?q?1598455253524097699?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aaron Armstrong Skomra <skomra@gmail.com>

commit 619d3a2922ce623ca2eca443cc936810d328317c upstream.

The code path for recent Bluetooth devices omits an exit report which
resets all the values of the device.

Fixes: 4922cd26f0 ("HID: wacom: Support 2nd-gen Intuos Pro's Bluetooth classic interface")
Cc: <stable@vger.kernel.org> # 4.11
Signed-off-by: Aaron Armstrong Skomra <aaron.skomra@wacom.com>
Reviewed-by: Ping Cheng <ping.cheng@wacom.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/wacom_wac.c |   76 +++++++++++++++++++++++++++++-------------------
 1 file changed, 46 insertions(+), 30 deletions(-)

--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -689,6 +689,45 @@ static int wacom_intuos_get_tool_type(in
 	return tool_type;
 }
 
+static void wacom_exit_report(struct wacom_wac *wacom)
+{
+	struct input_dev *input = wacom->pen_input;
+	struct wacom_features *features = &wacom->features;
+	unsigned char *data = wacom->data;
+	int idx = (features->type == INTUOS) ? (data[1] & 0x01) : 0;
+
+	/*
+	 * Reset all states otherwise we lose the initial states
+	 * when in-prox next time
+	 */
+	input_report_abs(input, ABS_X, 0);
+	input_report_abs(input, ABS_Y, 0);
+	input_report_abs(input, ABS_DISTANCE, 0);
+	input_report_abs(input, ABS_TILT_X, 0);
+	input_report_abs(input, ABS_TILT_Y, 0);
+	if (wacom->tool[idx] >= BTN_TOOL_MOUSE) {
+		input_report_key(input, BTN_LEFT, 0);
+		input_report_key(input, BTN_MIDDLE, 0);
+		input_report_key(input, BTN_RIGHT, 0);
+		input_report_key(input, BTN_SIDE, 0);
+		input_report_key(input, BTN_EXTRA, 0);
+		input_report_abs(input, ABS_THROTTLE, 0);
+		input_report_abs(input, ABS_RZ, 0);
+	} else {
+		input_report_abs(input, ABS_PRESSURE, 0);
+		input_report_key(input, BTN_STYLUS, 0);
+		input_report_key(input, BTN_STYLUS2, 0);
+		input_report_key(input, BTN_TOUCH, 0);
+		input_report_abs(input, ABS_WHEEL, 0);
+		if (features->type >= INTUOS3S)
+			input_report_abs(input, ABS_Z, 0);
+	}
+	input_report_key(input, wacom->tool[idx], 0);
+	input_report_abs(input, ABS_MISC, 0); /* reset tool id */
+	input_event(input, EV_MSC, MSC_SERIAL, wacom->serial[idx]);
+	wacom->id[idx] = 0;
+}
+
 static int wacom_intuos_inout(struct wacom_wac *wacom)
 {
 	struct wacom_features *features = &wacom->features;
@@ -741,36 +780,7 @@ static int wacom_intuos_inout(struct wac
 		if (!wacom->id[idx])
 			return 1;
 
-		/*
-		 * Reset all states otherwise we lose the initial states
-		 * when in-prox next time
-		 */
-		input_report_abs(input, ABS_X, 0);
-		input_report_abs(input, ABS_Y, 0);
-		input_report_abs(input, ABS_DISTANCE, 0);
-		input_report_abs(input, ABS_TILT_X, 0);
-		input_report_abs(input, ABS_TILT_Y, 0);
-		if (wacom->tool[idx] >= BTN_TOOL_MOUSE) {
-			input_report_key(input, BTN_LEFT, 0);
-			input_report_key(input, BTN_MIDDLE, 0);
-			input_report_key(input, BTN_RIGHT, 0);
-			input_report_key(input, BTN_SIDE, 0);
-			input_report_key(input, BTN_EXTRA, 0);
-			input_report_abs(input, ABS_THROTTLE, 0);
-			input_report_abs(input, ABS_RZ, 0);
-		} else {
-			input_report_abs(input, ABS_PRESSURE, 0);
-			input_report_key(input, BTN_STYLUS, 0);
-			input_report_key(input, BTN_STYLUS2, 0);
-			input_report_key(input, BTN_TOUCH, 0);
-			input_report_abs(input, ABS_WHEEL, 0);
-			if (features->type >= INTUOS3S)
-				input_report_abs(input, ABS_Z, 0);
-		}
-		input_report_key(input, wacom->tool[idx], 0);
-		input_report_abs(input, ABS_MISC, 0); /* reset tool id */
-		input_event(input, EV_MSC, MSC_SERIAL, wacom->serial[idx]);
-		wacom->id[idx] = 0;
+		wacom_exit_report(wacom);
 		return 2;
 	}
 
@@ -1226,6 +1236,12 @@ static void wacom_intuos_pro2_bt_pen(str
 		if (!valid)
 			continue;
 
+		if (!prox) {
+			wacom->shared->stylus_in_proximity = false;
+			wacom_exit_report(wacom);
+			input_sync(pen_input);
+			return;
+		}
 		if (range) {
 			/* Fix rotation alignment: userspace expects zero at left */
 			int16_t rotation = (int16_t)get_unaligned_le16(&frame[9]);
