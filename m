Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6EFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CAB720643
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550197138;
	bh=vjgFIP/T6BqnwvrvOTbFY2uQ3FKRMmicU4Xm4MfAzLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TwwIT839EQRAEOf4F6nYZobnNMdJ6XMPdJABm6usuN5vAnHhScsI/cWRwZGNVz4ip
	 WURVNN7TOdvIMJmN9rcmcSuNwbdKttZsgvDvtxkDjz1tpwG/70TxQRIJsBeSbaVKPL
	 6/jYRW9Cy2D1jswKRSUFCzKhEGikA5CA/7okPs7w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732573AbfBOCS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:18:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:55338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392068AbfBOCPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:15:43 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FB8F222D4;
        Fri, 15 Feb 2019 02:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196942;
        bh=vjgFIP/T6BqnwvrvOTbFY2uQ3FKRMmicU4Xm4MfAzLE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z+RPksI3p38/pEy0l6fKgR8BB7lmiGDMWoUcheFAP8ROKgwoZYUhDT2JVfVU6LYdm
         DUE9srvK8wd7ZmRBW0sb7ybQ7IVNPsD4PV2v+l2MSiViUBPAGQmbMvE+2yH5ixVU6o
         jsnDgkCaHOz/RYFtloWuAFyVkfHpjYHlFBonVBuc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thomas Falcon <tlfalcon@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.4 17/20] ibmveth: Do not process frames after calling napi_reschedule
Date:   Thu, 14 Feb 2019 21:15:08 -0500
Message-Id: <20190215021511.179333-17-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215021511.179333-1-sashal@kernel.org>
References: <20190215021511.179333-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Falcon <tlfalcon@linux.ibm.com>

[ Upstream commit e95d22c69b2c130ccce257b84daf283fd82d611e ]

The IBM virtual ethernet driver's polling function continues
to process frames after rescheduling NAPI, resulting in a warning
if it exhausted its budget. Do not restart polling after calling
napi_reschedule. Instead let frames be processed in the following
instance.

Signed-off-by: Thomas Falcon <tlfalcon@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ibm/ibmveth.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 61a9ab4fe047..70b3253e7ed5 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1238,7 +1238,6 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 	struct iphdr *iph;
 	u16 mss = 0;
 
-restart_poll:
 	while (frames_processed < budget) {
 		if (!ibmveth_rxq_pending_buffer(adapter))
 			break;
@@ -1336,7 +1335,6 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 		    napi_reschedule(napi)) {
 			lpar_rc = h_vio_signal(adapter->vdev->unit_address,
 					       VIO_IRQ_DISABLE);
-			goto restart_poll;
 		}
 	}
 
-- 
2.19.1

