Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D00EC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D37520827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:13:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D37520827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387508AbeKFShc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 13:37:32 -0500
Received: from relay.sw.ru ([185.231.240.75]:58500 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729160AbeKFShc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 13:37:32 -0500
Received: from [172.16.25.169] (helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.90_1)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1gJxQA-0002qA-Gk; Tue, 06 Nov 2018 12:13:14 +0300
Subject: [PATCH] fuse: Put leaked request on error path of fuse_retrieve()
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     miklos@szeredi.hu, ktkhai@virtuozzo.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 06 Nov 2018 12:13:14 +0300
Message-ID: <154149557692.17196.12607896696117775780.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fuse_request_send_notify_reply() may fail, and this case
it remains leaked (fuse_retrieve_end(), which is called
on error path, does not do that). Also, fc->num_waiting,
will never be decremented, and fuse_wait_aborted() will
never finish. So, put the request patently.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 fs/fuse/dev.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index ae813e609932..6fe330cc9709 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1768,8 +1768,10 @@ static int fuse_retrieve(struct fuse_conn *fc, struct inode *inode,
 	req->in.args[1].size = total_len;
 
 	err = fuse_request_send_notify_reply(fc, req, outarg->notify_unique);
-	if (err)
+	if (err) {
 		fuse_retrieve_end(fc, req);
+		fuse_put_request(fc, req);
+	}
 
 	return err;
 }

