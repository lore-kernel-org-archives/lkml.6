Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D0BECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 06:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3419520652
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 06:22:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3419520652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbeIRLxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 07:53:48 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35477 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbeIRLxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 07:53:48 -0400
Received: from 84-199-88-155.ifiber.telenet-ops.be ([84.199.88.155] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1g29PE-0005W4-0d; Tue, 18 Sep 2018 06:22:40 +0000
From:   Colin King <colin.king@canonical.com>
To:     Dmitry Tarnyagin <dmitry.tarnyagin@lockless.no>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][net-next] net: caif: remove redundant null check on frontpkt
Date:   Tue, 18 Sep 2018 08:22:37 +0200
Message-Id: <20180918062237.29581-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

It is impossible for frontpkt to be null at the point of the null
check because it has been assigned from rearpkt and there is no
way realpkt can be null at the point of the assignment because
of the sanity checking and exit paths taken previously. Remove
the redundant null check.

Detected by CoverityScan, CID#114434 ("Logically dead code")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 net/caif/cfrfml.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/caif/cfrfml.c b/net/caif/cfrfml.c
index b82440e1fcb4..a931a71ef6df 100644
--- a/net/caif/cfrfml.c
+++ b/net/caif/cfrfml.c
@@ -264,9 +264,6 @@ static int cfrfml_transmit(struct cflayer *layr, struct cfpkt *pkt)
 		frontpkt = rearpkt;
 		rearpkt = NULL;
 
-		err = -ENOMEM;
-		if (frontpkt == NULL)
-			goto out;
 		err = -EPROTO;
 		if (cfpkt_add_head(frontpkt, head, 6) < 0)
 			goto out;
-- 
2.17.1

