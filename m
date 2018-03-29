Return-Path: <moritz.fischer@ettus.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522338177; cv=none;
        d=google.com; s=arc-20160816;
        b=RlkbCgcrzPdr/q+BipwwX5qYxzpu3gL4c+XIflIephgDCHeegeAZeE6G2eMr1yt9ft
         UlkxQ9DHA29+xS+kiprXSBFWZUsp5HkQwJbEEpQUe2RyffChCInjDsINmlOb+37De5H9
         Oa9bO2ZjTOPI69qBiPnEgqYcaUhrNwMZ1rPttyIkqAN50KyOtrrcH4+4GUDt6an5XzZF
         nMrW6cThtppx2cTLc0KRjlKII4m+9GEcgDuWgOHj1sQ1OryxYt0bBJ/SND3avdfzjYjm
         rmNGXVafUJod549X1i2g+//NDujne/U7yNpzqvcTdp1B4m8rFtDIalHJnVCnB6znR9qd
         W1sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=s+GCWH9CEUM3Iss03E8MPXZzcEz/46i41NLRVCS+HlU=;
        b=MLlZhLjG0cZmK5zkjEbncySejzx0EtGdppSSZ0qNYG3d85hzRTMSR/CclRjtQ9ZWCR
         bYjYaLrMe1qQkVaKh4/EcabMHQ4yP48/qLyJAocWbZdCnPS3X5tow9VTRdYNlxz8Ccz5
         GPHhhb1LH0XwJRJRnFryDvrfr+834bD/MNRnha4/bBZTGnTVSxwAErxd5HS1c7Bxc3pM
         2xl7BeUYbAhIC5BX/UkQhlJ3qafp0k8QDDOnvzPEQTa3fq0w0nwN66wHbmzENeJlwWB1
         bbRjqi6R8wVwx7WPXqLAFrWW1zCPEyqfdPJJnVAigXB0x6DqR7LQfFhZjyjH7OHIXkuW
         mlbw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of moritz.fischer@ettus.com) smtp.mailfrom=moritz.fischer@ettus.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of moritz.fischer@ettus.com) smtp.mailfrom=moritz.fischer@ettus.com
X-Google-Smtp-Source: AIpwx49GvhiccuYJQxSvsqhEFcW57igajE8EswBHfbsOPeeMWcerHrxRawps06iWj3QusiDAhKU3Bw==
From: Moritz Fischer <mdf@kernel.org>
To: gregkh@linuxfoundation.org
Cc: atull@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 1/6] fpga: region: don't use drvdata in common fpga code
Date: Thu, 29 Mar 2018 08:36:53 -0700
Message-Id: <20180329153658.11614-2-mdf@kernel.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180329153658.11614-1-mdf@kernel.org>
References: <20180329153658.11614-1-mdf@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596287276477563606?=
X-GMAIL-MSGID: =?utf-8?q?1596287276477563606?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alan Tull <atull@kernel.org>

Part of patchset that changes the following fpga_*_register
functions to not set drvdata:
* fpga_region_register.
* fpga_mgr_register
* fpga_bridge_register

The rationale is that setting drvdata is fine for DT based devices
that will have one manager, bridge, or region per platform device.
However PCIe based devices may have multiple FPGA mgr/bridge/regions
under one PCIe device.  Without these changes, the PCIe solution has
to create an extra device for each child mgr/bridge/region to hold
drvdata.

Signed-off-by: Alan Tull <atull@kernel.org>
Reported-by: Jiuyue Ma <majiuyue@huawei.com>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/fpga/fpga-region.c    | 1 -
 drivers/fpga/of-fpga-region.c | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index edab2a2e03ef..ebe1f872810d 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -178,7 +178,6 @@ int fpga_region_register(struct device *dev, struct fpga_region *region)
 	region->dev.parent = dev;
 	region->dev.of_node = dev->of_node;
 	region->dev.id = id;
-	dev_set_drvdata(dev, region);
 
 	ret = dev_set_name(&region->dev, "region%d", id);
 	if (ret)
diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
index 119ff75522f1..35e7e8c4a0cb 100644
--- a/drivers/fpga/of-fpga-region.c
+++ b/drivers/fpga/of-fpga-region.c
@@ -438,6 +438,7 @@ static int of_fpga_region_probe(struct platform_device *pdev)
 		goto eprobe_mgr_put;
 
 	of_platform_populate(np, fpga_region_of_match, NULL, &region->dev);
+	dev_set_drvdata(dev, region);
 
 	dev_info(dev, "FPGA Region probed\n");
 
-- 
2.16.2
