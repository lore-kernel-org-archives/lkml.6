Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D23C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D2092077B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:48:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D2092077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733082AbeHWMRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:17:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50884 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732308AbeHWMRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:17:22 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8BC4C941;
        Thu, 23 Aug 2018 08:48:43 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sudarsana Reddy Kalluru <Sudarsana.Kalluru@cavium.com>,
        Ariel Elior <ariel.elior@cavium.com>,
        Michal Kalderon <Michal.Kalderon@cavium.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 065/324] qed: Fix possible memory leak in Rx error path handling.
Date:   Thu, 23 Aug 2018 09:52:11 +0200
Message-Id: <20180823074959.160106350@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sudarsana Reddy Kalluru <sudarsana.kalluru@cavium.com>

[ Upstream commit 4f9de4df901fb84709fe3a864dfa4eaf35700f68 ]

Memory for packet buffers need to be freed in the error paths as there is
no consumer (e.g., upper layer) for such packets and that memory will never
get freed.
The issue was uncovered when port was attacked with flood of isatap
packets, these are multicast packets hence were directed at all the PFs.
For foce PF, this meant they were routed to the ll2 module which in turn
drops such packets.

Fixes: 0a7fb11c ("qed: Add Light L2 support")
Signed-off-by: Sudarsana Reddy Kalluru <Sudarsana.Kalluru@cavium.com>
Signed-off-by: Ariel Elior <ariel.elior@cavium.com>
Signed-off-by: Michal Kalderon <Michal.Kalderon@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qlogic/qed/qed_ll2.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/qlogic/qed/qed_ll2.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_ll2.c
@@ -201,8 +201,9 @@ void qed_ll2b_complete_rx_packet(void *c
 
 	skb = build_skb(buffer->data, 0);
 	if (!skb) {
-		rc = -ENOMEM;
-		goto out_post;
+		DP_INFO(cdev, "Failed to build SKB\n");
+		kfree(buffer->data);
+		goto out_post1;
 	}
 
 	data->u.placement_offset += NET_SKB_PAD;
@@ -224,8 +225,14 @@ void qed_ll2b_complete_rx_packet(void *c
 		cdev->ll2->cbs->rx_cb(cdev->ll2->cb_cookie, skb,
 				      data->opaque_data_0,
 				      data->opaque_data_1);
+	} else {
+		DP_VERBOSE(p_hwfn, (NETIF_MSG_RX_STATUS | NETIF_MSG_PKTDATA |
+				    QED_MSG_LL2 | QED_MSG_STORAGE),
+			   "Dropping the packet\n");
+		kfree(buffer->data);
 	}
 
+out_post1:
 	/* Update Buffer information and update FW producer */
 	buffer->data = new_data;
 	buffer->phys_addr = new_phys_addr;


