Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226UA1vduUvs7xnx7TAKS1czWCooRd1BEqQupjvom8G4hDFGOQbZbvSmDwAgpZB9OdGlGFpD
ARC-Seal: i=1; a=rsa-sha256; t=1519411608; cv=none;
        d=google.com; s=arc-20160816;
        b=OA+JTAW6Kp20dRc2Ak0rILscfjprSy2hu3Eo363N4wFpXobaaWBjtiMVePSoWZ7kF4
         dR6S/R2+36cSb02JAmabqfRdejJDUb17/HhK5hBOQtP2cuUc7pcCeuk5Z29m0PqnTFHZ
         fgWW2GjG4w7lMDRh2aSx7M6ATn6PDu2+Z2dGZ+9hObTa3xm4yFR1hdxuPSq7qSbYIYUk
         5dv6vV/pTFRmfVoeWfFi4Dc3DFTw8BPSxzZiIaaY8UfdxZegixrsrKYkC11SzfiMIN3a
         i56510awWWS8Tcnns4YWeuw5EPs9P5i6b8Ba+Z0bCLT/c6Ib4xpe9w2gdTB+rs63aZwD
         35QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=D5mugG4IB49IDkpVLnSBDbCHkv6vdlCtp1tVCTQ+F8M=;
        b=so2UqDkeL/7ufEzAUWHbDXuGHXEu0vc/jimahp2xVRCel8xaeADyD5idQvqg/Gimva
         01ay+yYv6rUTLC+9WrlZZAJKbUtD9H8WOFkIe43VZf/1M3P6Bgu4XBvenz0uuDURf2XR
         lJ3aEcqXlPL55th67rou6hILU0CEuY3jQVZEP/kkF2T/0E05RZiWHGBMrsuIelOpABSK
         3RQOvfcvvkQSp5jTIm2mDYfyGv1AXjMfbwia0K9h2ZcOftvm5MD8uq22BPnaKZ2tu+vP
         jsH9a8RAhy+WXtB/K/3ugo8p0XoBSg4Ndd/PTmhcSWyFrK3rMfnpwgyqMaYVlRDUwo50
         vELg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>,
	"Gabriel M. Elder" <gabriel@tekgnowsys.com>,
	"Darren Hart (VMware)" <dvhart@infradead.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 084/145] platform/x86: dell-laptop: Fix keyboard max lighting for Dell Latitude E6410
Date: Fri, 23 Feb 2018 19:26:30 +0100
Message-Id: <20180223170735.601863409@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218546954783654?=
X-GMAIL-MSGID: =?utf-8?q?1593218546954783654?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Pali Roh·r" <pali.rohar@gmail.com>


[ Upstream commit 68a213d325c23d39f109f4c7c824b906a7d209de ]

This machine reports number of keyboard backlight led levels, instead of
value of the last led level index. Therefore max_brightness properly needs
to be subtracted by 1 to match led max_brightness API.

Signed-off-by: Pali Roh√°r <pali.rohar@gmail.com>
Reported-by: Gabriel M. Elder <gabriel@tekgnowsys.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=196913
Signed-off-by: Darren Hart (VMware) <dvhart@infradead.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/dell-laptop.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

--- a/drivers/platform/x86/dell-laptop.c
+++ b/drivers/platform/x86/dell-laptop.c
@@ -45,6 +45,7 @@
 
 struct quirk_entry {
 	u8 touchpad_led;
+	u8 kbd_led_levels_off_1;
 
 	int needs_kbd_timeouts;
 	/*
@@ -75,6 +76,10 @@ static struct quirk_entry quirk_dell_xps
 	.kbd_timeouts = { 0, 5, 15, 60, 5 * 60, 15 * 60, -1 },
 };
 
+static struct quirk_entry quirk_dell_latitude_e6410 = {
+	.kbd_led_levels_off_1 = 1,
+};
+
 static struct platform_driver platform_driver = {
 	.driver = {
 		.name = "dell-laptop",
@@ -270,6 +275,15 @@ static const struct dmi_system_id dell_q
 		},
 		.driver_data = &quirk_dell_xps13_9333,
 	},
+	{
+		.callback = dmi_matched,
+		.ident = "Dell Latitude E6410",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Latitude E6410"),
+		},
+		.driver_data = &quirk_dell_latitude_e6410,
+	},
 	{ }
 };
 
@@ -1170,6 +1184,9 @@ static int kbd_get_info(struct kbd_info
 	units = (buffer->output[2] >> 8) & 0xFF;
 	info->levels = (buffer->output[2] >> 16) & 0xFF;
 
+	if (quirks && quirks->kbd_led_levels_off_1 && info->levels)
+		info->levels--;
+
 	if (units & BIT(0))
 		info->seconds = (buffer->output[3] >> 0) & 0xFF;
 	if (units & BIT(1))
