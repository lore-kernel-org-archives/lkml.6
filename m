Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49arS2wgQ8AR7nN6iAPKN6sYDxw8SE3cNnBcH3NMB65Slqipy93lHX0hiFPAeQJNptRnwdb
ARC-Seal: i=1; a=rsa-sha256; t=1523022206; cv=none;
        d=google.com; s=arc-20160816;
        b=b9sdhJ6fR5IWF2iDLQQJ5R0E8CxCLRNX17WBtaPYnlSKe5tEpaMPhklXi6uvTSUh//
         Zm8jkGI04OHmurElJ6A1h+56KC1BU4FpwcE8E1L9DQkEvzNRJPemJdlKOz5fYYu4NoAJ
         Jx7Ggw7DvS4umAEvseesL3TxVX82QaY/Hhvd+C2yAv+8KCepSad78FD/uF+3zYw4Zkx0
         7Mli92X9W/m4iwQzzbX/8NErP8mBf1CFnMHVqb3+wF/zfMO9Yh3MjZDxXDE+wX7NtB3l
         xHczFXrCJcRJDbvRnlF5iv/DXih+NV1rcxZpAKe3zTaVmvLzc1AZ3sAxFj9tM58qiQwF
         Tw8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=AEh4zXpdPVTThCBRlWb1z5AfCL7jTQszvIlqUPsdFmE=;
        b=YwdRYtL7ntNj3ybhCI4jrI99C8BAUV1WaVNFjf5FGOYM4IAxA11orW6UMEUh8QBdM9
         hY+sAELAXW1sgV0iEELNeLVjRv7gD6YIuNlKfzySHda0FRFdFohAgB96nGntLJwMqf2P
         VfMrSKpW76of3MXiyq3GWcmEiVMOvrw73dM3qRG8E8Vl20WNFAx1lKaWuuYn/opwFsdk
         PWXM2ofyfFSgn2riM33qL1J8ESsFfOfyQtL2RyLcx4CyYQdA7rL3DUMMd3t1L7E9JkQM
         NNEIHyt4xNe/+byYdXxXhUhGg5U0BI/IlBe12pgmG7UoETM4SBEbCumSRuk1Ves1Q+sA
         y4dw==
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
Subject: [PATCH 4.15 64/72] Input: i8042 - enable MUX on Sony VAIO VGN-CS series to fix touchpad
Date: Fri,  6 Apr 2018 15:24:39 +0200
Message-Id: <20180406084353.733887080@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084349.367583460@linuxfoundation.org>
References: <20180406084349.367583460@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003629992266331?=
X-GMAIL-MSGID: =?utf-8?q?1597004533477130945?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1170,6 +1184,9 @@ static int __init i8042_platform_init(vo
 	if (dmi_check_system(i8042_dmi_nomux_table))
 		i8042_nomux = true;
 
+	if (dmi_check_system(i8042_dmi_forcemux_table))
+		i8042_nomux = false;
+
 	if (dmi_check_system(i8042_dmi_notimeout_table))
 		i8042_notimeout = true;
 
