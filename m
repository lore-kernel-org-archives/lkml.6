Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352EDC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 000AE20837
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:59:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 000AE20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbeLIV72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 16:59:28 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36186 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726742AbeLIVzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:38 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW730-0002ih-Rj; Sun, 09 Dec 2018 21:55:35 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72h-0003Y7-70; Sun, 09 Dec 2018 21:55:15 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Leon Romanovsky" <leonro@mellanox.com>,
        "Dennis Dalessandro" <dennis.dalessandro@intel.com>,
        "Daniel Jurgens" <danielj@mellanox.com>,
        "Jason Gunthorpe" <jgg@mellanox.com>,
        "Parav Pandit" <parav@mellanox.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.179233184@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 223/328] RDMA/cma: Protect cma dev list with lock
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

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

Fixes: f17df3b0dede ("RDMA/cma: Add support for AF_IB to rdma_resolve_addr()")
Signed-off-by: Parav Pandit <parav@mellanox.com>
Reviewed-by: Daniel Jurgens <danielj@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/infiniband/core/cma.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -434,6 +434,7 @@ static int cma_resolve_ib_dev(struct rdm
 	dgid = (union ib_gid *) &addr->sib_addr;
 	pkey = ntohs(addr->sib_pkey);
 
+	mutex_lock(&lock);
 	list_for_each_entry(cur_dev, &dev_list, list) {
 		if (rdma_node_get_transport(cur_dev->device->node_type) != RDMA_TRANSPORT_IB)
 			continue;
@@ -455,18 +456,19 @@ static int cma_resolve_ib_dev(struct rdm
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

