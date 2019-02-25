Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F4EC10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D122021848
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130347;
	bh=pwTJi5CspWCLqkxb9AsFpR0MRxiF9on9h1nvBZDnZYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NVYYdgkSmNXF7P7vTKb2u9Kzr+DFuyylsQFtJqOoghRYghxkacP1A4vO5fYbxwyW2
	 O14MeZatliK4L9njXX3y5GfjFiGh+SGexM4VOom+YdNyJQl8V6H/53XH4R+zaOQFMW
	 Dr9owoVYT/RDrJ0aFrZz8TzRpzOalwRtXOUTKFqk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732490AbfBYVc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:32:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:37918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731459AbfBYVcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:32:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DABE021841;
        Mon, 25 Feb 2019 21:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130344;
        bh=pwTJi5CspWCLqkxb9AsFpR0MRxiF9on9h1nvBZDnZYc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z22pjbLCVUlnOLrPV7IUaDVyD5xaDuCtTr7Ifil6/3SolMoi1Z0aHrQ+2WNg1y3i0
         t7G1P8D6MkV51qOTlbOopxZzNxKz6f3OohzOZe1c5rhGsrQk0S8ianCoxP0F8Bcyo5
         fGiDJpFJemrqawZZZj8B1POP9FmvXnzxHJ633oXI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jakub Spizewski <jakub.spizewski@intel.com>,
        Krzysztof Kazimierczak <krzysztof.kazimierczak@intel.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 090/183] xsk: Check if a queue exists during umem setup
Date:   Mon, 25 Feb 2019 22:11:03 +0100
Message-Id: <20190225195109.786461366@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index a264cf2accd0f..d4de871e7d4d7 100644
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



