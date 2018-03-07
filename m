Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu1T1zMJhLdmevmi46zxTmYkx8jTHLtkirBSFPzjbQ7QWklKa+ZgmOX9+P3mzy2SDkXUJq8
ARC-Seal: i=1; a=rsa-sha256; t=1520451844; cv=none;
        d=google.com; s=arc-20160816;
        b=zPzo9dIEC+AMO6vIDBuK6GIR9Kf9CQvD3m2g1RawSCEhC+eKtyScjA3XdvRjrPmR1o
         EJ3ZtCUdXCOE3uJAwZeqydHzbKIaxpRtAM7v1NDswGI/ZCQ1im6Aqq/fHFvyIcJizcav
         u4SOxzCgCDS1DXy0WVNoMQPGnLKSZszGyfjyImKOh7aP10KfAWqrJb4kDglvCwvcZGM4
         IL+2V/2QzqaGeKUyoWGN00eWLzOEX/pt5nty0WV8tX8Wd4YR8e8iJYHR5UmnIbQ9BMzG
         ZnzfblgSw0tp06OR8mXhpOia8CGNN4gP4/Gr/hBqaJLrglztNiFZuBQwcDrmFqC/56Z+
         SW6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=sTfZpX57XwvZ/8xp+l6tbDpgx3iKsHYXHtwBzwfhI9c=;
        b=RRtJPlNDS1mVr9LKlfoSIH/2W9kGntcVha85RmyEeNip0jY16PPf/1y65N8CI0wIQ4
         KWgJSkDCLs3BUuI3erVp7ozzVB09HOD2Zmt9kKmr4A7jlys1nY10MPoJevl4h6vzGFqh
         ecLsis7CiVDoF8Rou8SSJZIBIWY1q1lpZkoLocDIiCotmW+Aj2m+ggRVvLF7mhsX1Uuh
         1SV1VSPpHfKKbJ9aZQw1V3r9XuuyxW1t110FvWuH0BBxSxrF+j62HTnEDEpIFY5UGgg/
         B+wIxBVB5UkzAgrcNcTM+HZryV1jD5MYhvbIQc5SdqKxdmmlmMVeua4Pw0RhMt4eLeXZ
         p5KA==
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
Subject: [PATCH 4.15 120/122] ARM: dts: LogicPD Torpedo: Fix I2C1 pinmux
Date: Wed,  7 Mar 2018 11:38:52 -0800
Message-Id: <20180307191747.017707656@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309313451719428?=
X-GMAIL-MSGID: =?utf-8?q?1594309313451719428?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
