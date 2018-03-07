Return-Path: <flo@geekplace.eu>
X-Google-Smtp-Source: AG47ELsRgDZ3PIF9dROiCjE8o05xq/flEiPdVVMNzA9IgiFkwrmSyM7U2dncM2BfUaKU6Ow4H7VQ
ARC-Seal: i=1; a=rsa-sha256; t=1520416144; cv=none;
        d=google.com; s=arc-20160816;
        b=srk/cSVbRBZTYWvPQG1KUfcXrlb3V4OJyf/Vv8epJq3x+FKcN1RdnWefy+yhFArRjT
         amruG4aUhsG+7JiQejiOA3kBl6GZGB+Aov/EJ1gqErHSsXuckSnjUKU83LsEypA5RWgM
         zFg6/J6ySm3TgX7LaRMKLRc2secCt+nmjHu8ZMz3yKaAEYL+sYnCovlL/jhYlignp2/J
         PZz/SAiVSjySeqXPT4zNzbnUePoDyl2GXUanqHxmskvN0prCH1AjOERHK4rCh1WrShfS
         s18SVgRBgGCf7F/7Y+AwFe/UZoSkOkyTrxuZHLILgpR359V9KzGHaiurVKxdQH/4mom/
         KnyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=B/NZt0USaFg8RrtqtAU2Xls6dlFS02MQlFvY+ji3yH4=;
        b=pJoYzljzu9Lfhxxl6km29JPS/DTPOt9toxZ50ymSAGeTqnIYVn4fVqoIbiAGPXcqmo
         9vpnJ/Y1zDO7kHTBMVwxvMiHwJI4wQDDf2RI6OmSNRxIGFg+ufxOXarJf6A3MuBb87rI
         VnByJkDCflHz41eh+/wNNwEkSRY5A2zddsPp6eFh8sLw9V38O23Sn2TvYCfSPACBuwui
         EsSaH4tlb7uQ5AG8frmxM+uWSb4Qo7ZBQuwhfLAe63zU3ZIcLu9qS97al2LA/ndUZabw
         ZoBY8F9MhDea+IyH9XE2eNaOdZxFzgViidimnUi8R/QoqH8CgREOQH4zNcbYKDJ+VO32
         lPhQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of flo@geekplace.eu designates 37.221.197.231 as permitted sender) smtp.mailfrom=flo@geekplace.eu
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of flo@geekplace.eu designates 37.221.197.231 as permitted sender) smtp.mailfrom=flo@geekplace.eu
From: Florian Schmaus <flo@geekplace.eu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Florian Schmaus <flo@geekplace.eu>
Subject: [PATCH] driver-core: Log the BUG() causing driver
Date: Wed,  7 Mar 2018 10:49:02 +0100
Message-Id: <20180307094902.20316-1-flo@geekplace.eu>
X-Mailer: git-send-email 2.13.6
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594271878826578823?=
X-GMAIL-MSGID: =?utf-8?q?1594271878826578823?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I triggerd the BUG_ON(), which was added in
f48f3febb2cbfd0f2ecee7690835ba745c1034a4, when booting a domU Xen
domain. Since there was no contextual information logged, I needed to
attach kgdb to determine the culprit (the wmi-bmof driver in my case).

Signed-off-by: Florian Schmaus <flo@geekplace.eu>
---
 drivers/base/driver.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/base/driver.c b/drivers/base/driver.c
index ba912558a510..55f8db41df2b 100644
--- a/drivers/base/driver.c
+++ b/drivers/base/driver.c
@@ -148,7 +148,11 @@ int driver_register(struct device_driver *drv)
 	int ret;
 	struct device_driver *other;
 
-	BUG_ON(!drv->bus->p);
+	if (!drv->bus->p) {
+		printk(KERN_ERR "Driver '%s' was unable to register bus_type\n",
+			   drv->name);
+		BUG();
+	}
 
 	if ((drv->bus->probe && drv->probe) ||
 	    (drv->bus->remove && drv->remove) ||
-- 
2.13.6
