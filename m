Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F033C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 11:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F09522148E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 11:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545998014;
	bh=/+brTRHRjqDBbBu/uLsP1nmJjpnyTfltWBQORYRx0JE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tHom0E0KSROXxEX3clYtfGGf3AtMdjWVDerGKAfMY5Lt7Jk/oNMI6dhV4GAg7XFqa
	 FmgtYtDiqwy2SsClJciuF077JvqgdXbK9cswNeMsmAH2tj+qr546hVK0pdJZSBb0Eh
	 PTz8MRbCOILxI40Z5V6xdZOl6mpnicq4z1xSgx8w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732297AbeL1Lxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 06:53:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:53254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732247AbeL1Lx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 06:53:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEBD920879;
        Fri, 28 Dec 2018 11:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545998005;
        bh=/+brTRHRjqDBbBu/uLsP1nmJjpnyTfltWBQORYRx0JE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C9PeHV4XAfU2VvY8h4dZZuqkBZTgusXQrJZUbaXBuHEtVQ8s8JiOOSBQaa1x1PXxN
         GUufsHqtZsyKLaBG0XVr+zkG0n3Ll2BE6nHpMD3DxYujB3Y5o5KRCBk/TyINjh8wUr
         oQKcNsSOEdPVTODimmTv2tRY1AirGkHdfMZPVX5k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sjoerd Simons <sjoerd.simons@collabora.co.uk>,
        Andreas Dannenberg <dannenberg@ti.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.19 16/46] mmc: core: Use a minimum 1600ms timeout when enabling CACHE ctrl
Date:   Fri, 28 Dec 2018 12:52:10 +0100
Message-Id: <20181228113125.722066548@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181228113124.971620049@linuxfoundation.org>
References: <20181228113124.971620049@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ulf Hansson <ulf.hansson@linaro.org>

commit e3ae3401aa19432ee4943eb0bbc2ec704d07d793 upstream.

Some eMMCs from Micron have been reported to need ~800 ms timeout, while
enabling the CACHE ctrl after running sudden power failure tests. The
needed timeout is greater than what the card specifies as its generic CMD6
timeout, through the EXT_CSD register, hence the problem.

Normally we would introduce a card quirk to extend the timeout for these
specific Micron cards. However, due to the rather complicated debug process
needed to find out the error, let's simply use a minimum timeout of 1600ms,
the double of what has been reported, for all cards when enabling CACHE
ctrl.

Reported-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Reported-by: Andreas Dannenberg <dannenberg@ti.com>
Reported-by: Faiz Abbas <faiz_abbas@ti.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/core/mmc.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -30,6 +30,7 @@
 #include "pwrseq.h"
 
 #define DEFAULT_CMD6_TIMEOUT_MS	500
+#define MIN_CACHE_EN_TIMEOUT_MS 1600
 
 static const unsigned int tran_exp[] = {
 	10000,		100000,		1000000,	10000000,
@@ -1789,13 +1790,18 @@ static int mmc_init_card(struct mmc_host
 	}
 
 	/*
-	 * If cache size is higher than 0, this indicates
-	 * the existence of cache and it can be turned on.
+	 * If cache size is higher than 0, this indicates the existence of cache
+	 * and it can be turned on. Note that some eMMCs from Micron has been
+	 * reported to need ~800 ms timeout, while enabling the cache after
+	 * sudden power failure tests. Let's extend the timeout to a minimum of
+	 * DEFAULT_CACHE_EN_TIMEOUT_MS and do it for all cards.
 	 */
 	if (card->ext_csd.cache_size > 0) {
+		unsigned int timeout_ms = MIN_CACHE_EN_TIMEOUT_MS;
+
+		timeout_ms = max(card->ext_csd.generic_cmd6_time, timeout_ms);
 		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-				EXT_CSD_CACHE_CTRL, 1,
-				card->ext_csd.generic_cmd6_time);
+				EXT_CSD_CACHE_CTRL, 1, timeout_ms);
 		if (err && err != -EBADMSG)
 			goto free_card;
 


