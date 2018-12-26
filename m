Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0046C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 09:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A34B02148E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 09:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731984AbeL1J5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 04:57:43 -0500
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:39117 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729749AbeL1J5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 04:57:43 -0500
Received: from localhost.localdomain ([90.126.241.217])
        by mwinf5d25 with ME
        id HMxa1z0094i89ZE03Mxae3; Fri, 28 Dec 2018 10:57:39 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 28 Dec 2018 10:57:39 +0100
X-ME-IP: 90.126.241.217
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        rppt@linux.vnet.ibm.com, akpm@linux-foundation.org,
        yuehaibing@huawei.com, keescook@chromium.org
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 1/2] um: vector: Fix a potential NULL pointer dereference in 'vector_net_open()'
Date:   Wed, 26 Dec 2018 08:54:36 +0100
Message-Id: <20181226075436.11018-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'create_queue()' returns NULL in case of memory allocation failure. So we
must check if it succeeds in order to avoid potential NULL pointer
dereference.

For 'vp->rx_queue', the dereference would occur just one line after the
failed allocation. For 'vp->tx_queue', it would occur later during normal
processing.

Fixes: 49da7e64f33e ("High Performance UML Vector Network Driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 arch/um/drivers/vector_kern.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index 046fa9ea0ccc..5b917716289d 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -1182,6 +1182,8 @@ static int vector_net_open(struct net_device *dev)
 			vp->rx_header_size,
 			MAX_IOV_SIZE
 		);
+		if (!vp->rx_queue)
+			goto out_close;
 		vp->rx_queue->queue_depth = get_depth(vp->parsed);
 	} else {
 		vp->header_rxbuffer = kmalloc(
@@ -1198,6 +1200,8 @@ static int vector_net_open(struct net_device *dev)
 			vp->header_size,
 			MAX_IOV_SIZE
 		);
+		if (!vp->tx_queue)
+			goto out_close;
 	} else {
 		vp->header_txbuffer = kmalloc(vp->header_size, GFP_KERNEL);
 		if (vp->header_txbuffer == NULL)
-- 
2.19.1

