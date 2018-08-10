Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1769DC46460
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 01:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2FA2223A6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 01:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=tom.com header.i=@tom.com header.b="xnYLHKo1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2FA2223A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=tom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbeHJEE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 00:04:28 -0400
Received: from smtprz14.163.net ([106.3.154.247]:59507 "EHLO smtp.tom.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725724AbeHJEE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 00:04:28 -0400
Received: from antispam1.tom.com (unknown [172.25.16.55])
        by freemail01.tom.com (Postfix) with ESMTP id 648A61C80E07
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 08:29:17 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=201807;
        t=1533860957; bh=kkr0rmNyVHLT08DMyrgPHVJvmTyplOXY60evB4g3gwc=;
        h=From:To:Cc:Subject:Date:From;
        b=xnYLHKo1hId7vLa7Ihmtp8oWTQea+84n5UpklNGc7Rzsv2vUjr44TtzpxWkLtsrPW
         MNZW5pqEDUR3OnJE5CFEWIFSeXlpAuEFK8t/u46tzljBVOptLHiQiYS8l1UqGoS8j0
         LV5gJLpzSklMBQZTYwW1qc06XOV9RqBmS2QluCFI=
Received: from antispam1.tom.com (antispam1.tom.com [127.0.0.1])
        by antispam1.tom.com (Postfix) with ESMTP id 5C92E100133B
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 08:29:17 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at antispam1.tom.com
Received: from antispam1.tom.com ([127.0.0.1])
        by antispam1.tom.com (antispam1.tom.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KMvRrR8gaNcL for <linux-kernel@vger.kernel.org>;
        Fri, 10 Aug 2018 08:29:15 +0800 (CST)
Received: from localhost.localdomain (unknown [59.63.206.36])
        by antispam1.tom.com (Postfix) with ESMTPA id CCC951001333;
        Fri, 10 Aug 2018 08:29:14 +0800 (CST)
From:   zhouxianrong <zhouxianrong@tom.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        zhouxianrong@tom.com, zhouxianrong <zhouxianrong@huawei.com>
Subject: [PATCH] zsmalloc: fix linking bug in init_zspage
Date:   Thu,  9 Aug 2018 20:28:17 -0400
Message-Id: <20180810002817.2667-1-zhouxianrong@tom.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhouxianrong <zhouxianrong@huawei.com>

The last partial object in last subpage of zspage should not be linked
in allocation list. Otherwise it could trigger BUG_ON explicitly at
function zs_map_object. But it happened rarely.

Signed-off-by: zhouxianrong <zhouxianrong@huawei.com>
---
 mm/zsmalloc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 8d87e973a4f5..24dd8da0aa59 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1040,6 +1040,8 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
 			 * Reset OBJ_TAG_BITS bit to last link to tell
 			 * whether it's allocated object or not.
 			 */
+			if (off > PAGE_SIZE)
+				link -= class->size / sizeof(*link);
 			link->next = -1UL << OBJ_TAG_BITS;
 		}
 		kunmap_atomic(vaddr);
-- 
2.13.6

