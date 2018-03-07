Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuh/0iUCAYi08adtfNJN53cRhNUl8PKBGK3i6R6vt5xS9/jDEGgtD9zRmbGe7rK7Us9zWnH
ARC-Seal: i=1; a=rsa-sha256; t=1520451842; cv=none;
        d=google.com; s=arc-20160816;
        b=oXfOcX0nsQt8i3WeuULDBBI8ZM35/453LUPHowMXnvqvPHPjE6K0+9IgO4ERLx45qY
         cBD52fEP3vUnFA2yrGKuzGEJWJ1BWvTETyPrWx4J3ApfRcDSRqUQ/FbfMz9Yh3AbO+TN
         7tSs5GTTGkFBZRyHXHMpWDVI8Y5wdJszsAdNHxQ6ohKyV6UVpf6pgYC+em0ZSigQaf3X
         ivs2b8nmekQyx6tw5+xI8apmi7dLOJ0saCDKgosF5m7KgAqBse2pa3NcUolfRY6RWZGe
         PQr5vXNLaxeI4SQIZ/Qh2WkIx24bq3fFKdNuTI4JfMnHrHY1+SyShDpr9ZspGFXwyHK0
         UvRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Yi0+AImkkanUh5eBiI+6QXHDpTKYBEwmKDCuVAzYKtw=;
        b=kc96sPskmgNK+P2uZBEDrGmjINIUFsuSqzm7xg5SJiDmzhLAW6yDiafSHyjlCelVyc
         y5Pce5na8DddLyEK53PQr8gp0W5AlO23sZr1CYPahcyHrdvwrkHSNs+MfiVD6bXuSMzJ
         FFoy9oNWyXBwMDvmltTqwSHK1kUmEtBu1yYFKCwx5yVTaOmhCtu0AesiEhcdSfmQmPOX
         XqaGDCW8z1MyTXDLzcXM175aLc66sL8YTlqTSXNEXT1UAEGS/6UG6C/CjU+Fkr635I3f
         WSZptAdWJmN6JYVzGKH7BVBB3N3WZURSnBWU/0HAliJskwTL7nB1SRUkJ7+9DE4ag5Tu
         fV7g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Adam Ford <aford173@gmail.com>,
	Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4.15 119/122] ARM: dts: LogicPD SOM-LV: Fix I2C1 pinmux
Date: Wed,  7 Mar 2018 11:38:51 -0800
Message-Id: <20180307191746.864846388@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309311235762259?=
X-GMAIL-MSGID: =?utf-8?q?1594309311235762259?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adam Ford <aford173@gmail.com>

commit 84c7efd607e7fb6933920322086db64654f669b2 upstream.

The pinmuxing was missing for I2C1 which was causing intermittent issues
with the PMIC which is connected to I2C1.  The bootloader did not quite
configure the I2C1 either, so when running at 2.6MHz, it was generating
errors at times.

This correctly sets the I2C1 pinmuxing so it can operate at 2.6MHz

Fixes: ab8dd3aed011 ("ARM: DTS: Add minimal Support for Logic PD DM3730
SOM-LV")

Signed-off-by: Adam Ford <aford173@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/logicpd-som-lv.dtsi |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/arch/arm/boot/dts/logicpd-som-lv.dtsi
+++ b/arch/arm/boot/dts/logicpd-som-lv.dtsi
@@ -98,6 +98,8 @@
 };
 
 &i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins>;
 	clock-frequency = <2600000>;
 
 	twl: twl@48 {
@@ -216,7 +218,12 @@
 		>;
 	};
 
-
+	i2c1_pins: pinmux_i2c1_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x21ba, PIN_INPUT | MUX_MODE0)        /* i2c1_scl.i2c1_scl */
+			OMAP3_CORE1_IOPAD(0x21bc, PIN_INPUT | MUX_MODE0)        /* i2c1_sda.i2c1_sda */
+		>;
+	};
 };
 
 &omap3_pmx_wkup {
