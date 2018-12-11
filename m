Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6834C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA812084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544544284;
	bh=Iht4d3ZyjEjAKQtmrUv9DXnLxpUJIvzrDzkepHrcJ0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eFbV0UQEX7k731JxGHY1B48CWHExQakiH873V1KaucF8UwkOX3tekBpxZYpJTPzdL
	 e5QbIWnMJ0g0yqVMFF+yPV4j4VThAbj96F0NjUFksc/gaYoTKH9M4x+i7urqKNV1rD
	 3dcRvNd2+1n7ZzIG3ZpxynPCO2C7L4lIfUx+vjKc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAA812084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730799AbeLKQEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:04:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:44696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729288AbeLKPzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:55:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF5692086D;
        Tue, 11 Dec 2018 15:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543755;
        bh=Iht4d3ZyjEjAKQtmrUv9DXnLxpUJIvzrDzkepHrcJ0Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i/Cmsa9dumXjqU3w+R1GaH8WqysS/Kx6VSRoHiVVzWneRN74yd/2P4nBeU3l/S/Py
         gypPlA+nq7dYZE/irXy6Cms8lHIsdzYCodEa3bEm2Xj+EDQ721fNhjYbTk40us+jya
         m/BetNHeMGiRm9qeXGZzGyxLJq1yvXwGYqeDqL6Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Falcon <tlfalcon@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 052/118] ibmvnic: Fix RX queue buffer cleanup
Date:   Tue, 11 Dec 2018 16:41:11 +0100
Message-Id: <20181211151646.345279212@linuxfoundation.org>
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

[ Upstream commit b7cdec3d699db2e5985ad39de0f25d3b6111928e ]

The wrong index is used when cleaning up RX buffer objects during release
of RX queues. Update to use the correct index counter.

Signed-off-by: Thomas Falcon <tlfalcon@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index a646de07cbdc..f1d4d7a1278b 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -485,8 +485,8 @@ static void release_rx_pools(struct ibmvnic_adapter *adapter)
 
 		for (j = 0; j < rx_pool->size; j++) {
 			if (rx_pool->rx_buff[j].skb) {
-				dev_kfree_skb_any(rx_pool->rx_buff[i].skb);
-				rx_pool->rx_buff[i].skb = NULL;
+				dev_kfree_skb_any(rx_pool->rx_buff[j].skb);
+				rx_pool->rx_buff[j].skb = NULL;
 			}
 		}
 
-- 
2.19.1



