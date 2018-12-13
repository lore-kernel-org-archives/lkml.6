Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F2EC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEEA220870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544676650;
	bh=6ML7Ps8EVQLTfG55QOt3UddSmeQJRzLpsk34Z8Viajc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i2aqYvn9ttFbJEOtmAgB21yYQc7cQ/siqAqpaviIxaG9yEs328mLVu5uubwNcQbTt
	 nzHhL+/v8H2jgoTYTyOnqPHPqLv+HOaieoX/srQT8fzj2VgJTgSpS6SPaq8+i8vkiK
	 e7/b1Qkd1ktkKFBd8DyJ9msBIes0xd5ZQUrMv/9c=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEEA220870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbeLMEus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:50:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:42326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727540AbeLME3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:29:18 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F17F720880;
        Thu, 13 Dec 2018 04:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675357;
        bh=6ML7Ps8EVQLTfG55QOt3UddSmeQJRzLpsk34Z8Viajc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BDKUvwywTHXRtUJ+1IsSG+AbYEDfEfb5XGzaTuyCIzEcL92UCtN9DAqawPZsUgspq
         5Xf1xYaGPTZtLHuIfa2McYsP9QM61CxgDV4WfmjoWNkW+j7v2DAZsM4CX6XwSZq62t
         5oJ2nDzYrE0+Qe2JmLUBokUezgVYBoa1EsULxY34=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Pan Bian <bianpan2016@163.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 24/73] liquidio: read sc->iq_no before release sc
Date:   Wed, 12 Dec 2018 23:27:49 -0500
Message-Id: <20181213042838.75160-24-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213042838.75160-1-sashal@kernel.org>
References: <20181213042838.75160-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pan Bian <bianpan2016@163.com>

[ Upstream commit c0f53771ba45745e5870daf880127925c93f232f ]

The function lio_vf_rep_packet_sent_callback releases the occupation of
sc via octeon_free_soft_command. sc should not be used after that.
Unfortunately, sc->iq_no is read. To fix this, the patch stores sc->iq_no
into a local variable before releasing sc and then uses the local variable
instead of sc->iq_no.

Signed-off-by: Pan Bian <bianpan2016@163.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c b/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c
index ddd7431579f4..c99b59fe4c8f 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c
@@ -367,13 +367,15 @@ lio_vf_rep_packet_sent_callback(struct octeon_device *oct,
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
2.19.1

