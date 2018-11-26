Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DBDC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 09:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19EC92086B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 09:46:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19EC92086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbeKZUj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 15:39:57 -0500
Received: from relay.sw.ru ([185.231.240.75]:49798 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbeKZUj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 15:39:56 -0500
Received: from [172.16.25.169] (helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1gRDTA-0007C0-Rn; Mon, 26 Nov 2018 12:46:21 +0300
Subject: [PATCH 2/2] fuse: Replace page without copying in
 fuse_writepage_in_flight()
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     miklos@szeredi.hu, ktkhai@virtuozzo.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 26 Nov 2018 12:46:20 +0300
Message-ID: <154322557765.18737.14337090699283695815.stgit@localhost.localdomain>
In-Reply-To: <154322517208.18737.3297786654135648324.stgit@localhost.localdomain>
References: <154322517208.18737.3297786654135648324.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like we can optimize old_req page replacement
and avoid copying by simple updating the request's page.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 fs/fuse/file.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index c6650c68b31a..83b54b082c86 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1778,7 +1778,7 @@ static bool fuse_writepage_in_flight(struct fuse_req *new_req,
 	if (old_req->num_pages == 1 && old_req != first_req) {
 		struct backing_dev_info *bdi = inode_to_bdi(page->mapping->host);
 
-		copy_highpage(old_req->pages[0], page);
+		swap(old_req->pages[0], page);
 		spin_unlock(&fc->lock);
 
 		dec_wb_stat(&bdi->wb, WB_WRITEBACK);

