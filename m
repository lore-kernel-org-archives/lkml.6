Return-Path: <ulf.hansson@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524732808; cv=none;
        d=google.com; s=arc-20160816;
        b=tr4WLuYFxWCOlW1yvj9j8bsANnEItVSZWTHvwRe4m/VDbXopfM6z6B3XDc4iK+ULa+
         KZ+491ovFnJf9eNvCkY6TBNMQ6U/U/FgjKkYMK9K1pXn5fCRQhU268ALwTgoAN6QYdYd
         fo9bBD/stvykciYzRaYwlwjcRvdZfxO9W1VOOdn0LlC1sO2JFuNIxnToWBaC/U5pm4jD
         JRrwUe50Tw0UbT59zHoeT5vFGPbZDKmGz99CN3U0Fjo0fU0U5TXlhjzBBWumK69DSDJG
         NAmTsplfieOlFS2m+PSSvmhXgFRPLCdE/O1Eh0OofFL6TRZFvTOvtDhFilHu+9urXktG
         K4/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=1maFe3CUWeD8N7WGQ8g1FblEYpZX+jN7LBKPNpZNBvQ=;
        b=WsNSMd5Kk6kpjsoCZFAbmPci3LggDmqQrn9Y1TX/ZW2LN6MAj/d+ZT0Dx9qKQCbxWT
         YE+vjzh9TKo6tBK75pw0mruZaKYaa09aFOn9cyNJ0JoveXeThCDAVfSJhVipJfj4Lw5c
         us6pZS0ZoLu18j8b0nT/hRIALqOxnqiW0MkwJnbyREYWx6c9/geAV7pJdZYTUjkjenHd
         XNjEaLx1O9HDadcgFHaVByQ/oBzwT1pnSRSYhoYbdP3yhSOY4HT2C6P3aigzUb8sJPmM
         EP9kex1+r+wZK5dJ9vVpy79O6oZCwCRpH3H8J0UkbZuala+ij+QaInQ/mgvNGOAQvFuw
         IRAw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=BG4mqMK5;
       spf=pass (google.com: domain of ulf.hansson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulf.hansson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=BG4mqMK5;
       spf=pass (google.com: domain of ulf.hansson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulf.hansson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZoJG4RN8QM8LiaL9OTrpNuu/ioadGRH78XxkRMh74fyKk4+BBlx7cOyuCpc7EdO+OTdy9Jjug==
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
Subject: [PATCH 09/11] mmc: sdio: Respect all error codes from dev_pm_domain_attach()
Date: Thu, 26 Apr 2018 10:53:08 +0200
Message-Id: <1524732790-2234-10-git-send-email-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
References: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598798228736872946?=
X-GMAIL-MSGID: =?utf-8?q?1598798228736872946?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The limitation of being able to check only for -EPROBE_DEFER from
dev_pm_domain_attach() has been removed. Hence let's respect all error
codes and bail out accordingly.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/sdio_bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index 2b32b88..b6d8203 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -139,7 +139,7 @@ static int sdio_bus_probe(struct device *dev)
 		return -ENODEV;
 
 	ret = dev_pm_domain_attach(dev, false);
-	if (ret == -EPROBE_DEFER)
+	if (ret)
 		return ret;
 
 	/* Unbound SDIO functions are always suspended.
-- 
2.7.4
