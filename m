Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4A4ECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 06:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF1A2206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 06:40:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF1A2206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbeIRMLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 08:11:39 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:36971 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729295AbeIRMLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 08:11:38 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Mon, 17 Sep 2018 23:39:56 -0700
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 42F3E40951;
        Mon, 17 Sep 2018 23:40:20 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, Nadav Amit <namit@vmware.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        <virtualization@lists.linux-foundation.org>, <linux-mm@kvack.org>
Subject: [PATCH 14/19] mm/balloon_compaction: suppress allocation warnings
Date:   Mon, 17 Sep 2018 23:38:48 -0700
Message-ID: <20180918063853.198332-15-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180918063853.198332-1-namit@vmware.com>
References: <20180918063853.198332-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-002.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no reason to print warnings when balloon page allocation fails.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org
Cc: linux-mm@kvack.org
Reviewed-by: Xavier Deguillard <xdeguillard@vmware.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 mm/balloon_compaction.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index ef858d547e2d..a6c0efb3544f 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -22,7 +22,8 @@
 struct page *balloon_page_alloc(void)
 {
 	struct page *page = alloc_page(balloon_mapping_gfp_mask() |
-				       __GFP_NOMEMALLOC | __GFP_NORETRY);
+				       __GFP_NOMEMALLOC | __GFP_NORETRY |
+				       __GFP_NOWARN);
 	return page;
 }
 EXPORT_SYMBOL_GPL(balloon_page_alloc);
-- 
2.17.1

