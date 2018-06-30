Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE0BC3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 20:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D63D825497
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 20:39:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D63D825497
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751877AbeF3Uja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 16:39:30 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35154 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751466AbeF3Uj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 16:39:28 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fZMeT-000512-KF; Sat, 30 Jun 2018 20:39:25 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] netdevsim: fix sa_idx out of bounds check
Date:   Sat, 30 Jun 2018 21:39:24 +0100
Message-Id: <20180630203924.5121-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently if sa_idx is equal to NSIM_IPSEC_MAX_SA_COUNT then
an out-of-bounds read on ipsec->sa will occur. Fix the
incorrect bounds check by using >= rather than >.

Detected by CoverityScan, CID#1470226 ("Out-of-bounds-read")

Fixes: 7699353da875 ("netdevsim: add ipsec offload testing")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/netdevsim/ipsec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/netdevsim/ipsec.c b/drivers/net/netdevsim/ipsec.c
index ceff544510b9..2dcf6cc269d0 100644
--- a/drivers/net/netdevsim/ipsec.c
+++ b/drivers/net/netdevsim/ipsec.c
@@ -249,7 +249,7 @@ bool nsim_ipsec_tx(struct netdevsim *ns, struct sk_buff *skb)
 	}
 
 	sa_idx = xs->xso.offload_handle & ~NSIM_IPSEC_VALID;
-	if (unlikely(sa_idx > NSIM_IPSEC_MAX_SA_COUNT)) {
+	if (unlikely(sa_idx >= NSIM_IPSEC_MAX_SA_COUNT)) {
 		netdev_err(ns->netdev, "bad sa_idx=%d max=%d\n",
 			   sa_idx, NSIM_IPSEC_MAX_SA_COUNT);
 		return false;
-- 
2.17.1

