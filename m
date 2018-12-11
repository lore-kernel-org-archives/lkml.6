Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66505C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DF6F20879
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544544601;
	bh=Hpi+1G706tZwAfcLl1/SbIuwSBtuTaDuVix7wAkSqes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HWd3OAaJgotcYahs6TFWvx6wOF9xNpqKLexWr9PiTqUM3cDKWWi+puoWDmKMvff0i
	 LTvSkc6Syq52KupcaoBPYQk6vhc3DQYy+K+5XeWJcvoNy/fre1XxfRmF3hBn2duAcI
	 sMknnhmwO2h12ohO9dVnZb9x1tOWTcSSGdBTeQVo=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DF6F20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730177AbeLKQJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:09:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:40606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729616AbeLKPvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:51:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90C6F20855;
        Tue, 11 Dec 2018 15:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543515;
        bh=Hpi+1G706tZwAfcLl1/SbIuwSBtuTaDuVix7wAkSqes=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=icibyUYCticwB7TAfJm/gd0FZEnk5+1Rv2uxiOqwG7Fgp17iO2HLnu/htttSZGcL2
         Inr7MSNpX2MXQ652X0woUMQc3BVNy0dS4YHlADX8fcdiqXTOVRRS1fLJxkUMHPx7KX
         vxD5/trUP11trsi54AMQj/T78YeijcHRUbFwwCHY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Falcon <tlfalcon@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 27/67] ibmvnic: Fix RX queue buffer cleanup
Date:   Tue, 11 Dec 2018 16:41:27 +0100
Message-Id: <20181211151631.764550368@linuxfoundation.org>
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
index 5c7134ccc1fd..14c53ed5cca6 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -457,8 +457,8 @@ static void release_rx_pools(struct ibmvnic_adapter *adapter)
 
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



