Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B17EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4163208CC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:02:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4163208CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388611AbeHWMbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:31:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55894 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729739AbeHWMbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:31:39 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E05DBBBF;
        Thu, 23 Aug 2018 09:02:55 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 269/324] ibmvnic: Revise RX/TX queue error messages
Date:   Thu, 23 Aug 2018 09:55:35 +0200
Message-Id: <20180823075009.430590231@linuxfoundation.org>
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

From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>

[ Upstream commit 2d14d3795294d42aacc278948984a480569bcc23 ]

During a device failover, there may be latency between the loss
of the current backing device and a notification from firmware that
a failover has occurred. This latency can result in a large amount of
error printouts as firmware returns outgoing traffic with a generic
error code. These are not necessarily errors in this case as the
firmware is busy swapping in a new backing adapter and is not ready
to send packets yet. This patch reclassifies those error codes as
warnings with an explanation that a failover may be pending. All
other return codes will be considered errors.

Signed-off-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/ibm/ibmvnic.c |   39 +++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -319,7 +319,8 @@ static void replenish_rx_pool(struct ibm
 	return;
 
 failure:
-	dev_info(dev, "replenish pools failure\n");
+	if (lpar_rc != H_PARAMETER && lpar_rc != H_CLOSED)
+		dev_err_ratelimited(dev, "rx: replenish packet buffer failed\n");
 	pool->free_map[pool->next_free] = index;
 	pool->rx_buff[index].skb = NULL;
 
@@ -1594,7 +1595,8 @@ static int ibmvnic_xmit(struct sk_buff *
 				      &tx_crq);
 	}
 	if (lpar_rc != H_SUCCESS) {
-		dev_err(dev, "tx failed with code %ld\n", lpar_rc);
+		if (lpar_rc != H_CLOSED && lpar_rc != H_PARAMETER)
+			dev_err_ratelimited(dev, "tx: send failed\n");
 		dev_kfree_skb_any(skb);
 		tx_buff->skb = NULL;
 
@@ -3085,6 +3087,25 @@ static union ibmvnic_crq *ibmvnic_next_c
 	return crq;
 }
 
+static void print_subcrq_error(struct device *dev, int rc, const char *func)
+{
+	switch (rc) {
+	case H_PARAMETER:
+		dev_warn_ratelimited(dev,
+				     "%s failed: Send request is malformed or adapter failover pending. (rc=%d)\n",
+				     func, rc);
+		break;
+	case H_CLOSED:
+		dev_warn_ratelimited(dev,
+				     "%s failed: Backing queue closed. Adapter is down or failover pending. (rc=%d)\n",
+				     func, rc);
+		break;
+	default:
+		dev_err_ratelimited(dev, "%s failed: (rc=%d)\n", func, rc);
+		break;
+	}
+}
+
 static int send_subcrq(struct ibmvnic_adapter *adapter, u64 remote_handle,
 		       union sub_crq *sub_crq)
 {
@@ -3111,11 +3132,8 @@ static int send_subcrq(struct ibmvnic_ad
 				cpu_to_be64(u64_crq[2]),
 				cpu_to_be64(u64_crq[3]));
 
-	if (rc) {
-		if (rc == H_CLOSED)
-			dev_warn(dev, "CRQ Queue closed\n");
-		dev_err(dev, "Send error (rc=%d)\n", rc);
-	}
+	if (rc)
+		print_subcrq_error(dev, rc, __func__);
 
 	return rc;
 }
@@ -3133,11 +3151,8 @@ static int send_subcrq_indirect(struct i
 				cpu_to_be64(remote_handle),
 				ioba, num_entries);
 
-	if (rc) {
-		if (rc == H_CLOSED)
-			dev_warn(dev, "CRQ Queue closed\n");
-		dev_err(dev, "Send (indirect) error (rc=%d)\n", rc);
-	}
+	if (rc)
+		print_subcrq_error(dev, rc, __func__);
 
 	return rc;
 }


