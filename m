Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2278EJuVsT14rcYiJ8i6SY+aG3FUHtgKnhSzkZAoCjBHOipuCr77jvnZNk9Jqer66P2hjJGA
ARC-Seal: i=1; a=rsa-sha256; t=1519412174; cv=none;
        d=google.com; s=arc-20160816;
        b=0DJAO/fu5Kir2+mff58WLOaFGpD6d3KPSbQs0P7uIJtuW+ZFnnisiNMLgPh0pqn+lC
         W96RYlERcAl7YKrIL4nsHf/2+iKNK90384lGT3F5bLvLpsFdzZZTjwMIBEtXxyppJyrq
         6wRnMCicH6O10thMqAMkDplC4FSkpT1kmyujogHM4kwjmbah1ADSvGkHH3TAk9nuNNRC
         gvn4HkWahepcV4kG+WLf8Lb2MDHOAbHl6jgomXq8Q4nD35k3mmZlIkeQ4Tr77PgEYDAQ
         1LCG9hM2wxnV4GDWc9vTCcHWInFbUeqYOg2fOVbinXQmV4ExG3I/p7tevgvbqgBDXW+2
         9HzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9BSeHvhdSnYjuPc1yqcPH1+tp2oM2wLme+yAkHNpI/k=;
        b=Iyr73gnecSmP9F2I53ihdkJ3/PfG3MDnyk5Dxg++N9dVFFOTSMBJzbXwfWURIHHb7n
         2cSc3MiTZfzp6zMQ055k6fUTX9wJF87446kQ4TJtSNSWhwD6MtN7MAg0Bjk6IVzngm0d
         a0IvbOoba0AYbH03FYkxW/P2TD5nPs7MJGn38KVy97kpW5t6QWRPLYUdYFokpj+GnTqd
         DP0f/fPOfr9xTe2BXJt2WyqFjzZzaqNUnj4igQljznAn0SM1c6kzEAH1hCqdE7ZFg7fe
         yqoQYKiKhFY8r74+rHMeoCef5fhA49B1je0OEKZQ1eWFLQEogWQSEwn09hkLC4qqiwZQ
         D+fw==
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
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 149/159] platform/x86: dell-laptop: Fix keyboard max lighting for Dell Latitude E6410
Date: Fri, 23 Feb 2018 19:27:37 +0100
Message-Id: <20180223170801.016550997@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218546954783654?=
X-GMAIL-MSGID: =?utf-8?q?1593219140370248860?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/dell-laptop.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

--- a/drivers/platform/x86/dell-laptop.c
+++ b/drivers/platform/x86/dell-laptop.c
@@ -49,6 +49,7 @@
 
 struct quirk_entry {
 	u8 touchpad_led;
+	u8 kbd_led_levels_off_1;
 
 	int needs_kbd_timeouts;
 	/*
@@ -79,6 +80,10 @@ static struct quirk_entry quirk_dell_xps
 	.kbd_timeouts = { 0, 5, 15, 60, 5 * 60, 15 * 60, -1 },
 };
 
+static struct quirk_entry quirk_dell_latitude_e6410 = {
+	.kbd_led_levels_off_1 = 1,
+};
+
 static struct platform_driver platform_driver = {
 	.driver = {
 		.name = "dell-laptop",
@@ -280,6 +285,15 @@ static const struct dmi_system_id dell_q
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
 
@@ -1200,6 +1214,9 @@ static int kbd_get_info(struct kbd_info
 	units = (buffer->output[2] >> 8) & 0xFF;
 	info->levels = (buffer->output[2] >> 16) & 0xFF;
 
+	if (quirks && quirks->kbd_led_levels_off_1 && info->levels)
+		info->levels--;
+
 	if (units & BIT(0))
 		info->seconds = (buffer->output[3] >> 0) & 0xFF;
 	if (units & BIT(1))
