Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtQXY72D3ZLPne1I0w0RKiJKLXCwQot9O81ZcofwQp23Mxa8v+6sXb70/6hOMcJespO8u6o
ARC-Seal: i=1; a=rsa-sha256; t=1521483452; cv=none;
        d=google.com; s=arc-20160816;
        b=y9XtzHJHiUL48gswpHLEReuLx0U/AfP9oVO23DcsoUfS9tk8Ly6eK2vX/34iOOp8w7
         ii1C4VchwaCU5Qd6wyLQ0A/uBW/OIn4dH4KGk1+vjkpgXcrzdU3CSXIUKJ/QwIbTQlyM
         p4Ti+XPEHzNi7hzKSWW6iarWFYbA//Emhib122VtnsNxN4mTTve69fJJUrHxjX2Xdqp8
         2f5QaoZBqsPdZy8lDHvuzhEersStVF2Ehegr4AzMJ9p63WFxs/I3zNXHchBVu7SR5KjE
         fdEwcslKILeXmA0xOYW0236Ur3o1LnDybbkpZlyEbZ7WmCkTWF++nUDlygmEZfZrXXFS
         UGug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ARH4AMY8VYQbgKqqJw1JOArQXQqx4+KQTPdDBgra1c0=;
        b=gjH54RFB4VsQbkntLa7aHjO1nvS7CPbr+RW158lP3jX8xfwNGv1UI1n+hDzW3rGNbf
         EfzdyXR+nw99esR+n5ADgb3StMKErHJR2XbM8r4oI1Tk6vlVuw0HhGUdEWj8bfxsFygf
         9di766SUBkl8L54VvIN9w9odRz/tFTYlQUZ05zx1wzaRo6ctOF/4BXT72jSHfY9xoYS9
         ifdlTNs5jtleUeyY4lkM/UGu5ELEQTm0cj3VO9/dm8a0f8FFcnjV2NrlHt2h6hD7mU2t
         LW5gFmmdffSPw1dILdDsMuyuJ7XQvlfAGIFzK9BXKU+w56117KdrxYGZ0P5n5nTUFPOV
         dd1Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Adam Ford <aford173@gmail.com>,
	Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4.4 129/134] ARM: dts: LogicPD Torpedo: Fix I2C1 pinmux
Date: Mon, 19 Mar 2018 19:06:52 +0100
Message-Id: <20180319171907.894319225@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391032674985552?=
X-GMAIL-MSGID: =?utf-8?q?1595391032674985552?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adam Ford <aford173@gmail.com>

commit 74402055a2d3ec998a1ded599e86185a27d9bbf4 upstream.

The pinmuxing was missing for I2C1 which was causing intermittent issues
with the PMIC which is connected to I2C1.  The bootloader did not quite
configure the I2C1 either, so when running at 2.6MHz, it was generating
errors at time.

This correctly sets the I2C1 pinmuxing so it can operate at 2.6MHz

Fixes: 687c27676151 ("ARM: dts: Add minimal support for LogicPD Torpedo
DM3730 devkit")

Signed-off-by: Adam Ford <aford173@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/logicpd-torpedo-som.dtsi |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
+++ b/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
@@ -90,6 +90,8 @@
 };
 
 &i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins>;
 	clock-frequency = <2600000>;
 
 	twl: twl@48 {
@@ -137,6 +139,12 @@
 			OMAP3_CORE1_IOPAD(0x218e, PIN_OUTPUT | MUX_MODE4)	/* mcbsp1_fsr.gpio_157 */
 		>;
 	};
+	i2c1_pins: pinmux_i2c1_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x21ba, PIN_INPUT | MUX_MODE0)        /* i2c1_scl.i2c1_scl */
+			OMAP3_CORE1_IOPAD(0x21bc, PIN_INPUT | MUX_MODE0)        /* i2c1_sda.i2c1_sda */
+		>;
+	};
 };
 
 &omap3_pmx_core2 {
