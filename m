Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2262tn1nCCYXPFvk16RJdtTQ7a4TW7F9OsGpWvKrMH8AHecopK4nS+IrY0b7ggPYJ/zbU/xr
ARC-Seal: i=1; a=rsa-sha256; t=1519218405; cv=none;
        d=google.com; s=arc-20160816;
        b=mu1dSOldRN3WZWZkzfkD1LlrRoNZO78bPML8caPXF6X0ZlN2nW4Q4qV7c00ZHEp94e
         SdPNOpdOnDVZDJkMcTM1Ar79UKrZR2/cUD46eVYKZOKZU+h8CT0JYRyft0HCV9c2/cRb
         qrmKs1SfZhI2A6CWHSF70SMujAxw3QKYv2mlwaaVJ732jYoDbbyIdjhYQgmpLFtCwO1a
         9z5qk9wTeMcv7iOIWwz6IMcsBvSLQHBQ5KtfSmIPXWOz3FSuvMkRlAduCy6PJawm4ywE
         E8TTTxOhIhSSdpsHzAL5eQ5pcm0y6zbuV/KpKy/H8s7AH8UOsbvOLWZmAKbtj6LKZhZk
         fpgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=xPsNAltHZILAgK7nzj2s65oSrMcEnFSjokgBddJfTmQ=;
        b=sAJg8Th+6QlRN6Yg9gbJuTC5gW9Z1dmLD5dnhUzV19KZ8ehsFmexKIiL4h5kEY+WsZ
         TXvQ9M+n1gW8il8I/2zR6+wq/nyFVuSMhK9RNqx7i2IzcrqEnIsdXICCaE43zDnrt3U5
         fP2Uqzs3SM1o67gSQZ8Ao97raOpfXyG4otoqxQ0nJ2dwI6J66SYs1KRFlR46Dq42Z0Uq
         IPVsdJPx3XfR6U/DTLUWTsv2RZaGPdlgZwBfUT3ge0y1nU8fNN4ECAws0aF9RywqUmfx
         j0N7diVMUEp3QiPAHpCZXq6B0RO0r1yM4G7OqRUXLBQf055J4kRalSMY5YnDPYCSQ121
         CESg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.15 028/163] ARM: lpc3250: fix uda1380 gpio numbers
Date: Wed, 21 Feb 2018 13:47:37 +0100
Message-Id: <20180221124531.779446069@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015399989445570?=
X-GMAIL-MSGID: =?utf-8?q?1593015958525449357?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit ca32e0c4bf9ca4b87089c5a5ce945e5f2ec890da upstream.

dtc warns about obviously incorrect GPIO numbers for the audio codec
on both lpc32xx boards:

arch/arm/boot/dts/lpc3250-phy3250.dtb: Warning (gpios_property): reset-gpio property size (12) too small for cell size 3 in /ahb/apb/i2c@400A0000/uda1380@18
arch/arm/boot/dts/lpc3250-phy3250.dtb: Warning (gpios_property): power-gpio property size (12) too small for cell size 3 in /ahb/apb/i2c@400A0000/uda1380@18
arch/arm/boot/dts/lpc3250-ea3250.dtb: Warning (gpios_property): reset-gpio property size (12) too small for cell size 3 in /ahb/apb/i2c@400A0000/uda1380@18
arch/arm/boot/dts/lpc3250-ea3250.dtb: Warning (gpios_property): power-gpio property size (12) too small for cell size 3 in /ahb/apb/i2c@400A0000/uda1380@18

It looks like the nodes are written for a different binding that combines
the GPIO number into a single number rather than a bank/number pair.
I found the right numbers on stackexchange.com, so this patch fixes
the warning and has a reasonable chance of getting things to actually
work.

Cc: stable@vger.kernel.org
Link: https://unix.stackexchange.com/questions/59497/alsa-asoc-how-to-correctly-load-devices-drivers/62217#62217
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/lpc3250-ea3250.dts  |    4 ++--
 arch/arm/boot/dts/lpc3250-phy3250.dts |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

--- a/arch/arm/boot/dts/lpc3250-ea3250.dts
+++ b/arch/arm/boot/dts/lpc3250-ea3250.dts
@@ -156,8 +156,8 @@
 	uda1380: uda1380@18 {
 		compatible = "nxp,uda1380";
 		reg = <0x18>;
-		power-gpio = <&gpio 0x59 0>;
-		reset-gpio = <&gpio 0x51 0>;
+		power-gpio = <&gpio 3 10 0>;
+		reset-gpio = <&gpio 3 2 0>;
 		dac-clk = "wspll";
 	};
 
--- a/arch/arm/boot/dts/lpc3250-phy3250.dts
+++ b/arch/arm/boot/dts/lpc3250-phy3250.dts
@@ -81,8 +81,8 @@
 	uda1380: uda1380@18 {
 		compatible = "nxp,uda1380";
 		reg = <0x18>;
-		power-gpio = <&gpio 0x59 0>;
-		reset-gpio = <&gpio 0x51 0>;
+		power-gpio = <&gpio 3 10 0>;
+		reset-gpio = <&gpio 3 2 0>;
 		dac-clk = "wspll";
 	};
 
