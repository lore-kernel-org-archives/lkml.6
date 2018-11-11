Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15B1C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE7A20818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qPWNTxzs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DE7A20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390821AbeKLIWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:22:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:54138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390805AbeKLIWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:22:42 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02D5622503;
        Sun, 11 Nov 2018 22:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975565;
        bh=Cj3MjZgaSNz8Lijy/mZFObp5c6DL2x8UwFO/sSm9O+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qPWNTxzsezdsqXpXmeIiNZo1NZ8NTJ/Qovec4gua0Ma3PWP60qdQdMEG/lukbjBSn
         prfThB7n0nr4GlqhW+eVeYIXCNJX00tdFsTTV/3oowD/AmDLJIb6uJV8ciqCbR+DZT
         UYF3mHr+KKdCCDwoOc7b6jAHJ4BEmPObMDpYLHbg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Artemy Kovalyov <artemyko@mellanox.com>,
        Majd Dibbiny <majd@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.14 134/222] IB/mlx5: Fix MR cache initialization
Date:   Sun, 11 Nov 2018 14:23:51 -0800
Message-Id: <20181111221659.550124307@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Artemy Kovalyov <artemyko@mellanox.com>

commit 013c2403bf32e48119aeb13126929f81352cc7ac upstream.

Schedule MR cache work only after bucket was initialized.

Cc: <stable@vger.kernel.org> # 4.10
Fixes: 49780d42dfc9 ("IB/mlx5: Expose MR cache for mlx5_ib")
Signed-off-by: Artemy Kovalyov <artemyko@mellanox.com>
Reviewed-by: Majd Dibbiny <majd@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/mlx5/mr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -675,7 +675,6 @@ int mlx5_mr_cache_init(struct mlx5_ib_de
 		init_completion(&ent->compl);
 		INIT_WORK(&ent->work, cache_work_func);
 		INIT_DELAYED_WORK(&ent->dwork, delayed_cache_work_func);
-		queue_work(cache->wq, &ent->work);
 
 		if (i > MR_CACHE_LAST_STD_ENTRY) {
 			mlx5_odp_init_mr_cache_entry(ent);
@@ -694,6 +693,7 @@ int mlx5_mr_cache_init(struct mlx5_ib_de
 			ent->limit = dev->mdev->profile->mr_cache[i].limit;
 		else
 			ent->limit = 0;
+		queue_work(cache->wq, &ent->work);
 	}
 
 	err = mlx5_mr_cache_debugfs_init(dev);


