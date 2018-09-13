Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B57C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A30F20652
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:05:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A30F20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731894AbeIMTPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:15:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35492 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728095AbeIMTPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:15:08 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D38F3D39;
        Thu, 13 Sep 2018 14:05:28 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nadav Amit <namit@vmware.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.18 183/197] mm: respect arch_dup_mmap() return value
Date:   Thu, 13 Sep 2018 15:32:12 +0200
Message-Id: <20180913131848.884233380@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nadav Amit <namit@vmware.com>

commit 1ed0cc5a01a4d868d9907ce96468c4b4c6709556 upstream.

Commit d70f2a14b72a ("include/linux/sched/mm.h: uninline mmdrop_async(),
etc") ignored the return value of arch_dup_mmap(). As a result, on x86,
a failure to duplicate the LDT (e.g. due to memory allocation error)
would leave the duplicated memory mapping in an inconsistent state.

Fix by using the return value, as it was before the change.

Link: http://lkml.kernel.org/r/20180823051229.211856-1-namit@vmware.com
Fixes: d70f2a14b72a4 ("include/linux/sched/mm.h: uninline mmdrop_async(), etc")
Signed-off-by: Nadav Amit <namit@vmware.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

---
 kernel/fork.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -549,8 +549,7 @@ static __latent_entropy int dup_mmap(str
 			goto out;
 	}
 	/* a new mm has just been created */
-	arch_dup_mmap(oldmm, mm);
-	retval = 0;
+	retval = arch_dup_mmap(oldmm, mm);
 out:
 	up_write(&mm->mmap_sem);
 	flush_tlb_mm(oldmm);


