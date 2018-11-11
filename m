Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86074C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 00:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4496421104
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 00:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vFUYHOvU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4496421104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbeKKKXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 05:23:13 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46858 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbeKKKXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 05:23:12 -0500
Received: by mail-pf1-f195.google.com with SMTP id s9-v6so2573538pfm.13;
        Sat, 10 Nov 2018 16:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=00AErAWdshdmjgkPuka4mDKoUyjZJOLQPu7jh66w8aM=;
        b=vFUYHOvUSE5BtlHoWwt7B+sZDnSkH35fI3Jg+Vj9nCQiSI3zbOXzJdAaVyv70jVri7
         9SfUsoeryucTyVqz7cW2W1g5lKKWh23GbBxMkP5wK0cgXM7uyK0lb9YYk4PNRbrP8zqN
         UmN9CiHPYmzetkwyj2+I9I4vVgyGH+YnoV6rPfxD2RO0RxW0N4hoyK2/nQOGJpxAi6Qk
         omtLMcVk9Nm7lwAp5xs20CRU6Cni5ESWudV0NcEG2WrdGnOa8rIUpROi7cYF9YuVVbQ/
         8WCCyyhIQPXyCDrrZyNNla8ljV1Rv8w3UDu3DE/0X2yFD+hmxYeJv5l/G34z7WLNazsj
         X6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=00AErAWdshdmjgkPuka4mDKoUyjZJOLQPu7jh66w8aM=;
        b=n0i3O10A6erPPN11Kr50LPvunezkm9//LPrOPD0kVlNxAJkg7G7WkD2Aqy9ixwFfpV
         GyMfsP8HBkVLpoI/ZCQqfhSVlzUFozmnqUYKYPmbFpGmH0DTIOPEYmvpFPiXZ/bOv3OZ
         +aSuRZ2Ya8gqA9kuwX+PSz+cSGIZo9M3VLnL0YmEI6SxJ6fWm/ZEZtN2vQrS+u1IFufb
         GOPAnIQ9cGB7pWUEhETa9iPaPZDDMFvuw//JaKj8c3V5pyrHa/09+uy+Gyj/bF2wgamc
         0AelGs9P4yJ3w0LO/GrK1dtWhC6j8k9FdDmiGCXTbMZakTECbuYICdxUof6zqUTY0uB4
         ORkQ==
X-Gm-Message-State: AGRZ1gJbWM8U5kpMWc2O2i3JsBYheV2XZODv5MgnVHcc09DZ6LGV7Swj
        R5b+C7XmK+VzJCcEWTLT6Uo=
X-Google-Smtp-Source: AJdET5cWKyJvj3Fb0Rrq5k+/X1CCgGBHpTqhZNAri3dT0ewISwGjRDQwQMCgSSKmNmxG1tpT2+lWkg==
X-Received: by 2002:a63:2e02:: with SMTP id u2mr12800987pgu.9.1541896581916;
        Sat, 10 Nov 2018 16:36:21 -0800 (PST)
Received: from localhost.localdomain ([64.64.108.230])
        by smtp.gmail.com with ESMTPSA id u76-v6sm14122483pfa.176.2018.11.10.16.36.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Nov 2018 16:36:21 -0800 (PST)
From:   hmsjwzb <weizhefix@gmail.com>
To:     darrick.wong@oracle.com
Cc:     hmsjwzb <weizhefix@gmail.com>, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Fix coding style issue in xfs_acl.c and xfs_aops.c
Date:   Sun, 11 Nov 2018 08:36:03 +0800
Message-Id: <20181111003603.7598-1-weizhefix@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Possible unwrapped commit description (prefer a maximum 75 chars per line)

Signed-off-by: hmsjwzb <weizhefix@gmail.com>
---
 fs/xfs/xfs_acl.c  |  4 +--
 fs/xfs/xfs_aops.c | 73 ++++++++++++++++++++++++-----------------------
 2 files changed, 39 insertions(+), 38 deletions(-)

