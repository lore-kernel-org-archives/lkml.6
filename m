Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/B7121TInjQJ1Ew+jw3BNC5oiWuAcS8Q3+8jkpQ+5KQPiq8/09yzPX9Bt37N0/0yxQzb0r
ARC-Seal: i=1; a=rsa-sha256; t=1524405854; cv=none;
        d=google.com; s=arc-20160816;
        b=X63DiWMHEKQ502BeTcN+feBJIrxNwoMmlqm7guieJNUgKt/lACWOzBF6mCUnD/pCXv
         nvcnSbL14VxjzonDoIaUeHrlESeXqQmxTm+Zdf2Tg/fRvxw00hAzMucnsW5GQH/uQyMn
         rNXWhGsvMN5+Nl7DAsO+YR+fe/+yBA4lCmeWIWt9vNnPnG5Scka66By2JQzJ8sBsidYd
         Pg4qRLdhYtfnr47efVDQ0N8m1nac7eDRK8Na9vQcXINCTuUkwkwSVZ9e9Lvt1ZeqQHkQ
         TwOtjkqwmpuuYrP7JMnEH3SxRKPhhxmcapuW9I5xAE/hWLaNNW2pGiRrx0ZvrOHILqgM
         Gwww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RoEmyaHD6Lp56QvYj7H2GJLJXs/HwRni6baTeJJeMQM=;
        b=hAd1BrUGDwcp+ZFkyuu/fVsI5gZ34fpi9qWQCoeawqPKF1Umx4nme/X1/Oo7M8CB0T
         Eh/ThjBOPn7yiG+QbmCMqrzcvn798nuFeQ4HqVOadaxuwJcID2wc6XEA7+H8gpsIzF4e
         xHK4RhsRkRZKEs0rFixUZF3OSbxMscCXqaVqgv4iVQ429qcrEgfyKgjS8VmWv/qV1kFy
         YruVB2uIyBFYKipTstEGwTJSzPNBFzmAXUdBWOM2vDLS+SA9nBhZg1kxKuQIq6S45410
         O2mOL2TZR34ZbKjtzGkhjmpaRSC7flLIpWX+eqRo6KMr9FSGHKodAZKNN/+K6Ul4ZXOm
         Zarw==
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
Subject: [PATCH 4.14 022/164] arm: dts: mt7623: fix USB initialization fails on bananapi-r2
Date: Sun, 22 Apr 2018 15:51:29 +0200
Message-Id: <20180422135136.300918216@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454830471039483?=
X-GMAIL-MSGID: =?utf-8?q?1598455393909205667?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
 
