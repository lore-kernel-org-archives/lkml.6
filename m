Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1FFC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B8B920862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:30:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B8B920862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730377AbeKFSzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 13:55:12 -0500
Received: from relay.sw.ru ([185.231.240.75]:59168 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729430AbeKFSzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 13:55:11 -0500
Received: from [172.16.25.169] (helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.90_1)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1gJxhC-0002w3-9j; Tue, 06 Nov 2018 12:30:50 +0300
Subject: [PATCH 4/6] fuse: Check for FR_SENT bit in fuse_dev_do_write()
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     miklos@szeredi.hu, ktkhai@virtuozzo.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 06 Nov 2018 12:30:49 +0300
Message-ID: <154149664975.17764.16537105755726576371.stgit@localhost.localdomain>
In-Reply-To: <154149586524.17764.5252013294539109287.stgit@localhost.localdomain>
References: <154149586524.17764.5252013294539109287.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's not possible to have answer to a request,
before the request is actually sent. Add sanity
check for that.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 fs/fuse/dev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 739968ee8b0c..c603f1ebf0fd 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1947,7 +1947,7 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
 		goto err_unlock_pq;
 
 	req = request_find(fpq, oh.unique & ~FUSE_INT_REQ_BIT);
-	if (!req)
+	if (!req || !test_bit(FR_SENT, &req->flags))
 		goto err_unlock_pq;
 
 	/* Is it an interrupt reply ID? */

