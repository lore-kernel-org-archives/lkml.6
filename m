Return-Path: <rrajk@nvidia.com>
X-Google-Smtp-Source: AG47ELsbx+1lHD7VPGLyJ3cYsgd3vg3Hi2Bnier5TwGJ0ihcUtsSUeIdDIcrUNpO5XCPNVsXIg8X
ARC-Seal: i=1; a=rsa-sha256; t=1521607287; cv=none;
        d=google.com; s=arc-20160816;
        b=jlyrZBTRcFZlc3CfV7C0f1DhFEfdg/QvV8KEeRV8GzoBugQyXG2kegxrzRGWWteHwA
         vmRd+5yYWXif2m4bP7ehCUbdhXH3qyVlVOv7eoaO4LIxpyDy8AeyGnqCPmvR9BsVa+ID
         S/h614/B3AY4m/w43GgkHxXTE8C/V5AZP3wR+umNJ3RPQWLl8XM5CfKlik/JJ0PVDK4O
         4A6pKWr6HCqCMG0vyLOpTxW40I8yV8J5KfdwkeSZfjFDhLTAzQZUfuzlg35hcNxzShE4
         r0gcrm1di5A+TM6W9OEqocngmM69twj9I0nYJC2sja37FBSlS1KxJu7BFddvqfCFylvU
         LXsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=ADQbGqbrl1VWAYjDzdbOXOPCVW2ZfAVh0Fy6JLGHVP4=;
        b=q9HN5QJneuKLfD/0EzVtZZcVxNrTnBQ97oUVjuyiVlUz3KuxMh6xEGH3zApGif6IhQ
         3VC8snyKeTkmpDhmINRGqNgb/75CBCWMRo2hx19LMnmA4SHXCuUqOwdFF4hS4/rJ0sRp
         aWj4j/PTCb02J/lt0JtiZ6Ehb4C3gV296A5rBoA1ABu5k8Sl32DoHkL9/TrylEdWYf8Y
         Gh3XAzjX5EIaCwrxcX/lF26qLMV8tHEccRJBhQDexhKrDCNas9TJR8GztJOqfwVbqud6
         Jc4+Dm2gPUELiPvPLXErGmOUTajxUr3tgcLLm0pZILWWVoVJYU0dXZPUF5xm2LGZg6fs
         SbSQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of rrajk@nvidia.com designates 216.228.121.143 as permitted sender) smtp.mailfrom=rrajk@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of rrajk@nvidia.com designates 216.228.121.143 as permitted sender) smtp.mailfrom=rrajk@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
X-PGP-Universal: processed;
	by hqpgpgate101.nvidia.com on Tue, 20 Mar 2018 21:41:26 -0700
From: Rajkumar Rampelli <rrajk@nvidia.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
	<jonathanh@nvidia.com>, <jdelvare@suse.com>, <linux@roeck-us.net>,
	<corbet@lwn.net>, <catalin.marinas@arm.com>, <will.deacon@arm.com>,
	<kstewart@linuxfoundation.org>, <gregkh@linuxfoundation.org>,
	<pombredanne@nexb.com>, <mmaddireddy@nvidia.com>, <mperttunen@nvidia.com>,
	<arnd@arndb.de>, <timur@codeaurora.org>, <andy.gross@linaro.org>,
	<xuwei5@hisilicon.com>, <elder@linaro.org>, <heiko@sntech.de>,
	<krzk@kernel.org>, <ard.biesheuvel@linaro.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pwm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-hwmon@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <ldewangan@nvidia.com>,
	<rrajk@nvidia.com>
Subject: [PATCH V2 4/9] arm64: tegra: Add Tachometer Controller on Tegra186
Date: Wed, 21 Mar 2018 10:10:39 +0530
Message-ID: <1521607244-29734-5-git-send-email-rrajk@nvidia.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1521607244-29734-1-git-send-email-rrajk@nvidia.com>
References: <1521607244-29734-1-git-send-email-rrajk@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595520883779757925?=
X-GMAIL-MSGID: =?utf-8?q?1595520883779757925?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The NVIDIA Tegra186 SoC has a Tachometer Controller that analyzes the
PWM signal of a Fan and reports the period value through pwm interface.

Signed-off-by: Rajkumar Rampelli <rrajk@nvidia.com>
---

V2: Renamed clock-names/reset-names dt properties values to "tachometer"
    Renamed compatible property value to "nvidia-tegra186-pwm-tachometer"

 arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts |  5 +++++
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           | 11 +++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
index bd5305a..13c3e59 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
@@ -172,4 +172,9 @@
 			vin-supply = <&vdd_5v0_sys>;
 		};
 	};
+
+	tachometer@39c0000 {
+		nvidia,pulse-per-rev = <2>;
+		nvidia,capture-window-len = <2>;
+	};
 };
diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 731cd01..19e1afc 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -1042,4 +1042,15 @@
 		reset-names = "pwm";
 		status = "disabled";
 	};
+
+	tegra_tachometer: tachometer@39c0000 {
+		compatible = "nvidia,tegra186-pwm-tachometer";
+		reg = <0x0 0x039c0000 0x0 0x10>;
+		#pwm-cells = <2>;
+		clocks = <&bpmp TEGRA186_CLK_TACH>;
+		clock-names = "tachometer";
+		resets = <&bpmp TEGRA186_RESET_TACH>;
+		reset-names = "tachometer";
+		status = "disabled";
+	};
 };
-- 
2.1.4
