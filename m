Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFC8C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBB572083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:03:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBB572083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731977AbeHATt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:49:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49804 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405873AbeHATIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:08:38 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F26D91342;
        Wed,  1 Aug 2018 17:12:32 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bart Van Assche <bart.vanassche@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.14 006/246] drivers/infiniband/ulp/srpt/ib_srpt.c: fix build with gcc-4.4.4
Date:   Wed,  1 Aug 2018 18:48:36 +0200
Message-Id: <20180801165012.008693768@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165011.700991984@linuxfoundation.org>
References: <20180801165011.700991984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrew Morton <akpm@linux-foundation.org>

commit 06892cc190550807d332c95a0114c7e175584012 upstream.

gcc-4.4.4 has issues with initialization of anonymous unions:

drivers/infiniband/ulp/srpt/ib_srpt.c: In function 'srpt_zerolength_write':
drivers/infiniband/ulp/srpt/ib_srpt.c:854: error: unknown field 'wr_cqe' specified in initializer
drivers/infiniband/ulp/srpt/ib_srpt.c:854: warning: initialization makes integer from pointer without a cast

Work aound this.

Fixes: 2a78cb4db487 ("IB/srpt: Fix an out-of-bounds stack access in srpt_zerolength_write()")
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -790,8 +790,9 @@ static int srpt_zerolength_write(struct
 	struct ib_send_wr *bad_wr;
 	struct ib_rdma_wr wr = {
 		.wr = {
+			.next		= NULL,
+			{ .wr_cqe	= &ch->zw_cqe, },
 			.opcode		= IB_WR_RDMA_WRITE,
-			.wr_cqe		= &ch->zw_cqe,
 			.send_flags	= IB_SEND_SIGNALED,
 		}
 	};


