Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27B3C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 22:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7DA5206BA
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 22:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731075AbeLPWmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 17:42:17 -0500
Received: from a2nlsmtp01-04.prod.iad2.secureserver.net ([198.71.225.38]:52220
        "EHLO a2nlsmtp01-04.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730758AbeLPWmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 17:42:17 -0500
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id Yf62geg8gThUeYf62gg634; Sun, 16 Dec 2018 15:41:15 -0700
x-originating-ip: 107.180.71.197
Received: from longli by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <longli@linuxonhyperv2.linuxonhyperv.com>)
        id 1gYf62-0004DS-PW; Sun, 16 Dec 2018 15:41:14 -0700
From:   Long Li <longli@linuxonhyperv.com>
To:     Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>, stable@vger.kernel.org,
        Murphy Zhou <jencce.kernel@gmail.com>
Subject: [PATCH] CIFS: return correct errors when pinning memory failed for direct I/O
Date:   Sun, 16 Dec 2018 22:41:07 +0000
Message-Id: <20181216224107.16164-1-longli@linuxonhyperv.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Reply-To: longli@microsoft.com
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfEe15opoqopfTRBJopBEjQextT9kIvKHLmYcxa2cjXKOGgaQ1Gk76SaDsG8K53H4v2VExPcKlQEO8E5qHDTURnh3q2S7qdLhBxv+nlhaxde6oCCCy4i+
 WlS+myf6QtxJD9siqgHzQqXjWhY/wm5UOb6V1uOAZsM4eb4VNbYp+p9c+4w8hEWF6peYQnV6eYxgO0HYkRzut1auoVN2wAojo/LIftoooGhYwDqj5X67Rgd2
 RdG5U7jyJvjt7H1WJi8CEGUUfENpX+o/a4sBaEAKe3VHMu9vPww/5anedhHcSahK7Kw4nfwhPYmMj8YcYHBJW9UD66EfZNyb5jBlHlAQo8HVpXBdZPRmobsJ
 J8jHVhciF8LiP/KYnJN9Q6/lwtzrDhZFD4xUJX5Gn3eQpW8c7dsEtCtbM1B3HvKoJIFF2M3TZJ/3MM/QDFJpQwaicj8gA08/ddB4o3GVnWNeT5p4wAzK8+kc
 7krW/RcwJRUiWegf
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Long Li <longli@microsoft.com>

When pinning memory failed, we should return the correct error code and
rewind the SMB credits.

Reported-by: Murphy Zhou <jencce.kernel@gmail.com>
Signed-off-by: Long Li <longli@microsoft.com>
Cc: stable@vger.kernel.org
Cc: Murphy Zhou <jencce.kernel@gmail.com>
---
 fs/cifs/file.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index c9bc56b..3467351 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -2630,6 +2630,9 @@ cifs_write_from_iter(loff_t offset, size_t len, struct iov_iter *from,
 					result, from->type,
 					from->iov_offset, from->count);
 				dump_stack();
+
+				rc = result;
+				add_credits_and_wake_if(server, credits, 0);
 				break;
 			}
 			cur_len = (size_t)result;
@@ -3313,13 +3316,16 @@ cifs_send_async_read(loff_t offset, size_t len, struct cifsFileInfo *open_file,
 					cur_len, &start);
 			if (result < 0) {
 				cifs_dbg(VFS,
-					"couldn't get user pages (cur_len=%zd)"
+					"couldn't get user pages (rc=%zd)"
 					" iter type %d"
 					" iov_offset %zd count %zd\n",
 					result, direct_iov.type,
 					direct_iov.iov_offset,
 					direct_iov.count);
 				dump_stack();
+
+				rc = result;
+				add_credits_and_wake_if(server, credits, 0);
 				break;
 			}
 			cur_len = (size_t)result;
-- 
2.7.4

