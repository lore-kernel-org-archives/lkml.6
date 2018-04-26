Return-Path: <ulf.hansson@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524732805; cv=none;
        d=google.com; s=arc-20160816;
        b=m2x1Ypo8OHERtgcDENNfUP36tYjKECmVIsyEIyxvmkFL472rt4eybdJi5v7cso/wb3
         nCOkLwYTIaW3n55OI+iTYnCDhUGCO23Z8wlwuW6ngSOOCdFV3HjuMJMgitml6LPnJUVE
         FWLT7dJ8r4LJracOXSM+XId4PSiRHgW9SML063HE0HSKrFh+glok1ZyjuJmtNpd2dbNx
         59ht+10KshVXCRkNJ5+kUjSO/bEWHHszEtLsoh2+m3DpY+mpGTXHdoU291itHNHutIbK
         9Z4AM1LSGO3FN1VJmCdPHI0UVwsU6yf/mOk/mN3PWCf66G/s3TDHHPSrdeyCp2KYaLVi
         jJCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=H5Anx8HHtixBsfJHQkkyvqYQI+3r9uHRYHoqlZJ0xFo=;
        b=0Rjk5Ou7fjyty92jjNCZcooxpIWJo2CiuIGWBRbj1bPAbgPcLHVbh1XlyrYsrYErDZ
         J2dlwTWVzHO1WPol5bKsyd8hrr329MmUeA4TNXcfZqtTdkXgrp2ylJUw9FpvtH2JXrdI
         l4UXAUoVaDTc6XrzjNvYwcBVCobW5lWpjucKaK52FhpZwH58+3x00Pm2t8+s6ldgzlHH
         GQZhXHL0J1K2TmPOKtycFEPtBl+Bj0yjGxDl5JIOSWNXKShXhDDWwvcbmqrYcAbiotXH
         c8uEyP9EokAtyokJQJgwFjwpwp2/no4wzMAUyLlfs/gHi8lsSH7EkHNJ6ZSRjqXIKLL/
         oJcA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=YdPW6sbQ;
       spf=pass (google.com: domain of ulf.hansson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulf.hansson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=YdPW6sbQ;
       spf=pass (google.com: domain of ulf.hansson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulf.hansson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZq8Upp3SruXHrnUeX4byXevOhdkpWfiIciJPXCcvr+cFZc5+nFzRwL9rxyhIE/fhbS4O8MBnw==
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
Subject: [PATCH 07/11] driver core: Respect all error codes from dev_pm_domain_attach()
Date: Thu, 26 Apr 2018 10:53:06 +0200
Message-Id: <1524732790-2234-8-git-send-email-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
References: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598798225940952926?=
X-GMAIL-MSGID: =?utf-8?q?1598798225940952926?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The limitation of being able to check only for -EPROBE_DEFER from
dev_pm_domain_attach() has been removed. Hence let's respect all error
codes and bail out accordingly.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/platform.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 8075ddc..9460139 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -572,17 +572,16 @@ static int platform_drv_probe(struct device *_dev)
 		return ret;
 
 	ret = dev_pm_domain_attach(_dev, true);
-	if (ret != -EPROBE_DEFER) {
-		if (drv->probe) {
-			ret = drv->probe(dev);
-			if (ret)
-				dev_pm_domain_detach(_dev, true);
-		} else {
-			/* don't fail if just dev_pm_domain_attach failed */
-			ret = 0;
-		}
+	if (ret)
+		goto out;
+
+	if (drv->probe) {
+		ret = drv->probe(dev);
+		if (ret)
+			dev_pm_domain_detach(_dev, true);
 	}
 
+out:
 	if (drv->prevent_deferred_probe && ret == -EPROBE_DEFER) {
 		dev_warn(_dev, "probe deferral not supported\n");
 		ret = -ENXIO;
-- 
2.7.4
