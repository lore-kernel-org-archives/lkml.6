Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/40SY9Un0PFPreEv28FyXrYH5Hx0XZaM2kj9VHktwF1dmd/lTquE9jcrKblgRe/VE87XeK
ARC-Seal: i=1; a=rsa-sha256; t=1523021491; cv=none;
        d=google.com; s=arc-20160816;
        b=leBP1o+I1RSIFV5S1z6UIJ64qwoQOhq1vzm4ybrHKk7K0R8RVmPt7rd5EIpay8oRYa
         X8ifVUQG8ok4fSHzJRcTPcsbvgp4fkjP0OTWIpS5EFKpQEfQADQdI0LIwivfH/OhGY0h
         lZMuYFGSo8geRi+3OzioGETiLpD0F8Uu1prcQr/eU/puTXWrF40DUge5Eug747IsFNGH
         At2ONbMWIOGmC8NZ6DXHfdiUZ1eZQaz5ZwGZl/DHVBINLC81+lXCBzkqZmwmikWC9MEb
         kEh6ea/oya+5CPr4+1bWsHunY1Dwq7GvNHk0ed4tCzykrSThPACe4Aou5w0xgkbEeX8Z
         zynQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=k/KkfSSzm4UJoq5hU9IIM1QFMhz1whFKHrgKubfN/zA=;
        b=kBsiVU4TtjQV0SoIAjrXJ5QHgzMPi/LnQCPVXa6Znx9QCafnsR7EHvkQ55eSeBPkZA
         iXVBrcrTlsJr19R0vGMUQL5TG9pyUeWa2WNzXxOyqP6CJCVNt+jaXBDQ8GqoHTo/LlxZ
         rvot18fr5D7yO3p+5p4G3boonLyb/hOQAa3xrNhg4IewzS1lBWfmDpjLI6mbe+ahLf/q
         lKMCp7sh4Xwc/kYyDsbub5gzxhyYG93RWxFzYwetS1Gn6VeNI1AkgjxVOSez7mXRBfxL
         /NLmXZJdY5gYFb74n6lDITyZE0+5061Q3LHNYLPjl91JmefOnyfVQYprAGVGsqVR19K9
         YpaA==
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
Subject: [PATCH 4.4 56/72] Input: i8042 - enable MUX on Sony VAIO VGN-CS series to fix touchpad
Date: Fri,  6 Apr 2018 15:23:57 +0200
Message-Id: <20180406084310.002027578@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003629992266331?=
X-GMAIL-MSGID: =?utf-8?q?1597003782740490169?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
 
