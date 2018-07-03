Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44087C3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9C4323DA8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:27:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9C4323DA8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932553AbeGCC1V (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 22:27:21 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:35328 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932381AbeGCC1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 22:27:20 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Mon, 2 Jul 2018 19:27:17 -0700
Received: from htb-2n-eng-dhcp405.eng.vmware.com (unknown [10.33.114.36])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 7395D4078A;
        Mon,  2 Jul 2018 19:27:19 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        <xdeguillard@vmware.com>, Nadav Amit <namit@vmware.com>,
        <stable@vger.kernel.org>
Subject: [PATCH] vmw_balloon: fix inflation with batching
Date:   Mon, 2 Jul 2018 19:27:13 -0700
Message-ID: <20180703022713.24345-1-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-001.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Embarrassingly, the recent fix introduced worse problem than it solved,
causing the balloon not to inflate. The VM informed the hypervisor that
the pages for lock/unlock are sitting in the wrong address, as it used
the page that is used the uninitialized page variable.

Fixes: b23220fe054e9 ("vmw_balloon: fixing double free when batching mode is off")
Cc: stable@vger.kernel.org
Reviewed-by: Xavier Deguillard <xdeguillard@vmware.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 drivers/misc/vmw_balloon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index efd733472a35..56c6f79a5c5a 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -467,7 +467,7 @@ static int vmballoon_send_batched_lock(struct vmballoon *b,
 		unsigned int num_pages, bool is_2m_pages, unsigned int *target)
 {
 	unsigned long status;
-	unsigned long pfn = page_to_pfn(b->page);
+	unsigned long pfn = PHYS_PFN(virt_to_phys(b->batch_page));
 
 	STATS_INC(b->stats.lock[is_2m_pages]);
 
@@ -515,7 +515,7 @@ static bool vmballoon_send_batched_unlock(struct vmballoon *b,
 		unsigned int num_pages, bool is_2m_pages, unsigned int *target)
 {
 	unsigned long status;
-	unsigned long pfn = page_to_pfn(b->page);
+	unsigned long pfn = PHYS_PFN(virt_to_phys(b->batch_page));
 
 	STATS_INC(b->stats.unlock[is_2m_pages]);
 
-- 
2.17.1

