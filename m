Return-Path: <ulf.hansson@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524732804; cv=none;
        d=google.com; s=arc-20160816;
        b=nG0YOb6VJO9PcjZTEaEMHsQa7PjE+kjeG1D1ztPC1EUpxwb1scnMvNuSVzkBnCG/7+
         XAN2Ho6bZIx8MHl4kjFSnT5njKT46e8joblrMvTrIy909ovXySglTGYmahVFLaotjmnD
         hTgzcuVVDMuDXTL49Iu4DgM5GJ2Wb9xDvYHvN5AKYvF97Rbthv2K4i1fhe1O2AuorNBI
         E5wTqYzZOzPXAwnMxt+ZbUa596jhJmiOS0KmIhnkqkDK1p/UlxGYlR02mP2MwO/SiDzl
         2SmcrVvYtS1B1C1TbmMfzQBAjpq0cLxmIbF37O08RoCscfLnRsqNAH60E5LB1SUy+NId
         NW5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=soNOtJTU3RLapthGVgaxgE2rq+eWjefBnIsGZ8fdPIU=;
        b=DnJigYWbI9saHR+Sfkb3TxGmR012VNL7Uko7u7WeQKqsg9YYQMDZRkF26771bdW7U7
         ySTii1F2OMX5Lybw53dpcIMYIgYJ2tTV3f635Ld7RW/LzqI76zCFnaYOoWNIdHoMThKT
         y5kGzRRAlxADhd8EYrnw6guTwn/erZVF7NsJxshxxW7FK0u/mftU5SMTegEO9ijLFOMI
         FBpVWtAQbHSDN436Vhgeu8lUynJFh3ex4GFMjQDF2nRUFzFOc3d06OzG4YxoE2PpB0hz
         iTqZcCTNf3QBg/kLVYaBc/vtMTCEzC+q013CDPedV+3QtWXT0pVH8PonPrODgpYeUqBw
         rFqQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=XNyT9mzJ;
       spf=pass (google.com: domain of ulf.hansson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulf.hansson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=XNyT9mzJ;
       spf=pass (google.com: domain of ulf.hansson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulf.hansson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZpUUskqWy8u6tjl2FAxw4EfS+g2nkLhpili7g5TEQVTRxrLN9JQ6GyyueALctaQCs06aqn/+Q==
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
Subject: [PATCH 06/11] amba: Respect all error codes from dev_pm_domain_attach()
Date: Thu, 26 Apr 2018 10:53:05 +0200
Message-Id: <1524732790-2234-7-git-send-email-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
References: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598798224987064703?=
X-GMAIL-MSGID: =?utf-8?q?1598798224987064703?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The limitation of being able to check only for -EPROBE_DEFER from
dev_pm_domain_attach() has been removed. Hence let's respect all error
codes and bail out accordingly.

Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/amba/bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 594c228..79fcbff 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -243,7 +243,7 @@ static int amba_probe(struct device *dev)
 			break;
 
 		ret = dev_pm_domain_attach(dev, true);
-		if (ret == -EPROBE_DEFER)
+		if (ret)
 			break;
 
 		ret = amba_get_enable_pclk(pcdev);
@@ -370,7 +370,7 @@ static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
 	}
 
 	ret = dev_pm_domain_attach(&dev->dev, true);
-	if (ret == -EPROBE_DEFER) {
+	if (ret) {
 		iounmap(tmp);
 		goto err_release;
 	}
-- 
2.7.4
