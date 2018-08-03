Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FF2C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 06:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16401216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 06:40:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16401216FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbeHCIes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 04:34:48 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10619 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726833AbeHCIer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 04:34:47 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A79A747C5AD49;
        Fri,  3 Aug 2018 14:39:56 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.399.0; Fri, 3 Aug 2018
 14:39:51 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <jdike@addtoit.com>, <richard@nod.at>,
        <anton.ivanov@cambridgegreys.com>, <christophe.jaillet@wanadoo.fr>,
        <keescook@chromium.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-um@lists.infradead.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] um: NULL check before kfree is not needed
Date:   Fri, 3 Aug 2018 14:39:11 +0800
Message-ID: <20180803063911.23384-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kfree(NULL) is safe,so this removes NULL check before freeing the mem

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 arch/um/drivers/vector_kern.c | 15 +++++----------
 arch/um/drivers/vector_user.c |  6 ++----
 arch/um/kernel/irq.c          |  3 +--
 3 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index 50ee3bb..c84133c 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -1118,16 +1118,11 @@ static int vector_net_close(struct net_device *dev)
 		os_close_file(vp->fds->tx_fd);
 		vp->fds->tx_fd = -1;
 	}
-	if (vp->bpf != NULL)
-		kfree(vp->bpf);
-	if (vp->fds->remote_addr != NULL)
-		kfree(vp->fds->remote_addr);
-	if (vp->transport_data != NULL)
-		kfree(vp->transport_data);
-	if (vp->header_rxbuffer != NULL)
-		kfree(vp->header_rxbuffer);
-	if (vp->header_txbuffer != NULL)
-		kfree(vp->header_txbuffer);
+	kfree(vp->bpf);
+	kfree(vp->fds->remote_addr);
+	kfree(vp->transport_data);
+	kfree(vp->header_rxbuffer);
+	kfree(vp->header_txbuffer);
 	if (vp->rx_queue != NULL)
 		destroy_queue(vp->rx_queue);
 	if (vp->tx_queue != NULL)
diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
index 4d6a78e..3d8cdbd 100644
--- a/arch/um/drivers/vector_user.c
+++ b/arch/um/drivers/vector_user.c
@@ -267,8 +267,7 @@ static struct vector_fds *user_init_raw_fds(struct arglist *ifspec)
 		os_close_file(rxfd);
 	if (txfd >= 0)
 		os_close_file(txfd);
-	if (result != NULL)
-		kfree(result);
+	kfree(result);
 	return NULL;
 }
 
@@ -434,8 +433,7 @@ static struct vector_fds *user_init_socket_fds(struct arglist *ifspec, int id)
 	if (fd >= 0)
 		os_close_file(fd);
 	if (result != NULL) {
-		if (result->remote_addr != NULL)
-			kfree(result->remote_addr);
+		kfree(result->remote_addr);
 		kfree(result);
 	}
 	return NULL;
diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
index 6b7f382..8360fa3 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -244,8 +244,7 @@ static void garbage_collect_irq_entries(void)
 			to_free = NULL;
 		}
 		walk = walk->next;
-		if (to_free != NULL)
-			kfree(to_free);
+		kfree(to_free);
 	}
 }
 
-- 
2.7.0


