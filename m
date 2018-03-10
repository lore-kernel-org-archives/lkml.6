Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu6Kva6r9Ny3UyvVhaVg5UAj1nWiP70+0/gD/P0zW3vdgxZcGy4U5q2EvVt6mHI+FNGb3xB
ARC-Seal: i=1; a=rsa-sha256; t=1520641365; cv=none;
        d=google.com; s=arc-20160816;
        b=L6EKSgBqLXf/qTDFZ3Ubt6y1BQke6mvlvd9kJYSZRUF/5+xEcP0GdWHwD1Rq+0Q4wn
         5QKdE/wigNXELpS4a4iT8ZX4EHne6tgPVnPsCzo9nBuFxfIYH27Mpyy61E7QWvGXPKUn
         KZHpJ4vjjOuMaqm0rldloxSTLfQO3kVuApp/0M0w0Ca8ePR2D78vHEhQYGRo+RiW4q9H
         qbEP1JcUNGDRxvjYaB7YW8wBoE+L25IhJlcKZlnH6JyWS4cMmoqE2xPJtbYa6T/3lnpH
         F/WyNKxSBjkuyz2AOmfEVgnw2h8Zez4+hUZ/lsVqmVf+gpzGVpP/f5LXBclWHKyEV2m2
         mO9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=inV8xa9BsGuPS+czjhIUVGmdWM0GFnmoSTpHNyn9y0c=;
        b=bfabJ6Npw0RMYbFHZ0G38Zt5yw//+XpYkBO2GbR1CAC+v0ZiK/on4kBfDvEzuxoEZV
         ZaNAWtF2OysdqPIqb1Rc9zyp/h2j1ZcWHOXE20cq5Zee2mlSS+Vjx2rG9LZXPV5rF5AU
         dj79BR7MsCuf5EyxNWJtmkauq1mMF75+V/WDQj2gEplaTd7lCwdxaDsRZ6KIvQw8MdJb
         jnZidbmqe2/1fAI3xm2Wp9x/PJ525uZIF9pTpdD1Tp5JNkr0GRaIYphOH1uZLmonTgPu
         PVQJN+jhcxNJQZJ7Byxg4fFDSgFyA3GOK96A5v9BPiW+xrawYNTOFbzQMFdgrkb/Oz3l
         V67g==
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
Subject: [PATCH 4.9 26/65] ARM: dts: LogicPD SOM-LV: Fix I2C1 pinmux
Date: Fri,  9 Mar 2018 16:18:26 -0800
Message-Id: <20180310001827.031845889@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001824.927996722@linuxfoundation.org>
References: <20180310001824.927996722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594508040560199237?=
X-GMAIL-MSGID: =?utf-8?q?1594508040560199237?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
