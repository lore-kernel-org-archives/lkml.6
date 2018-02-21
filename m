Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225u/UKES931al/+lOnl4x17GhnHFjUsxeSoCPC5M7+eCabGTT1h9N+3q/LgaPm3vlxSbODB
ARC-Seal: i=1; a=rsa-sha256; t=1519217872; cv=none;
        d=google.com; s=arc-20160816;
        b=Jw1k8ISqm3YEenSt+ogFIG54pBxEfBmKZIkqbz0TC6vBBxLz6v5J0PV4cCzzzCfYVk
         mF/RadAH4kLJ9alZF6ykVvIys0Lw6Sm3L52eBTD24EIt3Gmoa16zpSRLFwvYFV8xnuya
         7Jp9i65UGv7FVz6Wki95Lisobipm2qdRLnbzjGywZkBtg+mNb5qvPhLPsyEh6bmUaMq/
         Vmo+1WPX4/75xJzvaw3q4Rtupq81HHRqzgIHyjOplTD6aSYkYQbCiDN2dqkHepRLz6xW
         hbaiBDSE+DwRRwckN886THryTehDN+eBWLYVxYVy5JBnJ/2v7cZQ4Me0nWdvNCjXVtEI
         2jZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=NuCuMt911FiSQhD78MxPEP6LaMBQxb7xBppQaIfAt1o=;
        b=Njk+AxIwLsfTa0nhLvtmxpu/037cWX6Rtx27Xng+xIu2aGdQkDvzswZm9mPi2lj8PR
         7EPc1buDCCr9jo+tjO2gAhhflHTk5DajiChXe6ouISuIN9zXYg7tTT+dRbCHHZPA7tVg
         aU2yFOi89XWWrXS4CE8NYnNcDAOpyQ4OIWPSjKjBbK2fXO5UwT1Pv0L+Zrbkp7h8ACQ6
         T3v66De0ZVCLYv8UT2kLGsJnBauSgMWcQA7ogUeggBbRIzhqHkyOlkKR6aAuu3ZeVBMT
         s4IsqNujaHOz5u9YhmsLHjix1ouCpXABMmwUIT9rhGrDPBGVdRKCLe9k3952ZpQwEO0J
         xIUQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.9 44/77] ARM: lpc3250: fix uda1380 gpio numbers
Date: Wed, 21 Feb 2018 13:48:53 +0100
Message-Id: <20180221124434.042724403@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015399989445570?=
X-GMAIL-MSGID: =?utf-8?q?1593015399989445570?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
 
