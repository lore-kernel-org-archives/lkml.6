Return-Path: <ulf.hansson@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524732800; cv=none;
        d=google.com; s=arc-20160816;
        b=DYZsQMLOmj36VtGSn+wa61AkSAZNmhjXdaT8I8tPXZ5lGvh1IPphN3BI7aWUG9XMLL
         oaTGB/x8Rj54Kc4F6M1ZA3QgKgFyfVhUuCcoRMcpUA94kGtg+GN0TkBpHmfdHGaooL7M
         O6Y2DJtYq8yof6ZzAWbln3QulqFsfRgpyRadqmk2Iwaow/gh6rn8WtV8AJfYFgW4pexh
         dNtfq92SehCrNo3VnAUw6IScSRQO+akANy9epEZbcRhi2EOWISZ0eo6NrEQo4l6b72vw
         h3/GEZYoO42O0X4HMJy1N5nSz4j4BMm+bmzmErur2MOy99h7fKB6umXbC/eNTVnea7Fh
         AlwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=592d1ZuHzXITHjPuFb/XpT9ecoVcy1aDhYaYmkB2pFg=;
        b=o6hdaPkcJepdrBmcQ+UBiHgYuij62syFSitPjKXLuU9ubDAgEkiQagrMDFVUUxy2Bg
         Yt0+9duK3Ltuo8iKuYiF/+IHIwiHAkx69j/Gl9KLcw9830jCgjNUJgvYK9iN31BqoSle
         KCkf91CMfkmxf6CgparKd+OWuTKBN5ebGYmrl4ojiZ1gkxuIXLIF2HEVUssnBFEUWErk
         Wu+TLQ3xFCoX3Dj8G/6nBxFiit4HBokGkxMDULJU0gXDmGAaA85kJTv0RJpee3RDNGHP
         TMvvAr4bNRzINCcwLNNtTmFJ6WcyHtHDUHdTtlxv06fQtME3R8edHc5Yb4fj0j7xlZTG
         9qfg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=bgxQbXgk;
       spf=pass (google.com: domain of ulf.hansson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulf.hansson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=bgxQbXgk;
       spf=pass (google.com: domain of ulf.hansson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulf.hansson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZpmEFysc1YWVrAwbCtS0RNgYGZBA9lukz8bbM5jIWBv95xCe8brHRdkbkBv4p+Eg3Rwv0BB6Q==
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
Subject: [PATCH 03/11] PM / Domains: Drop redundant code in genpd while attaching devices
Date: Thu, 26 Apr 2018 10:53:02 +0200
Message-Id: <1524732790-2234-4-git-send-email-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
References: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598798220709307856?=
X-GMAIL-MSGID: =?utf-8?q?1598798220709307856?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The driver core together with the PM core, nowadays deals with deferring
all probes during the device system sleep phases. Therefore genpd no longer
need to care about this situation, so let's drop the corresponding code.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index d3703a1..d4b96ed 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1377,7 +1377,7 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 			    struct gpd_timing_data *td)
 {
 	struct generic_pm_domain_data *gpd_data;
-	int ret = 0;
+	int ret;
 
 	dev_dbg(dev, "%s()\n", __func__);
 
@@ -1390,11 +1390,6 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 
 	genpd_lock(genpd);
 
-	if (genpd->prepared_count > 0) {
-		ret = -EAGAIN;
-		goto out;
-	}
-
 	ret = genpd->attach_dev ? genpd->attach_dev(genpd, dev) : 0;
 	if (ret)
 		goto out;
@@ -2194,7 +2189,6 @@ int genpd_dev_pm_attach(struct device *dev)
 {
 	struct of_phandle_args pd_args;
 	struct generic_pm_domain *pd;
-	unsigned int i;
 	int ret;
 
 	if (!dev->of_node)
@@ -2220,14 +2214,7 @@ int genpd_dev_pm_attach(struct device *dev)
 
 	dev_dbg(dev, "adding to PM domain %s\n", pd->name);
 
-	for (i = 1; i < GENPD_RETRY_MAX_MS; i <<= 1) {
-		ret = genpd_add_device(pd, dev, NULL);
-		if (ret != -EAGAIN)
-			break;
-
-		mdelay(i);
-		cond_resched();
-	}
+	ret = genpd_add_device(pd, dev, NULL);
 	mutex_unlock(&gpd_list_lock);
 
 	if (ret < 0) {
-- 
2.7.4
