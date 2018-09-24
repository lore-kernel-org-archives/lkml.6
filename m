Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476B6ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E5B320877
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:02:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E5B320877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730890AbeIXSEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:04:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53718 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730861AbeIXSEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:04:11 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 40EA4106D;
        Mon, 24 Sep 2018 12:02:24 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.9 051/111] mmc: omap_hsmmc: fix wakeirq handling on removal
Date:   Mon, 24 Sep 2018 13:52:18 +0200
Message-Id: <20180924113110.076833416@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.337261320@linuxfoundation.org>
References: <20180924113103.337261320@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andreas Kemnade <andreas@kemnade.info>

commit 3c398f3c3bef21961eaaeb93227fa66d440dc83d upstream.

after unbinding mmc I get things like this:
[  185.294067] mmc1: card 0001 removed
[  185.305206] omap_hsmmc 480b4000.mmc: wake IRQ with no resume: -13

The wakeirq stays in /proc-interrupts

rebinding shows this:
[  289.795959] genirq: Flags mismatch irq 112. 0000200a (480b4000.mmc:wakeup) vs. 0000200a (480b4000.mmc:wakeup)
[  289.808959] omap_hsmmc 480b4000.mmc: Unable to request wake IRQ
[  289.815338] omap_hsmmc 480b4000.mmc: no SDIO IRQ support, falling back to polling

That bug seems to be introduced by switching from devm_request_irq()
to generic wakeirq handling.

So let us cleanup at removal.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Fixes: 5b83b2234be6 ("mmc: omap_hsmmc: Change wake-up interrupt to use generic wakeirq")
Cc: stable@vger.kernel.org # v4.2+
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/omap_hsmmc.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2215,6 +2215,7 @@ static int omap_hsmmc_remove(struct plat
 	dma_release_channel(host->tx_chan);
 	dma_release_channel(host->rx_chan);
 
+	dev_pm_clear_wake_irq(host->dev);
 	pm_runtime_dont_use_autosuspend(host->dev);
 	pm_runtime_put_sync(host->dev);
 	pm_runtime_disable(host->dev);


