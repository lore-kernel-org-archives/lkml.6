Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C789C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8DA621E20
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=tom.com header.i=@tom.com header.b="Bo7oPjU/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8DA621E20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=tom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732079AbeHIQcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 12:32:08 -0400
Received: from smtprz14.163.net ([106.3.154.247]:48026 "EHLO smtp.tom.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730803AbeHIQcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 12:32:07 -0400
X-Greylist: delayed 744 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Aug 2018 12:32:05 EDT
Received: from antispam1.tom.com (unknown [172.25.16.55])
        by freemail01.tom.com (Postfix) with ESMTP id 1A71D1C80E86
        for <linux-kernel@vger.kernel.org>; Thu,  9 Aug 2018 21:54:25 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=201807;
        t=1533822865; bh=mlyZ/31eJFR0kJ6uOZgwqtBmx3NSF+Wb/78Ui1u++7c=;
        h=From:To:Cc:Subject:Date:From;
        b=Bo7oPjU/ez6hDWUJAZB+NvGqCWy6QRxYdya7GwOjUqITOswiu+WHdGJrnYDwpI4GR
         tLegBZ/aHKdqv+L/sc6LA0xlsDK+4ltTLfdoISSA8XtKCqpOfxpgU5fQtc0dGooiiC
         GX4/Cqh68igzSCmqOAoa+bqBCmCQKOhNTl/AZdl4=
Received: from antispam1.tom.com (antispam1.tom.com [127.0.0.1])
        by antispam1.tom.com (Postfix) with ESMTP id 166EA100129C
        for <linux-kernel@vger.kernel.org>; Thu,  9 Aug 2018 21:54:25 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at antispam1.tom.com
Received: from antispam1.tom.com ([127.0.0.1])
        by antispam1.tom.com (antispam1.tom.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xaDjsSGoAB-u for <linux-kernel@vger.kernel.org>;
        Thu,  9 Aug 2018 21:54:24 +0800 (CST)
Received: from localhost.localdomain (unknown [118.212.136.26])
        by antispam1.tom.com (Postfix) with ESMTPA id 71BBB1001035;
        Thu,  9 Aug 2018 21:54:24 +0800 (CST)
From:   zhouxianrong <zhouxianrong@tom.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        zhouxianrong@tom.com
Subject: [PATCH] zsmalloc: fix linking bug in init_zspage
Date:   Thu,  9 Aug 2018 09:53:56 -0400
Message-Id: <20180809135356.4070-1-zhouxianrong@tom.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The last partial object in last subpage of zspage should not be linked
in allocation list.

Signed-off-by: zhouxianrong <zhouxianrong@tom.com>
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

