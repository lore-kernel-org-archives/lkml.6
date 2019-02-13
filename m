Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91078C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E31720835
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550026538;
	bh=FyeuQQSdyN9WHyHcgeVNvSocPg0cKfrOg0UCO7NBf7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sO86TrMUcU5ijUD4pu+KgktYsAif1pjikzk2Qlkb0GlKD52PQSEfwuUotYIKcaX1P
	 PM+bcDRDz/iBSSE+/VMPWGCeWKxXXDLbIQusKW0Jye/rrlx2qh1cu9zt9w9rtHrz7g
	 aD2QadBgGqbEB5FZWs61jCqDHxQOwRuKUSPyzquE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732777AbfBMChb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:37:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:39184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388018AbfBMCf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:35:29 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3453206B6;
        Wed, 13 Feb 2019 02:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025328;
        bh=FyeuQQSdyN9WHyHcgeVNvSocPg0cKfrOg0UCO7NBf7Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x4Jssm3gg5TP7JQ/wTCMAVmgfGTwTTo82QPOvmcX8xBv2WLEI0Gr6wSO3hwAot+Ak
         ve0Pha6RVE6eexP2ZR9fS4MaW2UduI63QF/ya1h4qSM5jPOVXIVPlzn5U1PhATZMQf
         CkmP+mMwUpP2ymayh7CBwr37i6Tf4RCqTd7CFyhI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Krzysztof Kazimierczak <krzysztof.kazimierczak@intel.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        xdp-newbies@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 072/105] xsk: Check if a queue exists during umem setup
Date:   Tue, 12 Feb 2019 21:33:03 -0500
Message-Id: <20190213023336.19019-72-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023336.19019-1-sashal@kernel.org>
References: <20190213023336.19019-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kazimierczak <krzysztof.kazimierczak@intel.com>

[ Upstream commit cc5b5d3565048ae57d14e5674a5fb085b2ab0193 ]

In the xdp_umem_assign_dev() path, the xsk code does not
check if a queue for which umem is to be created exists.
It leads to a situation where umem is not assigned to any
Tx/Rx queue of a netdevice, without notifying the stack
about an error. This affects both XDP_SKB and XDP_DRV
modes - in case of XDP_DRV_ZC, queue index is checked by
the driver.

This patch fixes xsk code, so that in both XDP_SKB and
XDP_DRV mode of AF_XDP, an error is returned when requested
queue index exceedes an existing maximum.

Fixes: c9b47cc1fabca ("xsk: fix bug when trying to use both copy and zero-copy on one queue id")
Reported-by: Jakub Spizewski <jakub.spizewski@intel.com>
Signed-off-by: Krzysztof Kazimierczak <krzysztof.kazimierczak@intel.com>
Acked-by: Björn Töpel <bjorn.topel@intel.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xdp/xdp_umem.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
index a264cf2accd0..d4de871e7d4d 100644
--- a/net/xdp/xdp_umem.c
+++ b/net/xdp/xdp_umem.c
@@ -41,13 +41,20 @@ void xdp_del_sk_umem(struct xdp_umem *umem, struct xdp_sock *xs)
  * not know if the device has more tx queues than rx, or the opposite.
  * This might also change during run time.
  */
-static void xdp_reg_umem_at_qid(struct net_device *dev, struct xdp_umem *umem,
-				u16 queue_id)
+static int xdp_reg_umem_at_qid(struct net_device *dev, struct xdp_umem *umem,
+			       u16 queue_id)
 {
+	if (queue_id >= max_t(unsigned int,
+			      dev->real_num_rx_queues,
+			      dev->real_num_tx_queues))
+		return -EINVAL;
+
 	if (queue_id < dev->real_num_rx_queues)
 		dev->_rx[queue_id].umem = umem;
 	if (queue_id < dev->real_num_tx_queues)
 		dev->_tx[queue_id].umem = umem;
+
+	return 0;
 }
 
 struct xdp_umem *xdp_get_umem_from_qid(struct net_device *dev,
@@ -88,7 +95,10 @@ int xdp_umem_assign_dev(struct xdp_umem *umem, struct net_device *dev,
 		goto out_rtnl_unlock;
 	}
 
-	xdp_reg_umem_at_qid(dev, umem, queue_id);
+	err = xdp_reg_umem_at_qid(dev, umem, queue_id);
+	if (err)
+		goto out_rtnl_unlock;
+
 	umem->dev = dev;
 	umem->queue_id = queue_id;
 	if (force_copy)
-- 
2.19.1

