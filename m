Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6AEC04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 02:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45BA320834
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 02:01:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45BA320834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbeLANNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 08:13:05 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:46168 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726013AbeLANNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 08:13:05 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4664595B5515;
        Sat,  1 Dec 2018 10:01:42 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.408.0; Sat, 1 Dec 2018 10:01:37 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>
CC:     YueHaibing <yuehaibing@huawei.com>,
        <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] xen/pvcalls: remove set but not used variable 'bedata'
Date:   Sat, 1 Dec 2018 02:10:09 +0000
Message-ID: <1543630209-135108-1-git-send-email-yuehaibing@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/xen/pvcalls-front.c: In function 'pvcalls_front_sendmsg':
drivers/xen/pvcalls-front.c:506:25: warning:
 variable 'bedata' set but not used [-Wunused-but-set-variable]

drivers/xen/pvcalls-front.c: In function 'pvcalls_front_recvmsg':
drivers/xen/pvcalls-front.c:603:25: warning:
 variable 'bedata' set but not used [-Wunused-but-set-variable]

It never used since introduction.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/xen/pvcalls-front.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/xen/pvcalls-front.c b/drivers/xen/pvcalls-front.c
index 77224d8..223ad7b 100644
--- a/drivers/xen/pvcalls-front.c
+++ b/drivers/xen/pvcalls-front.c
@@ -503,7 +503,6 @@ static int __write_ring(struct pvcalls_data_intf *intf,
 int pvcalls_front_sendmsg(struct socket *sock, struct msghdr *msg,
 			  size_t len)
 {
-	struct pvcalls_bedata *bedata;
 	struct sock_mapping *map;
 	int sent, tot_sent = 0;
 	int count = 0, flags;
@@ -515,7 +514,6 @@ int pvcalls_front_sendmsg(struct socket *sock, struct msghdr *msg,
 	map = pvcalls_enter_sock(sock);
 	if (IS_ERR(map))
 		return PTR_ERR(map);
-	bedata = dev_get_drvdata(&pvcalls_front_dev->dev);
 
 	mutex_lock(&map->active.out_mutex);
 	if ((flags & MSG_DONTWAIT) && !pvcalls_front_write_todo(map)) {
@@ -600,7 +598,6 @@ static int __read_ring(struct pvcalls_data_intf *intf,
 int pvcalls_front_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		     int flags)
 {
-	struct pvcalls_bedata *bedata;
 	int ret;
 	struct sock_mapping *map;
 
@@ -610,7 +607,6 @@ int pvcalls_front_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 	map = pvcalls_enter_sock(sock);
 	if (IS_ERR(map))
 		return PTR_ERR(map);
-	bedata = dev_get_drvdata(&pvcalls_front_dev->dev);
 
 	mutex_lock(&map->active.in_mutex);
 	if (len > XEN_FLEX_RING_SIZE(PVCALLS_RING_ORDER))



