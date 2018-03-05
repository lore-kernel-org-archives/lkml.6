Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934541AbeCEMIU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 07:08:20 -0500
Received: from mout.web.de ([217.72.192.78]:59241 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932911AbeCEMIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 07:08:18 -0500
To: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] mmc/core/block: Use memdup_user() rather than duplicating its
 implementation
Message-ID: <4eca7388-cb2d-31e0-b64d-afb30818f53e@users.sourceforge.net>
Date: Mon, 5 Mar 2018 13:08:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:bfFw8Y5PHWdrOaMOGNVyI1H9ew94icNpI4MGpkuWEKyCXUWOnUB
 awKFFgK0CsY4zTVJq0YS0x4b/TabIuVD95vpIS0iuexhOVLjJHZ7vY94+aowMfWnYccJu+x
 /cVQo4uvWdNYPa7m7vUXoT+Nn/sGekvMWYdSKMw54NPbP1S9E2YfgZnIM9bLhde8SAc2xz0
 U93Am7AozraH2CiulTbvw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/lMMKBuLYLQ=:wFOGqMEGBSIZZtZYE3GMXX
 aqhdWqvmekqeT0NtuKpwI1Zb6FSAuB6OKebKmbTi1AkJGUbW81aiBIOqCkNMMgzz7u6gnFVPm
 C+y6SNhlsmZDvpHmwGS8fyolFQSR266gFLfjD1DavlTtW3+4Hnk6pK4glo8+/sLkTJlN2DDJl
 OBuaAgyIBzFYrgwYvOao6ukSfet0Aw0qnshU/6c3tS1pzefs6OWY2SIskPJgaJYtCz6eayUhL
 y/nVzYP4xXHLHtBlfK4/NuPBVuNXvG2vE+I1PFmR93sMZ1xCLXVJ4FhaIvTBaH+6gSmRJpqDP
 OmWkfSFX9+tRlG/lQBRciF+EEx8MwmXmuPBvMB8+gQaHr6F3UH5Z5PGng/n/203sBet5oy5XD
 6gNUM4bmLuDQ2HQzRw9oZ+gAtvnefm51JEE02xr8GU3HOlgNZok9jop/Rf9qREhz9aXXROVM9
 x2aDDRWd7+tRuHsAkAUi3dOMfPp9wX3EC+AqDOELGC6vYzRgPPDoxWaN/e8/UuzBs9SDMekql
 3oW0BevSILEH+HZCRiu6bMqpj3yugROHev6Uz+lM37ou00dnWvd7u/hh34MapueXE6/M+zWg7
 BTie5IkkSHOe3yIxpfSnPMvS6NLWYdpyaeKPF7aLoIoXILrt1wCX2z3p821F3xAzeQh7BjzBv
 75bPjyZUGJWQIRt8zVKythW7tyRvqsxjsKXoY+CSIUYG8VM/xGJUiYF53u/FxwxV3NLNxIKrp
 3wP+ooJ2zLWstW1h9xiRt9fgwicxBhd4i+W/VgdHZlt0ljU+OTVHGgmk79LwXMEtHckRBu2dp
 2eOLvKyopj5i6Ea/0ESGcwulnVROoSuPUCpJad9HasDqEDfsIk=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 5 Mar 2018 11:33:21 +0100

Reuse existing functionality from memdup_user() instead of keeping
duplicate source code.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/mmc/core/block.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 20135a5de748..4b09c7380e70 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -375,22 +375,15 @@ static struct mmc_blk_ioc_data *mmc_blk_ioctl_copy_from_user(
 		return idata;
 	}
 
-	idata->buf = kmalloc(idata->buf_bytes, GFP_KERNEL);
-	if (!idata->buf) {
-		err = -ENOMEM;
+	idata->buf = memdup_user((void __user *)(unsigned long)
+				 idata->ic.data_ptr, idata->buf_bytes);
+	if (IS_ERR(idata->buf)) {
+		err = PTR_ERR(idata->buf);
 		goto idata_err;
 	}
 
-	if (copy_from_user(idata->buf, (void __user *)(unsigned long)
-					idata->ic.data_ptr, idata->buf_bytes)) {
-		err = -EFAULT;
-		goto copy_err;
-	}
-
 	return idata;
 
-copy_err:
-	kfree(idata->buf);
 idata_err:
 	kfree(idata);
 out:
-- 
2.16.2
