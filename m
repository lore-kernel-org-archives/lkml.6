Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE1CC71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C7A420645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:46:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C7A420645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729558AbeJNX1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:27:33 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37200 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728141AbeJNX1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:27:32 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiM8-0004cF-2q; Sun, 14 Oct 2018 16:31:00 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLQ-0000Hk-Us; Sun, 14 Oct 2018 16:30:16 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "David Sterba" <dsterba@suse.com>,
        "Liu Bo" <bo.liu@linux.alibaba.com>,
        "Nikolay Borisov" <nborisov@suse.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.290018870@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 106/366] Btrfs: bail out on error during
 replay_dir_deletes
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

From: Liu Bo <bo.liu@linux.alibaba.com>

commit b98def7ca6e152ee55e36863dddf6f41f12d1dc6 upstream.

If errors were returned by btrfs_next_leaf(), replay_dir_deletes needs
to bail out, otherwise @ret would be forced to be 0 after 'break;' and
the caller won't be aware of it.

Fixes: e02119d5a7b4 ("Btrfs: Add a write ahead tree log to optimize synchronous operations")
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/btrfs/tree-log.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -1979,8 +1979,10 @@ again:
 			nritems = btrfs_header_nritems(path->nodes[0]);
 			if (path->slots[0] >= nritems) {
 				ret = btrfs_next_leaf(root, path);
-				if (ret)
+				if (ret == 1)
 					break;
+				else if (ret < 0)
+					goto out;
 			}
 			btrfs_item_key_to_cpu(path->nodes[0], &found_key,
 					      path->slots[0]);

