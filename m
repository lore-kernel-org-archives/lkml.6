Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtV3j3633ROlnPaLSnvZ5BRYJRLKbxxq5DIUzyfDRMkuapqpzhJbTdkn6LG6QTxewTlzKg+
ARC-Seal: i=1; a=rsa-sha256; t=1521214603; cv=none;
        d=google.com; s=arc-20160816;
        b=ZWiJ/OU6UE2HEI/cjqOO7r5HI4v8vugnCs3Xzr1D1eOEo82ePQkqhn1AgsKuoKWzUk
         5q99A9r40c+MgjpuFVaHopcSqyHJrakIVt8pdyE3BCOU1Zpg4hX3uDIwgmUPgXsOhMpm
         +ElVxKi3kwWRkhu2qTkgmnWbkpLoNh3F/DWk6sbvvqpMeIOJiR6qJU6ERUldWGEO5H7F
         WxVgxYmDNgagbUjmIIq5aodXiyEixWG0l6KHRL0SfqQ0rHK1HGFfvxEY+fSI1znm+09q
         264F5o+uisXYno7v3nyO32zJp+4L9tJeTvl70NI5e4aNSSYp4m8KHywAofqwPeUSPzF/
         lu0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=aXGJY1Vfu4jNjmFZLc8eojvfMco8J8enKkHyylt25qc=;
        b=lE4MdKlnjpP44Pq9sD0HORe1zHQ9uV7HrS+p2Q+DRHj9q6Lry7H0nW6cO9HKvmzxGH
         Mc1JeP+yJU2m6cxyK9lQ/9OYWdE+pbnIozpWGWC2/bvi40OHsBCLpcd+rAnU3GcKGkC7
         AQzRSdRTKG5cchk1fo5BWV8GzlkEx7yv449hX+MkRBknNJWnH+6k0CKNH8mMfvcCzUl3
         FIdw7PzjmXIm49AMhlaqd0k9WeEHJncmeKIBwGa74oIum9lh36aic87+WXgCZSpeOVl7
         OnOXiWFkwok8dv3rTC/0rbPae2R+0DnhLiST0/RQbDUX01KMmtGn5QpgwoPbR3JfjQIx
         CB7A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Jiri Kosina <jkosina@suse.cz>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 030/109] HID: multitouch: Only look at non touch fields in first packet of a frame
Date: Fri, 16 Mar 2018 16:22:59 +0100
Message-Id: <20180316152331.605570881@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109123763996154?=
X-GMAIL-MSGID: =?utf-8?q?1595109123763996154?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>


[ Upstream commit 55746d28d66860bccaae20a67b55b9d5db7c14af ]

Devices in "single finger hybrid mode" will send one report per finger,
on some devices only the first report of such a multi-packet frame will
contain a value for BTN_LEFT, in subsequent reports (if multiple fingers
are down) the value is always 0, causing hid-mt to report BTN_LEFT going
1 - 0 - 1 - 0 when pressing a clickpad and putting down a second finger.
This happens for example on USB 0603:0002 mt touchpads.

This commit fixes this by only reporting non touch fields for the first
packet of a (possibly) multi-packet frame.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/hid-multitouch.c |   17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -738,9 +738,11 @@ static int mt_touch_event(struct hid_dev
 }
 
 static void mt_process_mt_event(struct hid_device *hid, struct hid_field *field,
-				struct hid_usage *usage, __s32 value)
+				struct hid_usage *usage, __s32 value,
+				bool first_packet)
 {
 	struct mt_device *td = hid_get_drvdata(hid);
+	__s32 cls = td->mtclass.name;
 	__s32 quirks = td->mtclass.quirks;
 	struct input_dev *input = field->hidinput->input;
 
@@ -794,6 +796,15 @@ static void mt_process_mt_event(struct h
 			break;
 
 		default:
+			/*
+			 * For Win8 PTP touchpads we should only look at
+			 * non finger/touch events in the first_packet of
+			 * a (possible) multi-packet frame.
+			 */
+			if ((cls == MT_CLS_WIN_8 || cls == MT_CLS_WIN_8_DUAL) &&
+			    !first_packet)
+				return;
+
 			if (usage->type)
 				input_event(input, usage->type, usage->code,
 						value);
@@ -813,6 +824,7 @@ static void mt_touch_report(struct hid_d
 {
 	struct mt_device *td = hid_get_drvdata(hid);
 	struct hid_field *field;
+	bool first_packet;
 	unsigned count;
 	int r, n;
 
@@ -831,6 +843,7 @@ static void mt_touch_report(struct hid_d
 			td->num_expected = value;
 	}
 
+	first_packet = td->num_received == 0;
 	for (r = 0; r < report->maxfield; r++) {
 		field = report->field[r];
 		count = field->report_count;
@@ -840,7 +853,7 @@ static void mt_touch_report(struct hid_d
 
 		for (n = 0; n < count; n++)
 			mt_process_mt_event(hid, field, &field->usage[n],
-					field->value[n]);
+					    field->value[n], first_packet);
 	}
 
 	if (td->num_received >= td->num_expected)
