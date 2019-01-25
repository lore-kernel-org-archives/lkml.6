Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C164AC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EB14218D9
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbfAYNfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 08:35:13 -0500
Received: from smtprz14.163.net ([106.3.154.247]:45344 "EHLO smtp.tom.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726095AbfAYNfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 08:35:13 -0500
Received: from 172.25.16.148 (unknown [172.25.16.148])
        by freemail02.tom.com (Postfix) with ESMTP id 9A606B00DB7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 21:34:55 +0800 (CST)
Received: from 172.25.16.91 (HELO smtp.tom.com) ([172.25.16.91])
          by localhost (TOM SMTP Server) with SMTP ID 1938871118
          for <linux-kernel@vger.kernel.org>;
          Fri, 25 Jan 2019 21:34:55 +0800 (CST)
Received: from antispam2.tom.com (unknown [172.25.16.56])
        by freemail02.tom.com (Postfix) with ESMTP id 28283B00D37
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 21:34:55 +0800 (CST)
Received: from antispam2.tom.com (antispam2.tom.com [127.0.0.1])
        by antispam2.tom.com (Postfix) with ESMTP id 261028162E
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 21:34:55 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at antispam2.tom.com
Received: from antispam2.tom.com ([127.0.0.1])
        by antispam2.tom.com (antispam2.tom.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id EBdwy3wsjz6q for <linux-kernel@vger.kernel.org>;
        Fri, 25 Jan 2019 21:34:54 +0800 (CST)
Received: from localhost (unknown [222.209.19.163])
        by antispam2.tom.com (Postfix) with ESMTPA id BE7F0815E1;
        Fri, 25 Jan 2019 21:34:53 +0800 (CST)
From:   Liu Xiang <liu.xiang6@zte.com.cn>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, liuxiang_1999@126.com,
        Liu Xiang <liu.xiang6@zte.com.cn>
Subject: [PATCH] mm/filemap.c: Simplify the calculation of ra->prev_pos
Date:   Fri, 25 Jan 2019 21:34:48 +0800
Message-Id: <1548423288-4225-1-git-send-email-liu.xiang6@zte.com.cn>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The calculation of ra->prev_pos can be simplified.

Signed-off-by: Liu Xiang <liu.xiang6@zte.com.cn>
---
 mm/filemap.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 9f5e323..7f30844 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2279,9 +2279,7 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 would_block:
 	error = -EAGAIN;
 out:
-	ra->prev_pos = prev_index;
-	ra->prev_pos <<= PAGE_SHIFT;
-	ra->prev_pos |= prev_offset;
+	ra->prev_pos = (prev_index << PAGE_SHIFT) | prev_offset;
 
 	*ppos = ((loff_t)index << PAGE_SHIFT) + offset;
 	file_accessed(filp);
-- 
1.9.1

