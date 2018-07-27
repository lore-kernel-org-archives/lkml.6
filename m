Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE9CC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F179A2089F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:12:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F179A2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389515AbeG0LdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:33:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36978 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729547AbeG0LdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:33:22 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id AC56ACB5;
        Fri, 27 Jul 2018 10:12:09 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Tariq Toukan <tariqt@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 03/23] net/mlx4_core: Save the qpn from the input modifier in RST2INIT wrapper
Date:   Fri, 27 Jul 2018 12:09:04 +0200
Message-Id: <20180727100845.315516288@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727100845.054377089@linuxfoundation.org>
References: <20180727100845.054377089@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jack Morgenstein <jackm@dev.mellanox.co.il>

[ Upstream commit 958c696f5a7274d9447a458ad7aa70719b29a50a ]

Function mlx4_RST2INIT_QP_wrapper saved the qp number passed in the qp
context, rather than the one passed in the input modifier.

However, the qp number in the qp context is not defined as a
required parameter by the FW. Therefore, drivers may choose to not
specify the qp number in the qp context for the reset-to-init transition.

Thus, we must save the qp number passed in the command input modifier --
which is always present. (This saved qp number is used as the input
modifier for command 2RST_QP when a slave's qp's are destroyed).

Fixes: c82e9aa0a8bc ("mlx4_core: resource tracking for HCA resources used by guests")
Signed-off-by: Jack Morgenstein <jackm@dev.mellanox.co.il>
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx4/resource_tracker.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlx4/resource_tracker.c
+++ b/drivers/net/ethernet/mellanox/mlx4/resource_tracker.c
@@ -2891,7 +2891,7 @@ int mlx4_RST2INIT_QP_wrapper(struct mlx4
 	u32 srqn = qp_get_srqn(qpc) & 0xffffff;
 	int use_srq = (qp_get_srqn(qpc) >> 24) & 1;
 	struct res_srq *srq;
-	int local_qpn = be32_to_cpu(qpc->local_qpn) & 0xffffff;
+	int local_qpn = vhcr->in_modifier & 0xffffff;
 
 	err = adjust_qp_sched_queue(dev, slave, qpc, inbox);
 	if (err)


