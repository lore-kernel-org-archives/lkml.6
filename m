Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514CFC0044C
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 03:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D3C620843
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 03:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9LkbwgO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D3C620843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbeKDMRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 07:17:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:39050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727163AbeKDMRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 07:17:49 -0500
Received: from localhost (c-71-202-137-17.hsd1.ca.comcast.net [71.202.137.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D46582082E;
        Sun,  4 Nov 2018 03:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541300672;
        bh=2Gg6yu9o9pSfyZHkI/PIfF2WmKVtqsq2JLt5eJQTeiA=;
        h=From:To:Cc:Subject:Date:From;
        b=B9LkbwgOjn30ODm7qdA0Ebys6K1ahauL+nmet6ivaf3wXfX0lV3YJ5dWyzlmSHQsi
         7xL9U1xGbB9M627d3mnjrFYPXWYnOcRStV/eRgEBUa/Xmi8C7JinRXquJUU86hCU4F
         cvAddXK7xDdCcMH3VfFQnaEWtcx38hi9Vizdq5RA=
From:   Andy Lutomirski <luto@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-fs@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: [PATCH] net/9p: Fix iov_iter usage
Date:   Sat,  3 Nov 2018 20:04:28 -0700
Message-Id: <f1705194dfd581fb83ec26b32626dc4ddf6039f2.1541300643.git.luto@kernel.org>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to use 9pfs causes QEMU to complain:

    qemu-system-x86_64: virtio: bogus descriptor or out of resources

This happens because 9p was broken by the iov_iter refactoring because
a ! got lost.  Put it back.  The offending hunk was:

diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 7728b0acde09..4d7d2070e9c8 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -322,7 +322,7 @@ static int p9_get_mapped_pages(struct virtio_chan *chan,
 	if (!iov_iter_count(data))
 		return 0;

-	if (!(data->type & ITER_KVEC)) {
+	if (iov_iter_is_kvec(data)) {

Cc: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Fixes: 00e23707442a ("iov_iter: Use accessor function")
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 net/9p/trans_virtio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 91981970f542..b1d39cabf125 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -329,7 +329,7 @@ static int p9_get_mapped_pages(struct virtio_chan *chan,
 	if (!iov_iter_count(data))
 		return 0;
 
-	if (iov_iter_is_kvec(data)) {
+	if (!iov_iter_is_kvec(data)) {
 		int n;
 		/*
 		 * We allow only p9_max_pages pinned. We wait for the
-- 
2.17.2

