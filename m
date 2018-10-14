Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1FFC71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF73020645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:48:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF73020645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729554AbeJNXaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:30:09 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37340 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728128AbeJNXaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:30:08 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiMB-0004cD-W5; Sun, 14 Oct 2018 16:31:04 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLQ-0000FR-2U; Sun, 14 Oct 2018 16:30:16 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "David Sterba" <dsterba@suse.com>,
        "Filipe Manana" <fdmanana@suse.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.195468558@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 083/366] Btrfs: fix copy_items() return value when
 logging an inode
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

commit 8434ec46c6e3232cebc25a910363b29f5c617820 upstream.

When logging an inode, at tree-log.c:copy_items(), if we call
btrfs_next_leaf() at the loop which checks for the need to log holes, we
need to make sure copy_items() returns the value 1 to its caller and
not 0 (on success). This is because the path the caller passed was
released and is now different from what is was before, and the caller
expects a return value of 0 to mean both success and that the path
has not changed, while a return value of 1 means both success and
signals the caller that it can not reuse the path, it has to perform
another tree search.

Even though this is a case that should not be triggered on normal
circumstances or very rare at least, its consequences can be very
unpredictable (especially when replaying a log tree).

Fixes: 16e7549f045d ("Btrfs: incompatible format change to remove hole extents")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/btrfs/tree-log.c | 1 +
 1 file changed, 1 insertion(+)

--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3524,6 +3524,7 @@ fill_holes:
 			ASSERT(ret == 0);
 			src = src_path->nodes[0];
 			i = 0;
+			need_find_last_extent = true;
 		}
 
 		btrfs_item_key_to_cpu(src, &key, i);

