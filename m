Return-Path: <ulf.hansson@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524732801; cv=none;
        d=google.com; s=arc-20160816;
        b=E6J9/4RW6aJiaMCXKoCRCosDbNWAdzGOqzfyY5WLJSNoM36XX69SPZchLaY/1UgJ8+
         nusLWFBgyqdkBg2Av+/bVtGA5zJcY2f+z8rNvWCTYhTCkZlbIt303SoJOKJr0rf6no0N
         eSyX/zACZo2SpRsUYoOuJDIPv12rRs/gac67I//sHHHeHYFNM1+dcssj2n2bgzPibtGh
         xO401j27wHBLAngkoRHXz0vWxceRCZKabWDh1OMtMPvmekBksVq/TpnjhqU/4zWZdimu
         8yUrJY1sUPmkIAm97vInEQR1Jew5V6Xj7hBKmDqnMJGIC0O5V+CM/Stizeanp+TGD+63
         VR3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=0GyqQznU278kM2emAIQfIFInCTzuUYGErGb1DqJIbtQ=;
        b=qzuHog7yFDN4Si7TFYi2eQHAySgHvYztV7rOLtbzooZ/7G86/50+yMja3P/riudHpQ
         CNWWxcSsw2fuNRqO+dyXxb5mmQwLjG/NGEqg1P/i2c5im0jB5+h/3R/COd1OvZ+FhZXh
         JystGVE8yyubSiQVDHwenqvsuFcqtXooG/696oUC/M0pRFwnTCLGMYrJYRch2xryqRBv
         Kxzdk6+r9qA9JJili6ehR8MsJhr2bUDQiX58/91RIyHxmtHAfagNDB3tAnvA4j44nsf2
         AI+NXVUCOigJEfu0Mjp6TtmCEOSvJGrjSa6udjP3ZWLzVW6oHcpSvEh9SF33Hwzdb43w
         1Z+A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=ZVBeT7vE;
       spf=pass (google.com: domain of ulf.hansson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulf.hansson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=ZVBeT7vE;
       spf=pass (google.com: domain of ulf.hansson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulf.hansson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZpUhL3m3fgj9e1oO7eZFkyPRdW/mrAPcSsU4ZM6YwUIxSxl70Afa/JiuZr1NtwnnRR3A0mMKg==
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pm@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Kevin Hilman <khilman@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Vinod Koul <vinod.koul@intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 04/11] PM / Domains: Check for existing PM domain in dev_pm_domain_attach()
Date: Thu, 26 Apr 2018 10:53:03 +0200
Message-Id: <1524732790-2234-5-git-send-email-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
References: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598798222138276329?=
X-GMAIL-MSGID: =?utf-8?q?1598798222138276329?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Instead of checking if an existing PM domain pointer has been assigned in
genpd_dev_pm_attach() and acpi_dev_pm_attach(), move the check to the
common path in dev_pm_domain_attach(), thus potentially avoid one
unnecessary check.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/acpi/device_pm.c    | 3 ---
 drivers/base/power/common.c | 3 +++
 drivers/base/power/domain.c | 3 ---
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index 3d96e4d..d006300 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -1259,9 +1259,6 @@ int acpi_dev_pm_attach(struct device *dev, bool power_on)
 	if (!adev)
 		return -ENODEV;
 
-	if (dev->pm_domain)
-		return -EEXIST;
-
 	/*
 	 * Only attach the power domain to the first device if the
 	 * companion is shared by multiple. This is to prevent doing power
diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
index f6a9ad5..f3cf61f 100644
--- a/drivers/base/power/common.c
+++ b/drivers/base/power/common.c
@@ -104,6 +104,9 @@ int dev_pm_domain_attach(struct device *dev, bool power_on)
 {
 	int ret;
 
+	if (dev->pm_domain)
+		return -EEXIST;
+
 	ret = acpi_dev_pm_attach(dev, power_on);
 	if (ret)
 		ret = genpd_dev_pm_attach(dev);
diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index d4b96ed..b816adb 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2194,9 +2194,6 @@ int genpd_dev_pm_attach(struct device *dev)
 	if (!dev->of_node)
 		return -ENODEV;
 
-	if (dev->pm_domain)
-		return -EEXIST;
-
 	ret = of_parse_phandle_with_args(dev->of_node, "power-domains",
 					"#power-domain-cells", 0, &pd_args);
 	if (ret < 0)
-- 
2.7.4
