Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DD3ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFF8A206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:39:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFF8A206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387918AbeGPIFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:05:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47094 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbeGPIFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:05:18 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 381ECC03;
        Mon, 16 Jul 2018 07:39:17 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Tony Battersby <tonyb@cybernetics.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.17 51/67] bsg: fix bogus EINVAL on non-data commands
Date:   Mon, 16 Jul 2018 09:35:20 +0200
Message-Id: <20180716073451.554302298@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716073443.294323458@linuxfoundation.org>
References: <20180716073443.294323458@linuxfoundation.org>
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

From: Tony Battersby <tonyb@cybernetics.com>

commit 70dbcc2254fa2a9add74a122b9dac954c4736e01 upstream.

Fix a regression introduced in Linux kernel 4.17 where sending a SCSI
command that does not transfer data (such as TEST UNIT READY) via
/dev/bsg/* results in EINVAL.

Fixes: 17cb960f29c2 ("bsg: split handling of SCSI CDBs vs transport requeues")
Cc: <stable@vger.kernel.org> # 4.17+
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/bsg.c |    2 --
 1 file changed, 2 deletions(-)

--- a/block/bsg.c
+++ b/block/bsg.c
@@ -268,8 +268,6 @@ bsg_map_hdr(struct request_queue *q, str
 	} else if (hdr->din_xfer_len) {
 		ret = blk_rq_map_user(q, rq, NULL, uptr64(hdr->din_xferp),
 				hdr->din_xfer_len, GFP_KERNEL);
-	} else {
-		ret = blk_rq_map_user(q, rq, NULL, NULL, 0, GFP_KERNEL);
 	}
 
 	if (ret)


