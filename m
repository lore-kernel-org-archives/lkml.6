Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70AAC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E07C20864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:26:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E07C20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966273AbeFRI0r (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:26:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57428 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966243AbeFRI0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:26:42 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 36014C5C;
        Mon, 18 Jun 2018 08:26:42 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Michal Kalderon <Michal.Kalderon@cavium.com>,
        Sudarsana Kalluru <Sudarsana.Kalluru@cavium.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 214/279] qede: Fix gfp flags sent to rdma event node allocation
Date:   Mon, 18 Jun 2018 10:13:19 +0200
Message-Id: <20180618080617.723405501@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Kalderon <Michal.Kalderon@cavium.com>

[ Upstream commit 090477e4acb31c5dd674940c7c01d4f16bd1ac41 ]

A previous commit 4609adc27175 ("qede: Fix qedr link update")
added a flow that could allocate rdma event objects from an
interrupt path (link notification). Therefore the kzalloc call
should be done with GFP_ATOMIC.

fixes: 4609adc27175 ("qede: Fix qedr link update")
Signed-off-by: Michal Kalderon <Michal.Kalderon@cavium.com>
Signed-off-by: Sudarsana Kalluru <Sudarsana.Kalluru@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qlogic/qede/qede_rdma.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/qlogic/qede/qede_rdma.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_rdma.c
@@ -238,7 +238,7 @@ qede_rdma_get_free_event_node(struct qed
 	}
 
 	if (!found) {
-		event_node = kzalloc(sizeof(*event_node), GFP_KERNEL);
+		event_node = kzalloc(sizeof(*event_node), GFP_ATOMIC);
 		if (!event_node) {
 			DP_NOTICE(edev,
 				  "qedr: Could not allocate memory for rdma work\n");


