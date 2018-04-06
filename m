Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/9ol3BXlBE1Aqe+Zz7R09gZILAcwDEYWiy1uc4/2TttKPlC5Bx34B4XgIHboD9XXrjpGG/
ARC-Seal: i=1; a=rsa-sha256; t=1523021614; cv=none;
        d=google.com; s=arc-20160816;
        b=aO7g4YpcuG5nb2ojgYXW7LvgtYosutFpyeoCYsW38wZtdbGpVgHCphvkE13hUKFahD
         sUJBhM19ppn5y0DiDqePWM6QDEshxy4i+JXkO59Oh7wTP6cWZsV5PiTNe5IUz4CJqy64
         mr33/kEKRvnOcshYNGbtNfYvbWSjL3o2R6c3ymQb2tsFl6o5a6QIdd0ip15CWmFQ3F+F
         JifU65INq0kUkyThlWWJgWtIVBk9OOgB7v2GSSgDdO+4Ly/8PL08j9n1ET4pAj8cGh2w
         snSdDbyeX8FW01QS6gj4A7c7D4gJZlLzWdiGR93EoxPTii35uwVCtZhdmN/Xex1+W7Zb
         yTWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=zDly7uu1XpIlGYd0aQ0F+mo9LOFZTgvcgpuraeXMmfE=;
        b=Vg6OSVOABGIpTFhvDIbDb7KE4QRf049/wvLQqqi3F8qPBKcvYJXFhMMPsCJUCNHqQf
         J5HBgrQ1GWSj3bd1cg+l5XbmaQc6sJqRrJXVCDuC7EL/PI2BYlpzeLtMC1TvRVuVspLf
         I9U+dzh6M5SmTcn8AqpH+bjhJ3Wn+/ppRxkmCBMjwh7z4OeJCtW20zoS4zvGMi9vUNuD
         uYW1J5mYknJzGP2e4gnoJTP/CPF60+F2G+Bi+dOk0rpEBKCBM1I2GhkIDX4eHUD/ZTbC
         MxE/+LJMy3HHZFaFMhBFwbnxljZ0HHOKsNggWuiDvTae0q9Anre77cVyRIdnGtIbFIMl
         yWCQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Frank Praznik <frank.praznik@gmail.com>,
	Jiri Kosina <jkosina@suse.cz>,
	Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.9 027/102] HID: sony: Use LED_CORE_SUSPENDRESUME
Date: Fri,  6 Apr 2018 15:23:08 +0200
Message-Id: <20180406084335.460135496@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003911938399334?=
X-GMAIL-MSGID: =?utf-8?q?1597003911938399334?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Frank Praznik <frank.praznik@gmail.com>

commit 765a1077c85e5f2efcc43582f80caf43a052e903 upstream.

The LED subsystem provides the LED_CORE_SUSPENDRESUME flag to handle
automatically turning off and restoring the state of device LEDs during
suspend/resume.  Use this flag instead of saving and restoring the state
locally.

Signed-off-by: Frank Praznik <frank.praznik@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Cc: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/hid-sony.c |   45 +++++++++++++++------------------------------
 1 file changed, 15 insertions(+), 30 deletions(-)

--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1056,7 +1056,6 @@ struct sony_sc {
 	u8 battery_charging;
 	u8 battery_capacity;
 	u8 led_state[MAX_LEDS];
-	u8 resume_led_state[MAX_LEDS];
 	u8 led_delay_on[MAX_LEDS];
 	u8 led_delay_off[MAX_LEDS];
 	u8 led_count;
@@ -1793,6 +1792,7 @@ static int sony_leds_init(struct sony_sc
 		led->name = name;
 		led->brightness = sc->led_state[n];
 		led->max_brightness = max_brightness[n];
+		led->flags = LED_CORE_SUSPENDRESUME;
 		led->brightness_get = sony_led_get_brightness;
 		led->brightness_set = sony_led_set_brightness;
 
@@ -2509,47 +2509,32 @@ static void sony_remove(struct hid_devic
 
 static int sony_suspend(struct hid_device *hdev, pm_message_t message)
 {
-	/*
-	 * On suspend save the current LED state,
-	 * stop running force-feedback and blank the LEDS.
-	 */
-	if (SONY_LED_SUPPORT || SONY_FF_SUPPORT) {
-		struct sony_sc *sc = hid_get_drvdata(hdev);
-
 #ifdef CONFIG_SONY_FF
-		sc->left = sc->right = 0;
-#endif
 
-		memcpy(sc->resume_led_state, sc->led_state,
-			sizeof(sc->resume_led_state));
-		memset(sc->led_state, 0, sizeof(sc->led_state));
+	/* On suspend stop any running force-feedback events */
+	if (SONY_FF_SUPPORT) {
+		struct sony_sc *sc = hid_get_drvdata(hdev);
 
+		sc->left = sc->right = 0;
 		sony_send_output_report(sc);
 	}
 
+#endif
 	return 0;
 }
 
 static int sony_resume(struct hid_device *hdev)
 {
-	/* Restore the state of controller LEDs on resume */
-	if (SONY_LED_SUPPORT) {
-		struct sony_sc *sc = hid_get_drvdata(hdev);
-
-		memcpy(sc->led_state, sc->resume_led_state,
-			sizeof(sc->led_state));
-
-		/*
-		 * The Sixaxis and navigation controllers on USB need to be
-		 * reinitialized on resume or they won't behave properly.
-		 */
-		if ((sc->quirks & SIXAXIS_CONTROLLER_USB) ||
-			(sc->quirks & NAVIGATION_CONTROLLER_USB)) {
-			sixaxis_set_operational_usb(sc->hdev);
-			sc->defer_initialization = 1;
-		}
+	struct sony_sc *sc = hid_get_drvdata(hdev);
 
-		sony_set_leds(sc);
+	/*
+	 * The Sixaxis and navigation controllers on USB need to be
+	 * reinitialized on resume or they won't behave properly.
+	 */
+	if ((sc->quirks & SIXAXIS_CONTROLLER_USB) ||
+		(sc->quirks & NAVIGATION_CONTROLLER_USB)) {
+		sixaxis_set_operational_usb(sc->hdev);
+		sc->defer_initialization = 1;
 	}
 
 	return 0;
