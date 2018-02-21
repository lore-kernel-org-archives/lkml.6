Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225r9m4axjeJxtk7oP3ocnqF5HWk7KDfZU8qTCwFX9WwD/zruC/ftqocSyq56TOOHnDc12ZR
ARC-Seal: i=1; a=rsa-sha256; t=1519217170; cv=none;
        d=google.com; s=arc-20160816;
        b=iL9mArFrqOonAlxpsTVxozuw+pdlijb9IPeV0V6MSpLHtK5dmefEl/6OEk0I2wfBxR
         vxT5X14tn7p03xkT1R6EVJB2SmRi2hL2P9Y3pPWTHUAn7kTG/lO+uzKEyJVwRmIOUV4v
         1DL0dlNl72cU7AFQ1kxhN01k7wJfXIMG8hdCHqLtVd2I2zECa40Y8+RJPISuvBBU9UmV
         Yg8gAbFs7TlJk8R7NyQrc6lKcn4g7Bjwq1fP5tO3ndXctf3IvkqoIGc7L3JF+al2p5UG
         gRTp9e0uYOiWZcKxfRN+HRhBBfEMAH5i4uc1SlRL3uobuhlIHlYtrmYCWxhmTFGbVBA4
         Doew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0vHGljW7My4HCiOtfSVginrNYPCtKFPHhj6UHQ7zpmg=;
        b=e9ofIKmTojegOBh2vyLtexK+eTXFVdJ2TXhCnsgkvkId1J/7BSVjqOWJdxuj72y2NW
         h+8QiJYugyb0mzl/fDgLHvQWMr1KFtIZLO1RzfWjB3KO6UcCLcovl3vTfyVRJFREazp1
         Lo+yg//sDQCe1M+YambRkf1a7h1e7C1dExrEARt8dfG+x6OW2LVdUy3HNbJdRyo/m33Z
         gJ4rZkb6UTB2J3XWkntnzl0LgzO/3Q32Y3kRSn9eXVrNdG+9fhZhutfG+mpOMQTFjpJF
         LoxnpQebrGdy0E2OvBsNWSIuvIxK2G8TgVSqya65NnKhNt+N2pr+HUuLN88SkTWHUCQb
         8aww==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Olof Johansson <olof@lixom.net>
Subject: [PATCH 4.4 06/33] arm: spear13xx: Fix dmas cells
Date: Wed, 21 Feb 2018 13:44:49 +0100
Message-Id: <20180221124409.875789417@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124409.564661689@linuxfoundation.org>
References: <20180221124409.564661689@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014663549542696?=
X-GMAIL-MSGID: =?utf-8?q?1593014663549542696?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Viresh Kumar <viresh.kumar@linaro.org>

commit cdd10409914184c7eee5ae3e11beb890c9c16c61 upstream.

The "dmas" cells for the designware DMA controller need to have only 3
properties apart from the phandle: request line, src master and
destination master. But the commit 6e8887f60f60 updated it incorrectly
while moving from platform code to DT. Fix it.

Cc: stable@vger.kernel.org # v3.10+
Fixes: 6e8887f60f60 ("ARM: SPEAr13xx: Pass generic DW DMAC platform data from DT")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/devicetree/bindings/dma/snps-dma.txt |    2 +-
 arch/arm/boot/dts/spear1340.dtsi                   |    4 ++--
 arch/arm/boot/dts/spear13xx.dtsi                   |    6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

--- a/Documentation/devicetree/bindings/dma/snps-dma.txt
+++ b/Documentation/devicetree/bindings/dma/snps-dma.txt
@@ -58,6 +58,6 @@ Example:
 		interrupts = <0 35 0x4>;
 		status = "disabled";
 		dmas = <&dmahost 12 0 1>,
-			<&dmahost 13 0 1 0>;
+			<&dmahost 13 1 0>;
 		dma-names = "rx", "rx";
 	};
--- a/arch/arm/boot/dts/spear1340.dtsi
+++ b/arch/arm/boot/dts/spear1340.dtsi
@@ -141,8 +141,8 @@
 				reg = <0xb4100000 0x1000>;
 				interrupts = <0 105 0x4>;
 				status = "disabled";
-				dmas = <&dwdma0 0x600 0 0 1>, /* 0xC << 11 */
-					<&dwdma0 0x680 0 1 0>; /* 0xD << 7 */
+				dmas = <&dwdma0 12 0 1>,
+					<&dwdma0 13 1 0>;
 				dma-names = "tx", "rx";
 			};
 
--- a/arch/arm/boot/dts/spear13xx.dtsi
+++ b/arch/arm/boot/dts/spear13xx.dtsi
@@ -100,7 +100,7 @@
 			reg = <0xb2800000 0x1000>;
 			interrupts = <0 29 0x4>;
 			status = "disabled";
-			dmas = <&dwdma0 0 0 0 0>;
+			dmas = <&dwdma0 0 0 0>;
 			dma-names = "data";
 		};
 
@@ -288,8 +288,8 @@
 				#size-cells = <0>;
 				interrupts = <0 31 0x4>;
 				status = "disabled";
-				dmas = <&dwdma0 0x2000 0 0 0>, /* 0x4 << 11 */
-					<&dwdma0 0x0280 0 0 0>;  /* 0x5 << 7 */
+				dmas = <&dwdma0 4 0 0>,
+					<&dwdma0 5 0 0>;
 				dma-names = "tx", "rx";
 			};
 
