Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvwWxyZGq+rkwln1uOr+D+vi1Zh5v9aHdmsEnWhuNEinEXnId6rKH3ZukGJ/gsR1MFFjKU+
ARC-Seal: i=1; a=rsa-sha256; t=1520451616; cv=none;
        d=google.com; s=arc-20160816;
        b=vheTA84lDlvVV5b4+xnCUqKoGHCDjUVRK3a49RRMdoPleSsM2jjPGrRYyEHe2HUMkW
         Wk81fEokAM6WUHWiVQ14h+lqIyB9du+Ofn8GFYTKDn78LxL/REa4IBthnE5ipt0+aJmq
         b16zasP2EfSWBKo2m7XhLQfDAoUOHYkMUOGR1L0aNVDQAPP2jhx1PKhBMQ/c70CA7oK+
         mYZfTtMV05N1d3ma1UqlzVkwKRtlolplxD7mMw50d78gaodEQIJAweY3TKJXb61ONNQJ
         X6fvh2AIU5Ui9JVgw0Ea4JgiwPz7RK0eqVoHnA7dYTnFFg1YYg6/OcJvBSmQeCK4hUt8
         dIdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=2gThD77z4Jf3yRC4oTMNCnrmdvILpZl55rZCFqcgOAM=;
        b=O3bUV/6mIeU6JeDn9j/NbthHPoCwTfMeeVpk/2gVWqmniZxngku4XEBUJyazcQz+RN
         iYdjC/H63QV/yjXui383kiRGu6pn0xSgkJXjK+uIP8oaNCMUMYXbLcz55H4UK3s915H8
         1p5tdHNoynGgTBOI8GKd/y/885BWQabK9TSyzmI8eyQCVXKJRAbtuUMS4Wye/C2OLtd0
         P+XZI2swto8J2C+TchEQ00fSJSGZnfgO6pjLOIK8qA1CyWI0M24wwwe4wo4KZIBNKNh3
         rc0C7XvDJgQFy6nuB1d9h7VkWuT2Tj7U9Kz83sb/hkxIfsWwOQRGwTgUEyAZ27jsFnHI
         2/ug==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.15 021/122] mmc: dw_mmc: Factor out dw_mci_init_slot_caps
Date: Wed,  7 Mar 2018 11:37:13 -0800
Message-Id: <20180307191732.401979026@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309074889292291?=
X-GMAIL-MSGID: =?utf-8?q?1594309074889292291?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shawn Lin <shawn.lin@rock-chips.com>

commit a4faa4929ed3be15e2d500d2405f992f6dedc8eb upstream.

Factor out dw_mci_init_slot_caps to consolidate parsing
all differents types of capabilities from host contrllers.
No functional change intended.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Fixes: 800d78bfccb3 ("mmc: dw_mmc: add support for implementation specific callbacks")
Cc: <stable@vger.kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/dw_mmc.c |   73 +++++++++++++++++++++++++++-------------------
 1 file changed, 43 insertions(+), 30 deletions(-)

--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2782,12 +2782,50 @@ static irqreturn_t dw_mci_interrupt(int
 	return IRQ_HANDLED;
 }
 
+static int dw_mci_init_slot_caps(struct dw_mci_slot *slot)
+{
+	struct dw_mci *host = slot->host;
+	const struct dw_mci_drv_data *drv_data = host->drv_data;
+	struct mmc_host *mmc = slot->mmc;
+	int ctrl_id;
+
+	if (host->pdata->caps)
+		mmc->caps = host->pdata->caps;
+
+	/*
+	 * Support MMC_CAP_ERASE by default.
+	 * It needs to use trim/discard/erase commands.
+	 */
+	mmc->caps |= MMC_CAP_ERASE;
+
+	if (host->pdata->pm_caps)
+		mmc->pm_caps = host->pdata->pm_caps;
+
+	if (host->dev->of_node) {
+		ctrl_id = of_alias_get_id(host->dev->of_node, "mshc");
+		if (ctrl_id < 0)
+			ctrl_id = 0;
+	} else {
+		ctrl_id = to_platform_device(host->dev)->id;
+	}
+	if (drv_data && drv_data->caps)
+		mmc->caps |= drv_data->caps[ctrl_id];
+
+	if (host->pdata->caps2)
+		mmc->caps2 = host->pdata->caps2;
+
+	/* Process SDIO IRQs through the sdio_irq_work. */
+	if (mmc->caps & MMC_CAP_SDIO_IRQ)
+		mmc->caps2 |= MMC_CAP2_SDIO_IRQ_NOTHREAD;
+
+	return 0;
+}
+
 static int dw_mci_init_slot(struct dw_mci *host)
 {
 	struct mmc_host *mmc;
 	struct dw_mci_slot *slot;
-	const struct dw_mci_drv_data *drv_data = host->drv_data;
-	int ctrl_id, ret;
+	int ret;
 	u32 freq[2];
 
 	mmc = mmc_alloc_host(sizeof(struct dw_mci_slot), host->dev);
@@ -2821,38 +2859,13 @@ static int dw_mci_init_slot(struct dw_mc
 	if (!mmc->ocr_avail)
 		mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
 
-	if (host->pdata->caps)
-		mmc->caps = host->pdata->caps;
-
-	/*
-	 * Support MMC_CAP_ERASE by default.
-	 * It needs to use trim/discard/erase commands.
-	 */
-	mmc->caps |= MMC_CAP_ERASE;
-
-	if (host->pdata->pm_caps)
-		mmc->pm_caps = host->pdata->pm_caps;
-
-	if (host->dev->of_node) {
-		ctrl_id = of_alias_get_id(host->dev->of_node, "mshc");
-		if (ctrl_id < 0)
-			ctrl_id = 0;
-	} else {
-		ctrl_id = to_platform_device(host->dev)->id;
-	}
-	if (drv_data && drv_data->caps)
-		mmc->caps |= drv_data->caps[ctrl_id];
-
-	if (host->pdata->caps2)
-		mmc->caps2 = host->pdata->caps2;
-
 	ret = mmc_of_parse(mmc);
 	if (ret)
 		goto err_host_allocated;
 
-	/* Process SDIO IRQs through the sdio_irq_work. */
-	if (mmc->caps & MMC_CAP_SDIO_IRQ)
-		mmc->caps2 |= MMC_CAP2_SDIO_IRQ_NOTHREAD;
+	ret = dw_mci_init_slot_caps(slot);
+	if (ret)
+		goto err_host_allocated;
 
 	/* Useful defaults if platform data is unset. */
 	if (host->use_dma == TRANS_MODE_IDMAC) {
