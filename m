Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsnYI3PZwpcxUXM21bWI75QRLlYAan8E8XUwxPCt62K46lEYgZv3KNGz2mEB08IJuoL9P+O
ARC-Seal: i=1; a=rsa-sha256; t=1520452093; cv=none;
        d=google.com; s=arc-20160816;
        b=gvnXxfa7GIav1bGPTrTHSK2GA35MoxQS0tEF/H+2+yxOmc54nAnFxrR+MkEh8iM3Cm
         6/kdturZ1stbVNUPWc6wsNit5mYIC/zyjR4HZJ0V9u7gn8T/fQ3qDbH8sgWPkZhuqI/J
         0hMqLTkkv34jlJx9lotbCnoBSmBm6KuvFJ4Onq/hlKHr33RF20Uy2++f81Xs5MGEJblt
         DY2WPWwbdQamYqrcX9PpD+W6jdVSgAnabfQxX6jtT6VCCMAXDRSCt8dIhMk6TmShewz+
         SxmhhNlIDDy6k5LkJ+rHdBg0mC3SbMMoTonrANuZGbMeRSNSd4BE2N8CtIJ6hndyvVkU
         oMTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=X+fe54FoTle9moNUm0J7gf9FbTfTGFDB9y8Uo1QGLks=;
        b=fZQgK5qVMg4XAthGZ2gkbm72AqwhFZeJ6ln6wLv49WyacXey6n17hXgxzLBQ2zr/Wh
         MDS4JcHvW6tbO6RbK2jCXJv1aJfVCjatRGttB+lBmyb4kt0NAbOmYd8OP0LyE467s9UR
         O+WUz/1BiYwzEm5VanxayQ4ZHUBW3LHkP/wFp1BK+pK9qerRNDpdsyRXhj7nkYKd+JHW
         29cXZyvqvK+msfmWRlAKr/YtI8nIAwS932EZLtxRtvIYqwgu56pNO9kSiAnN2ywnFvvF
         7N2wi6eoduTtGkLOf57zSvVA8nUaXC6kM6KQ8Iq5xNOrTT0/L66DB1rZKdXq1vjn7j9K
         mvXA==
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
Subject: [PATCH 4.14 108/110] ARM: dts: LogicPD Torpedo: Fix I2C1 pinmux
Date: Wed,  7 Mar 2018 11:39:31 -0800
Message-Id: <20180307191053.823149228@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309313451719428?=
X-GMAIL-MSGID: =?utf-8?q?1594309574176020722?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -104,6 +104,8 @@
 };
 
 &i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins>;
 	clock-frequency = <2600000>;
 
 	twl: twl@48 {
@@ -211,6 +213,12 @@
 			OMAP3_CORE1_IOPAD(0x21b8, PIN_INPUT | MUX_MODE0)	/* hsusb0_data7.hsusb0_data7 */
 		>;
 	};
+	i2c1_pins: pinmux_i2c1_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x21ba, PIN_INPUT | MUX_MODE0)        /* i2c1_scl.i2c1_scl */
+			OMAP3_CORE1_IOPAD(0x21bc, PIN_INPUT | MUX_MODE0)        /* i2c1_sda.i2c1_sda */
+		>;
+	};
 };
 
 &uart2 {
