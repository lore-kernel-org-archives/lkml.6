Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A54C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC99620867
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:50:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC99620867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbeICVLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:11:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36212 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728024AbeICVLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:11:51 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D359FCF5;
        Mon,  3 Sep 2018 16:50:54 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kiran Kumar Modukuri <kiran.modukuri@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 22/56] fscache: Allow cancelled operations to be enqueued
Date:   Mon,  3 Sep 2018 18:49:12 +0200
Message-Id: <20180903164925.202493671@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903164924.078355019@linuxfoundation.org>
References: <20180903164924.078355019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kiran Kumar Modukuri <kiran.modukuri@gmail.com>

[ Upstream commit d0eb06afe712b7b103b6361f40a9a0c638524669 ]

Alter the state-check assertion in fscache_enqueue_operation() to allow
cancelled operations to be given processing time so they can be cleaned up.

Also fix a debugging statement that was requiring such operations to have
an object assigned.

Fixes: 9ae326a69004 ("CacheFiles: A cache that backs onto a mounted filesystem")
Reported-by: Kiran Kumar Modukuri <kiran.modukuri@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/fscache/operation.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/fs/fscache/operation.c
+++ b/fs/fscache/operation.c
@@ -37,7 +37,8 @@ void fscache_enqueue_operation(struct fs
 	ASSERT(op->processor != NULL);
 	ASSERT(fscache_object_is_available(op->object));
 	ASSERTCMP(atomic_read(&op->usage), >, 0);
-	ASSERTCMP(op->state, ==, FSCACHE_OP_ST_IN_PROGRESS);
+	ASSERTIFCMP(op->state != FSCACHE_OP_ST_IN_PROGRESS,
+		    op->state, ==,  FSCACHE_OP_ST_CANCELLED);
 
 	fscache_stat(&fscache_n_op_enqueue);
 	switch (op->flags & FSCACHE_OP_TYPE) {
@@ -401,7 +402,8 @@ void fscache_put_operation(struct fscach
 	struct fscache_cache *cache;
 
 	_enter("{OBJ%x OP%x,%d}",
-	       op->object->debug_id, op->debug_id, atomic_read(&op->usage));
+	       op->object ? op->object->debug_id : 0,
+	       op->debug_id, atomic_read(&op->usage));
 
 	ASSERTCMP(atomic_read(&op->usage), >, 0);
 


