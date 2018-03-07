Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4098462-1520451971-2-9828141656003119367
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520451970; b=SgMcMLrum5xu5Jbyg6nofm/6Sg32XXGlQVKBND2j86+ToXg
    //SPd9WEt8VXo0TSepeqCj8vmieb6rVJevOZnDroLxdLXIdGjCoZyejr99QFKZkp
    nWvSILAW3hMLGGT1rr1726aA/7PXSFQBaB8H73EPxfRboHt1bYv2EDkvhB3VBcro
    /0+poF9f7BhIGR3KlsmV3Uz8gC5MIj1VYF2s3BLtU1U7qaFJ4DUqEEml4qoaqmiH
    UZ0yd7WZ9KHSs2Q1BsVMkX4+pSegdMMBvz44iSSmlSxV5kKXP0Qj0OCkhCRnIqs3
    kUwg0+G8mX37/SEC7j3/Rx3XBgRtonCF2mkAVCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520451970; bh=+B69skLm/KUumc8eg/yWkxDtJB
    I1grQ8jAki8ny2bNI=; b=VxsCyWWtTJ3H48C4ULb8/gPLKqoNl34mb+0z69G/MV
    v4e2mQQd97gJO4jK6gQhqF0BJC7k5CddprRIwi5RMuvNx+AfQ4Rz90jJJ8QTZTKR
    8KNJR6hZTWDKPTB6cY3mR5JUr5esnS5offlDgSzK3ciYQX4U1ZUgjJapXWxUPgfE
    RuVD+3tSjmF70tC/5KVD3Pjvw2yiEfhmeY+2Xtnp9tZoKQvAngDtMCYz1H11r5b1
    +2v6MftdRVsRZ5d7GXbYoUIKVyiOXn608ylcs/RPpcurB9U+QPQ+63QhRPSjFzYC
    wnvpoE6Mgx9MB8Xo6dPKpWXgZuo+Fi+7xO0zHTMdlRXA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
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
        id S965454AbeCGTqF (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 14:46:05 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44442 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965391AbeCGTqD (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 14:46:03 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.14 015/110] mmc: sdhci-pci: Fix S0i3 for Intel BYT-based controllers
Date: Wed,  7 Mar 2018 11:37:58 -0800
Message-Id: <20180307191041.685553678@linuxfoundation.org>
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

From: Adrian Hunter <adrian.hunter@intel.com>

commit f8870ae6e2d6be75b1accc2db981169fdfbea7ab upstream.

Tuning can leave the IP in an active state (Buffer Read Enable bit set)
which prevents the entry to low power states (i.e. S0i3). Data reset will
clear it.

Generally tuning is followed by a data transfer which will anyway sort out
the state, so it is rare that S0i3 is actually prevented.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/sdhci-pci-core.c |   35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -594,9 +594,36 @@ static void byt_read_dsm(struct sdhci_pc
 	slot->chip->rpm_retune = intel_host->d3_retune;
 }
 
-static int byt_emmc_probe_slot(struct sdhci_pci_slot *slot)
+static int intel_execute_tuning(struct mmc_host *mmc, u32 opcode)
+{
+	int err = sdhci_execute_tuning(mmc, opcode);
+	struct sdhci_host *host = mmc_priv(mmc);
+
+	if (err)
+		return err;
+
+	/*
+	 * Tuning can leave the IP in an active state (Buffer Read Enable bit
+	 * set) which prevents the entry to low power states (i.e. S0i3). Data
+	 * reset will clear it.
+	 */
+	sdhci_reset(host, SDHCI_RESET_DATA);
+
+	return 0;
+}
+
+static void byt_probe_slot(struct sdhci_pci_slot *slot)
 {
+	struct mmc_host_ops *ops = &slot->host->mmc_host_ops;
+
 	byt_read_dsm(slot);
+
+	ops->execute_tuning = intel_execute_tuning;
+}
+
+static int byt_emmc_probe_slot(struct sdhci_pci_slot *slot)
+{
+	byt_probe_slot(slot);
 	slot->host->mmc->caps |= MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE |
 				 MMC_CAP_HW_RESET | MMC_CAP_1_8V_DDR |
 				 MMC_CAP_CMD_DURING_TFR |
@@ -651,7 +678,7 @@ static int ni_byt_sdio_probe_slot(struct
 {
 	int err;
 
-	byt_read_dsm(slot);
+	byt_probe_slot(slot);
 
 	err = ni_set_max_freq(slot);
 	if (err)
@@ -664,7 +691,7 @@ static int ni_byt_sdio_probe_slot(struct
 
 static int byt_sdio_probe_slot(struct sdhci_pci_slot *slot)
 {
-	byt_read_dsm(slot);
+	byt_probe_slot(slot);
 	slot->host->mmc->caps |= MMC_CAP_POWER_OFF_CARD | MMC_CAP_NONREMOVABLE |
 				 MMC_CAP_WAIT_WHILE_BUSY;
 	return 0;
@@ -672,7 +699,7 @@ static int byt_sdio_probe_slot(struct sd
 
 static int byt_sd_probe_slot(struct sdhci_pci_slot *slot)
 {
-	byt_read_dsm(slot);
+	byt_probe_slot(slot);
 	slot->host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY |
 				 MMC_CAP_AGGRESSIVE_PM | MMC_CAP_CD_WAKE;
 	slot->cd_idx = 0;
