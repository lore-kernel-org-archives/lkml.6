Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452B5C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BAD32073F
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Y75nl5yQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BAD32073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbeK2K56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 05:57:58 -0500
Received: from m12-17.163.com ([220.181.12.17]:60065 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726876AbeK2K55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 05:57:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=mV9PGtULwc+fD54lMG
        rsYSEqRHO3KwMMrP0Jsw4kLbI=; b=Y75nl5yQLthhBD5oTuGdMFFitcKwdhmZGv
        U/+fTLoGqqlbfLliC8LPyQWZvEFYIVzudLJDw+q9RbOO4/Yok2duG12wxe791qau
        uOh8V4eC9CBW56ycSTjpLVRXu1j2XDlp2xR/gtV6UXQdN77GZO2x/RDXZWF02W+W
        78j8a6u6w=
Received: from bp.localdomain (unknown [106.120.213.96])
        by smtp13 (Coremail) with SMTP id EcCowADnrFisKv9bKWwrCA--.35120S3;
        Thu, 29 Nov 2018 07:54:26 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     Derek Chickles <derek.chickles@caviumnetworks.com>,
        Satanand Burla <satananda.burla@caviumnetworks.com>,
        Felix Manlunas <felix.manlunas@caviumnetworks.com>,
        Raghu Vatsavayi <raghu.vatsavayi@caviumnetworks.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pan Bian <bianpan2016@163.com>
Subject: [PATCH net] liquidio: read sc->iq_no before release sc
Date:   Thu, 29 Nov 2018 07:54:22 +0800
Message-Id: <1543449262-70421-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: EcCowADnrFisKv9bKWwrCA--.35120S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFyfZw47XrWxuF17tFW5KFg_yoW8Gr4kpr
        y8Jry2kr97JF18ua1DJr48WF93Ka1kta4YkFWfG3s3J3Z8JFyIgFy0yFyYyrWDurWkuF4S
        yFWDCa17XFn5A37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j6UDJUUUUU=
X-Originating-IP: [106.120.213.96]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/xtbBURMNclaD0WaTOwAAs3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function lio_vf_rep_packet_sent_callback releases the occupation of
sc via octeon_free_soft_command. sc should not be used after that.
Unfortunately, sc->iq_no is read. To fix this, the patch stores sc->iq_no
into a local variable before releasing sc and then uses the local variable
instead of sc->iq_no.

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c b/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c
index ea9859e..de61060 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c
@@ -349,13 +349,15 @@ lio_vf_rep_packet_sent_callback(struct octeon_device *oct,
 	struct octeon_soft_command *sc = (struct octeon_soft_command *)buf;
 	struct sk_buff *skb = sc->ctxptr;
 	struct net_device *ndev = skb->dev;
+	u32 iq_no;
 
 	dma_unmap_single(&oct->pci_dev->dev, sc->dmadptr,
 			 sc->datasize, DMA_TO_DEVICE);
 	dev_kfree_skb_any(skb);
+	iq_no = sc->iq_no;
 	octeon_free_soft_command(oct, sc);
 
-	if (octnet_iq_is_full(oct, sc->iq_no))
+	if (octnet_iq_is_full(oct, iq_no))
 		return;
 
 	if (netif_queue_stopped(ndev))
-- 
2.7.4


