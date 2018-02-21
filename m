Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227enyeS26xbqXVhKO32O3G23NSho9QeFUjvImLQKtWDKeNhh1B6OujpH0Gx/PIvCatBB2kt
ARC-Seal: i=1; a=rsa-sha256; t=1519217856; cv=none;
        d=google.com; s=arc-20160816;
        b=GGXui8VhDe+58ZQefGszXEGCmrtfo4+sIfh9e2bfIeCgCHNMtV/f7Yk1gwXwL9qCEX
         4KeHzNFC4BlgGTKsC0PU3dPEv/tNvHzGgynbEomQ74JUysekJkmEglTSHprvtyOB4bG/
         oaQdVvn4ETgLYjtyjmXAT4F/J3YlzidcR6pM1VZB/BaK0Hrli9dDxBLcZII/8B7vLzru
         MkKq35hjs1SAyMalP2ulE62uaKtVzN1nhrqZIggqqLfVqIGtrZuo0yHF6dRpv7/Nk0Tt
         Se1pHCjpQ3CGLWvTbClTovTxAuqjOK1XCeJNxENk8+eE5cLdcFuuhkLIdKmFuc7ASdXp
         LJbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=UvlS0ty97SQqJuINR1n1gEp4duIemwIun5kL/p0/knk=;
        b=AbfMDqsEyytZ4mUuEQbEQpodQ72gqNwq/QTPn7MKskOjJRgsTM7Dhh9x9La8DkB1i/
         FP+FwCdiBiyLbPAakOEWMwp2lNxSCowIZRYuSW6z92aVL27tzKA1a4TJzDAXeWqwABaD
         sG5FCHQHZp7//mmaL27EAKpBz3A6kMB9WRWb0r24XMeC5rGTzgzC8D4zZqhkhz313dLb
         flDz0pSBDA4YmwM5OVZsZ2oMDxrkPQq6fc/WiREGVXUZ3uQI0gRFN6mhcEMa4WgFdvIm
         Pt+wT9Qb7ovNmu4zctu4II7zhdw1e4TCI9Lv7vihs66l81WMPmz9q+F2pbquDPpQbPq+
         dSxA==
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
Subject: [PATCH 4.9 48/77] arm: spear13xx: Fix dmas cells
Date: Wed, 21 Feb 2018 13:48:57 +0100
Message-Id: <20180221124434.210290172@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014663549542696?=
X-GMAIL-MSGID: =?utf-8?q?1593015382949880285?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -63,6 +63,6 @@ Example:
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
 
