Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD051C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A90208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:34:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1A90208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389221AbeGJSeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:34:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47992 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388417AbeGJSeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:34:19 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3DC07E3D;
        Tue, 10 Jul 2018 18:34:06 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mike Snitzer <snitzer@redhat.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: [PATCH 4.14 45/53] dm: set QUEUE_FLAG_DAX accordingly in dm_table_set_restrictions()
Date:   Tue, 10 Jul 2018 20:25:21 +0200
Message-Id: <20180710182501.354318085@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710182458.736721865@linuxfoundation.org>
References: <20180710182458.736721865@linuxfoundation.org>
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

From: Mike Snitzer <snitzer@redhat.com>

commit ad3793fc3945173f64d82d05d3ecde41f6c0435c upstream.

Rather than having DAX support be unique by setting it based on table
type in dm_setup_md_queue().

Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/dm-table.c |    2 ++
 drivers/md/dm.c       |    3 ---
 2 files changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1813,6 +1813,8 @@ void dm_table_set_restrictions(struct dm
 	}
 	blk_queue_write_cache(q, wc, fua);
 
+	if (dm_table_supports_dax(t))
+		queue_flag_set_unlocked(QUEUE_FLAG_DAX, q);
 	if (dm_table_supports_dax_write_cache(t))
 		dax_write_cache(t->md->dax_dev, true);
 
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2050,9 +2050,6 @@ int dm_setup_md_queue(struct mapped_devi
 		 */
 		bioset_free(md->queue->bio_split);
 		md->queue->bio_split = NULL;
-
-		if (type == DM_TYPE_DAX_BIO_BASED)
-			queue_flag_set_unlocked(QUEUE_FLAG_DAX, md->queue);
 		break;
 	case DM_TYPE_NONE:
 		WARN_ON_ONCE(true);


