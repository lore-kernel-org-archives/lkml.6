Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49Z3qa4IN6sBjaLCYku2UaDHL04HFGxZagjHFGNcSyfgZBqg4XhaA61z9QXEyMwwHZrzI6+
ARC-Seal: i=1; a=rsa-sha256; t=1523021780; cv=none;
        d=google.com; s=arc-20160816;
        b=MIXIdstYHNxdp5UZosG/Ns6emX0TpQX4gROJtBRRlJoJ7hzHsWBDImgsDWKx23lmqu
         QaqI7rQqe6QwTl1vOnOn0YApCSAVa2zqqanQcgjeIftzZRgyu9MFjpjJvEw7KMh1XkQU
         3lmQa1V/zWNXs7uO6ovoIbPgU1NkAB/8GbUu9qYQJyUbvgxtCpOM5QuwpOVmzxtonuCn
         ZGMoXPeRezilv2n2KQm/+pDzYh7H6Iwed4hPyyMUSD0cbNclUGUO3471UL68IHXfnwO6
         Or5B/n3ZDYODQfepdHVrWNQGcpbyM3lcJvCvIw6FuiFdJV6uMuQQboyduWFda398y6t9
         RdQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0vUK3/+0RI+baowPX8oFTzH6wD1tmj0Lz8OM5z/rJfA=;
        b=legD+RieYCqqED5XJydYsQJhEycDalWcAJFRtzeSy+men9fEnCLPP52QY7V+ifCKQd
         EHasmcbzzlJ49eaqM8cWcx/yp9WIStDl9gN5yeqAHFJua77bRMKbh+Nxfy/55Ca0kcDi
         8m1iQx5lNQtQ4GIWo1TpuYm7veoJD1azBnV5rU55gY9lic3hPJR+UyUnUF56k5z7ZIzB
         7M06H7efou6oxkRO/VIBuMMs183yzZsPzzQXCODBgqezLe2ktSkW1Cfif4ilIoFxK3T3
         Da2EW5uvUsu2Z4hDkRhNOJXmvbmD48iXMTUNCFjIJca292y9rJGVNCGXjXKvUFkPJBqg
         JSpw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ondrej Zary <linux@rainbow-software.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.9 088/102] Input: i8042 - enable MUX on Sony VAIO VGN-CS series to fix touchpad
Date: Fri,  6 Apr 2018 15:24:09 +0200
Message-Id: <20180406084343.920281560@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003629992266331?=
X-GMAIL-MSGID: =?utf-8?q?1597004086769252500?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ondrej Zary <linux@rainbow-software.org>

commit 04bb1719c4de94700056241d4c0fe3c1413f5aff upstream.

The touch sensor buttons on Sony VAIO VGN-CS series laptops (e.g.
VGN-CS31S) are a separate PS/2 device. As the MUX is disabled for all
VAIO machines by the nomux blacklist, the data from touch sensor
buttons and touchpad are combined. The protocol used by the buttons is
probably similar to the touchpad protocol (both are Synaptics) so both
devices get enabled. The controller combines the data, creating a mess
which results in random button clicks, touchpad stopping working and
lost sync error messages:
psmouse serio1: TouchPad at isa0060/serio1/input0 lost sync at byte 4
psmouse serio1: TouchPad at isa0060/serio1/input0 lost sync at byte 1
psmouse serio1: TouchPad at isa0060/serio1/input0 lost sync at byte 1
psmouse serio1: TouchPad at isa0060/serio1/input0 lost sync at byte 1
psmouse serio1: TouchPad at isa0060/serio1/input0 lost sync at byte 1
psmouse serio1: issuing reconnect request

Add a new i8042_dmi_forcemux_table whitelist with VGN-CS.
With MUX enabled, touch sensor buttons are detected as separate device
(and left disabled as there's currently no driver), fixing all touchpad
problems.

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/serio/i8042-x86ia64io.h |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -530,6 +530,20 @@ static const struct dmi_system_id __init
 	{ }
 };
 
+static const struct dmi_system_id i8042_dmi_forcemux_table[] __initconst = {
+	{
+		/*
+		 * Sony Vaio VGN-CS series require MUX or the touch sensor
+		 * buttons will disturb touchpad operation
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "VGN-CS"),
+		},
+	},
+	{ }
+};
+
 /*
  * On some Asus laptops, just running self tests cause problems.
  */
@@ -1230,6 +1244,9 @@ static int __init i8042_platform_init(vo
 	if (dmi_check_system(i8042_dmi_nomux_table))
 		i8042_nomux = true;
 
+	if (dmi_check_system(i8042_dmi_forcemux_table))
+		i8042_nomux = false;
+
 	if (dmi_check_system(i8042_dmi_notimeout_table))
 		i8042_notimeout = true;
 
