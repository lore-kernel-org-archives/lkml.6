Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFCCC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8736E21533
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:15:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8736E21533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbeI0B3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 21:29:40 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:25069 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727460AbeI0B3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 21:29:39 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 26 Sep 2018 12:15:05 -0700
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 9E78BB05DE;
        Wed, 26 Sep 2018 15:15:09 -0400 (EDT)
From:   Nadav Amit <namit@vmware.com>
To:     Arnd Bergmann <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC:     Xavier Deguillard <xdeguillard@vmware.com>,
        <linux-kernel@vger.kernel.org>, Nadav Amit <namit@vmware.com>
Subject: [PATCH v3 08/20] vmw_balloon: rename VMW_BALLOON_2M_SHIFT to VMW_BALLOON_2M_ORDER
Date:   Wed, 26 Sep 2018 12:13:24 -0700
Message-ID: <20180926191336.101885-9-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180926191336.101885-1-namit@vmware.com>
References: <20180926191336.101885-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-002.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The name of the macro'd VMW_BALLOON_2M_SHIFT is misleading. The value
reflects 2M huge-page order. Unfortunately, we cannot use
HPAGE_PMD_ORDER, since it is not defined when transparent huge-pages are
off, so we need to define our own one.

Rename it to VMW_BALLOON_2M_ORDER. No functional change.

Signed-off-by: Nadav Amit <namit@vmware.com>
---
 drivers/misc/vmw_balloon.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index 4e067d269706..626abe65eddb 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -77,7 +77,7 @@ enum vmwballoon_capabilities {
 					| VMW_BALLOON_BATCHED_2M_CMDS \
 					| VMW_BALLOON_SIGNALLED_WAKEUP_CMD)
 
-#define VMW_BALLOON_2M_SHIFT		(9)
+#define VMW_BALLOON_2M_ORDER		(PMD_SHIFT - PAGE_SHIFT)
 #define VMW_BALLOON_NUM_PAGE_SIZES	(2)
 
 /*
@@ -348,7 +348,7 @@ static bool vmballoon_send_guest_id(struct vmballoon *b)
 static u16 vmballoon_page_size(bool is_2m_page)
 {
 	if (is_2m_page)
-		return 1 << VMW_BALLOON_2M_SHIFT;
+		return 1 << VMW_BALLOON_2M_ORDER;
 
 	return 1;
 }
@@ -387,7 +387,7 @@ static struct page *vmballoon_alloc_page(bool is_2m_page)
 {
 	if (is_2m_page)
 		return alloc_pages(VMW_HUGE_PAGE_ALLOC_FLAGS,
-				   VMW_BALLOON_2M_SHIFT);
+				   VMW_BALLOON_2M_ORDER);
 
 	return alloc_page(VMW_PAGE_ALLOC_FLAGS);
 }
@@ -395,7 +395,7 @@ static struct page *vmballoon_alloc_page(bool is_2m_page)
 static void vmballoon_free_page(struct page *page, bool is_2m_page)
 {
 	if (is_2m_page)
-		__free_pages(page, VMW_BALLOON_2M_SHIFT);
+		__free_pages(page, VMW_BALLOON_2M_ORDER);
 	else
 		__free_page(page);
 }
-- 
2.17.1

