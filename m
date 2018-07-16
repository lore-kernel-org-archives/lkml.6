Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA1EECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB91B2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:44:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB91B2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389354AbeGPIKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:10:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48202 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388522AbeGPIK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:10:29 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A9331C03;
        Mon, 16 Jul 2018 07:44:26 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xavier Deguillard <xdeguillard@vmware.com>,
        Nadav Amit <namit@vmware.com>
Subject: [PATCH 4.4 03/43] vmw_balloon: fix inflation with batching
Date:   Mon, 16 Jul 2018 09:36:08 +0200
Message-Id: <20180716073512.143167619@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716073511.796555857@linuxfoundation.org>
References: <20180716073511.796555857@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nadav Amit <namit@vmware.com>

commit 90d72ce079791399ac255c75728f3c9e747b093d upstream.

Embarrassingly, the recent fix introduced worse problem than it solved,
causing the balloon not to inflate. The VM informed the hypervisor that
the pages for lock/unlock are sitting in the wrong address, as it used
the page that is used the uninitialized page variable.

Fixes: b23220fe054e9 ("vmw_balloon: fixing double free when batching mode is off")
Cc: stable@vger.kernel.org
Reviewed-by: Xavier Deguillard <xdeguillard@vmware.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/misc/vmw_balloon.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -467,7 +467,7 @@ static int vmballoon_send_batched_lock(s
 		unsigned int num_pages, bool is_2m_pages, unsigned int *target)
 {
 	unsigned long status;
-	unsigned long pfn = page_to_pfn(b->page);
+	unsigned long pfn = PHYS_PFN(virt_to_phys(b->batch_page));
 
 	STATS_INC(b->stats.lock[is_2m_pages]);
 
@@ -515,7 +515,7 @@ static bool vmballoon_send_batched_unloc
 		unsigned int num_pages, bool is_2m_pages, unsigned int *target)
 {
 	unsigned long status;
-	unsigned long pfn = page_to_pfn(b->page);
+	unsigned long pfn = PHYS_PFN(virt_to_phys(b->batch_page));
 
 	STATS_INC(b->stats.unlock[is_2m_pages]);
 


