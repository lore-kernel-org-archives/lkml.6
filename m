Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08A0C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 03:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A614120855
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 03:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="RIkjrbl3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbeLaDDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 22:03:11 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44731 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbeLaDDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 22:03:11 -0500
Received: by mail-qt1-f193.google.com with SMTP id n32so28374613qte.11
        for <linux-kernel@vger.kernel.org>; Sun, 30 Dec 2018 19:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=d4KYS8YMtiignV1VOD2/X2g4gyDrGL+kfAiXjO2ePL0=;
        b=RIkjrbl3V2d4qSIbW+6h6V0swPyb3N0G/pbsT1hnrOF90js9/FNMAppC1nIhghAqD4
         7bzYfjbzbZZLDEuY17cQ5qGCw4jOWgFRgEm9aVaLKv7mbC3QQalRybZuIufeo9KqjFxc
         xl+cCzPzATPXM6IKOdRYtb0HQLIYDSrTzEk2rQPF448rnWbq+dr9lcLUww1pffciV5de
         EC5WnnisljKv9vl/vwhCWj0G7QIpejuja05kcs+33p7wa6anFfRN8o/PDxQjfqgDtBcz
         89V5nZgLRcpA95XgBM1B+e2CQaFMg13JoMS/WC3Q/ZunHwzntQoj6BBd6xvS9xNBXJBX
         9G8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=d4KYS8YMtiignV1VOD2/X2g4gyDrGL+kfAiXjO2ePL0=;
        b=OQwYQmtW0c34v/J3ID1jt6yQe3uFTm5irpZQhgePTwr72Amr9A9prmyOJECX/YbG7K
         tXfEMqW8I8CC/xX1SstbublLFoHYE/z2uvQZM7pi14isYLWvhnCqGh7dNf7I/2si8J3L
         9owiWKzjsj/D+3fv4XRKL8hw+WkDGQm7EsE7EZJnqUveWzg+Q5ZkGek1NKXOVc2rWgnR
         Tt/GhwghBuOjKl3RdLuq+eHfQHoLi6ftzKU7539XBsxN4RsqYI8HqdqFUWz14AhlFwbe
         8XW8eol5niwxlpsBkGe03OndqeyrKmA5LZDi4oQ6k5OTkmzT1PNQ3T9phPRi/7FtaA4u
         WQlw==
X-Gm-Message-State: AJcUukeTPNGEJq85BdIwLhl5X4TDei6IGRyLIOdKO5wo1/vsrkIxNKHr
        yUR4ksCa9UPB1kxgn8dRBi6XDA==
X-Google-Smtp-Source: ALg8bN4vfBV0h+/x6YxHpcpNaCK9HoDJF5c1Tiu5SYqtZhWaoBaQgek33nG0qXbdYRW7aIPqUaU6qQ==
X-Received: by 2002:a0c:c966:: with SMTP id v35mr35433867qvj.45.1546225390145;
        Sun, 30 Dec 2018 19:03:10 -0800 (PST)
Received: from ovpn-120-55.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id q5sm31485856qtq.20.2018.12.30.19.03.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Dec 2018 19:03:09 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     keescook@chromium.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] usercopy: no check page span for stack objects
Date:   Sun, 30 Dec 2018 22:02:54 -0500
Message-Id: <20181231030254.99441-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is easy to trigger this with CONFIG_HARDENED_USERCOPY_PAGESPAN=y,

usercopy: Kernel memory overwrite attempt detected to spans multiple
pages (offset 0, size 23)!
kernel BUG at mm/usercopy.c:102!

For example,

print_worker_info
char name[WQ_NAME_LEN] = { };
char desc[WORKER_DESC_LEN] = { };
  probe_kernel_read(name, wq->name, sizeof(name) - 1);
  probe_kernel_read(desc, worker->desc, sizeof(desc) - 1);
    __copy_from_user_inatomic
      check_object_size
        check_heap_object
          check_page_span

This is because on-stack variables could cross PAGE_SIZE boundary, and
failed this check,

if (likely(((unsigned long)ptr & (unsigned long)PAGE_MASK) ==
	   ((unsigned long)end & (unsigned long)PAGE_MASK)))

ptr = FFFF889007D7EFF8
end = FFFF889007D7F00E

Hence, fix it by checking if it is a stack object first.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/usercopy.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/usercopy.c b/mm/usercopy.c
index 852eb4e53f06..a1f58beaa246 100644
--- a/mm/usercopy.c
+++ b/mm/usercopy.c
@@ -262,9 +262,6 @@ void __check_object_size(const void *ptr, unsigned long n, bool to_user)
 	/* Check for invalid addresses. */
 	check_bogus_address((const unsigned long)ptr, n, to_user);
 
-	/* Check for bad heap object. */
-	check_heap_object(ptr, n, to_user);
-
 	/* Check for bad stack object. */
 	switch (check_stack_object(ptr, n)) {
 	case NOT_STACK:
@@ -282,6 +279,9 @@ void __check_object_size(const void *ptr, unsigned long n, bool to_user)
 		usercopy_abort("process stack", NULL, to_user, 0, n);
 	}
 
+	/* Check for bad heap object. */
+	check_heap_object(ptr, n, to_user);
+
 	/* Check for object in kernel to avoid text exposure. */
 	check_kernel_text_object((const unsigned long)ptr, n, to_user);
 }
-- 
2.17.2 (Apple Git-113)

