Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1F1C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C0B621841
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217760;
	bh=zAUjmbnakdEAOukMuAN6RDNYv+t9bSVX6jLwyYqrXWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FF3WB87LayiVvLqsNXiSg7j6U3iUeAOT4o5n4x323QwVNBCrETCYh5aulJEksqrQW
	 YH3NTQ//3Iyk0Og1w9eIX9vEdElyI7KB+RSI3XjapntuXd0zuEa4Sd1DQoKo2sBw4L
	 ROQawfj/ak1hA3+adR8uACpXcXKNhKPTTEx09mls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404209AbfAKOmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:42:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:35350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404166AbfAKOme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:42:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D7FB2063F;
        Fri, 11 Jan 2019 14:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217753;
        bh=zAUjmbnakdEAOukMuAN6RDNYv+t9bSVX6jLwyYqrXWw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MKBPA0enNvM1xfy7MRpe1EaSCee5QMFapLbWKSZprnsEX10qyYKkkfGbLWgSifKBO
         ibc8MpE9rYzroQEHGS9Qg2L3+HnpfV/eWVqU24QQzJvVUEb58XpwHloxGEFcxG3h2k
         hBjJ/TIXqkxNXjuy8Ls/Aer6l4N8z1c/rSlDXH5g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.20 28/65] dm: do not allow readahead to limit IO size
Date:   Fri, 11 Jan 2019 15:15:14 +0100
Message-Id: <20190111131100.218159212@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131055.331350141@linuxfoundation.org>
References: <20190111131055.331350141@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jaegeuk Kim <jaegeuk@kernel.org>

commit c6d6e9b0f6b4201c77f2cea3964dd122697e3543 upstream.

Update DM to set the bdi's io_pages.  This fixes reads to be capped at
the device's max request size (even if user's read IO exceeds the
established readahead setting).

Fixes: 9491ae4a ("mm: don't cap request size based on read-ahead setting")
Cc: stable@vger.kernel.org
Reviewed-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-table.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1927,6 +1927,9 @@ void dm_table_set_restrictions(struct dm
 	 */
 	if (blk_queue_is_zoned(q))
 		blk_revalidate_disk_zones(t->md->disk);
+
+	/* Allow reads to exceed readahead limits */
+	q->backing_dev_info->io_pages = limits->max_sectors >> (PAGE_SHIFT - 9);
 }
 
 unsigned int dm_table_get_num_targets(struct dm_table *t)


