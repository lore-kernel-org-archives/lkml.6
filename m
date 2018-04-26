Return-Path: <ulf.hansson@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524732809; cv=none;
        d=google.com; s=arc-20160816;
        b=CefIRpA1X9nClgc3B9NgOOj0wkKbNUoGef0W59hHMbSuzOng2ocZStZ8lzOlwD+ymo
         /us2jq3Yr+0PrIxoz6aRmVZyrpX6zHn8ijREkKzKs0Bt6pQymz8Mr3XaO+sshXSSsbIs
         C7MrZEZTasdBRHHwdTUYOYTDIM6v5hlOSeV9fs4KZtlk4FG0KlsVpBH8BPC8/j1No9dY
         nQqdNvIBU36op3Xh29nZrcNe0NYU4Ywz8eE2tid0b3yj6097Fa4NhWh69hwI80Likm9z
         M2Q/QeT5rD+FV7TlBNIOe0cYpT189wYrWub5GBLplUi4cyTkc4CiAcrQ5YIHNwZ+WabY
         +qPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=rlrpHb/IeX5xP3SDTjra/zpY68YkXnTDM31XH0nhg+w=;
        b=JNCXwToErg3tY+UYSZcpvbggpywJQPw9bR/VYOYXBvQvJYHtn+vStKnRbK/Q9dZZkD
         KEbwCzfhhXUdGBDsJPr9mACihtjGxqYGaU1Mzt8xmZqe6rIkoy3qVpIWGBEAJVvvcuZH
         E5vf2xQ60CrXKbot+GIfonPcMqCcamphnx/qzj/Rx3aiDUEGFbwuuSiQU9r2UFLW/QhJ
         WTggRacfdpa3Wesx74hezhFqz0WWc6sJRq3HzPLsJ0noRz+hmpS3oeVbKb89kP/yJ8mf
         BpytRvZccw6NHH0hXi3NXcsK73XkRmZitUflUFVR7IDutIQFt3u9gUjLM4HLAJcTBPS9
         YxTg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=erboZ726;
       spf=pass (google.com: domain of ulf.hansson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulf.hansson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=erboZ726;
       spf=pass (google.com: domain of ulf.hansson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulf.hansson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZo4zVxcacJ9yKjlB/IJFq/AqR9WWf+d4AGgC5HSHcYgPfMP7Tn5imDu+bDc+/qfDi1F25griA==
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
Subject: [PATCH 10/11] soundwire: Respect all error codes from dev_pm_domain_attach()
Date: Thu, 26 Apr 2018 10:53:09 +0200
Message-Id: <1524732790-2234-11-git-send-email-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
References: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598798230564470166?=
X-GMAIL-MSGID: =?utf-8?q?1598798230564470166?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The limitation of being able to check only for -EPROBE_DEFER from
dev_pm_domain_attach() has been removed. Hence let's respect all error
codes and bail out accordingly.

Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Sanyog Kale <sanyog.r.kale@intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/soundwire/bus_type.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
index d5f3a70..283b283 100644
--- a/drivers/soundwire/bus_type.c
+++ b/drivers/soundwire/bus_type.c
@@ -83,17 +83,16 @@ static int sdw_drv_probe(struct device *dev)
 	 * attach to power domain but don't turn on (last arg)
 	 */
 	ret = dev_pm_domain_attach(dev, false);
-	if (ret != -EPROBE_DEFER) {
-		ret = drv->probe(slave, id);
-		if (ret) {
-			dev_err(dev, "Probe of %s failed: %d\n", drv->name, ret);
-			dev_pm_domain_detach(dev, false);
-		}
-	}
-
 	if (ret)
 		return ret;
 
+	ret = drv->probe(slave, id);
+	if (ret) {
+		dev_err(dev, "Probe of %s failed: %d\n", drv->name, ret);
+		dev_pm_domain_detach(dev, false);
+		return ret;
+	}
+
 	/* device is probed so let's read the properties now */
 	if (slave->ops && slave->ops->read_prop)
 		slave->ops->read_prop(slave);
-- 
2.7.4
