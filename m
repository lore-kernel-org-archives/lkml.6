Return-Path: <ulf.hansson@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524732806; cv=none;
        d=google.com; s=arc-20160816;
        b=C+jf7M1SZJ8mCim9hpfcSCMCuPcdPPon4+c9F1OaJuHp3HlyLxGNF9zjSQe9XE7njT
         KRD+9zRevNGWBiaYpDIt1VRfOjsXAFsEHBhwbRIKa4y75i2EZBR+EhuoTcI6qfN4bjEO
         AiNNouosxzS9hQlBz+fNwiggUNUDGOWDA7UCDTvYUR7UOmEv3SaDYFRBF1/8c5S5yOK5
         RPLTcicaVTQzY8aQ8+vstkDLKfbhRXPrc/1ivWyEeWFcvkzOjyG5kGsVQtIh7nJsWozO
         GJtcBb6+18Y9WDWd5auire82FqOUVJXPRVenX3eky0bbIViik/x37pXIPug4N8JNFpDI
         cm9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=hU5FXEWc+uiOnBCNzHi77rqnIeKqwSZvkLGgu3DHGbc=;
        b=i8irMgt1/e68pR9TUovK/LqwJWEyqxqFy+pufuvvwSkflOqrP5nvyxAXHnytSNgmU2
         cprXZgIXORHTV15o+/uhbbI5683IIFjVCJGhuqi2zMHcyEX2HTfeJ2aBXIufUbRrYkQu
         YVsFHI84y6GqMpPu1DMSFRHoqO0eSI+gg9DO2sNLHhKENPE9SeslpCeBDZ+z2sBBx+fl
         IdjghxCdQ9coPC+/bjw1TfwQbB6s/NlgUdD0MiVx3SEMbKdM0Lsk4EXGgVP+SCz64u9X
         U66hhcKLwsRDTfuNFzXz4BsxpdDw2M79OSWZ2tGHVaXn9YM/OQY/rCvEnIaVWiTog21e
         PFEA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=QhaqIzG9;
       spf=pass (google.com: domain of ulf.hansson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulf.hansson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=QhaqIzG9;
       spf=pass (google.com: domain of ulf.hansson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulf.hansson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZoJgNcglg0Z2vo/HvKrEcTo/CLva2VpGhVnoHZ6oCSVLLaX0T1EUL3fdeUHLPnCdbV531886w==
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
Subject: [PATCH 08/11] i2c: Respect all error codes from dev_pm_domain_attach()
Date: Thu, 26 Apr 2018 10:53:07 +0200
Message-Id: <1524732790-2234-9-git-send-email-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
References: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598798227731676848?=
X-GMAIL-MSGID: =?utf-8?q?1598798227731676848?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The limitation of being able to check only for -EPROBE_DEFER from
dev_pm_domain_attach() has been removed. Hence let's respect all error
codes and bail out accordingly.

Cc: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/i2c/i2c-core-base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 1ba40bb..a17f46a 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -363,7 +363,7 @@ static int i2c_device_probe(struct device *dev)
 		goto err_clear_wakeup_irq;
 
 	status = dev_pm_domain_attach(&client->dev, true);
-	if (status == -EPROBE_DEFER)
+	if (status)
 		goto err_clear_wakeup_irq;
 
 	/*
-- 
2.7.4
