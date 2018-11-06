Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F95C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E2920862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:30:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2E2920862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730398AbeKFSzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 13:55:17 -0500
Received: from relay.sw.ru ([185.231.240.75]:59176 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729241AbeKFSzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 13:55:17 -0500
Received: from [172.16.25.169] (helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.90_1)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1gJxhH-0002w9-QP; Tue, 06 Nov 2018 12:30:55 +0300
Subject: [PATCH 5/6] fuse: Do some refactoring in fuse_dev_do_write()
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     miklos@szeredi.hu, ktkhai@virtuozzo.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 06 Nov 2018 12:30:55 +0300
Message-ID: <154149665549.17764.16369219275104315430.stgit@localhost.localdomain>
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

This is needed for next patch.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 fs/fuse/dev.c |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index c603f1ebf0fd..315d395d5c02 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1955,18 +1955,14 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
 		__fuse_get_request(req);
 		spin_unlock(&fpq->lock);
 
-		err = -EINVAL;
-		if (nbytes != sizeof(struct fuse_out_header)) {
-			fuse_put_request(fc, req);
-			goto err_finish;
-		}
-
-		if (oh.error == -ENOSYS)
+		if (nbytes != sizeof(struct fuse_out_header))
+			nbytes = -EINVAL;
+		else if (oh.error == -ENOSYS)
 			fc->no_interrupt = 1;
 		else if (oh.error == -EAGAIN)
 			queue_interrupt(&fc->iq, req);
-		fuse_put_request(fc, req);
 
+		fuse_put_request(fc, req);
 		fuse_copy_finish(cs);
 		return nbytes;
 	}

