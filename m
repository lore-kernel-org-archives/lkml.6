Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A0EC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F1D0214E0
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0s2QYiqr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F1D0214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391030AbeKLIi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:38:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:56794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404392AbeKLIXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:23:22 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28832223C8;
        Sun, 11 Nov 2018 22:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975604;
        bh=IRUyuaGPN2S7E2Dop3xOXS+uMkv/bjwIPWe4vXD5MO8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0s2QYiqr/xZUf11QaTAb4bMaA9r3N6/owfgARWmhtf0QpUwt0hr/FF28RfrAdgFKN
         /aF0iacJyPW/LTRFADiFX64CKWy2K/x6/FUZ6W8AuspPgnQRXPW+eEKXKVS1bUxPJ+
         IpQsxplvyG2A/ki4BcgpcqEHlDtboZ3vBKr7mD/c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josef Bacik <jbacik@fb.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.14 213/222] btrfs: set max_extent_size properly
Date:   Sun, 11 Nov 2018 14:25:10 -0800
Message-Id: <20181111221705.523218209@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josef Bacik <jbacik@fb.com>

commit ad22cf6ea47fa20fbe11ac324a0a15c0a9a4a2a9 upstream.

We can't use entry->bytes if our entry is a bitmap entry, we need to use
entry->max_extent_size in that case.  Fix up all the logic to make this
consistent.

CC: stable@vger.kernel.org # 4.4+
Signed-off-by: Josef Bacik <jbacik@fb.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/free-space-cache.c |   30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -1795,6 +1795,13 @@ static int search_bitmap(struct btrfs_fr
 	return -1;
 }
 
+static inline u64 get_max_extent_size(struct btrfs_free_space *entry)
+{
+	if (entry->bitmap)
+		return entry->max_extent_size;
+	return entry->bytes;
+}
+
 /* Cache the size of the max extent in bytes */
 static struct btrfs_free_space *
 find_free_space(struct btrfs_free_space_ctl *ctl, u64 *offset, u64 *bytes,
@@ -1816,8 +1823,8 @@ find_free_space(struct btrfs_free_space_
 	for (node = &entry->offset_index; node; node = rb_next(node)) {
 		entry = rb_entry(node, struct btrfs_free_space, offset_index);
 		if (entry->bytes < *bytes) {
-			if (entry->bytes > *max_extent_size)
-				*max_extent_size = entry->bytes;
+			*max_extent_size = max(get_max_extent_size(entry),
+					       *max_extent_size);
 			continue;
 		}
 
@@ -1835,8 +1842,8 @@ find_free_space(struct btrfs_free_space_
 		}
 
 		if (entry->bytes < *bytes + align_off) {
-			if (entry->bytes > *max_extent_size)
-				*max_extent_size = entry->bytes;
+			*max_extent_size = max(get_max_extent_size(entry),
+					       *max_extent_size);
 			continue;
 		}
 
@@ -1848,8 +1855,10 @@ find_free_space(struct btrfs_free_space_
 				*offset = tmp;
 				*bytes = size;
 				return entry;
-			} else if (size > *max_extent_size) {
-				*max_extent_size = size;
+			} else {
+				*max_extent_size =
+					max(get_max_extent_size(entry),
+					    *max_extent_size);
 			}
 			continue;
 		}
@@ -2709,8 +2718,8 @@ static u64 btrfs_alloc_from_bitmap(struc
 
 	err = search_bitmap(ctl, entry, &search_start, &search_bytes, true);
 	if (err) {
-		if (search_bytes > *max_extent_size)
-			*max_extent_size = search_bytes;
+		*max_extent_size = max(get_max_extent_size(entry),
+				       *max_extent_size);
 		return 0;
 	}
 
@@ -2747,8 +2756,9 @@ u64 btrfs_alloc_from_cluster(struct btrf
 
 	entry = rb_entry(node, struct btrfs_free_space, offset_index);
 	while (1) {
-		if (entry->bytes < bytes && entry->bytes > *max_extent_size)
-			*max_extent_size = entry->bytes;
+		if (entry->bytes < bytes)
+			*max_extent_size = max(get_max_extent_size(entry),
+					       *max_extent_size);
 
 		if (entry->bytes < bytes ||
 		    (!entry->bitmap && entry->offset < min_start)) {


