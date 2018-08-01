Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53A2C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4D42208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:59:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4D42208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732643AbeHATpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:45:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49886 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405912AbeHATIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:08:39 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 00CB1114F;
        Wed,  1 Aug 2018 17:05:35 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 231/336] mmc: sdhci-omap: Fix when capabilities are obtained from SDHCI_CAPABILITIES reg
Date:   Wed,  1 Aug 2018 18:49:26 +0200
Message-Id: <20180801165037.906437707@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kishon Vijay Abraham I <kishon@ti.com>

[ Upstream commit 0ec4ee3c9b9755b28fd2e89b2ceaae6f15403368 ]

sdhci_omap_config_iodelay_pinctrl_state() requires caps and caps2 to be
initialized (speed mode capabilities like UHS/HS200) before it is
invoked. While mmc_of_parse() initializes caps/caps2 if capabilities is
populated in device tree, it will remain uninitialized for capabilities
obtained from SDHCI_CAPABILITIES register.
Fix sdhci_omap_config_iodelay_pinctrl_state() to be used even while
getting the capabilities from SDHCI_CAPABILITIES register by invoking
sdhci_setup_host() before sdhci_omap_config_iodelay_pinctrl_state().

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/sdhci-omap.c |   17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -916,10 +916,6 @@ static int sdhci_omap_probe(struct platf
 		goto err_put_sync;
 	}
 
-	ret = sdhci_omap_config_iodelay_pinctrl_state(omap_host);
-	if (ret)
-		goto err_put_sync;
-
 	host->mmc_host_ops.get_ro = mmc_gpio_get_ro;
 	host->mmc_host_ops.start_signal_voltage_switch =
 					sdhci_omap_start_signal_voltage_switch;
@@ -930,12 +926,23 @@ static int sdhci_omap_probe(struct platf
 	sdhci_read_caps(host);
 	host->caps |= SDHCI_CAN_DO_ADMA2;
 
-	ret = sdhci_add_host(host);
+	ret = sdhci_setup_host(host);
 	if (ret)
 		goto err_put_sync;
 
+	ret = sdhci_omap_config_iodelay_pinctrl_state(omap_host);
+	if (ret)
+		goto err_cleanup_host;
+
+	ret = __sdhci_add_host(host);
+	if (ret)
+		goto err_cleanup_host;
+
 	return 0;
 
+err_cleanup_host:
+	sdhci_cleanup_host(host);
+
 err_put_sync:
 	pm_runtime_put_sync(dev);
 


