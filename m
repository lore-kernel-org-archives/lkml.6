Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E337C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13EA4208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:40:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13EA4208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407976AbeHATSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:18:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52872 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389912AbeHATSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:18:35 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 05E9CD57;
        Wed,  1 Aug 2018 17:31:50 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, syzkaller <syzkaller@googlegroups.com>,
        Noa Osherovich <noaos@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.9 140/144] RDMA/uverbs: Protect from attempts to create flows on unsupported QP
Date:   Wed,  1 Aug 2018 18:52:47 +0200
Message-Id: <20180801164958.972920598@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801164949.023217860@linuxfoundation.org>
References: <20180801164949.023217860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

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

Cc: <stable@vger.kernel.org> # 3.11
Fixes: 436f2ad05a0b ("IB/core: Export ib_create/destroy_flow through uverbs")
Cc: syzkaller <syzkaller@googlegroups.com>
Reported-by: Noa Osherovich <noaos@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/core/uverbs_cmd.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -3725,6 +3725,11 @@ int ib_uverbs_ex_create_flow(struct ib_u
 		goto err_uobj;
 	}
 
+	if (qp->qp_type != IB_QPT_UD && qp->qp_type != IB_QPT_RAW_PACKET) {
+		err = -EINVAL;
+		goto err_put;
+	}
+
 	flow_attr = kzalloc(sizeof(*flow_attr) + cmd.flow_attr.num_of_specs *
 			    sizeof(union ib_flow_spec), GFP_KERNEL);
 	if (!flow_attr) {


