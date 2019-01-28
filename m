Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B11C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EAF72084A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548692731;
	bh=rn/2B/IEAWsO17j06R1zbEZEjs7ElTOiErs04wjXLlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GMGuSvX5q2cVjzE1GZsnQjEUplNnJszDOSXCmzo9EQeWr7SxqHXcQZYvZi9OkAzK5
	 thEfARJiMA37qNvl33bczlS4gtQ5EdhitYyQTFAUvE/sadpIacNG+dLvYt6zMrU8fZ
	 EUzmeWlwi0skkFdXgLnsjdsqlp9BFLwG9sr8HF6w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387653AbfA1QZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:25:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:34306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389939AbfA1QZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:25:27 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 816012147A;
        Mon, 28 Jan 2019 16:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692727;
        bh=rn/2B/IEAWsO17j06R1zbEZEjs7ElTOiErs04wjXLlo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HpZQHBR35xk6bEXMUtrX9OBI4c3s53BpshCAT/FkkOYFbdDrWZVfQZ1Bt/BAOGRtx
         ACCPRnby6a27YI32RkvRwHaMoLdH+ilqhoLYfdx72o8EL6QbQkgk63MenG2HSav8nz
         QKMpAcCtJuxK2KUS1diGqlKozS+zu/zElVV3Ecxk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 50/80] xfrm6_tunnel: Fix spi check in __xfrm6_tunnel_alloc_spi
Date:   Mon, 28 Jan 2019 11:23:31 -0500
Message-Id: <20190128162401.58841-50-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128162401.58841-1-sashal@kernel.org>
References: <20190128162401.58841-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit fa89a4593b927b3f59c3b69379f31d3b22272e4e ]

gcc warn this:

net/ipv6/xfrm6_tunnel.c:143 __xfrm6_tunnel_alloc_spi() warn:
 always true condition '(spi <= 4294967295) => (0-u32max <= u32max)'

'spi' is u32, which always not greater than XFRM6_TUNNEL_SPI_MAX
because of wrap around. So the second forloop will never reach.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/xfrm6_tunnel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv6/xfrm6_tunnel.c b/net/ipv6/xfrm6_tunnel.c
index 5743044cd660..56b72cada346 100644
--- a/net/ipv6/xfrm6_tunnel.c
+++ b/net/ipv6/xfrm6_tunnel.c
@@ -144,6 +144,9 @@ static u32 __xfrm6_tunnel_alloc_spi(struct net *net, xfrm_address_t *saddr)
 		index = __xfrm6_tunnel_spi_check(net, spi);
 		if (index >= 0)
 			goto alloc_spi;
+
+		if (spi == XFRM6_TUNNEL_SPI_MAX)
+			break;
 	}
 	for (spi = XFRM6_TUNNEL_SPI_MIN; spi < xfrm6_tn->spi; spi++) {
 		index = __xfrm6_tunnel_spi_check(net, spi);
-- 
2.19.1

