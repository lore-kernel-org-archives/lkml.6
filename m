Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F6AC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B03C2080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:06:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B03C2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731352AbeKLFze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:55:34 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51900 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730739AbeKLFzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:55:33 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsx-0000oP-8b; Sun, 11 Nov 2018 19:59:07 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsU-0001dZ-DB; Sun, 11 Nov 2018 19:58:38 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Leon Romanovsky" <leonro@mellanox.com>,
        "Noa Osherovich" <noaos@mellanox.com>,
        "syzkaller" <syzkaller@googlegroups.com>,
        "Jason Gunthorpe" <jgg@mellanox.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.618716352@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 198/366] RDMA/uverbs: Protect from attempts to create
 flows on unsupported QP
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Leon Romanovsky <leonro@mellanox.com>

commit 940efcc8889f0d15567eb07fc9fd69b06e366aa5 upstream.

Flows can be created on UD and RAW_PACKET QP types. Attempts to provide
other QP types as an input causes to various unpredictable failures.

The reason is that in order to support all various types (e.g. XRC), we
are supposed to use real_qp handle and not qp handle and expect to
driver/FW to fail such (XRC) flows. The simpler and safer variant is to
ban all QP types except UD and RAW_PACKET, instead of relying on
driver/FW.

Fixes: 436f2ad05a0b ("IB/core: Export ib_create/destroy_flow through uverbs")
Cc: syzkaller <syzkaller@googlegroups.com>
Reported-by: Noa Osherovich <noaos@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/infiniband/core/uverbs_cmd.c | 5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -2740,6 +2740,11 @@ int ib_uverbs_ex_create_flow(struct ib_u
 		goto err_uobj;
 	}
 
+	if (qp->qp_type != IB_QPT_UD && qp->qp_type != IB_QPT_RAW_PACKET) {
+		err = -EINVAL;
+		goto err_put;
+	}
+
 	flow_attr = kmalloc(sizeof(*flow_attr) + cmd.flow_attr.size, GFP_KERNEL);
 	if (!flow_attr) {
 		err = -ENOMEM;

