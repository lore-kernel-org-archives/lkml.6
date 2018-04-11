Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+KIYi8I9eH1s7HeXEEHMqN0WEVWy7di6jEAekpCrnU5HA+GAabgoQWtH4disOk/1a50+qd
ARC-Seal: i=1; a=rsa-sha256; t=1523473362; cv=none;
        d=google.com; s=arc-20160816;
        b=HmRm3dRW6gs81BweEiiWuwyo1uEncKfD3e6RFFBfBbWjlQS5gvZGcmbMaGU9uRvBd+
         yJ0RXLU2ZvKrrtivtvGPVnoYgS+q2xIGwsvrDWfSOFB9sodkf1fizR/P30mGvvNXFPJY
         9mvMd/ojppcSbjHBHt9eP6FeCeQ3X0ZWm/P5SGy99Cuyn7LsqgsDYJOoVW4TnOBSvIPO
         djXmkeWoYkJ6mEWONJ/nJfrmG2IGH+C6HewYPi08sNaVkgjEIwM8CTizr7K9nYk4Jury
         fpmNH2gSZFWmMBy0qvT4eZLjFNP8cUAvDPxpqGtdAJmI9ePDrw3YuKLwHino+21Mqzf0
         iFcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=xsWGK35B3Z7+AMYkm+Z1CG/+jzNd+5J+RcdHWHwfMbg=;
        b=tD/3v+Y35xR2bu21wa13JBuVmCvraqpd2/UrgTocAiS9PprhWxFbkRGsttgrt+fqsV
         8XRi9q0r4htfJHCD5IQ/nrf4eJV185cTHh/BUQ53mdQWbr36m4ftgPGeX0+TEth0rIWT
         g3PA8tJaLmnAbGUjy6LwjZk3gbM0ByhSTtodshFcvR2QG1lGIWZ6rAnoCgO+K1O+OROp
         XftObIOTktNOsWZbJhqKzR6clP7zjwIgxV1MxSFJoeIDzbnqL9lkzUQEzAhi8xoMg5nf
         2aaqk4Uyandok9Si1oXZgyCK5ThfejhcsO2/04oBpiN9iCEKgyO9BqUSC2g5Xp5T22PP
         rHpA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Simon Horman <horms+renesas@verge.net.au>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 221/310] ARM: dts: armadillo800eva: Split LCD mux and gpio
Date: Wed, 11 Apr 2018 20:36:00 +0200
Message-Id: <20180411183632.047615699@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477604898223974?=
X-GMAIL-MSGID: =?utf-8?q?1597477604898223974?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>


[ Upstream commit 13132b3f44d3600983aceb7e9920b8ebb55a7cf8 ]

Configuration of the lcd0 pinmux group and GPIO hog for the external
GPIO mux are done using a single device node, causing the "output-high"
property to be applied to both.  This will fail for the pinmux group,
but doesn't cause any harm, as the failure is ignored silently.

However, after "pinctrl: sh-pfc: propagate errors on group config", the
failure will become fatal, leading to a broken display:

    sh-pfc e6050000.pin-controller: pin_config_group_set op failed for group 102
    sh-pfc e6050000.pin-controller: Error applying setting, reverse things back
    sh-pfc e6050000.pin-controller: failed to select default state

Move the GPIO hog to its own node to fix this.

Fixes: ffd2f9a5afb730b9 ("ARM: shmobile: armadillo800eva dts: Add pinctrl and gpio-hog for lcdc0")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
@@ -266,7 +266,9 @@
 	lcd0_pins: lcd0 {
 		groups = "lcd0_data24_0", "lcd0_lclk_1", "lcd0_sync";
 		function = "lcd0";
+	};
 
+	lcd0_mux {
 		/* DBGMD/LCDC0/FSIA MUX */
 		gpio-hog;
 		gpios = <176 0>;
