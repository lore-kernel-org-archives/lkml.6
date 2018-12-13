Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C1EC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E73D820879
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544675359;
	bh=cjPv1SgfIN+9gmFf3f2owrw0kwnxR47hRvSI03XLCaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c8N4JD6ltsJ78Dfb7KbZRvLIZfdPG5u6DHe5O9ttS0d4DN941u1cqYc8BC1h8rpcx
	 4Zz5PeXnh3X4bV1geLSUK2UAbE3gOBsFdhpWjMZkiIE1qLw/CQAQmtA0qu7zxQ8G18
	 m09wrotu6SBNx5oanT20k7lk5hZBxiPIsv81Ey4o=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E73D820879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbeLME3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:29:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:42260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727482AbeLME3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:29:15 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0F4A20873;
        Thu, 13 Dec 2018 04:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675354;
        bh=cjPv1SgfIN+9gmFf3f2owrw0kwnxR47hRvSI03XLCaA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AvKB5KzXm3utGmiMgAXg7pGDNdtCCk6iAGZozc+RwKdv1U0lULUfz1qbGDxAhkXEo
         HlCiVGjqyrdhwAx9bb+18FTAXLhehXBWMk9rJPFRQ4r9tDBhu/MrCBGGFpQ43g9KMs
         aWFpHT2wmHqJFQvp+kT/2Qf7tm/TqmYvJ6yFHRSs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dmitry Bogdanov <dmitry.bogdanov@aquantia.com>,
        Igor Russkikh <igor.russkikh@aquantia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 21/73] net: aquantia: fix rx checksum offload bits
Date:   Wed, 12 Dec 2018 23:27:46 -0500
Message-Id: <20181213042838.75160-21-sashal@kernel.org>
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

From: Dmitry Bogdanov <dmitry.bogdanov@aquantia.com>

[ Upstream commit 37c4b91f955fdd5f4ad771956b97d35f1321098e ]

The last set of csum offload fixes had a leak:

Checksum enabled status bits from rx descriptor were incorrectly
interpreted. Consequently all the other valid logic worked on zero bits.
That caused rx checksum offloads never to trigger.

Tested by dumping rx descriptors and validating resulting csum_level.

Reported-by: Igor Russkikh <igor.russkikh@aquantia.com>
Signed-off-by: Dmitry Bogdanov <dmitry.bogdanov@aquantia.com>
Signed-off-by: Igor Russkikh <igor.russkikh@aquantia.com>
Fixes: ad703c2b9127f ("net: aquantia: invalid checksumm offload implementation")
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
index 88705dee5b95..56363ff5c891 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
@@ -667,7 +667,7 @@ static int hw_atl_b0_hw_ring_rx_receive(struct aq_hw_s *self,
 
 		rx_stat = (0x0000003CU & rxd_wb->status) >> 2;
 
-		is_rx_check_sum_enabled = (rxd_wb->type) & (0x3U << 19);
+		is_rx_check_sum_enabled = (rxd_wb->type >> 19) & 0x3U;
 
 		pkt_type = 0xFFU & (rxd_wb->type >> 4);
 
-- 
2.19.1

