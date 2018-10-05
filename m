Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C61C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 09:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C509720652
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 09:55:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C509720652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbeJEQxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 12:53:03 -0400
Received: from gateway22.websitewelcome.com ([192.185.47.163]:40169 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727610AbeJEQxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 12:53:03 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id D43255514
        for <linux-kernel@vger.kernel.org>; Fri,  5 Oct 2018 04:55:01 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 8Mp3gecNVPvAd8Mp3gUvaU; Fri, 05 Oct 2018 04:55:01 -0500
X-Authority-Reason: nr=8
Received: from 174.206.93.92.rev.sfr.net ([92.93.206.174]:35734 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1g8Mp2-003umf-8o; Fri, 05 Oct 2018 04:55:01 -0500
Date:   Fri, 5 Oct 2018 11:54:57 +0200
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Alex Dubov <oakad@yahoo.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] mmc: tifm_sd: Mark expected switch fall-through
Message-ID: <20181005095457.GA21116@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 92.93.206.174
X-Source-L: No
X-Exim-ID: 1g8Mp2-003umf-8o
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 174.206.93.92.rev.sfr.net (embeddedor) [92.93.206.174]:35734
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Notice that in this particular case, I replaced the
"deliberate fall-through" comment with a proper "fall through"
at the bottom of the case, which is what GCC is expecting to find.

Addresses-Coverity-ID: 1373887 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/mmc/host/tifm_sd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/tifm_sd.c b/drivers/mmc/host/tifm_sd.c
index a3d8380..b6644ce 100644
--- a/drivers/mmc/host/tifm_sd.c
+++ b/drivers/mmc/host/tifm_sd.c
@@ -336,7 +336,8 @@ static unsigned int tifm_sd_op_flags(struct mmc_command *cmd)
 		rc |= TIFM_MMCSD_RSP_R0;
 		break;
 	case MMC_RSP_R1B:
-		rc |= TIFM_MMCSD_RSP_BUSY; // deliberate fall-through
+		rc |= TIFM_MMCSD_RSP_BUSY;
+		/* fall-through */
 	case MMC_RSP_R1:
 		rc |= TIFM_MMCSD_RSP_R1;
 		break;
-- 
2.7.4

