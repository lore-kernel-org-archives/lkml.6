Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3798EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 06:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 984E62081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 06:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="aCL/JicF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 984E62081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbeK1Ryb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 12:54:31 -0500
Received: from m12-16.163.com ([220.181.12.16]:35409 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbeK1Ryb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 12:54:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=Pggwhj1fBXnFvLoo9X
        a6KiblLoMCJt+kMhaTX3GV/iI=; b=aCL/JicFDbMyWKCml8yJGDrY6grESNOKF/
        imwrrEBS2veKNDmrnO4/R1wSlmQ198WviiD0VDHSZ92Nz8YLFY+9GjvG8aXoqp3H
        wBAwVlbrOdsB1S1UC2B4cxTa2x/sLO6BXv4b4EnSTQUzfZSkn8LWPK7hSro6bQPw
        ztvvH6b+o=
Received: from bp.localdomain (unknown [106.120.213.96])
        by smtp12 (Coremail) with SMTP id EMCowAAHATVeO_5bmYpKAQ--.19291S3;
        Wed, 28 Nov 2018 14:53:28 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandre Bounine <alexandre.bounine@idt.com>,
        Pan Bian <bianpan2016@163.com>
Subject: [PATCH] rapidio/rionet: do not free skb before reading its length
Date:   Wed, 28 Nov 2018 14:53:19 +0800
Message-Id: <1543387999-115433-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: EMCowAAHATVeO_5bmYpKAQ--.19291S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7JrykJw4rJF15ZFW7AF1fWFg_yoW3Zwc_uF
        10ganrW345Grs09w15Jw4fXryFkrs8XFW8uw1Sqr9Iya47Gr97ZwsavrsxGr93ur4xWF9x
        GFyxtr1xAa4YqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0JCztUUUUU==
X-Originating-IP: [106.120.213.96]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/1tbiVBYNclUMGMCUKwAAsD
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

skb is freed via dev_kfree_skb_any, however, skb->len is read then. This
may result in a use-after-free bug.

Fixes: e6161d64263 ("rapidio/rionet: rework driver initialization and removal")
Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/net/rionet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/rionet.c b/drivers/net/rionet.c
index e9f101c..bfbb39f 100644
--- a/drivers/net/rionet.c
+++ b/drivers/net/rionet.c
@@ -216,9 +216,9 @@ static int rionet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 			 * it just report sending a packet to the target
 			 * (without actual packet transfer).
 			 */
-			dev_kfree_skb_any(skb);
 			ndev->stats.tx_packets++;
 			ndev->stats.tx_bytes += skb->len;
+			dev_kfree_skb_any(skb);
 		}
 	}
 
-- 
2.7.4