diff --git a/fs/xfs/xfs_acl.c b/fs/xfs/xfs_acl.c
index 8039e35147dd..5c779c161727 100644
--- a/fs/xfs/xfs_acl.c
+++ b/fs/xfs/xfs_acl.c
@@ -19,8 +19,8 @@
 
 /*
  * Locking scheme:
- *  - all ACL updates are protected by inode->i_mutex, which is taken before
- *    calling into this file.
+ *  - all ACL updates are protected by inode->i_mutex,
+ *    which is taken before calling into this file.
  */
 
 STATIC struct posix_acl *
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 338b9d9984e0..1a6cb88ffdb7 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -81,8 +81,8 @@ xfs_finish_page_writeback(
 
 /*
  * We're now finished for good with this ioend structure.  Update the page
- * state, release holds on bios, and finally free up memory.  Do not use the
- * ioend after this.
+ * state, release holds on bios, and finally free up memory.
+ * Do not use the ioend after this.
  */
 STATIC void
 xfs_destroy_ioend(
@@ -464,18 +464,18 @@ xfs_map_blocks(
 }
 
 /*
- * Submit the bio for an ioend. We are passed an ioend with a bio attached to
- * it, and we submit that bio. The ioend may be used for multiple bio
- * submissions, so we only want to allocate an append transaction for the ioend
- * once. In the case of multiple bio submission, each bio will take an IO
- * reference to the ioend to ensure that the ioend completion is only done once
- * all bios have been submitted and the ioend is really done.
+ * Submit the bio for an ioend. We are passed an ioend with a bio attached
+ * to it, and we submit that bio. The ioend may be used for multiple bio
+ * submissions, so we only want to allocate an append transaction for the
+ * ioend once. In the case of multiple bio submission, each bio will take
+ * an IO reference to the ioend to ensure that the ioend completion is only
+ * done once all bios have been submitted and the ioend is really done.
  *
- * If @fail is non-zero, it means that we have a situation where some part of
- * the submission process has failed after we have marked paged for writeback
- * and unlocked them. In this situation, we need to fail the bio and ioend
- * rather than submit it to IO. This typically only happens on a filesystem
- * shutdown.
+ * If @fail is non-zero, it means that we have a situation where some part
+ * of the submission process has failed after we have marked paged for
+ * writeback and unlocked them. In this situation, we need to fail the bio
+ * and ioend rather than submit it to IO. This typically only happens
+ * on a filesystem shutdown.
  */
 STATIC int
 xfs_submit_ioend(
@@ -583,8 +583,8 @@ xfs_chain_bio(
 }
 
 /*
- * Test to see if we have an existing ioend structure that we could append to
- * first, otherwise finish off the current ioend and start another.
+ * Test to see if we have an existing ioend structure that we could append
+ * to first, otherwise finish off the current ioend and start another.
  */
 STATIC void
 xfs_add_to_ioend(
@@ -637,15 +637,16 @@ xfs_vm_invalidatepage(
 }
 
 /*
- * If the page has delalloc blocks on it, we need to punch them out before we
- * invalidate the page.  If we don't, we leave a stale delalloc mapping on the
- * inode that can trip up a later direct I/O read operation on the same region.
+ * If the page has delalloc blocks on it, we need to punch them out before
+ * we invalidate the page.  If we don't, we leave a stale delalloc mapping
+ * on the inode that can trip up a later direct I/O read operation on
+ * the same region.
  *
- * We prevent this by truncating away the delalloc regions on the page.  Because
- * they are delalloc, we can do this without needing a transaction. Indeed - if
- * we get ENOSPC errors, we have to be able to do this truncation without a
- * transaction as there is no space left for block reservation (typically why we
- * see a ENOSPC in writeback).
+ * We prevent this by truncating away the delalloc regions on the page.
+ * Because they are delalloc, we can do this without needing a transaction.
+ * Indeed - if we get ENOSPC errors, we have to be able to do this
+ * truncation without a transaction as there is no space left for block
+ * reservation (typically why we see a ENOSPC in writeback).
  */
 STATIC void
 xfs_aops_discard_page(
@@ -674,20 +675,20 @@ xfs_aops_discard_page(
 }
 
 /*
- * We implement an immediate ioend submission policy here to avoid needing to
- * chain multiple ioends and hence nest mempool allocations which can violate
- * forward progress guarantees we need to provide. The current ioend we are
- * adding blocks to is cached on the writepage context, and if the new block
- * does not append to the cached ioend it will create a new ioend and cache that
- * instead.
+ * We implement an immediate ioend submission policy here to avoid needing
+ * to chain multiple ioends and hence nest mempool allocations which can
+ * violate forward progress guarantees we need to provide. The current
+ * ioend we are adding blocks to is cached on the writepage context,
+ * and if the new block does not append to the cached ioend it will create
+ * a new ioend and cache that instead.
  *
- * If a new ioend is created and cached, the old ioend is returned and queued
- * locally for submission once the entire page is processed or an error has been
- * detected.  While ioends are submitted immediately after they are completed,
- * batching optimisations are provided by higher level block plugging.
- *
- * At the end of a writeback pass, there will be a cached ioend remaining on the
- * writepage context that the caller will need to submit.
+ * If a new ioend is created and cached, the old ioend is returned and
+ * queued locally for submission once the entire page is processed or an
+ * error has been detected.  While ioends are submitted immediately
+ * after they are completed, batching optimisations are provided by higher
+ * level block plugging.
+ * At the end of a writeback pass, there will be a cached ioend remaining
+ * on the writepage context that the caller will need to submit.
  */
 static int
 xfs_writepage_map(
-- 
2.17.1

