Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9F9C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F4DC217D4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866375;
	bh=GoO3tHLEJE/PyU4HfTecTt4CwqMKgOl3yz9tEr56Opw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FfezOcCvJCs+H+5QwbMhTNklE54cr1sS7md20Ym+kUQNJpEhVBqY5Kch1Eqo/ECc8
	 vb3pv7UnWbswK4xoyipbSPesSJVL/oVqjWRjZUbbPST7pUHNEvhbE16ZeQP+IRFZRz
	 dFskaSFdMeKHq6FwsbD4DnciWQ61+sbVZHioKkgg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731534AbfAGNGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:06:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:53662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727252AbfAGNGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:06:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A17821736;
        Mon,  7 Jan 2019 13:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866372;
        bh=GoO3tHLEJE/PyU4HfTecTt4CwqMKgOl3yz9tEr56Opw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jX1gdKZn6R7nne9BzT2qtuEJ4XrJ/kB8tGwC+FQYo2kHkajZNwmMnJ0e5YTjl/qfl
         op2xG9g74lptpB82WWIeD9aF85Nk29uFiXRwIKP5dHGHc5T6MMJ6SSJYfcX2nBXrhb
         /wVDUkcM4iHnulBwI/n6gbsJd5AI+FMj/A97Nw+Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 07/71] ibmveth: fix DMA unmap error in ibmveth_xmit_start error path
Date:   Mon,  7 Jan 2019 13:32:36 +0100
Message-Id: <20190107105330.747485049@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107105330.280153213@linuxfoundation.org>
References: <20190107105330.280153213@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>

[ Upstream commit 756af9c642329d54f048bac2a62f829b391f6944 ]

Commit 33a48ab105a7 ("ibmveth: Fix DMA unmap error") fixed an issue in the
normal code path of ibmveth_xmit_start() that was originally introduced by
Commit 6e8ab30ec677 ("ibmveth: Add scatter-gather support"). This original
fix missed the error path where dma_unmap_page is wrongly called on the
header portion in descs[0] which was mapped with dma_map_single. As a
result a failure to DMA map any of the frags results in a dmesg warning
when CONFIG_DMA_API_DEBUG is enabled.

------------[ cut here ]------------
DMA-API: ibmveth 30000002: device driver frees DMA memory with wrong function
  [device address=0x000000000a430000] [size=172 bytes] [mapped as page] [unmapped as single]
WARNING: CPU: 1 PID: 8426 at kernel/dma/debug.c:1085 check_unmap+0x4fc/0xe10
...
<snip>
...
DMA-API: Mapped at:
ibmveth_start_xmit+0x30c/0xb60
dev_hard_start_xmit+0x100/0x450
sch_direct_xmit+0x224/0x490
__qdisc_run+0x20c/0x980
__dev_queue_xmit+0x1bc/0xf20

This fixes the API misuse by unampping descs[0] with dma_unmap_single.

Fixes: 6e8ab30ec677 ("ibmveth: Add scatter-gather support")
Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/ibm/ibmveth.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1162,11 +1162,15 @@ out:
 
 map_failed_frags:
 	last = i+1;
-	for (i = 0; i < last; i++)
+	for (i = 1; i < last; i++)
 		dma_unmap_page(&adapter->vdev->dev, descs[i].fields.address,
 			       descs[i].fields.flags_len & IBMVETH_BUF_LEN_MASK,
 			       DMA_TO_DEVICE);
 
+	dma_unmap_single(&adapter->vdev->dev,
+			 descs[0].fields.address,
+			 descs[0].fields.flags_len & IBMVETH_BUF_LEN_MASK,
+			 DMA_TO_DEVICE);
 map_failed:
 	if (!firmware_has_feature(FW_FEATURE_CMO))
 		netdev_err(netdev, "tx: unable to map xmit buffer\n");


