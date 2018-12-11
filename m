Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DE6C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0D2F2084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543490;
	bh=GN7W4OAIQJImCtpARNKgATw13qsK4UxyBhweSNCwPTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ov+opE4jlZco8wSRefSY02Us+zZWfcfwGHT8nmESjqciQGjXg9GAa9e5NdVNBTC3n
	 vtGBiJ4gZLoroZrPRfNpBiwgf6wZOfBYBZ8/DHNm4VcpyKWCGPyW7vkybeKMv+HOx1
	 ng0A+pxG+ott4grWJYGv4ucfEVAF3PksYvtmJVHc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0D2F2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbeLKPv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:51:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:40070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728270AbeLKPv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:51:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 618C62084E;
        Tue, 11 Dec 2018 15:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543485;
        bh=GN7W4OAIQJImCtpARNKgATw13qsK4UxyBhweSNCwPTw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cSvULXdyeh6vwV5/BvDEnfPehGh/zwpPihoyeEGoS1SCtNLCyOIUO7btOiOD4mHbS
         y9dYD0BtHNGKsOlG3UDlJLr+sN9kHLDm1RKh1EYnz1VMQlij5/m68zlgLkYNqSF9zt
         +DM6Wmyq/kCK/l5GKlnBOiR92E321N1gkNWI1+Do=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aya Levin <ayal@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 17/67] net/mlx4: Fix UBSAN warning of signed integer overflow
Date:   Tue, 11 Dec 2018 16:41:17 +0100
Message-Id: <20181211151631.258636206@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151630.378216233@linuxfoundation.org>
References: <20181211151630.378216233@linuxfoundation.org>
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

[ Upstream commit a463146e67c848cbab5ce706d6528281b7cded08 ]

UBSAN: Undefined behavior in
drivers/net/ethernet/mellanox/mlx4/resource_tracker.c:626:29
signed integer overflow: 1802201963 + 1802201963 cannot be represented
in type 'int'

The union of res_reserved and res_port_rsvd[MLX4_MAX_PORTS] monitors
granting of reserved resources. The grant operation is calculated and
protected, thus both members of the union cannot be negative.  Changed
type of res_reserved and of res_port_rsvd[MLX4_MAX_PORTS] from signed
int to unsigned int, allowing large value.

Fixes: 5a0d0a6161ae ("mlx4: Structures and init/teardown for VF resource quotas")
Signed-off-by: Aya Levin <ayal@mellanox.com>
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx4/mlx4.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/mlx4.h b/drivers/net/ethernet/mellanox/mlx4/mlx4.h
index c68da1986e51..aaeb446bba62 100644
--- a/drivers/net/ethernet/mellanox/mlx4/mlx4.h
+++ b/drivers/net/ethernet/mellanox/mlx4/mlx4.h
@@ -541,8 +541,8 @@ struct slave_list {
 struct resource_allocator {
 	spinlock_t alloc_lock; /* protect quotas */
 	union {
-		int res_reserved;
-		int res_port_rsvd[MLX4_MAX_PORTS];
+		unsigned int res_reserved;
+		unsigned int res_port_rsvd[MLX4_MAX_PORTS];
 	};
 	union {
 		int res_free;
-- 
2.19.1



