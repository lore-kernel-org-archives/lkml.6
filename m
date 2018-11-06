Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC48C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACCE420869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:30:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACCE420869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730617AbeKFWzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 17:55:25 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53740 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730421AbeKFWzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 17:55:25 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sjoerd)
        with ESMTPSA id 68D8F27DDD7
Received: by beast.luon.net (Postfix, from userid 1000)
        id EA1283E238B; Tue,  6 Nov 2018 14:30:07 +0100 (CET)
From:   Sjoerd Simons <sjoerd.simons@collabora.co.uk>
To:     linux-mmc@vger.kernel.org
Cc:     kernel@collabora.com, linux-kernel@vger.kernel.org,
        Hongjie Fang <hongjiefang@asrmicro.com>,
        Bastian Stender <bst@pengutronix.de>,
        Kyle Roeschley <kyle.roeschley@ni.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Harish Jenny K N <harish_kandiga@mentor.com>,
        Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH] mmc: core: Remove timeout when enabling cache
Date:   Tue,  6 Nov 2018 14:30:07 +0100
Message-Id: <20181106133007.12318-1-sjoerd.simons@collabora.co.uk>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some of our boards containing Micron eMMC chips compatible with
the eMMC 5.0 specification we starting seeing boot failures due to
timeouts:
  mmc1: error -110 whilst initialising MMC card

It turns out that switching the cache on after a power loss event can
take quite long. In some simple testing thusfar we've seen values up to
700ms, which is far longer then the GENERIC_CMD6_TIME of the chip
(250ms).

Looking at both the eMMC 4.51 and 5.0 specification there doesn't seem
to be a defined upper bound for the CACHE_CTRL ON command. For both
CACHE_CTRL OFF and FLUSH_CACHE it is documented that they can take
essentially unbounded time, but CACHE_CTRL ON i get the impression that
it's assumed to be "fast". Unfortunately this is not true in reality.

To resolve this, simply drop the timeout from CACHE_CTRL ON and assume
it might take an unbounded time similar to the FLUSH_CACHE command.

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>

---

 drivers/mmc/core/mmc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index bc1bd2c25613..ac70b508a939 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1794,8 +1794,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	if (!mmc_card_broken_hpi(card) &&
 	    card->ext_csd.cache_size > 0) {
 		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-				EXT_CSD_CACHE_CTRL, 1,
-				card->ext_csd.generic_cmd6_time);
+				EXT_CSD_CACHE_CTRL, 1, 0);
 		if (err && err != -EBADMSG)
 			goto free_card;
 
-- 
2.19.1

