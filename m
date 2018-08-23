Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF41C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 496472084A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:00:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 496472084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388134AbeHWM2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:28:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53234 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbeHWM2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:28:41 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0C802CA0;
        Thu, 23 Aug 2018 08:59:59 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 196/324] net: qrtr: Reset the node and port ID of broadcast messages
Date:   Thu, 23 Aug 2018 09:54:22 +0200
Message-Id: <20180823075005.968038177@linuxfoundation.org>
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

From: Arun Kumar Neelakantam <aneela@codeaurora.org>

[ Upstream commit d27e77a3de2866b0a772803fd03cd667b5ff8a9a ]

All the control messages broadcast to remote routers are using
QRTR_NODE_BCAST instead of using local router NODE ID which cause
the packets to be dropped on remote router due to invalid NODE ID.

Signed-off-by: Arun Kumar Neelakantam <aneela@codeaurora.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/qrtr/qrtr.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/net/qrtr/qrtr.c
+++ b/net/qrtr/qrtr.c
@@ -191,8 +191,13 @@ static int qrtr_node_enqueue(struct qrtr
 	hdr->type = cpu_to_le32(type);
 	hdr->src_node_id = cpu_to_le32(from->sq_node);
 	hdr->src_port_id = cpu_to_le32(from->sq_port);
-	hdr->dst_node_id = cpu_to_le32(to->sq_node);
-	hdr->dst_port_id = cpu_to_le32(to->sq_port);
+	if (to->sq_port == QRTR_PORT_CTRL) {
+		hdr->dst_node_id = cpu_to_le32(node->nid);
+		hdr->dst_port_id = cpu_to_le32(QRTR_NODE_BCAST);
+	} else {
+		hdr->dst_node_id = cpu_to_le32(to->sq_node);
+		hdr->dst_port_id = cpu_to_le32(to->sq_port);
+	}
 
 	hdr->size = cpu_to_le32(len);
 	hdr->confirm_rx = 0;


