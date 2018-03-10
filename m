Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuYX57BZwtpr4H2f5zD+QOBxYapNoE1CA1eHhf6reaGt//L7/oNVXCRfMLoW4gTlNQJIWZ0
ARC-Seal: i=1; a=rsa-sha256; t=1520641367; cv=none;
        d=google.com; s=arc-20160816;
        b=E6Qf+VBHlm0mTCDOULaAgWS7M+QotRv6OLCzXXJRP6S91daifkrF+3L345ZWRsO13r
         inLk9QDTAvCiEVe1hki6zC3HPNySZnkVvnl6cNwqLalOGP27xEmMtthb046DhwTWxLzn
         x1InKxF+SpUbUus3Atb1StjTzYTh3L8hsq+BFqQBJedD0la1CGAyXHldc9dzPyP5Mxsy
         wAo2hhUXohRxaJu6i/kj/tERpDeIFEw8KxzQEf8P3mA+tMOTPqPF0JL4SDE7MjpLOxey
         H2+feNp5uCElFQW2jAL1h5OIlL59ZmImsGpS+6lsO+NPLadobLttgaKkPWzKsRRCfj/m
         guLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=n0NilBEmMkLjEIcHTVP8zo9wBMP+eVXl+AoeMxu8DNQ=;
        b=mNNOfNXYWOEu5z75vqsqaBc5H8w0QsPqjZgRpue8Le33ZUBJreKMbnUARU4m5fibMw
         9wciH7V3xqoztVyaGp3tGe5a8GDdIXAid0k8QnkxzEhd0gW7vENi2XAJenQDKOq5KKQg
         I/hOnL0sc5CGi1BwoVE4D777moJ/dxt6+Uql5JRO2nTZgM1dFFXRMa96olTy4n9E/hHO
         YKpQSmF+aK8erQNMc8LQ7umk/xFyUQZsY8RAJZ3hRJE3TDoWvHzDEqSGKfRuBLHKoQTb
         IMiTM9nOc+8g4/6vTBpye+xD1rKgy44tDEpdfVdlnMnkYDjpVuxigLNbpZsb5PAPgOTw
         Hy1g==
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
Subject: [PATCH 4.9 27/65] ARM: dts: LogicPD Torpedo: Fix I2C1 pinmux
Date: Fri,  9 Mar 2018 16:18:27 -0800
Message-Id: <20180310001827.105917170@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001824.927996722@linuxfoundation.org>
References: <20180310001824.927996722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507853156064783?=
X-GMAIL-MSGID: =?utf-8?q?1594508042632197024?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -100,6 +100,8 @@
 };
 
 &i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins>;
 	clock-frequency = <2600000>;
 
 	twl: twl@48 {
@@ -207,6 +209,12 @@
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
