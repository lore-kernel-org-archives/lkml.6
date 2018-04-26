Return-Path: <ulf.hansson@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524732803; cv=none;
        d=google.com; s=arc-20160816;
        b=UgCFYg1vELRgAFIhKqPm6GYMzQc6LGfqe+SNM4UnVubhCM6DhyeaZf/1FxyMSI9Ndz
         Gw8udptRhH+3joo3rRoMj8efYkMsvzb1UEaUxUWpow54XwhSB1chOW/5xuuHutyQKb2N
         tOkjkLAgFhOeNR8MAfeLdK6BJYH0qT9QonWAyT+6UmqMB1e5tHZMmKes0rDEm6h6HNcL
         maZZNOa9mJBFF0hgcRsBGmv4/iREEra6/689IAXN4++TbuH827MTuQI0Ajg7yCnMqwoc
         fLejjWi/LvfGXUGvFM02JJBrz4N/W1R6GQuTpPLSkbJWI7vOsw5w2owPn8a70YIXR8Tl
         C49w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=myhUo+RRBuBr1W4j3dNgjvpKR9j5RD+zME8+Uz1EWlA=;
        b=HFwe588HdFg7eT7Osk/+LOOBC7D4pnrM7hb1zMJlFgF9wvNnhzOkXQ+NEqtMuL4AzL
         QGQXuwvkv5mnduIGPUbz3RA/MTDVX5LFupPnq2XqcFNR7GstdoAaXELXNcGB02/xaoAf
         jxnIDO6Nm8oqVCCX11+6xTQBMdS5JTOZc5KFlPwW4zP4dBkcd1ZEz2/1z/caN/M3Zamr
         7sUqRxdBiAFf93eebm4Pqf2XpCZhybdPn2IxI0k1M+4bTO0atNJGk5Var2M5t+Sk26Av
         ul8LyGz46R1xI2pQ9Py0ef2YlwVRkAd5Oj+xMuvqJGXfu95t4cTmAJXoajOC9NTruy33
         Iirw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=jByH7P3D;
       spf=pass (google.com: domain of ulf.hansson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulf.hansson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=jByH7P3D;
       spf=pass (google.com: domain of ulf.hansson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulf.hansson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZpmBkzo6Ygg1o+pbE6kj8XIK+loIVKJpjYpBna9W22AgODjnbsaJ5mPShWrEY9ENWm2EpPeqw==
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
Subject: [PATCH 05/11] PM / Domains: Allow a better error handling of dev_pm_domain_attach()
Date: Thu, 26 Apr 2018 10:53:04 +0200
Message-Id: <1524732790-2234-6-git-send-email-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
References: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598798223252230159?=
X-GMAIL-MSGID: =?utf-8?q?1598798223252230159?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The callers of dev_pm_domain_attach() currently checks the returned error
code for -EPROBE_DEFER and needs to ignore other error codes. This is an
unnecessary limitation, which also leads to a rather strange behaviour in
the error path.

Address this limitation, by changing the return codes from
acpi_dev_pm_attach() and genpd_dev_pm_attach(). More precisely, let them
return 0, when no PM domain is needed for the device and then return 1, in
case the device was successfully attached to its PM domain. In this way,
dev_pm_domain_attach(), gets a better understanding of what happens in the
attach attempts and also allowing its caller to better act on real errors
codes.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/acpi/device_pm.c    |  6 +++---
 drivers/base/power/common.c |  7 ++++---
 drivers/base/power/domain.c | 19 ++++++++++---------
 include/linux/acpi.h        |  2 +-
 include/linux/pm_domain.h   |  2 +-
 5 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index d006300..a7c2673 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -1257,7 +1257,7 @@ int acpi_dev_pm_attach(struct device *dev, bool power_on)
 	struct acpi_device *adev = ACPI_COMPANION(dev);
 
 	if (!adev)
-		return -ENODEV;
+		return 0;
 
 	/*
 	 * Only attach the power domain to the first device if the
@@ -1265,7 +1265,7 @@ int acpi_dev_pm_attach(struct device *dev, bool power_on)
 	 * management twice.
 	 */
 	if (!acpi_device_is_first_physical_node(adev, dev))
-		return -EBUSY;
+		return 0;
 
 	acpi_add_pm_notifier(adev, dev, acpi_pm_notify_work_func);
 	dev_pm_domain_set(dev, &acpi_general_pm_domain);
@@ -1275,7 +1275,7 @@ int acpi_dev_pm_attach(struct device *dev, bool power_on)
 	}
 
 	dev->pm_domain->detach = acpi_dev_pm_detach;
-	return 0;
+	return 1;
 }
 EXPORT_SYMBOL_GPL(acpi_dev_pm_attach);
 #endif /* CONFIG_PM */
diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
index f3cf61f..5e4b481 100644
--- a/drivers/base/power/common.c
+++ b/drivers/base/power/common.c
@@ -98,7 +98,8 @@ EXPORT_SYMBOL_GPL(dev_pm_put_subsys_data);
  * Callers must ensure proper synchronization of this function with power
  * management callbacks.
  *
- * Returns 0 on successfully attached PM domain or negative error code.
+ * Returns 0 on successfully attached PM domain and when it found that the
+ * device don't need a PM domain, else a negative error code.
  */
 int dev_pm_domain_attach(struct device *dev, bool power_on)
 {
@@ -108,10 +109,10 @@ int dev_pm_domain_attach(struct device *dev, bool power_on)
 		return -EEXIST;
 
 	ret = acpi_dev_pm_attach(dev, power_on);
-	if (ret)
+	if (!ret)
 		ret = genpd_dev_pm_attach(dev);
 
-	return ret;
+	return ret < 0 ? ret : 0;
 }
 EXPORT_SYMBOL_GPL(dev_pm_domain_attach);
 
diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index b816adb..455ecea 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2180,10 +2180,11 @@ static void genpd_dev_pm_sync(struct device *dev)
  * Parse device's OF node to find a PM domain specifier. If such is found,
  * attaches the device to retrieved pm_domain ops.
  *
- * Returns 0 on successfully attached PM domain or negative error code. Note
- * that if a power-domain exists for the device, but it cannot be found or
- * turned on, then return -EPROBE_DEFER to ensure that the device is not
- * probed and to re-try again later.
+ * Returns 1 on successfully attached PM domain, 0 when the device don't need a
+ * PM domain or a negative error code in case of failures. Note that if a
+ * power-domain exists for the device, but it cannot be found or turned on,
+ * then return -EPROBE_DEFER to ensure that the device is not probed and to
+ * re-try again later.
  */
 int genpd_dev_pm_attach(struct device *dev)
 {
@@ -2192,12 +2193,12 @@ int genpd_dev_pm_attach(struct device *dev)
 	int ret;
 
 	if (!dev->of_node)
-		return -ENODEV;
+		return 0;
 
 	ret = of_parse_phandle_with_args(dev->of_node, "power-domains",
 					"#power-domain-cells", 0, &pd_args);
 	if (ret < 0)
-		return ret;
+		return 0;
 
 	mutex_lock(&gpd_list_lock);
 	pd = genpd_get_from_provider(&pd_args);
@@ -2218,7 +2219,7 @@ int genpd_dev_pm_attach(struct device *dev)
 		if (ret != -EPROBE_DEFER)
 			dev_err(dev, "failed to add to PM domain %s: %d",
 				pd->name, ret);
-		goto out;
+		return ret;
 	}
 
 	dev->pm_domain->detach = genpd_dev_pm_detach;
@@ -2230,8 +2231,8 @@ int genpd_dev_pm_attach(struct device *dev)
 
 	if (ret)
 		genpd_remove_device(pd, dev);
-out:
-	return ret ? -EPROBE_DEFER : 0;
+
+	return ret ? -EPROBE_DEFER : 1;
 }
 EXPORT_SYMBOL_GPL(genpd_dev_pm_attach);
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 15bfb15..c01675b 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -899,7 +899,7 @@ static inline int acpi_subsys_runtime_suspend(struct device *dev) { return 0; }
 static inline int acpi_subsys_runtime_resume(struct device *dev) { return 0; }
 static inline int acpi_dev_pm_attach(struct device *dev, bool power_on)
 {
-	return -ENODEV;
+	return 0;
 }
 #endif
 
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 04dbef9..a1da66e 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -280,7 +280,7 @@ static inline int of_genpd_parse_idle_states(struct device_node *dn,
 
 static inline int genpd_dev_pm_attach(struct device *dev)
 {
-	return -ENODEV;
+	return 0;
 }
 
 static inline
-- 
2.7.4
