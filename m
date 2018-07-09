Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C6EC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3141520873
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:55:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3141520873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932903AbeGIMzV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 08:55:21 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:26167 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932688AbeGIMzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 08:55:19 -0400
Received: from fsav402.sakura.ne.jp (fsav402.sakura.ne.jp [133.242.250.101])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w69CtI3M053863;
        Mon, 9 Jul 2018 21:55:18 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav402.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp);
 Mon, 09 Jul 2018 21:55:18 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w69CtE6r053843
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 9 Jul 2018 21:55:17 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: BUG: corrupted list in cpu_stop_queue_work
To:     Matthew Wilcox <willy@infradead.org>
References: <00000000000032412205706753b5@google.com>
 <000000000000693c7d057087caf3@google.com>
Cc:     syzbot <syzbot+d8a8e42dfba0454286ff@syzkaller.appspotmail.com>,
        bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        matt@codeblueprint.co.uk, mingo@kernel.org, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        linux-mm <linux-mm@kvack.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <1271c58e-876b-0df3-3224-319d82634663@I-love.SAKURA.ne.jp>
Date:   Mon, 9 Jul 2018 21:55:17 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <000000000000693c7d057087caf3@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Matthew,

It seems to me that there are other locations which do not check xas_store()
failure. Is that really OK? If they are OK, I think we want a comment like
/* This never fails. */ or /* Failure is OK because ... */
for each call without failure check.



From d6f24d6eecd79836502527624f8086f4e3e4c331 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Mon, 9 Jul 2018 15:58:44 +0900
Subject: [PATCH] shmem: Fix crash upon xas_store() failure.

syzbot is reporting list corruption [1]. This is because xas_store() from
shmem_add_to_page_cache() is not handling memory allocation failure. Fix
this by checking xas_error() after xas_store().

[1] https://syzkaller.appspot.com/bug?id=ccf34b892706ff6f3321da526329476eab23d5a0

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot+d8a8e42dfba0454286ff@syzkaller.appspotmail.com
Fixes: "shmem: Convert shmem_add_to_page_cache to XArray"
---
 mm/shmem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index 0f151c8..382aeb3 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -606,6 +606,8 @@ static int shmem_add_to_page_cache(struct page *page,
 		}
 next:
 		xas_store(&xas, page + i);
+		if (xas_error(&xas))
+			goto unlock;
 		if (++i < nr) {
 			xas_next(&xas);
 			goto next;
-- 
1.8.3.1

