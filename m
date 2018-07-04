Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E6FC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E5FC21A13
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ayVYpC5u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E5FC21A13
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753313AbeGDR2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 13:28:53 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:33466 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752684AbeGDR2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 13:28:49 -0400
Received: by mail-pl0-f65.google.com with SMTP id 6-v6so65705plb.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 10:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=CfvS61GzRlbzbwAlBu5aUfR801yCyrpHIY3VWiUVknQ=;
        b=ayVYpC5u6+ODNnw2fJll5vCfs2nc4Y/0JIscZxMSIn1wdJr/j6PE1PvLoTOs9XyJ0X
         DfbkEAJrW3tMB9D1hwWANLgktZLrOAOsaNV08yBpsAR0yZi2c5cxtEWMJ43IOalWIA7y
         WEHDqVPnkDWmJDFmbQcjyP+sRJ1unor3XPenc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=CfvS61GzRlbzbwAlBu5aUfR801yCyrpHIY3VWiUVknQ=;
        b=iWdjpXjyXNW4d6DPtwUIGtcRflR9+Yp7xZlj4/ZoXG+vFfsAR6aP3XKwK1Zwa/nU6t
         dgYAsNtvCfSFxGta5QZQZR7dNFnmXVZvSAiTO0nv18VDqI+vrhhnKdgBNRmHZ39iXi7J
         U+P3RoudSyjZ3UmyfwSt9BtJEYKE8jwPudzd/aPpYc0KUPv0kExF6ayH67nlcXp4VUqT
         r8Fvivku2OIgY/Yzz2z/ewdT3yli/wYUNCZP6WSMplY4GUWEMKKPY+50Rsn5buasvua2
         fVDJPVFLnM5A0YthnY4XQDhNeF7DK9Xz3O+rjLVOABWj3cG4kpOlD7kqZqwv67zlJzmy
         0h0Q==
X-Gm-Message-State: APt69E2SzOHaxoYsSp6KQu1BQo83YyzL2UBHEc58io0UN6ekFOew7hI2
        bMXnj0jfGGrwWRIcm1l0cMXkrg==
X-Google-Smtp-Source: AAOMgpcbisZsOaxigfMOO1Z+vqrCeSmX6x1S2PL2CWYz7/9k7bl0tfo5EtM8q2gykj1GpCEBb2zRVA==
X-Received: by 2002:a17:902:a60b:: with SMTP id u11-v6mr2949397plq.158.1530725329042;
        Wed, 04 Jul 2018 10:28:49 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id a24-v6sm15105006pfj.140.2018.07.04.10.28.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 10:28:47 -0700 (PDT)
Date:   Wed, 4 Jul 2018 10:28:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Saeed Mahameed <saeedm@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Vadim Pasternak <vadimp@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net/mlx5: Use 2-factor allocator calls
Message-ID: <20180704172847.GA33621@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This restores the use of 2-factor allocation helpers that were already
fixed treewide. Please do not use open-coded multiplication; prefer,
instead, using 2-factor allocation helpers.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index bbd2fd0b2e06..c7791d036e9f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -349,7 +349,8 @@ static int mlx5e_rq_alloc_mpwqe_info(struct mlx5e_rq *rq,
 {
 	int wq_sz = mlx5_wq_ll_get_size(&rq->mpwqe.wq);
 
-	rq->mpwqe.info = kvzalloc_node(wq_sz * sizeof(*rq->mpwqe.info),
+	rq->mpwqe.info = kvzalloc_node(array_size(wq_sz,
+						  sizeof(*rq->mpwqe.info)),
 				       GFP_KERNEL, cpu_to_node(c->cpu));
 	if (!rq->mpwqe.info)
 		return -ENOMEM;
@@ -969,7 +970,7 @@ static int mlx5e_alloc_xdpsq_db(struct mlx5e_xdpsq *sq, int numa)
 {
 	int wq_sz = mlx5_wq_cyc_get_size(&sq->wq);
 
-	sq->db.di = kvzalloc_node(sizeof(*sq->db.di) * wq_sz,
+	sq->db.di = kvzalloc_node(array_size(wq_sz, sizeof(*sq->db.di)),
 				  GFP_KERNEL, numa);
 	if (!sq->db.di) {
 		mlx5e_free_xdpsq_db(sq);
@@ -1028,7 +1029,8 @@ static int mlx5e_alloc_icosq_db(struct mlx5e_icosq *sq, int numa)
 {
 	u8 wq_sz = mlx5_wq_cyc_get_size(&sq->wq);
 
-	sq->db.ico_wqe = kvzalloc_node(sizeof(*sq->db.ico_wqe) * wq_sz,
+	sq->db.ico_wqe = kvzalloc_node(array_size(wq_sz,
+						  sizeof(*sq->db.ico_wqe)),
 				       GFP_KERNEL, numa);
 	if (!sq->db.ico_wqe)
 		return -ENOMEM;
@@ -1083,9 +1085,11 @@ static int mlx5e_alloc_txqsq_db(struct mlx5e_txqsq *sq, int numa)
 	int wq_sz = mlx5_wq_cyc_get_size(&sq->wq);
 	int df_sz = wq_sz * MLX5_SEND_WQEBB_NUM_DS;
 
-	sq->db.dma_fifo = kvzalloc_node(df_sz * sizeof(*sq->db.dma_fifo),
+	sq->db.dma_fifo = kvzalloc_node(array_size(df_sz,
+						   sizeof(*sq->db.dma_fifo)),
 					GFP_KERNEL, numa);
-	sq->db.wqe_info = kvzalloc_node(wq_sz * sizeof(*sq->db.wqe_info),
+	sq->db.wqe_info = kvzalloc_node(array_size(wq_sz,
+						   sizeof(*sq->db.wqe_info)),
 					GFP_KERNEL, numa);
 	if (!sq->db.dma_fifo || !sq->db.wqe_info) {
 		mlx5e_free_txqsq_db(sq);
-- 
2.17.1


-- 
Kees Cook
Pixel Security
