Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227DfCcLngR2X7qhbQwbNs2CRlr6+dEQhirAULNBkbZZFxDbHhcMnKAwcd8hm8mHki1T+VJM
ARC-Seal: i=1; a=rsa-sha256; t=1517591269; cv=none;
        d=google.com; s=arc-20160816;
        b=NtmpXbYE8bK85FA713hXjAxLx7JRYKTbaCDrWBGnUOEVoj3Pr89B0phTG5y2aYcaH2
         kRwXSxLSnVzZgwU1jq4xqR+9RW5MSVGByeT2HUa3G9E+Dpg/0L6+aDcGn7jgUeFpYZWn
         gmo8wGSDVaBOQ/8xuf++RmRHdKOaj0CZ9Q7l98XPMrEmtd2TlmTGdjrLxAZDk7nXppS7
         26w+a2Pm/eYGtP84KSizDacKefQ5MsBpZogm7Of3uzMKVHz2wBIGfxUWzorMYDEIcGug
         u6kS/6DlLXOh0aXjiN5dMeGaQJa0QiqveMv2ScXEa6AXlyoFhcpMHNz+9fFnziP+udkc
         f+zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=TinKj3s1gQOgx+0JnxGVAHHxiHzwU/7GV57F/8rswrI=;
        b=JfI9/S6DXMllm42/T4XUlqVV+Ml4viZk6XSnnyEC4Ay+OaNcQxw5BKXQ3C7O/G8LP9
         0x9USomn0dl13uKwW+DkTXZp6jreKN47qPcDbYbviuEAJDYwYsNGtAdrimpxliwF9trB
         D/vkiSN9dF6FmQxdNqNYmto2SXU5N4i8nKAX3UJ2Dysgz70IlzUqLkucW+nRCJGx/VyJ
         U7hAz6L7i8/E4usiO7P7GR1zD6xQh+3N2I4hvtWucKfsGu2asityWVoJ1c83NWoacyuc
         sBiBueQzi/07sViFSDw1W7xCZgLCDKRtArHUi+EOhnBKP49PokiBUoosS9LnG5MSpP8Y
         g4Yg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Aaron Skomra <aaron.skomra@wacom.com>,
	Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 4.14 021/156] HID: wacom: Fix reporting of touch toggle (WACOM_HID_WD_MUTE_DEVICE) events
Date: Fri,  2 Feb 2018 17:56:42 +0100
Message-Id: <20180202140841.282225601@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309782831925446?=
X-GMAIL-MSGID: =?utf-8?q?1591309782831925446?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Gerecke <killertofu@gmail.com>

commit 403c0f681c1964ff1db8c2fb8de8c4067779d081 upstream.

Touch toggle softkeys send a '1' while pressed and a '0' while released,
requring the kernel to keep track of wether touch should be enabled or
disabled. The code does not handle the state transitions properly,
however. If the key is pressed repeatedly, the following four states
of states are cycled through (assuming touch starts out enabled):

Press:   shared->is_touch_on => 0, SW_MUTE_DEVICE => 1
Release: shared->is_touch_on => 0, SW_MUTE_DEVICE => 1
Press:   shared->is_touch_on => 1, SW_MUTE_DEVICE => 0
Release: shared->is_touch_on => 1, SW_MUTE_DEVICE => 1

The hardware always properly enables/disables touch when the key is
pressed but applications that listen for SW_MUTE_DEVICE events to provide
feedback about the state will only ever show touch as being enabled while
the key is held, and only every-other time. This sequence occurs because
the fallthrough WACOM_HID_WD_TOUCHONOFF case is always handled, and it
uses the value of the *local* is_touch_on variable as the value to
report to userspace. The local value is equal to the shared value when
the button is pressed, but equal to zero when the button is released.

Reporting the shared value to userspace fixes this problem, but the
fallthrough case needs to update the shared value in an incompatible
way (which is why the local variable was introduced in the first place).
To work around this, we just handle both cases in a single block of code
and update the shared variable as appropriate.

Fixes: d793ff8187 ("HID: wacom: generic: support touch on/off softkey")
Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
Reviewed-by: Aaron Skomra <aaron.skomra@wacom.com>
Tested-by: Aaron Skomra <aaron.skomra@wacom.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/wacom_wac.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1924,7 +1924,6 @@ static void wacom_wac_pad_event(struct h
 	struct wacom_features *features = &wacom_wac->features;
 	unsigned equivalent_usage = wacom_equivalent_usage(usage->hid);
 	int i;
-	bool is_touch_on = value;
 	bool do_report = false;
 
 	/*
@@ -1969,16 +1968,17 @@ static void wacom_wac_pad_event(struct h
 		break;
 
 	case WACOM_HID_WD_MUTE_DEVICE:
-		if (wacom_wac->shared->touch_input && value) {
-			wacom_wac->shared->is_touch_on = !wacom_wac->shared->is_touch_on;
-			is_touch_on = wacom_wac->shared->is_touch_on;
-		}
-
-		/* fall through*/
 	case WACOM_HID_WD_TOUCHONOFF:
 		if (wacom_wac->shared->touch_input) {
+			bool *is_touch_on = &wacom_wac->shared->is_touch_on;
+
+			if (equivalent_usage == WACOM_HID_WD_MUTE_DEVICE && value)
+				*is_touch_on = !(*is_touch_on);
+			else if (equivalent_usage == WACOM_HID_WD_TOUCHONOFF)
+				*is_touch_on = value;
+
 			input_report_switch(wacom_wac->shared->touch_input,
-					    SW_MUTE_DEVICE, !is_touch_on);
+					    SW_MUTE_DEVICE, !(*is_touch_on));
 			input_sync(wacom_wac->shared->touch_input);
 		}
 		break;
