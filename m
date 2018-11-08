Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FDAECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB33E21486
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uh5onaJJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB33E21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731748AbeKIHnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:43:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:35428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727227AbeKIHnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:43:11 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF9F020844;
        Thu,  8 Nov 2018 22:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714740;
        bh=UyN3P1C06sMEsM8DJFLtJYDHfMLitEyAQc9AJLxhuE4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uh5onaJJchCY5Sb0kLYGRySt2WJ8FmNlGcJgYZvpO4L7oyDdx1MwxxfsfbIc/JPAO
         DfO28wjpOPpMB32lx5083PZV2EioE1zRkuVFrkbyRbrl4KYj26SnF48Dcw+p7Du2xp
         JtmQLh0YRdWGJDFcZNb1q51YnAp1pABIr8Z0Jixs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        David Sterba <dsterba@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 097/171] mm/frame_vector.c: release a semaphore in get_vaddr_frames()
Date:   Thu,  8 Nov 2018 13:51:07 -0800
Message-Id: <20181108215134.528482156@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 1f704fd0d14043e76e80f6b8b2251b9b2cedcca6 ]

A semaphore is acquired before this check, so we must release it before
leaving.

Link: http://lkml.kernel.org/r/20171211211009.4971-1-christophe.jaillet@wanadoo.fr
Fixes: b7f0554a56f2 ("mm: fail get_vaddr_frames() for filesystem-dax mappings")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: David Sterba <dsterba@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/frame_vector.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/frame_vector.c b/mm/frame_vector.c
index 375a103d7a56..d73eed0443f6 100644
--- a/mm/frame_vector.c
+++ b/mm/frame_vector.c
@@ -61,8 +61,10 @@ int get_vaddr_frames(unsigned long start, unsigned int nr_frames,
 	 * get_user_pages_longterm() and disallow it for filesystem-dax
 	 * mappings.
 	 */
-	if (vma_is_fsdax(vma))
-		return -EOPNOTSUPP;
+	if (vma_is_fsdax(vma)) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
 
 	if (!(vma->vm_flags & (VM_IO | VM_PFNMAP))) {
 		vec->got_ref = true;
-- 
2.17.1



