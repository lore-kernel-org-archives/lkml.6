Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48OSp1n0DpBco5ZJ3alCQrBIlIexA2+cPn5e64PiaNJftPbNEjKCzM2fFOa88hIPIvWUJt+
ARC-Seal: i=1; a=rsa-sha256; t=1524405317; cv=none;
        d=google.com; s=arc-20160816;
        b=E9yt1AqCiFyFsoe+bHlqU1P5iGjeIXLOMtukVibFALTdaSdIOlBLtFp2acuzCM5jON
         BTecTcUsDsFNiG7G6tZqlSEQv3dJEoiN7QHa9V+ChOrwjcyoXs5qO2OUJAjJB/Se7U1W
         yUI6tZUExot5PCPYZy5XP67VxC/PQG4UACBOKNmzmKXAxhCpCpNKwd22Lpdi7O1lt6Rc
         7ayfcrdEt8bRvEAb1d4Q1O7sNvdf3zDThlPId2g8+FaYLWypHFPCU25cNiN6uBcMDAp7
         g1Oiw5eQS53Gttfji21iuqem0Mocjf+myI9uhqkHLzFKIK8pRLZN9jUjSKZ9+umRaz3R
         zpqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7ZFOE+i2pjUmMNws9bWcRughFqZsDujMtoODYV/+GWk=;
        b=xlzrtn9PZPgU/Vq7lpRBIt/yXYoV3ZxTKcI1qx7/wYBIveWvhw4muMgoofWGO1G6W0
         CUJJzUGlJOq79D6AgLpAF4N0KhUW/INKyCwOsNMjEFHiTwq29E+Cj6htlnwJGYe5w25p
         5src7wsDCr/yZV8++S1yiI7gcYZCUuORuV31fkVhI+Jz85JpUggaNVIGNZD/cSmaJAaz
         ByriDNQ16ede7f//I2Vr69ifM8+KcC25TP1hZGKxuhbkcPhypx7bHYQjWQ8G7XoGLf+f
         HfbkyTz5ZeqtZ54P9PdD8Oppqxx6aAs7ve2WZKBIj7murPawfqIpBwF03aTjhnfOPJ8E
         0q0w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH 4.16 023/196] arm: dts: mt7623: fix USB initialization fails on bananapi-r2
Date: Sun, 22 Apr 2018 15:50:43 +0200
Message-Id: <20180422135105.313050375@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454830471039483?=
X-GMAIL-MSGID: =?utf-8?q?1598454830471039483?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Wang <sean.wang@mediatek.com>

commit 0629a01920c0f8a3f825361b24863d760610884a upstream.

Fix that USB initialization fails as below runtime log is present during
booting on bananapi-r2 board by adding missing regulators the USB device
requires. Current regulators USB device uses are being updated with the
correct ones to reflect real configurations which are all from fixed
regulators rather than MT6323 one's output.

xhci-mtk 1a1c0000.usb: 1a1c0000.usb supply vbus not found, using dummy regulator
xhci-mtk 1a240000.usb: 1a240000.usb supply vbus not found, using dummy regulator

Cc: stable@vger.kernel.org
Fixes: f4ff257cd160 ("arm: dts: mt7623: add support for Bananapi R2 (BPI-R2) board")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
[mb: update kernel log in commit message]
Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts |   24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

--- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
+++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
@@ -39,6 +39,24 @@
 		};
 	};
 
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	reg_5v: regulator-5v {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-5V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
 	gpio_keys {
 		compatible = "gpio-keys";
 		pinctrl-names = "default";
@@ -468,12 +486,14 @@
 };
 
 &usb1 {
-	vusb33-supply = <&mt6323_vusb_reg>;
+	vusb33-supply = <&reg_3p3v>;
+	vbus-supply = <&reg_5v>;
 	status = "okay";
 };
 
 &usb2 {
-	vusb33-supply = <&mt6323_vusb_reg>;
+	vusb33-supply = <&reg_3p3v>;
+	vbus-supply = <&reg_5v>;
 	status = "okay";
 };
 
