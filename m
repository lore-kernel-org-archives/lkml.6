Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D58C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFDD62146F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129885;
	bh=3DBK4uJfOeqg8/GmAz10UBksp7Zv+xkF0Uq9tc9QVb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Xhx3fXTfKbsb7I62qDCGpCO3YcIOsycq8XzYqIyqbLBsWYurTmRkdScwu4lH6fBM/
	 lVSAPy8Ldzjl0jV5NWj4qMmSU4WSwlCD6MRVJoSHcAPWXW1s1O7xITYcK7UKArETi2
	 2XL1CB6Mgwsoi4XiabuwR8jsQdJVQDURRalElDIQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730970AbfBYVYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:24:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:59210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731290AbfBYVYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:24:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0935720C01;
        Mon, 25 Feb 2019 21:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129881;
        bh=3DBK4uJfOeqg8/GmAz10UBksp7Zv+xkF0Uq9tc9QVb0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=anraVIaPuqrhHhS+JsqfA2p63JZAVsEk3+4SxFaHGwmDDt1iGJKfzTieE1abDErjc
         KNZNiwKq+LueJWnX5hdW7GHo2ylxXD8J5x4okXs10TMRiEyNU9nP87AzxNRX/v/rn1
         KXBuktIIkEfaOsqGZporwykntlmBLJghZ3zbrxtA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 096/152] net/mlx5e: Fix wrong (zero) TX drop counter indication for representor
Date:   Mon, 25 Feb 2019 22:11:28 +0100
Message-Id: <20190225195049.597741635@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
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

[ Upstream commit 7fdc1adc52d3975740547a78c2df329bb207f15d ]

For representors, the TX dropped counter is not folded from the
per-ring counters. Fix it.

Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index c9cc9747d21d1..701624a63d2f4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -144,6 +144,7 @@ static void mlx5e_rep_update_sw_counters(struct mlx5e_priv *priv)
 
 			s->tx_packets		+= sq_stats->packets;
 			s->tx_bytes		+= sq_stats->bytes;
+			s->tx_queue_dropped	+= sq_stats->dropped;
 		}
 	}
 }
-- 
2.19.1



