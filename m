Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428AEECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C7920989
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlRkDzV+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00C7920989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729301AbeKAIHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:07:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:56158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729279AbeKAIHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:07:54 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2029520840;
        Wed, 31 Oct 2018 23:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027263;
        bh=+HO/lVP/Q5O6sXq47kLAeDC4vHbyvLENQeQRCAFGzyc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hlRkDzV+3VqseZUh8djxSDXnESp5yXm6/gd7rexLhKArunz5hCcorhOKWI1Iktqcd
         sEuc0yNjj0/VkxS8cQMNCJ+Xq/oKQJmpOb9EX2Jk8CXrbGbeXHy4AK7tgzr6hJXUWQ
         xKjhVU1KJ7BAqp3dXaUtv8NJU5qJO2j8jYqEC2yM=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Moni Shoua <monis@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 135/146] IB/mlx5: Allow transition of DCI QP to reset
Date:   Wed, 31 Oct 2018 19:05:30 -0400
Message-Id: <20181031230541.28822-135-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230541.28822-1-sashal@kernel.org>
References: <20181031230541.28822-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/infiniband/hw/mlx5/qp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 6cba2a02d11b..d53d954ac8af 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -3243,7 +3243,9 @@ static bool modify_dci_qp_is_ok(enum ib_qp_state cur_state, enum ib_qp_state new
 	int req = IB_QP_STATE;
 	int opt = 0;
 
-	if (cur_state == IB_QPS_RESET && new_state == IB_QPS_INIT) {
+	if (new_state == IB_QPS_RESET) {
+		return is_valid_mask(attr_mask, req, opt);
+	} else if (cur_state == IB_QPS_RESET && new_state == IB_QPS_INIT) {
 		req |= IB_QP_PKEY_INDEX | IB_QP_PORT;
 		return is_valid_mask(attr_mask, req, opt);
 	} else if (cur_state == IB_QPS_INIT && new_state == IB_QPS_INIT) {
-- 
2.17.1

