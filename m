Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A057C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 002D52081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544544343;
	bh=RxTwKM2CQZ0beuG0q7698RDs+s45m8kiFyhW2UZxhN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PYrHH4qCTIvN3UJv/pHQ2PzyRZoUA1JkX/uX3rDFN7VL8LXWu6mq796u7M41k7o1O
	 /rrTUWNr5p4fd+kP+Q9+1MlGz5WOqHLFGAEkp/KaemnOqA147TczKhBcMGnrVOKMeM
	 oEElGMp682PUVKlgI/6oZQUpQh76WoDSCiWGjpIY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 002D52081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731006AbeLKQFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:05:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:43746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729829AbeLKPzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:55:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17FD42146F;
        Tue, 11 Dec 2018 15:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543706;
        bh=RxTwKM2CQZ0beuG0q7698RDs+s45m8kiFyhW2UZxhN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aKaSXJDa6voH6Y874m8P4G/54+jiS7HEQJrV8ZKhlaD3+VZ4hcJJjyXJXImeNvO/7
         J9mR1I7iMr5PZMLln8uOha9b2GfFoWe5d9qJrvJ+a1DT4j58qRN4S2hipH9Ly+PhNE
         jwWA9FwXp81cQZnCpyxGeJt5Ss6uL1O2LywpsV2I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aya Levin <ayal@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 031/118] net/mlx4: Fix UBSAN warning of signed integer overflow
Date:   Tue, 11 Dec 2018 16:40:50 +0100
Message-Id: <20181211151645.498726662@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
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
index ebcd2778eeb3..23f1b5b512c2 100644
--- a/drivers/net/ethernet/mellanox/mlx4/mlx4.h
+++ b/drivers/net/ethernet/mellanox/mlx4/mlx4.h
@@ -540,8 +540,8 @@ struct slave_list {
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



