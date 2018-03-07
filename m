Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsbe9y3ewz/5b9tizmXitzx5GwOmVSnQJ6h3vM+V4Erh/WU6AxPrWQSY7K/GIOrFWMN/Y9Q
ARC-Seal: i=1; a=rsa-sha256; t=1520452091; cv=none;
        d=google.com; s=arc-20160816;
        b=UT5zMG3gPUaxu6nFch+h8BLwpVuGFsU/BLRdjuFu/vw2oGpQgblrBjHB8xrDUhEL5I
         o9Ar4M/7+MsKguumAdBz3ek+S2ZEnEXxXy7bCdXtCQIw0YrTqZJZ97P1yYrnnWELKoqZ
         4vMsqRwG6iuiUjETWaBn4S36rfj6+yJuB8TX72Dc6D1woQNNHn1mhqmSlLGDJk1qEpEp
         uNS3Gk8Ui7LEtAjHX54wy2Ms7qXSyx5wHo2+mSIcvz7l/ql1X+O0VJC0S68nhlCDpcVJ
         hQ3LqOuHWKJFPwf+MW/dk8fME9GQaovP0PlvA79qTVVXX6wdHXPk13a3MkamEST0D5zj
         A1sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=W2d66W00QSPTGWLVk72TlDQ3eI6sRd7hTs9QV2B7RDc=;
        b=QlVDW8gGXNHQxy1+qoyEK6BaxSMVGvzCtnIYqXW3sLxmCvG6BkHWLw2Rq0LxKqW+60
         DPRam3cSdkIH5eDIS4+564O85HqgnEOyP3EJGUI1juN/MzQAg7GjHi7xMSu0WiS9vcdi
         xDJAvn4TkPYMNUoq6B/Ytkl14NkzD+1AZoK8kO5mGHJShPyIzjyajDgA43c72DjnMpL+
         chGou1t/gciuLS05AWHFxvC4DAnzjr8cbaNirDRsSeM6h0ti5BCADrpBy/GIw3mOdgoG
         GKmM11byqrt9cysi9D8pf0PAN2oGSD3/GJ9AQDDrRgDX5E11WxgVXNj3KLWECuL0icvg
         M6+g==
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
Subject: [PATCH 4.14 107/110] ARM: dts: LogicPD SOM-LV: Fix I2C1 pinmux
Date: Wed,  7 Mar 2018 11:39:30 -0800
Message-Id: <20180307191053.665535272@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309311235762259?=
X-GMAIL-MSGID: =?utf-8?q?1594309571970475277?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -97,6 +97,8 @@
 };
 
 &i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins>;
 	clock-frequency = <2600000>;
 
 	twl: twl@48 {
@@ -215,7 +217,12 @@
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
