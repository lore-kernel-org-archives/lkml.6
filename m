Return-Path: <rrajk@nvidia.com>
X-Google-Smtp-Source: AH8x227O0xwAKBiwsyplyfrPUNe3ea6vsPQn8dnaJXs8kPxY/p5XIfq7QUJ+ozCEdpmvMQNaYBbu
ARC-Seal: i=1; a=rsa-sha256; t=1519196433; cv=none;
        d=google.com; s=arc-20160816;
        b=VYVssF/2tW7AeVxspo3Yj+H3vvnouB6narJ6E5R7t9+Nbvshi///tO2HbJcCpAwhcF
         Pi83kMm4zqgu3FgUhq9qSyeXzONQ6jUr5QzL1efU15biX901FAOjus5hE7AC33sAmTfV
         pv8JyOx2RoveReWi9C4Lz2jqfus0kNYii7aPLXlHr5wxXIf7G9uZTiC7sOW0b5XO0dYj
         BoeEGlP2s+WSyy1F10g58MN3bxjbtdhXOqnNX4oXEpiqxa4I8O2Ap8Mr1tEC7h55txjV
         o+6cJjFFn0bbp3nj/1piCaDrGpBQw8ybpsi8NJo776vSc34ngYqBfbk72M0zMrSjJsT5
         UA7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=NW5vN21woXYbdWnNVSAIooPhSuo9raU9pKQ4+5XTlok=;
        b=epga76FJHUR5ronty+RDkD4JjEfqSWDBGl7Py7g3O+PTQUO+pcXCeHRkuVsj8QN+wH
         JFttoHUljMTfbaemkKz0bi0mVWseWvkx1fLJxzPzIs3wzM3SvfAC1IeW3mVMwek7/mde
         y1SHXOOxSpZxIfrd36vwK2GV008mMGCf0DdCMy6HNOuDqlZBG5o0Os4hUhqxk5Jjn51H
         HUrbLQvnl4qfSRg4yoaRVJHj8P0NSgW8Dp6ONWrFjtUJRka0XB1cTsmDeoFv4xnpoaAc
         QasmqyeXUcDnDunVWYyQL/VvU1Sts7jbTN8Mr8egyi96JdZE8QyCk16soLoBwW5sofzc
         he3Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of rrajk@nvidia.com designates 216.228.121.64 as permitted sender) smtp.mailfrom=rrajk@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of rrajk@nvidia.com designates 216.228.121.64 as permitted sender) smtp.mailfrom=rrajk@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
X-PGP-Universal: processed;
	by hqpgpgate101.nvidia.com on Tue, 20 Feb 2018 23:00:32 -0800
From: Rajkumar Rampelli <rrajk@nvidia.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
	<jonathanh@nvidia.com>, <jdelvare@suse.com>, <linux@roeck-us.net>,
	<corbet@lwn.net>, <catalin.marinas@arm.com>, <will.deacon@arm.com>,
	<kstewart@linuxfoundation.org>, <gregkh@linuxfoundation.org>,
	<pombredanne@nexb.com>, <mmaddireddy@nvidia.com>, <mperttunen@nvidia.com>,
	<arnd@arndb.de>, <gregory.clement@free-electrons.com>,
	<timur@codeaurora.org>, <andy.gross@linaro.org>, <xuwei5@hisilicon.com>,
	<elder@linaro.org>, <heiko@sntech.de>, <krzk@kernel.org>,
	<ard.biesheuvel@linaro.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pwm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-hwmon@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <ldewangan@nvidia.com>,
	<rrajk@nvidia.com>
Subject: [PATCH 07/10] arm64: tegra: Add PWM based Tachometer support on Tegra186
Date: Wed, 21 Feb 2018 12:28:56 +0530
Message-ID: <1519196339-9377-8-git-send-email-rrajk@nvidia.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1519196339-9377-1-git-send-email-rrajk@nvidia.com>
References: <1519196339-9377-1-git-send-email-rrajk@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592992919427579079?=
X-GMAIL-MSGID: =?utf-8?q?1592992919427579079?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add PWM based Tachometer support on Tegra186 to measure
number of rotations of a Fan per minute by using PWM
capture interface

Signed-off-by: Rajkumar Rampelli <rrajk@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 8f2d598..37149e9 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -1042,4 +1042,10 @@
 		reset-names = "tachometer";
 		status = "disabled";
 	};
+
+	generic_pwm_tachometer {
+		compatible = "generic-pwm-tachometer";
+		pwms = <&tegra_tachometer 0 1000000>;
+		status = "disabled";
+	};
 };
-- 
2.1.4
