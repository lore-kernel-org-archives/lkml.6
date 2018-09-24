Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0B5C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0F2320877
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:02:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0F2320877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730552AbeIXSDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:03:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53660 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729771AbeIXSDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:03:46 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F22FAD64;
        Mon, 24 Sep 2018 12:01:58 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Parav Pandit <parav@mellanox.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.9 047/111] RDMA/cma: Protect cma dev list with lock
Date:   Mon, 24 Sep 2018 13:52:14 +0200
Message-Id: <20180924113109.746674313@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.337261320@linuxfoundation.org>
References: <20180924113103.337261320@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Parav Pandit <parav@mellanox.com>

commit 954a8e3aea87e896e320cf648c1a5bbe47de443e upstream.

When AF_IB addresses are used during rdma_resolve_addr() a lock is not
held. A cma device can get removed while list traversal is in progress
which may lead to crash. ie

        CPU0                                     CPU1
        ====                                     ====
rdma_resolve_addr()
 cma_resolve_ib_dev()
  list_for_each()                         cma_remove_one()
    cur_dev->device                        mutex_lock(&lock)
                                            list_del();
                                           mutex_unlock(&lock);
                                           cma_process_remove();


Therefore, hold a lock while traversing the list which avoids such
situation.

Cc: <stable@vger.kernel.org> # 3.10
Fixes: f17df3b0dede ("RDMA/cma: Add support for AF_IB to rdma_resolve_addr()")
Signed-off-by: Parav Pandit <parav@mellanox.com>
Reviewed-by: Daniel Jurgens <danielj@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/core/cma.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -673,6 +673,7 @@ static int cma_resolve_ib_dev(struct rdm
 	dgid = (union ib_gid *) &addr->sib_addr;
 	pkey = ntohs(addr->sib_pkey);
 
+	mutex_lock(&lock);
 	list_for_each_entry(cur_dev, &dev_list, list) {
 		for (p = 1; p <= cur_dev->device->phys_port_cnt; ++p) {
 			if (!rdma_cap_af_ib(cur_dev->device, p))
@@ -696,18 +697,19 @@ static int cma_resolve_ib_dev(struct rdm
 					cma_dev = cur_dev;
 					sgid = gid;
 					id_priv->id.port_num = p;
+					goto found;
 				}
 			}
 		}
 	}
-
-	if (!cma_dev)
-		return -ENODEV;
+	mutex_unlock(&lock);
+	return -ENODEV;
 
 found:
 	cma_attach_to_dev(id_priv, cma_dev);
-	addr = (struct sockaddr_ib *) cma_src_addr(id_priv);
-	memcpy(&addr->sib_addr, &sgid, sizeof sgid);
+	mutex_unlock(&lock);
+	addr = (struct sockaddr_ib *)cma_src_addr(id_priv);
+	memcpy(&addr->sib_addr, &sgid, sizeof(sgid));
 	cma_translate_ib(addr, &id_priv->id.route.addr.dev_addr);
 	return 0;
 }


