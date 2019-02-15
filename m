Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909BCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5589E2073D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550197461;
	bh=+PdbAR4rKtaxcrzs+9zeq745zR7PIu2KXabbSF5PTdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SPx0+lOdSXTKEIzvlmT2Cyh8dIoSffvdQq/nEiPxBtlvDc//sOZKZfEC94i3speCb
	 OKKR054iLhFPvaQEL6vF4cS1WRvPDK8syltAZAsj+kS2/UaCihh1HSPLqaUnIm4D1/
	 nG4Kn/t5/3at1vFbvXCxfN+iifnAOQG9LG9O6SEE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbfBOCYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:24:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:54204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391573AbfBOCOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:14:18 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53935206BA;
        Fri, 15 Feb 2019 02:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196858;
        bh=+PdbAR4rKtaxcrzs+9zeq745zR7PIu2KXabbSF5PTdU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cYdJSfOskJ83T0EhTo4pqkg1WCM+1Fhzo5gVBAaDQMqELWFA91pItQVGN8o6o231Q
         DQKr4AYdFM36VeZvJuxqeWr+AuuU8D8N1AvY/nbztodwek5qTJTUmFhz4HiwP9977X
         +Yi7E4Qu8P25X6MgVz8ICLhlWauwV+HiYhR4wRlY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thomas Falcon <tlfalcon@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 35/40] ibmveth: Do not process frames after calling napi_reschedule
Date:   Thu, 14 Feb 2019 21:13:08 -0500
Message-Id: <20190215021313.178476-35-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215021313.178476-1-sashal@kernel.org>
References: <20190215021313.178476-1-sashal@kernel.org>
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
index 6c05819d995e..754dff4c1771 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1314,7 +1314,6 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 	unsigned long lpar_rc;
 	u16 mss = 0;
 
-restart_poll:
 	while (frames_processed < budget) {
 		if (!ibmveth_rxq_pending_buffer(adapter))
 			break;
@@ -1402,7 +1401,6 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 		    napi_reschedule(napi)) {
 			lpar_rc = h_vio_signal(adapter->vdev->unit_address,
 					       VIO_IRQ_DISABLE);
-			goto restart_poll;
 		}
 	}
 
-- 
2.19.1

