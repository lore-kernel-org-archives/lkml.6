Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4119318-1520453199-2-1305616470831203510
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520453198; b=saK5rIjjBI58lUEYDfkaIzX3IcKBA5Y7apAgtKFXYP7YiWD
    8w71tw3IGkSt2tDndlhUbrFy4IvCrzJDWrvov3hMg59dbuLHb1kAt498B7uJZpzq
    7EZ8E8OzD9y6GSh94up91NG88uFytrMeChb4hOxHFXYZJRAZMhk5Dmvmzv17vqaj
    GRBJHS4jPfSZZS3wTmofDY9RwnSiOIS24kTHZNf3z3gzJlDm0/G9Qi4G7eWwpURx
    6js9NeBIjbHOIvXCwJk1wHPB4nOAy3QVaw5WyYx0LXV0KiO0mSmbBWtmuKE06A+H
    CHxk2VX0UrioEY2cfdzgfN/U4VEa7lswy3FtBKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520453198; bh=r7p+/zzfaycg6TCAzBvXZAaoma
    81Me0wi4H22wA8rPM=; b=XUV9bnCk/u8OjROhbItgzuI7KZUiWSK6OtKUN8qSWu
    LWfOBK82qQ8+PDaOcRgB95oHJZ6U3hnSSn7AVbCYzVntshDb3NYO3s7T8qSfOvav
    h1tFFCosMnGjlVPlwOPW2UY5TF87cSm9A7Se+Xl5ItsTREO0QpLXo1t/MrDSUC93
    OM5/cob3kv0GxSSS/y3Ni6GRFowp3bqRhK/TxNtrF5ccPLVExPdeB7bdudO3IBm6
    y9mgf0avHCsLTi5cjtrP1YuntQ/H43hSmxAdSTONea54HUBpLTLChO1EkelpY7d6
    q41mjRDTBIgbiBuBIyYxueM+Wl2bv6R1VEVSZs7bWF2Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934793AbeCGUGZ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 15:06:25 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44488 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965141AbeCGTqK (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 14:46:10 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.14 018/110] mmc: dw_mmc: Factor out dw_mci_init_slot_caps
Date: Wed,  7 Mar 2018 11:38:01 -0800
Message-Id: <20180307191042.048322596@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2762,12 +2762,50 @@ static irqreturn_t dw_mci_interrupt(int
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
@@ -2801,38 +2839,13 @@ static int dw_mci_init_slot(struct dw_mc
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
