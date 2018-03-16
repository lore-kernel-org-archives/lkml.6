Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtz9oJYit8R8owsMln00sgsIt1cL0lW0yv27sjc8BstbFaTgxGHj9e9/5M7LQUL7nw2nRhZ
ARC-Seal: i=1; a=rsa-sha256; t=1521214694; cv=none;
        d=google.com; s=arc-20160816;
        b=HCmJwo0BAJNSfYRo0fhmwdhxckoPp7LI+LmEF3xsftXB2Yl8N05TbRcAH4dWuQ/eeM
         NvG4iSgybtWmbLkEalbnIB6jIsO/9ALtRWVqQ63140ynzvzA22ixL3K3F6SX/3De/BwL
         Fib9FuqUmLOc7qOGaxQeJ7X7LbL/PT1MOcxBNzAJZx7eBNAhF4EQdY955KsZKW3Q/RyM
         EHhfvmKd+hSMCmt1+2OkunydXm/5YJeRsCadmSPkAADev7VTF3qsPa9z8JZ5jnvU7EAU
         Kf/2fnV2ZCXZ2u9X5OEMXdxjoDuzxZNSNlsYFeAUCOLqWqUV5bHDMIeHdX45WgwCy5YY
         yJsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LBFOEqtRfzwlOgTACsOUBQmXGkoWS/hcDE0C+3oaNlw=;
        b=lSWk/cI+Dv295CmCIiSnJyfj1OwpsaSkviQzb0BP1JUYrIW7wBc5CKqf/XKzDlwHCk
         woDQ7JMsUSk4fSCWbcS0XN3XkIz4EuyFHy8lg3lzApnCVin2Bvbq7mBE6VKbqm6Z55Xy
         OSNM+o/9AGPR5/GSCCM9isy1CiyayCcOJZgpUa3eTkVE1pKK4DN7FHjwABG5752eppIu
         p1Q1L2ZBzIotPlpaw9lyFJ1mWrO3wKv2/eWOsMWysV6enz4DtNXrUPWZQoNPNTxM/eG7
         I470YyIJCirsQi8teZYoPzfdqJ7BZBYI7tI35GF/zN/N+BauU4h5i8/67CCgmcUVj6Km
         TAkA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Simon Horman <horms+renesas@verge.net.au>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 095/109] arm64: dts: renesas: salvator-common: Add EthernetAVB PHY reset
Date: Fri, 16 Mar 2018 16:24:04 +0100
Message-Id: <20180316152335.063028359@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109220030381098?=
X-GMAIL-MSGID: =?utf-8?q?1595109220030381098?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>


[ Upstream commit f5bbcd533a9d1af97b8a0862a421bb8455f1bf6d ]

Describe the GPIO used to reset the Ethernet PHY for EthernetAVB.
This allows the driver to reset the PHY during probe and after system
resume.

This fixes Ethernet operation after resume from s2ram on Salvator-XS,
where the enable pin of the regulator providing PHY power is connected
to PRESETn, and PSCI powers down the SoC during system suspend.

On Salvator-X, the enable pin is always pulled high, but the driver may
still need to reset the PHY if this wasn't done by the bootloader
before.

Inspired by patches in the BSP for the individual Salvator-X/XS boards
by Kazuya Mizuguchi.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/renesas/salvator-common.dtsi |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm64/boot/dts/renesas/salvator-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
@@ -264,6 +264,7 @@
 		reg = <0>;
 		interrupt-parent = <&gpio2>;
 		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+		reset-gpios = <&gpio2 10 GPIO_ACTIVE_LOW>;
 	};
 };
 
