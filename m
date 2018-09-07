Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96DDC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E3F82075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VVyZjWlg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E3F82075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbeIGVDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 17:03:18 -0400
Received: from m12-11.163.com ([220.181.12.11]:36621 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726655AbeIGVDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 17:03:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=B72PEnuV855N8cV59A
        1XctToscYSGNTF+WhMvsFSYrs=; b=VVyZjWlg7s462HUGYyPMRwfGqh6KXsnNV3
        vDTMnRZbgkcsDmAg3XBa+AdPp/YRsWfXQHdvru83h9VHhCOTfb9rUQG2TtFrj1rf
        59lwUVh1VCAMECEB6bzt9DLCPonG5PxNKakYMrQK1NmUglZ8A4XsrRtCGjmhQDgs
        NnkKVAIeA=
Received: from localhost (unknown [183.156.140.9])
        by smtp7 (Coremail) with SMTP id C8CowADH5Q6DpZJbve+9Pw--.886S5;
        Sat, 08 Sep 2018 00:21:25 +0800 (CST)
From:   jun qian <hangdianqj@163.com>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Quentin Monnet <quentin.monnet@netronome.com>
Cc:     oss-drivers@netronome.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jun qian <hangdianqj@163.com>
Subject: [PATCH] ethernet:netronome:nfp:move spin_lock_bh to spin_lock in tasklet
Date:   Fri,  7 Sep 2018 09:21:17 -0700
Message-Id: <20180907162117.47361-1-hangdianqj@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: C8CowADH5Q6DpZJbve+9Pw--.886S5
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xr43KryDtF1UWw15XFykAFb_yoWfurbE9w
        1jgFyfGayDJF1Fkw12gr4aq34Ykw1DXr1fuF97KaySv3yDJFyrCw1kWF98JrnruF47Casr
        Xr12vFy2y342vjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUtEf7UUUUU==
X-Originating-IP: [183.156.140.9]
X-CM-SenderInfo: pkdqwvpldq1yi6rwjhhfrp/xtbBSQW6R1aDzFVnEQAAsL
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As you are already in a tasklet, it is unnecessary to call spin_lock_bh.

Signed-off-by: jun qian <hangdianqj@163.com>
---
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
index a8b9fbab5f73..084c983ec3c2 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
@@ -2075,10 +2075,10 @@ static void nfp_ctrl_poll(unsigned long arg)
 {
 	struct nfp_net_r_vector *r_vec = (void *)arg;
 
-	spin_lock_bh(&r_vec->lock);
+	spin_lock(&r_vec->lock);
 	nfp_net_tx_complete(r_vec->tx_ring, 0);
 	__nfp_ctrl_tx_queued(r_vec);
-	spin_unlock_bh(&r_vec->lock);
+	spin_unlock(&r_vec->lock);
 
 	nfp_ctrl_rx(r_vec);
 
-- 
2.17.1



