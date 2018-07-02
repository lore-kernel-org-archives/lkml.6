Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD508C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 22:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D18025A24
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 22:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BIX13R4u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D18025A24
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932312AbeGBWCQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 18:02:16 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:38864 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752832AbeGBWCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 18:02:15 -0400
Received: by mail-pg0-f68.google.com with SMTP id c9-v6so7713362pgf.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 15:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SKh13LkMK7j4XBTqGSWo1FUAYyaM8xDSpOf54EkY4xc=;
        b=BIX13R4uPRJtUM2PLlfjFO375WJjIr/xwG5flMI5/HPb0pYm0GAJkCCPP7VHJU81gk
         mIXY4jMFemSOyMDxscgDBoW7trqcZRH98FDUXyKyrs+99rzrsjB2BCotiDSdQBwbYA4J
         CFzNkd9a8Nop7151PRu3U9QYT41r6cWSBb/shBNYr7RGA8sq2p0+M29lHar1VfDA+fdO
         2tEJjJWMVRq0v5TRF+gSdyFwCd3J1HtgW5s4SQdM85jpJFq2zesaeqlX9QYolhL9ufDw
         sm7t3L0a3SYwHu9KoYuNM30yRaQmRkEa/WAKgYAhl58kwUsEsc65gUI8VBFx6O3hT9VT
         Wy1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SKh13LkMK7j4XBTqGSWo1FUAYyaM8xDSpOf54EkY4xc=;
        b=rIWi2/UvIfvw5lEIRsSb1QZfMjJC9acJ4xnyWBFRmXciIlXpMwKxCbFXnIRQIWTFGY
         xlHf2SB7hAwMCXIIXPbuQgH7TSBsypMZLtK7xcUp0cFi88u0bEwdK/ryv7c+Ra67eyIz
         D4r7jlC2V2inCaTpNGQAScVyVDz/PG+CUJugWjzvZkhaCwnb8cqgp+sHQS3JX6Ct9m1D
         TYCb8Zy+f264iHS0oWUZqvw4NoscHMf8uyuet7rRZMV4kdJJFVQIAWYVnJKpsmuWxCiN
         0qq2lkjzZr2IS7u0fE9/z4ML99skJVle7eghQngh70in28NzXbi13r+96Ze+fl6T7nYa
         GBHA==
X-Gm-Message-State: APt69E0RV+4sIJ9Gx9NnDJs6ZWt/Vr+GspR43Kriiis26sfYFv+XYlD6
        ETU34ns0eYxlqJ7auCGtmF7IMoJVSmo=
X-Google-Smtp-Source: AAOMgpcliNZPckQaC46iuvQtF9How/enwOSB/pM5GeWlhaTt9BWoTFO+Fi+zqcouktLe6xBVmTl99Q==
X-Received: by 2002:a63:1546:: with SMTP id 6-v6mr8808447pgv.271.1530568934429;
        Mon, 02 Jul 2018 15:02:14 -0700 (PDT)
Received: from shakeelb.mtv.corp.google.com ([2620:15c:2cb:201:3a5f:3a4f:fa44:6b63])
        by smtp.gmail.com with ESMTPSA id i89-v6sm30086229pfi.170.2018.07.02.15.02.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 15:02:13 -0700 (PDT)
From:   Shakeel Butt <shakeelb@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>
Subject: [PATCH] fs-mm-account-buffer_head-to-kmemcg.patch.fix
Date:   Mon,  2 Jul 2018 15:02:08 -0700
Message-Id: <20180702220208.213380-1-shakeelb@google.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
In-Reply-To: <20180627191250.209150-3-shakeelb@google.com>
References: <20180627191250.209150-3-shakeelb@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch "fs, mm: account buffer_head to kmemcg" missed to add
__GFP_ACCOUNT flag into the gfp mask for directed memcg charging. So,
adding it. Andrew, please squash this into the original patch.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 fs/buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index e08863af56f6..405d4723ed3d 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -814,7 +814,7 @@ struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
 		bool retry)
 {
 	struct buffer_head *bh, *head;
-	gfp_t gfp = GFP_NOFS;
+	gfp_t gfp = GFP_NOFS | __GFP_ACCOUNT;
 	long offset;
 	struct mem_cgroup *memcg;
 
-- 
2.18.0.399.gad0ab374a1-goog

