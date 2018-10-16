Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFB5C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0D8F2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:32:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0D8F2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbeJPWX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:23:28 -0400
Received: from gateway34.websitewelcome.com ([192.185.148.200]:14640 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726760AbeJPWX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:23:28 -0400
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 285CA778C4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 09:32:44 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id CQOqgdM2NkBj6CQOqghwwC; Tue, 16 Oct 2018 09:32:44 -0500
X-Authority-Reason: nr=8
Received: from lns-bzn-40-82-251-138-249.adsl.proxad.net ([82.251.138.249]:47442 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gCQOp-003QwQ-HC; Tue, 16 Oct 2018 09:32:43 -0500
Date:   Tue, 16 Oct 2018 16:32:40 +0200
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] IB/ucm: Fix Spectre v1 vulnerability
Message-ID: <20181016143240.GA6087@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 82.251.138.249
X-Source-L: No
X-Exim-ID: 1gCQOp-003QwQ-HC
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: lns-bzn-40-82-251-138-249.adsl.proxad.net (embeddedor) [82.251.138.249]:47442
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hdr.cmd can be indirectly controlled by user-space, hence leading to
a potential exploitation of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:

drivers/infiniband/core/ucm.c:1127 ib_ucm_write() warn: potential
spectre issue 'ucm_cmd_table' [r] (local cap)

Fix this by sanitizing hdr.cmd before using it to index
ucm_cmd_table.

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/infiniband/core/ucm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/core/ucm.c b/drivers/infiniband/core/ucm.c
index faa9e61..73332b9 100644
--- a/drivers/infiniband/core/ucm.c
+++ b/drivers/infiniband/core/ucm.c
@@ -46,6 +46,8 @@
 #include <linux/mutex.h>
 #include <linux/slab.h>
 
+#include <linux/nospec.h>
+
 #include <linux/uaccess.h>
 
 #include <rdma/ib.h>
@@ -1120,6 +1122,7 @@ static ssize_t ib_ucm_write(struct file *filp, const char __user *buf,
 
 	if (hdr.cmd >= ARRAY_SIZE(ucm_cmd_table))
 		return -EINVAL;
+	hdr.cmd = array_index_nospec(hdr.cmd, ARRAY_SIZE(ucm_cmd_table));
 
 	if (hdr.in + sizeof(hdr) > len)
 		return -EINVAL;
-- 
2.7.4

