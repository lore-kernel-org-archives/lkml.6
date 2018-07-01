Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14510C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEED0253A3
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:40:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEED0253A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031989AbeGAQk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:40:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37266 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031568AbeGAQky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:40:54 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D3309ACC;
        Sun,  1 Jul 2018 16:40:53 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Bloch <markb@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: [PATCH 4.17 095/220] IB/uverbs: Fix ordering of ucontext check in ib_uverbs_write
Date:   Sun,  1 Jul 2018 18:21:59 +0200
Message-Id: <20180701160912.380230391@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Gunthorpe <jgg@mellanox.com>

commit 1eb9364ce81d9445ad6f9d44921a91d2a6597156 upstream.

During disassociation the ucontext will become NULL, however due to how
the SRCU locking works the ucontext must only be examined after looking
at the ib_dev, which governs the RCU control flow.

With the wrong ordering userspace will see EINVAL instead of EIO for a
disassociated uverbs FD, which breaks rdma-core.

Cc: stable@vger.kernel.org
Fixes: 491d5c6a3023 ("RDMA/uverbs: Move uncontext check before SRCU read lock")
Reported-by: Mark Bloch <markb@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/core/uverbs_main.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -734,10 +734,6 @@ static ssize_t ib_uverbs_write(struct fi
 	if (ret)
 		return ret;
 
-	if (!file->ucontext &&
-	    (command != IB_USER_VERBS_CMD_GET_CONTEXT || extended))
-		return -EINVAL;
-
 	if (extended) {
 		if (count < (sizeof(hdr) + sizeof(ex_hdr)))
 			return -EINVAL;
@@ -757,6 +753,16 @@ static ssize_t ib_uverbs_write(struct fi
 		goto out;
 	}
 
+	/*
+	 * Must be after the ib_dev check, as once the RCU clears ib_dev ==
+	 * NULL means ucontext == NULL
+	 */
+	if (!file->ucontext &&
+	    (command != IB_USER_VERBS_CMD_GET_CONTEXT || extended)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	if (!verify_command_mask(ib_dev, command, extended)) {
 		ret = -EOPNOTSUPP;
 		goto out;


