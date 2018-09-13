Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429A4C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 017A120C0A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:34:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 017A120C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbeIMSoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:44:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58962 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727666AbeIMSoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:44:20 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 864F7CF3;
        Thu, 13 Sep 2018 13:34:50 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "natechancellor@gmail.com, mark.rutland@arm.com, will.deacon@arm.com,
        steve.capper@arm.com, kirill.shutemov@linux.intel.com, vbabka@suse.cz,
        mgorman@suse.de, Chas Williams" <chas3@att.com>,
        Chas Williams <chas3@att.com>
Subject: [PATCH 4.4 42/60] Fixes: Commit cdbf92675fad ("mm: numa: avoid waiting on freed migrated pages")
Date:   Thu, 13 Sep 2018 15:30:49 +0200
Message-Id: <20180913131747.410834060@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131745.261413581@linuxfoundation.org>
References: <20180913131745.261413581@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------


From: Chas Williams <chas3@att.com>

Commit cdbf92675fad ("mm: numa: avoid waiting on freed migrated pages")
was an incomplete backport of the upstream commit.  It is necessary to
always reset page_nid before attempting any early exit.

The original commit conflicted due to lack of commit 82b0f8c39a38
("mm: join struct fault_env and vm_fault") in 4.9 so it wasn't a clean
application, and the change must have just gotten lost in the noise.

Signed-off-by: Chas Williams <chas3@att.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/huge_memory.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1393,12 +1393,12 @@ int do_huge_pmd_numa_page(struct mm_stru
 
 	/* Migration could have started since the pmd_trans_migrating check */
 	if (!page_locked) {
+		page_nid = -1;
 		if (!get_page_unless_zero(page))
 			goto out_unlock;
 		spin_unlock(ptl);
 		wait_on_page_locked(page);
 		put_page(page);
-		page_nid = -1;
 		goto out;
 	}
 


