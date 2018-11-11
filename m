Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECBCC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 819A220818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hl/GuzrL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 819A220818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387844AbeKLITh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:19:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:41392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387789AbeKLITg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:19:36 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8171F21707;
        Sun, 11 Nov 2018 22:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975379;
        bh=LLp2VpfnlYwcA/m4dKaXbe+57v2j4S9vhXjot2vCt+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hl/GuzrLdRoQEBDyPJTu/UUCxv9f9/IKvRlDFpTFjhUIX0feBITfoeCDHUdFyCB5N
         s5A9tYt+jU5O6iVgOxWOIDRodXJejtzdqo4bxnDaPnWfucxnd2O5cZr08/yWaRpLeM
         gPDre4PwMcIEQMsJhQy5z3hKqK3LZsIYPiF/w3vE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mike Snitzer <snitzer@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Xiao Ni <xni@redhat.com>,
        Mariusz Dabrowski <mariusz.dabrowski@intel.com>,
        Rui Salvaterra <rsalvaterra@gmail.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.18 015/350] block: make sure discard bio is aligned with logical block size
Date:   Sun, 11 Nov 2018 14:17:59 -0800
Message-Id: <20181111221707.810285812@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming Lei <ming.lei@redhat.com>

commit 1adfc5e4136f5967d591c399aff95b3b035f16b7 upstream.

Obviously the created discard bio has to be aligned with logical block size.

This patch introduces the helper of bio_allowed_max_sectors() for
this purpose.

Cc: stable@vger.kernel.org
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Xiao Ni <xni@redhat.com>
Cc: Mariusz Dabrowski <mariusz.dabrowski@intel.com>
Fixes: 744889b7cbb56a6 ("block: don't deal with discard limit in blkdev_issue_discard()")
Fixes: a22c4d7e34402cc ("block: re-add discard_granularity and alignment checks")
Reported-by: Rui Salvaterra <rsalvaterra@gmail.com>
Tested-by: Rui Salvaterra <rsalvaterra@gmail.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/blk-lib.c   |    3 +--
 block/blk-merge.c |    3 ++-
 block/blk.h       |   10 ++++++++++
 3 files changed, 13 insertions(+), 3 deletions(-)

--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -58,8 +58,7 @@ int __blkdev_issue_discard(struct block_
 
 		if (!req_sects)
 			goto fail;
-		if (req_sects > UINT_MAX >> 9)
-			req_sects = UINT_MAX >> 9;
+		req_sects = min(req_sects, bio_allowed_max_sectors(q));
 
 		end_sect = sector + req_sects;
 
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -27,7 +27,8 @@ static struct bio *blk_bio_discard_split
 	/* Zero-sector (unknown) and one-sector granularities are the same.  */
 	granularity = max(q->limits.discard_granularity >> 9, 1U);
 
-	max_discard_sectors = min(q->limits.max_discard_sectors, UINT_MAX >> 9);
+	max_discard_sectors = min(q->limits.max_discard_sectors,
+			bio_allowed_max_sectors(q));
 	max_discard_sectors -= max_discard_sectors % granularity;
 
 	if (unlikely(!max_discard_sectors)) {
--- a/block/blk.h
+++ b/block/blk.h
@@ -327,6 +327,16 @@ static inline unsigned long blk_rq_deadl
 }
 
 /*
+ * The max size one bio can handle is UINT_MAX becasue bvec_iter.bi_size
+ * is defined as 'unsigned int', meantime it has to aligned to with logical
+ * block size which is the minimum accepted unit by hardware.
+ */
+static inline unsigned int bio_allowed_max_sectors(struct request_queue *q)
+{
+	return round_down(UINT_MAX, queue_logical_block_size(q)) >> 9;
+}
+
+/*
  * Internal io_context interface
  */
 void get_io_context(struct io_context *ioc);


