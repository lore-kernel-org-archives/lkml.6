Return-Path: <ulf.hansson@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524732810; cv=none;
        d=google.com; s=arc-20160816;
        b=pZecdG80ycm3iMHcZkAQGCSofd1dO9BLPqIL01TB+igPkpZ2B3kXpFazB+AjwgFMBh
         prU6sUWvi6HY1bmhGdKIYr96jP7G4vLarXueDDKCDA9rdGooK2JcLhLmFLfY/x853Wby
         KrzAoyDBQb0uiAdurvTxScyRCYEbaRAdCP1+zOw844ZuU6HY+Y5q5gXg+enQqxwX2U8k
         0kMWJabSj6F/JEcg0i1kL8il6TuzQiygYa5+SCVvEkJOkqKvaNwwhUjasQqRQcdg9nfC
         uBKSzsZdD8jOUHwIm25UQ0aS+V5549xgsaMKoRk0lkaV+L6Tk5zvqDZxDTQPGXhEeEr6
         78dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=4qRjfjcsNTisdPc2jK1jipH7JeqOKH7dML3l+Hiob5c=;
        b=FK33/A0kHM/ypzKDr1Vyn9DZqhqkG/5WJeTaHSb75P9nOjrQ4Ka9KugvCJHAPviQYK
         Fea43GniAsAAJwYZjXmf32eusoCP5zVsuQphdcMjwhF/GpkGFoyxnK6ErbN6NQmEQWnO
         HpFy+MbZZjw76soCNWokmRRvxTJxW4njBh28kLtvzWIS82I4GT4Wvx/A0NOalzNsD5V5
         vvGm3cd5NerL/JNyjhf5HpET9qjrU/oNy0G0RY+93AIPbpb3/lXD6tt/L3DUXVCugibv
         bBVg7qbRkIB81HVLVZQZ9pZrEqHTgtrM6nO6v8exEZRrGHA5NVLEz5R48LzNgofj/uAK
         mL+A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Cr+cY3A4;
       spf=pass (google.com: domain of ulf.hansson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulf.hansson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Cr+cY3A4;
       spf=pass (google.com: domain of ulf.hansson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulf.hansson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZr0FO6Dc/su+Yv7xk87b2fh/iPmzRVQyBUX/0+XYx44xeHrK+u+tntfi29r1fL+O9Zg15yaOg==
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
Subject: [PATCH 11/11] spi: Respect all error codes from dev_pm_domain_attach()
Date: Thu, 26 Apr 2018 10:53:10 +0200
Message-Id: <1524732790-2234-12-git-send-email-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
References: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598798231336171631?=
X-GMAIL-MSGID: =?utf-8?q?1598798231336171631?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The limitation of being able to check only for -EPROBE_DEFER from
dev_pm_domain_attach() has been removed. Hence let's respect all error
codes and bail out accordingly.

Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/spi/spi.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 7b213fa..eeab67f 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -356,11 +356,12 @@ static int spi_drv_probe(struct device *dev)
 	}
 
 	ret = dev_pm_domain_attach(dev, true);
-	if (ret != -EPROBE_DEFER) {
-		ret = sdrv->probe(spi);
-		if (ret)
-			dev_pm_domain_detach(dev, true);
-	}
+	if (ret)
+		return ret;
+
+	ret = sdrv->probe(spi);
+	if (ret)
+		dev_pm_domain_detach(dev, true);
 
 	return ret;
 }
-- 
2.7.4
