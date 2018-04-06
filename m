Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+4mL5GLtmvA+hvVod70uRfpFIfSuv4HgVhO1VIxUuQGy7ruaDbvwz80ZwOv7n5rdEjl4lU
ARC-Seal: i=1; a=rsa-sha256; t=1523021344; cv=none;
        d=google.com; s=arc-20160816;
        b=PtfvR8BeP4meCVJw1glaUp94gnz+VTEVkrGEvwIcwKJ4BuaHbJOj3XBLhVoCgPydsH
         yg/8ZBdToCrblSJerlAjFq7TcjvuwGl1oN0alFnaCu5AMjFBXR2tGuTERX4WsNkIGI47
         D6Wl731WkNDDjqCgZcrYl9wqGnTuIGLDk6n5NbUP6DqEUMmhBCvBA1WdhYOPlSJIGKGb
         OGZAkn/sbHYf4tVNJYVo86O/sfKf5j1XGWqyq8WGhq2mbPyhrdi0oftNcDeKs7r4gZTE
         b7OUlHvh/vN/m9fMYb45sFA+EyJytzkmjLQsudplA/5YX5zwP/JMnI+zrg2s14JSE1fc
         qDKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=86/IeWjXUaNB2eWuEVnvh2Prhb5ENQeJ5oVih7doVEs=;
        b=OraLYpq4q9L5/Y5/flayibxpnCW6whPJdJCpKWo1GPeTgqjuCTJ0thVwVRo+ufv+Je
         Jp2PvnBrIj+8NlSG5TNYFshAU95Mhov6xYgOnrM7OIYa0NYNQiOPpdNQJ6m5uhWLAOqw
         6n7LALQZ+Hile2VsknvAptIehQcgcaAE65gMASlNP+Z5EYfvp7uawmFzi536CmP1XPiL
         CUhVrBmRTmClcFsHM6RWVW5rEftal7QFHvFJs7KfoQSva3H+tfZM2Agta9Q8383j13Ib
         IiFFJIW8drGF3Qy2DHMsqNlmB5YwQNpQeHnT9n6LwtVYByV7NWR9HpdnSE/GSWyzlmAC
         YHQQ==
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
Subject: [PATCH 3.18 86/93] Input: i8042 - enable MUX on Sony VAIO VGN-CS series to fix touchpad
Date: Fri,  6 Apr 2018 15:23:55 +0200
Message-Id: <20180406084228.943644700@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003629992266331?=
X-GMAIL-MSGID: =?utf-8?q?1597003629992266331?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -712,6 +712,20 @@ static const struct dmi_system_id __init
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
  * Some Wistron based laptops need us to explicitly enable the 'Dritek
  * keyboard extension' to make their extra keys start generating scancodes.
@@ -1124,6 +1138,9 @@ static int __init i8042_platform_init(vo
 	if (dmi_check_system(i8042_dmi_nomux_table))
 		i8042_nomux = true;
 
+	if (dmi_check_system(i8042_dmi_forcemux_table))
+		i8042_nomux = false;
+
 	if (dmi_check_system(i8042_dmi_notimeout_table))
 		i8042_notimeout = true;
 
