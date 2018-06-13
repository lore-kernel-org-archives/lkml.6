Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2B306C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 23:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D47F3208CC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 23:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iy6XrhLg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D47F3208CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935944AbeFMXuw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 19:50:52 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34408 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935682AbeFMXuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 19:50:50 -0400
Received: by mail-pf0-f194.google.com with SMTP id a63-v6so2244457pfl.1;
        Wed, 13 Jun 2018 16:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=VHbULG8ozC+UkKDpE/21dGLmyxJ0KOJyVY0sNvQ17kU=;
        b=iy6XrhLgUyPgbfKLVa09TDw4WyAYCnuh7V9W5perUkK1CDTnrJiN8oRv8qU0IkMONi
         XtL01KLRY68YY49p7vpo2MYRm0R8ztSqIAX//Kkk6oFjJ6P+5p0bmztlAgJP16w2L4xL
         r6uNPNftadYPwhlDDFcR8euemcBP+YZfKAHptaaxdTRJQK8FI4hghjRRRJC9rB3knPjm
         rEkBx39O1QQjks7TnHsbpYhqDH3lS1EFd/RfyBqmXbbqPDC9s1hngWwydBv6KL5J6PlP
         OPEIdcyOJoN8cAo/czmSonB1vqa4u8ObVd8il/urUuGYpAKkhvgkkTXFZjrAQTZdZZIf
         BsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VHbULG8ozC+UkKDpE/21dGLmyxJ0KOJyVY0sNvQ17kU=;
        b=ijEX+3etUkv/IqvnRpGs+ukmC/23T54gvgp3/OH/1kjx18G5tRTbxyDTyaZynC/LQJ
         I4TQ6sasYIhWDkTBhKxGOSNP9XcfAZ1iyh+PP++P299W11oNf0f7xEt4D+af6k4d/wHY
         D7fxwahqfIiw8AKjioDWXxmIKy5Tef7bhxGzX7+HdcIS/rE862oNX40qWz8pnovoDZJ4
         0o2UvJlRKVBWxAp+wpYUE6+rvNafFv+/1L3QfJvDfbPRSeXbVFyCiggOGWxmEr2WUCde
         JJsXL3p14mr3ckv9kGzB6mgS+HsC3UMQLCkIauZdXILbSpPj6k64WjUiyY8cmy+DJY2W
         Ypow==
X-Gm-Message-State: APt69E3wtrRZB1CDeh/2VWEdDzRvV4c9GyVncW9W1vrmapkyJSTAKgFV
        TKidG/OqxtV4UvEguPSlS9BoW7qy
X-Google-Smtp-Source: ADUXVKI3w+X4QPcLMhAZRf4rZF3b0wqUuSzmJJ4PX8lSbR6e07tRrVUdoZZvWwBzaufA1/EUrL9xmA==
X-Received: by 2002:a63:8f4f:: with SMTP id r15-v6mr239208pgn.210.1528933850272;
        Wed, 13 Jun 2018 16:50:50 -0700 (PDT)
Received: from tw-172-25-29-199.office.twttr.net ([8.25.197.27])
        by smtp.gmail.com with ESMTPSA id r3-v6sm6092545pfl.162.2018.06.13.16.50.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 16:50:49 -0700 (PDT)
From:   Cong Wang <xiyou.wangcong@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-rdma@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH] infiniband: fix a subtle race condition
Date:   Wed, 13 Jun 2018 16:49:47 -0700
Message-Id: <20180613234947.15767-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ucma_event_handler() we lock the mutex like this:

mutex_lock(&ctx->file->mut);
...
mutex_unlock(&ctx->file->mut);

which seems correct, but we could translate it into this:

f = ctx->file;
mutex_lock(&f->mut);
...
f = ctx->file;
mutex_unlock(&f->mut);

as the compiler does. And, because ucma_event_handler() is
called in a workqueue so it could race with ucma_migrate_id(),
so the following race condition could happen:

CPU0			CPU1
f = ctx->file;
			ucma_lock_files(f, new_file);
			ctx->file = new_file
			ucma_lock_files(f, new_file);
mutex_lock(&f->mut); // still the old file!
...
f = ctx->file; // now the new one!!
mutex_unlock(&f->mut); // unlock new file!

Fix this by reading ctx->file once before mutex_lock(), so we
won't unlock a different mutex any more.

Reported-by: syzbot+e5579222b6a3edd96522@syzkaller.appspotmail.com
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 drivers/infiniband/core/ucma.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index ec8fb289621f..8729d6acf981 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -341,13 +341,15 @@ static int ucma_event_handler(struct rdma_cm_id *cm_id,
 {
 	struct ucma_event *uevent;
 	struct ucma_context *ctx = cm_id->context;
+	struct ucma_file *cur_file;
 	int ret = 0;
 
 	uevent = kzalloc(sizeof(*uevent), GFP_KERNEL);
 	if (!uevent)
 		return event->event == RDMA_CM_EVENT_CONNECT_REQUEST;
 
-	mutex_lock(&ctx->file->mut);
+	cur_file = ctx->file;
+	mutex_lock(&cur_file->mut);
 	uevent->cm_id = cm_id;
 	ucma_set_event_context(ctx, event, uevent);
 	uevent->resp.event = event->event;
@@ -382,12 +384,12 @@ static int ucma_event_handler(struct rdma_cm_id *cm_id,
 		goto out;
 	}
 
-	list_add_tail(&uevent->list, &ctx->file->event_list);
-	wake_up_interruptible(&ctx->file->poll_wait);
+	list_add_tail(&uevent->list, &cur_file->event_list);
+	wake_up_interruptible(&cur_file->poll_wait);
 	if (event->event == RDMA_CM_EVENT_DEVICE_REMOVAL)
 		ucma_removal_event_handler(cm_id);
 out:
-	mutex_unlock(&ctx->file->mut);
+	mutex_unlock(&cur_file->mut);
 	return ret;
 }
 
-- 
2.14.4

