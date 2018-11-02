Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF3AC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19BF420847
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tlyjIZ/h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19BF420847
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730119AbeKCDxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:53:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:48668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729136AbeKCDxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:53:08 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24B4E20847;
        Fri,  2 Nov 2018 18:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184295;
        bh=qLvrr1TVP6a9IjcTjb+pUqpMJb/4dk8buReP5SwMEro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tlyjIZ/hk+Ga69JPFoE3xouZ3XwMNRvOMnrgwzByodIPZN9B4kOpKJDZ2srkzsQ7G
         qyIMsFYWlmHWkUQmxrWRo2B7ETQUvZ1ETq+dsaDi2TVmNAA3WsNZsXBIlb6IkSk2y4
         4VjjEKR+8LVsKaUOmInC1q6OwerS59b/gAPMKvZU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Huy Nguyen <huyn@mellanox.com>,
        Eli Cohen <eli@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.18 127/150] net/mlx5: Take only bit 24-26 of wqe.pftype_wq for page fault type
Date:   Fri,  2 Nov 2018 19:34:49 +0100
Message-Id: <20181102182911.689678650@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huy Nguyen <huyn@mellanox.com>

[ Upstream commit a48bc513159d4767f9988f0d857b2b0c38a4d614 ]

The HW spec defines only bits 24-26 of pftype_wq as the page fault type,
use the required mask to ensure that.

Fixes: d9aaed838765 ("{net,IB}/mlx5: Refactor page fault handling")
Signed-off-by: Huy Nguyen <huyn@mellanox.com>
Signed-off-by: Eli Cohen <eli@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/eq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
@@ -269,7 +269,7 @@ static void eq_pf_process(struct mlx5_eq
 		case MLX5_PFAULT_SUBTYPE_WQE:
 			/* WQE based event */
 			pfault->type =
-				be32_to_cpu(pf_eqe->wqe.pftype_wq) >> 24;
+				(be32_to_cpu(pf_eqe->wqe.pftype_wq) >> 24) & 0x7;
 			pfault->token =
 				be32_to_cpu(pf_eqe->wqe.token);
 			pfault->wqe.wq_num =


