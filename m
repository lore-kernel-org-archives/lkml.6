Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1E2C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A222920652
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjDVeeNZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A222920652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731341AbeJKXNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:13:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:45732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbeJKXNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:13:15 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBA0420652;
        Thu, 11 Oct 2018 15:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272730;
        bh=6yi8L2b1cBeWj/9VL74GYPEzVFRw0MxavDakRWztKmU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NjDVeeNZR0a7zWZsjeXNEBk46gJ1GshyxTBHjQSU4bGxi5zDUua/0mVOalT2A8Scr
         /S7YsJ7EwgbmSLhcX1vjUVwS5wVMVmgdqylrwHJVIw5p+BhqPIGM2rMPQ+YnZUHskz
         CBzKGi/nntKJmp5DzH1o2w6871pCxdYBkUAtLxCM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joe Thornber <ejt@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.14 19/45] dm cache metadata: ignore hints array being too small during resize
Date:   Thu, 11 Oct 2018 17:39:46 +0200
Message-Id: <20181011152509.687556424@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152508.885515042@linuxfoundation.org>
References: <20181011152508.885515042@linuxfoundation.org>
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

From: Joe Thornber <ejt@redhat.com>

commit 4561ffca88c546f96367f94b8f1e4715a9c62314 upstream.

Commit fd2fa9541 ("dm cache metadata: save in-core policy_hint_size to
on-disk superblock") enabled previously written policy hints to be
used after a cache is reactivated.  But in doing so the cache
metadata's hint array was left exposed to out of bounds access because
on resize the metadata's on-disk hint array wasn't ever extended.

Fix this by ignoring that there are no on-disk hints associated with the
newly added cache blocks.  An expanded on-disk hint array is later
rewritten upon the next clean shutdown of the cache.

Fixes: fd2fa9541 ("dm cache metadata: save in-core policy_hint_size to on-disk superblock")
Cc: stable@vger.kernel.org
Signed-off-by: Joe Thornber <ejt@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-cache-metadata.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/md/dm-cache-metadata.c
+++ b/drivers/md/dm-cache-metadata.c
@@ -1454,8 +1454,8 @@ static int __load_mappings(struct dm_cac
 		if (hints_valid) {
 			r = dm_array_cursor_next(&cmd->hint_cursor);
 			if (r) {
-				DMERR("dm_array_cursor_next for hint failed");
-				goto out;
+				dm_array_cursor_end(&cmd->hint_cursor);
+				hints_valid = false;
 			}
 		}
 


