Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83DAC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AD1421486
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789280;
	bh=LHxTaLysYE5fCmH+/50XMCETJlReBTLrtEm+O2O5rUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dqmO69aOk8/u292DwxR4/ALwkbsSXPFfcQoM17lqBNSOytjOBzJeC0Gl34/agSZG+
	 W8KmNEvVTAStH9xqunKMV4kUaIziKXGO7fHOF4Bc+UnRMbsmL5B+0KtY8s+pX7XH30
	 puU0IL6Om0fXYATOBQKFOJt+KqRFNtnDAsKLb78M=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AD1421486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731203AbeLNMH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:07:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:53264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731194AbeLNMHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:07:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 020A22147D;
        Fri, 14 Dec 2018 12:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789273;
        bh=LHxTaLysYE5fCmH+/50XMCETJlReBTLrtEm+O2O5rUY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z6HBxHcO0NdDu6e1dI2ODTlQ8zmnTwPOUeE+hHegdt157Gi/j86xN/I0ClJbKtXuO
         o/q64m3mkP7zgXBPVPOhAy7RCY40unO7navACDTbbEUjc9ziLdzYXonTE0jRPRHj59
         6ib9XiGIJmmLvxHv+8udrlHH0HW9xjP7xyGyF5UY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tarick Bedeir <tarick@google.com>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 06/89] net/mlx4_core: Correctly set PFC param if global pause is turned off.
Date:   Fri, 14 Dec 2018 12:59:19 +0100
Message-Id: <20181214115729.987419739@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115729.658859279@linuxfoundation.org>
References: <20181214115729.658859279@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tarick Bedeir <tarick@google.com>

[ Upstream commit bd5122cd1e0644d8bd8dd84517c932773e999766 ]

rx_ppp and tx_ppp can be set between 0 and 255, so don't clamp to 1.

Fixes: 6e8814ceb7e8 ("net/mlx4_en: Fix mixed PFC and Global pause user control requests")
Signed-off-by: Tarick Bedeir <tarick@google.com>
Reviewed-by: Eran Ben Elisha <eranbe@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
@@ -1070,8 +1070,8 @@ static int mlx4_en_set_pauseparam(struct
 
 	tx_pause = !!(pause->tx_pause);
 	rx_pause = !!(pause->rx_pause);
-	rx_ppp = priv->prof->rx_ppp && !(tx_pause || rx_pause);
-	tx_ppp = priv->prof->tx_ppp && !(tx_pause || rx_pause);
+	rx_ppp = (tx_pause || rx_pause) ? 0 : priv->prof->rx_ppp;
+	tx_ppp = (tx_pause || rx_pause) ? 0 : priv->prof->tx_ppp;
 
 	err = mlx4_SET_PORT_general(mdev->dev, priv->port,
 				    priv->rx_skb_size + ETH_FCS_LEN,


