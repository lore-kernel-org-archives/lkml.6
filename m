Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8A6C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 732D02183F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216366;
	bh=ezxktuBPXy+XkMrISUMKTKcZKAUUO/sN2tn/dizpP50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CseUPJ/Ci36EeAoLwu3MDL00vft5nqwWiUrEVbiJTzWzowmSuOSNOQhn/jTAzbZWI
	 /oyJ6WAQe0Fx2zjoIJXP89LtYnXpOVkM2zLCey7QKQ0mBxICrxUY+zs03Ili26wte9
	 3/vUGiwmRMllaLeavybIrMsuwVgSinkCP4af0uxA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731807AbfAKOTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:19:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:36192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731683AbfAKOTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:19:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 538DD2177B;
        Fri, 11 Jan 2019 14:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216358;
        bh=ezxktuBPXy+XkMrISUMKTKcZKAUUO/sN2tn/dizpP50=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zMUY/eJj1SJ21Wbt/msSYNUCffURVsjIhvrpr7xGrCzzYMHT0yk0G3HGfVJgxY84L
         YbdwTWcelZLpBw7NWxe5aymOkPj5r0JyfbPm3WtYzBZ6d2MwBeuJLNRq/7ERwrXa2C
         ArqTsFPK+OrIR1GWBoCYLsNmYLHD3JykUHGtPXO8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Omar Sandoval <osandov@fb.com>, Jens Axboe <axboe@kernel.dk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.4 71/88] block: break discard submissions into the user defined size
Date:   Fri, 11 Jan 2019 15:08:40 +0100
Message-Id: <20190111131057.981935488@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131045.137499039@linuxfoundation.org>
References: <20190111131045.137499039@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jens Axboe <axboe@kernel.dk>

commit af097f5d199e2aa3ab3ef777f0716e487b8f7b08 upstream.

Don't build discards bigger than what the user asked for, if the
user decided to limit the size by writing to 'discard_max_bytes'.

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Reviewed-by: Omar Sandoval <osandov@fb.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/blk-lib.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -81,8 +81,14 @@ int blkdev_issue_discard(struct block_de
 			break;
 		}
 
-		/* Make sure bi_size doesn't overflow */
-		req_sects = min_t(sector_t, nr_sects, UINT_MAX >> 9);
+		/*
+		 * Issue in chunks of the user defined max discard setting,
+		 * ensuring that bi_size doesn't overflow
+		 */
+		req_sects = min_t(sector_t, nr_sects,
+					q->limits.max_discard_sectors);
+		if (req_sects > UINT_MAX >> 9)
+			req_sects = UINT_MAX >> 9;
 
 		/*
 		 * If splitting a request, and the next starting sector would be


