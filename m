Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/HO0JpqldUPQ4fD+UWRDmFuFRY8+XL9INlnGsnXWCKXI5OGwjZ1hYDewjx94jSSRMaW4/V
ARC-Seal: i=1; a=rsa-sha256; t=1524406177; cv=none;
        d=google.com; s=arc-20160816;
        b=dg0eRJh2/17FtfsM7QmUh//Rik96wnCFRmGh/Ptk+ZFRcj9yCL2r6d1xcIzUfQxdDF
         0r1ikf3+K+3CDWN7O20Aud1t8ek2CCPLEqYl62B8V/3iz8Xkoz9p6wVXahQBsPf1Lox4
         78wv7z10tPWpSFAiubNp8Gb9rB+EoO3puzj5NFY0TmFJoaCTGrauRyMDABEWXqXaKUq2
         wHXOePXHj0nsuKhfNktmGNyaKItR2+KZgwCCvS3MVkQFopCeP45oGCHOK800WZnIJ8+j
         rEDZb35vE/E3q+KBHn+jhuKhYDB93GcXj/IDMR4S6ccBVfiedwGrZBDn0k06ivKZlJa7
         sikQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ThfBjUrGFEEBJuqhP9tAMAAVsHbLmLNxHDKf4ke+Pv8=;
        b=KUBdH+0NWJjWJ+1Q0KSKfvTFIAZ5FDcIxEkSX09FPHgYr6D1Sng/DS3vfHnFygE8yV
         fd9xoxBKbnTvBUCqm342ww8IYAUI2aHjxf6vpueWV9k8/MOudHUIHo/t4/s1HJzpBQfs
         1jYbwzwrSp3r7arnzpgeMQCvvf+U/HBwTvaxiM9AF8nrsKyjuDPQE/3eNu4R/eO/Vfj1
         bdDOCHkiU41r/IWKJCIQqVYdNKFd/AY90zQ+EIjco3qqzbcbY/yV/faNScExDEplGgmn
         a/AUccaC6NUvjiAml9bFtfthu08NaIW8rzzuYgtyLvTXfqoxqqUhxLPhvb+NaBmOTKxu
         tkwQ==
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
Subject: [PATCH 4.14 140/164] HID: wacom: bluetooth: send exit report for recent Bluetooth devices
Date: Sun, 22 Apr 2018 15:53:27 +0200
Message-Id: <20180422135141.176234098@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455253524097699?=
X-GMAIL-MSGID: =?utf-8?q?1598455731963300236?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
