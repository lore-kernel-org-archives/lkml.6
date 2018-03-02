Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELukP5emV83B505FMn/tTY/AuyZ9LtxczaMkTRhqMxvkiphxlRHExVtGdXvWzSzbB1lY4sOM
ARC-Seal: i=1; a=rsa-sha256; t=1519981302; cv=none;
        d=google.com; s=arc-20160816;
        b=mS5dzFUkEwVTkuRP4e2gL9VHfJARHodTOjNVvpE5KGfU8IR+QhODd7N2LcxHzCv6y3
         fr1D1cqgt2ZL2oThe/RsUyGEKhyU6o3OQlVEoQOXrvoGr+jcpp3HZZB401INcFMx4Jlb
         zfyRNiFEKvnzaX79oqm4xbOLU2svzhqUHmHHc2IaKq3EJKo9hyDGNvHUyzNafkrdewXF
         NwaLuxZ3Yd11ve0OK7QMtIx7/aHG2+5gYEycs1yTpzLGwD2GhWo/4sgu9fwhgny39pDh
         bXWywD5beCb7JMzImhCA0xwif/1ACJyM6R3l4OqMZbITQu4OhHs3zKyHk6DFy/va2S6q
         eDEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=r4FJcIUcA9IwhVnCOQZxgSTln8l5UqlLsdcj534e4WU=;
        b=VIWh2HbQ02RUIRDrzejMto2vDIq5SkANEWKEZMshIqJkuX4L/VzAMHwGSPnuCaOdiu
         lR0UWgbuks4fmlPCqZq0ArPetLcuc/IMg1dJpvFgSaC9Z+OhvB5Gb6nX5m/Ak0ZZMSeE
         noG63Efcuc7/N2HIjmtQWOyJyAk3IRbpqC9bzESkLP62VcMmi/whsNQVrnusJiVbZwNw
         7RBcAg4mfAFHrDkDY/CSgxFFp3vmJ7GisvPhEmT9vmB/rsgXdymPpIu2pbZTJGwUoTgA
         Xs8fNvi9dyHmxys3tDeqkfRAvBKsGLh62ZZ7H/HwmzL2g8eP7XY70PyqJqwLgouh7T0W
         7zWg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Bogdan Mirea <Bogdan-Stefan_Mirea@mentor.com>,
	Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
	Simon Horman <horms+renesas@verge.net.au>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 051/115] arm64: dts: renesas: ulcb: Remove renesas, no-ether-link property
Date: Fri,  2 Mar 2018 09:50:54 +0100
Message-Id: <20180302084505.940899496@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815914081680497?=
X-GMAIL-MSGID: =?utf-8?q?1593815914081680497?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bogdan Mirea <Bogdan-Stefan_Mirea@mentor.com>


[ Upstream commit 7d2901f809c110bd9a261e879d59efe62e3bc758 ]

The present change is a bug fix for AVB link iteratively up/down.

Steps to reproduce:
- start AVB TX stream (Using aplay via MSE),
- disconnect+reconnect the eth cable,
- after a reconnection the eth connection goes iteratively up/down
  without user interaction,
- this may heal after some seconds or even stay for minutes.

As the documentation specifies, the "renesas,no-ether-link" option
should be used when a board does not provide a proper AVB_LINK signal.
There is no need for this option enabled on RCAR H3/M3 Salvator-X/XS
and ULCB starter kits since the AVB_LINK is correctly handled by HW.

Choosing to keep or remove the "renesas,no-ether-link" option will
have impact on the code flow in the following ways:
- keeping this option enabled may lead to unexpected behavior since
  the RX & TX are enabled/disabled directly from adjust_link function
  without any HW interrogation,
- removing this option, the RX & TX will only be enabled/disabled after
  HW interrogation. The HW check is made through the LMON pin in PSR
  register which specifies AVB_LINK signal value (0 - at low level;
  1 - at high level).

In conclusion, the present change is also a safety improvement because
it removes the "renesas,no-ether-link" option leading to a proper way
of detecting the link state based on HW interrogation and not on
software heuristic.

Fixes: dc36965a8905 ("arm64: dts: r8a7796: salvator-x: Enable EthernetAVB")
Fixes: 6fa501c549aa ("arm64: dts: r8a7795: enable EthernetAVB on Salvator-X")
Signed-off-by: Bogdan Mirea <Bogdan-Stefan_Mirea@mentor.com>
Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/renesas/ulcb.dtsi |    1 -
 1 file changed, 1 deletion(-)

--- a/arch/arm64/boot/dts/renesas/ulcb.dtsi
+++ b/arch/arm64/boot/dts/renesas/ulcb.dtsi
@@ -145,7 +145,6 @@
 &avb {
 	pinctrl-0 = <&avb_pins>;
 	pinctrl-names = "default";
-	renesas,no-ether-link;
 	phy-handle = <&phy0>;
 	status = "okay";
 
