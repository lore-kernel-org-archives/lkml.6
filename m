Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA38BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8154C217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129863;
	bh=hOCF97rmrwXgr64eHS941umNAl8lCLqHDDd8fAz/Ju4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fVk+mG7yR39iIq6fFafXmUlZJRHL6BYEhRnCJ+O46CEmE7bGm0w5Nj3jNz8eNcI0w
	 wjhPYGtWGjEie+j9xBvvRy7S5pbHPYEwbnnkCVXf9ICOJG8aBoBgaJclcLBdjzLyT9
	 30+agx325QbN6DPYTCHNjCpy8JHgcQlq4Pc7IvGM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731244AbfBYVYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:24:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:58802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730806AbfBYVYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:24:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB121217F5;
        Mon, 25 Feb 2019 21:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129856;
        bh=hOCF97rmrwXgr64eHS941umNAl8lCLqHDDd8fAz/Ju4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZhQbDENAPv6D4gKiNMI4gr9efHQy3tY3hXY2+yNhkDcP4HBIka8rGLzArwITQvISA
         FKeGiexTZnmRUYqKMLOkkLriHX0yfpdPdHP/I6b0axwiXr0QfZ30ikmP50fsEDRPmZ
         m5XL7JparGD7CTReK3TQvmc1ziVeUGd0/4zHsO/o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joao Pinto <jpinto@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 062/152] net: stmmac: Check if CBS is supported before configuring
Date:   Mon, 25 Feb 2019 22:10:54 +0100
Message-Id: <20190225195047.716207131@linuxfoundation.org>
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

[ Upstream commit 0650d4017f4d2eee67230a02285a7ae5204240c2 ]

Check if CBS is currently supported before trying to configure it in HW.

Cc: Joao Pinto <jpinto@synopsys.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Signed-off-by: Jose Abreu <joabreu@synopsys.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 531294f4978bc..58ea18af9813a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -301,6 +301,8 @@ static int tc_setup_cbs(struct stmmac_priv *priv,
 	/* Queue 0 is not AVB capable */
 	if (queue <= 0 || queue >= tx_queues_count)
 		return -EINVAL;
+	if (!priv->dma_cap.av)
+		return -EOPNOTSUPP;
 	if (priv->speed != SPEED_100 && priv->speed != SPEED_1000)
 		return -EOPNOTSUPP;
 
-- 
2.19.1



