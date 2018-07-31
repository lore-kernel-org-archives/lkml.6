Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E5BC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 920AF20844
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:45:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 920AF20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732496AbeGaR0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 13:26:06 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51765 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbeGaR0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 13:26:06 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fkWpg-0001gX-Bw; Tue, 31 Jul 2018 15:45:08 +0000
From:   Colin King <colin.king@canonical.com>
To:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        "David S . Miller" <davem@davemloft.net>,
        linux-wpan@vger.kernel.org, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: ieee802154: 6lowpan: remove redundant pointers 'fq' and 'net'
Date:   Tue, 31 Jul 2018 16:45:07 +0100
Message-Id: <20180731154507.5247-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointers fq and net are being assigned but are never used hence they
are redundant and can be removed.

Cleans up clang warnings:
warning: variable 'fq' set but not used [-Wunused-but-set-variable]
warning: variable 'net' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 net/ieee802154/6lowpan/reassembly.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lowpan/reassembly.c
index ec7a5da56129..e7857a8ac86d 100644
--- a/net/ieee802154/6lowpan/reassembly.c
+++ b/net/ieee802154/6lowpan/reassembly.c
@@ -40,9 +40,6 @@ static int lowpan_frag_reasm(struct lowpan_frag_queue *fq,
 static void lowpan_frag_init(struct inet_frag_queue *q, const void *a)
 {
 	const struct frag_lowpan_compare_key *key = a;
-	struct lowpan_frag_queue *fq;
-
-	fq = container_of(q, struct lowpan_frag_queue, q);
 
 	BUILD_BUG_ON(sizeof(*key) > sizeof(q->key));
 	memcpy(&q->key, key, sizeof(*key));
@@ -52,10 +49,8 @@ static void lowpan_frag_expire(struct timer_list *t)
 {
 	struct inet_frag_queue *frag = from_timer(frag, t, timer);
 	struct frag_queue *fq;
-	struct net *net;
 
 	fq = container_of(frag, struct frag_queue, q);
-	net = container_of(fq->q.net, struct net, ieee802154_lowpan.frags);
 
 	spin_lock(&fq->q.lock);
 
-- 
2.17.1

