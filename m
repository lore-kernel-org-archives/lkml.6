Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224BdxTPyP+Qa1zw8hHF0BitQyn+nepr9DUQiaMlWbOArrLCz6DzQsNcp1Gh79b40UEW2+1g
ARC-Seal: i=1; a=rsa-sha256; t=1519411168; cv=none;
        d=google.com; s=arc-20160816;
        b=J+DtQ4N7lwl1ZX7NjVWMME3c+x/8pUFJB75jGvdZATsLkFQA0FyXVOVGFmzhnanGgZ
         BvEUGEM7EPA4TdUqO1aECypnOW30BU7LTfn/xYzWRXP52wOiejxm9u7vFguVnL51kQyo
         lwAXRExRLYNV6vbnzHriAR6vVvV264VaPU+B6148qK+ickxv+0jDgqYijoMR1tUSJXJW
         NbJEesUVQOw6cEA4Mjs2Y7UcY374SBQdWpgMi4FV3Rpu2V6FTPAnhD0elNMle/Y12WhE
         zyUcuGZF3OYhCP7gV800r+OSya2qcjDISds6DbfQKmzEhclN74Ixq44REmjbMQfFMu7i
         Xg1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=gNWgNaMgj93FnEqvnI0LBCd/bROy5z0lxsR5qmQthp0=;
        b=V1K5rcKGoY6iGm99K2QxWv/lr1zQgz+lZNVlahk/KgMilrzB8JgUmKXLSxe5wG4n0z
         bAeBwz8Y6uql6k+xhENTU3w0+QKmExp2LnbzeWP0U9LGORcCfkfkg8KRRLeT2GzUZMpT
         Gm3CgeTM5AZohdmK2ej5r+Cm2TShxD/pZg97PNp0OKRgf7oAuWfJp3x/5OkZQthg6eGj
         40fobGK6EOv9iLg6wtztk6jrPrKVbZgk9MbzuIVldTx3UaTERzdgzH5FuZPLbzj6oKer
         pmwM3bA/LGR4yhTjBB4wqIaFat+WNSGHYMcDB5Qfx7p+SZbrxi51WDnVOAmMbmFZ0UV1
         CRfA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.4 143/193] wireless: cw1200: use __maybe_unused to hide pm functions_
Date: Fri, 23 Feb 2018 19:26:16 +0100
Message-Id: <20180223170348.255073308@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218085582008729?=
X-GMAIL-MSGID: =?utf-8?q?1593218085582008729?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 836856e3bd61d0644e5178a2c1b51d90459e2788 upstream.

The cw1200 uses #ifdef to check for CONFIG_PM, but then
uses SIMPLE_DEV_PM_OPS, which leaves the references out when
CONFIG_PM_SLEEP is not defined, so we get a warning with
PM=y && PM_SLEEP=n:

drivers/net/wireless/st/cw1200/cw1200_spi.c:450:12: error: 'cw1200_spi_suspend' defined but not used [-Werror=unused-function]

This removes the incorrect #ifdef and instead uses a __maybe_unused
annotation to let the compiler know it can silently drop
the function definition.

For the DEV_PM_OPS definition, we can use an IS_ENABLED() check
to avoid defining the structure when CONFIG_PM is not set without
the #ifdef.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/cw1200/cw1200_spi.c |    9 ++-------
 drivers/net/wireless/cw1200/pm.h         |    9 +++++++--
 2 files changed, 9 insertions(+), 9 deletions(-)

--- a/drivers/net/wireless/cw1200/cw1200_spi.c
+++ b/drivers/net/wireless/cw1200/cw1200_spi.c
@@ -446,8 +446,7 @@ static int cw1200_spi_disconnect(struct
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int cw1200_spi_suspend(struct device *dev)
+static int __maybe_unused cw1200_spi_suspend(struct device *dev)
 {
 	struct hwbus_priv *self = spi_get_drvdata(to_spi_device(dev));
 
@@ -460,16 +459,12 @@ static int cw1200_spi_suspend(struct dev
 
 static SIMPLE_DEV_PM_OPS(cw1200_pm_ops, cw1200_spi_suspend, NULL);
 
-#endif
-
 static struct spi_driver spi_driver = {
 	.probe		= cw1200_spi_probe,
 	.remove		= cw1200_spi_disconnect,
 	.driver = {
 		.name		= "cw1200_wlan_spi",
-#ifdef CONFIG_PM
-		.pm		= &cw1200_pm_ops,
-#endif
+		.pm		= IS_ENABLED(CONFIG_PM) ? &cw1200_pm_ops : NULL,
 	},
 };
 
--- a/drivers/net/wireless/cw1200/pm.h
+++ b/drivers/net/wireless/cw1200/pm.h
@@ -31,13 +31,18 @@ int cw1200_pm_init(struct cw1200_pm_stat
 void cw1200_pm_deinit(struct cw1200_pm_state *pm);
 int cw1200_wow_suspend(struct ieee80211_hw *hw,
 		       struct cfg80211_wowlan *wowlan);
-int cw1200_wow_resume(struct ieee80211_hw *hw);
 int cw1200_can_suspend(struct cw1200_common *priv);
+int cw1200_wow_resume(struct ieee80211_hw *hw);
 void cw1200_pm_stay_awake(struct cw1200_pm_state *pm,
 			  unsigned long tmo);
 #else
 static inline void cw1200_pm_stay_awake(struct cw1200_pm_state *pm,
-					unsigned long tmo) {
+					unsigned long tmo)
+{
+}
+static inline int cw1200_can_suspend(struct cw1200_common *priv)
+{
+	return 0;
 }
 #endif
 #endif
