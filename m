Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A295C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C516C21104
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543762;
	bh=S+ptP9wgDJZaUFR14lx85wVIJi2JO0oD2PI8UaJ8bxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J5Mily6wKtbxmYrfunQGGt/Ocgdjj+HhmeGTeAzYXf4oDY9ryPuQufNXfsuLgLs32
	 FfKskZ0cz72jt+qZgV/aoc+BnwSE8IYVTjOTZ8N9g07cyJ3RdfIiPSlyjCIzmsGH0a
	 DtBY/aeqVnV2xT6Rkh4V8i5BBC+kM18vVtkybeVI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C516C21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730506AbeLKP4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:56:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:44760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730488AbeLKPz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:55:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 623B2205C9;
        Tue, 11 Dec 2018 15:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543757;
        bh=S+ptP9wgDJZaUFR14lx85wVIJi2JO0oD2PI8UaJ8bxE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kPUlCgKQQFENSKN5DHBzP1hGvZifAAKC/z07flwTHbnuPBOLOvK8xGJ3MpbLNwwpb
         dBzmPTf85q48FEK+0/TOPiiP+YxWzh5NPkDIG4+h7ZktioWdftTSX7JW9CtNfJheuv
         Me1q9gtJef6orAes6/OgfrAIIpbt+W2Lk5nyF3rY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Falcon <tlfalcon@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 053/118] ibmvnic: Update driver queues after change in ring size support
Date:   Tue, 11 Dec 2018 16:41:12 +0100
Message-Id: <20181211151646.385625150@linuxfoundation.org>
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

[ Upstream commit 5bf032ef08e6a110edc1e3bfb3c66a208fb55125 ]

During device reset, queue memory is not being updated to accommodate
changes in ring buffer sizes supported by backing hardware. Track
any differences in ring buffer sizes following the reset and update
queue memory when possible.

Signed-off-by: Thomas Falcon <tlfalcon@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index f1d4d7a1278b..5ab21a1b5444 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -1737,6 +1737,7 @@ static int do_reset(struct ibmvnic_adapter *adapter,
 		    struct ibmvnic_rwi *rwi, u32 reset_state)
 {
 	u64 old_num_rx_queues, old_num_tx_queues;
+	u64 old_num_rx_slots, old_num_tx_slots;
 	struct net_device *netdev = adapter->netdev;
 	int i, rc;
 
@@ -1748,6 +1749,8 @@ static int do_reset(struct ibmvnic_adapter *adapter,
 
 	old_num_rx_queues = adapter->req_rx_queues;
 	old_num_tx_queues = adapter->req_tx_queues;
+	old_num_rx_slots = adapter->req_rx_add_entries_per_subcrq;
+	old_num_tx_slots = adapter->req_tx_entries_per_subcrq;
 
 	ibmvnic_cleanup(netdev);
 
@@ -1810,7 +1813,11 @@ static int do_reset(struct ibmvnic_adapter *adapter,
 			if (rc)
 				return rc;
 		} else if (adapter->req_rx_queues != old_num_rx_queues ||
-			   adapter->req_tx_queues != old_num_tx_queues) {
+			   adapter->req_tx_queues != old_num_tx_queues ||
+			   adapter->req_rx_add_entries_per_subcrq !=
+							old_num_rx_slots ||
+			   adapter->req_tx_entries_per_subcrq !=
+							old_num_tx_slots) {
 			release_rx_pools(adapter);
 			release_tx_pools(adapter);
 			release_napi(adapter);
-- 
2.19.1



