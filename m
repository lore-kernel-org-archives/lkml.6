Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F18BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA49620866
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BfmqabT1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA49620866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732330AbeKLISB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:18:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:35400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732301AbeKLISA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:18:00 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E8A12154B;
        Sun, 11 Nov 2018 22:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975284;
        bh=dErEsMI3IKu091BW8mxPdoqnmg9ocM3AYVtPoWVrMtA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BfmqabT1syqPWyRfsSVWy6PtYvbmstnyz260y+l9eEeTPd/CIMd3CXBR1YhKwRSKd
         /rsa4Y2pXH7lmWmP82781s3MVQ93dLLFjbAM5g+JqePSSX9/t/mKo/S2L2bab4mnL1
         5iuqa+J4hR0aJyc3F2V2RAnC1qHZXV3vXzBkJf1A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Moni Shoua <monis@mellanox.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 179/361] IB/mlx5: Allow transition of DCI QP to reset
Date:   Sun, 11 Nov 2018 14:18:46 -0800
Message-Id: <20181111221645.321058753@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Moni Shoua <monis@mellanox.com>

[ Upstream commit 99ed748e878a99c6c7b87bbec063eefd9e47cb42 ]

The transition is allowed from any state and the atrribute mask must be
IB_QP_STATE.

Fixes: c32a4f296e1d ("IB/mlx5: Add support for DC Initiator QP")
Signed-off-by: Moni Shoua <monis@mellanox.com>
Reviewed-by: Artemy Kovalyov <artemyko@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/mlx5/qp.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -3243,7 +3243,9 @@ static bool modify_dci_qp_is_ok(enum ib_
 	int req = IB_QP_STATE;
 	int opt = 0;
 
-	if (cur_state == IB_QPS_RESET && new_state == IB_QPS_INIT) {
+	if (new_state == IB_QPS_RESET) {
+		return is_valid_mask(attr_mask, req, opt);
+	} else if (cur_state == IB_QPS_RESET && new_state == IB_QPS_INIT) {
 		req |= IB_QP_PKEY_INDEX | IB_QP_PORT;
 		return is_valid_mask(attr_mask, req, opt);
 	} else if (cur_state == IB_QPS_INIT && new_state == IB_QPS_INIT) {


