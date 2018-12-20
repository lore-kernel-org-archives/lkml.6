Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AFAC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C595820989
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298345;
	bh=hYHotAGHvnz8lbScZslWN1JYX6EL0SS7+Lx/NaW6XNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vQva1nJ3mZMfsLyWvmiL61g9KgvQcybwdV107cKE/uR8h8lybcr+fy6wzMT43V+/M
	 DwJHxahvGeqQOyuRdzZV0/JBW8ol55uag2rIkiYjcb+NOUoa75y2H7tWEyOv/GbAhs
	 /lT3Vd3DJZKTlBdPdF2e8O/A59ECSS0c8eO9Gens=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733103AbeLTJbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:31:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:45788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733082AbeLTJbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:31:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 771C720656;
        Thu, 20 Dec 2018 09:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545298275;
        bh=hYHotAGHvnz8lbScZslWN1JYX6EL0SS7+Lx/NaW6XNk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2kchU50JC2DlISrabgjL/XpGEjwaDwJ76k44EJ1dfy5HHW9zO9IIH+x2GlN+VLU9f
         xsaHlFGAtMqby0llJFCpxpnNU2/Z/aFfVtpsz4kMLRazMVBzqsLssvIMpBVVntNj/x
         Qs8SfkAyGFQJj+lasUh+LfCsdV7/ksVcpVBof+4U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pan Bian <bianpan2016@163.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 26/67] liquidio: read sc->iq_no before release sc
Date:   Thu, 20 Dec 2018 10:18:38 +0100
Message-Id: <20181220085904.585003979@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085903.562090333@linuxfoundation.org>
References: <20181220085903.562090333@linuxfoundation.org>
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



