Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30EDCC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00AF620449
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298421;
	bh=6u6h+hSeg+72zIN6bkaccFwFP+jb9kKwIWhfN0izLKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0xoS0XSu+vjIJRKUgKhH7xYWleHkTURKMU49578wWmljbV8anpDmEo17zZZ0OtvlM
	 eU94MjXMbT9FCz9QsTk+1igzZYDKvMyMY0o19iGKSauTGSlQFFaAo800tiqXIQIwi+
	 QM37qNAuPRTgbGl2pdJ1mzM/Fzbr8Ot21RPtoCi0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733232AbeLTJdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:33:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:35206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732869AbeLTJaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:30:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C45D221741;
        Thu, 20 Dec 2018 09:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545298210;
        bh=6u6h+hSeg+72zIN6bkaccFwFP+jb9kKwIWhfN0izLKI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=viMhsohkJlvCyitH22r1vTPh+D8Bpi9jPyTECIy97aAEXCgKMQJmjHBGH0KMQwykt
         XFM3vdUo6auqNAgcHpGyLe7VRDxgW4/xs8xv8ldO5Nc8sOSS47XmfZXu6o/zSx2nKl
         h6/xtBlsm+C8il1bzXUegt/13nmuTbOry9YYVoGk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Igor Russkikh <igor.russkikh@aquantia.com>,
        Dmitry Bogdanov <dmitry.bogdanov@aquantia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 23/67] net: aquantia: fix rx checksum offload bits
Date:   Thu, 20 Dec 2018 10:18:35 +0100
Message-Id: <20181220085904.466153691@linuxfoundation.org>
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



