Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8915C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 806D52148E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789793;
	bh=/uZsgQNW9hmBX6r1/lJ81JBZdLY3Ctssma43YpH1rWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lP4g1fStrEWYGcHfxXZFwgV6znYiWxWv4VPtruIs5bJsNAYe/WzrGNX7UL1I7tViv
	 dHq2l3bg2HM140C3eCUnvjj+gCb0ok1nxszUf/ezeSvh5dH9y7bkvz8pxERY+3IpxD
	 1bKGtHOAhMDFaXW9uPL0T6YI9Txq/0p1kUSsLLt8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 806D52148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732773AbeLNMQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:16:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:36682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732757AbeLNMQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:16:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B6062133F;
        Fri, 14 Dec 2018 12:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789788;
        bh=/uZsgQNW9hmBX6r1/lJ81JBZdLY3Ctssma43YpH1rWw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SJzmHqe0UMq0Kf2aHbgr7hXMOlTjcDO1Vz38PMTH6uoWIIt6edkD+F0bUnLyp2lcr
         +gYavQpip/d+Kf6Qok74NgGMzSChyAJw/JhCgDyaxJr4fSThBxdLEalS9gkqqy7G3Z
         xung0YjerTYtTxxDIvnWdUpTiNFV4dxCpjeBIe2E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>,
        Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 77/88] mm: replace get_user_pages_locked() write/force parameters with gup_flags
Date:   Fri, 14 Dec 2018 13:00:51 +0100
Message-Id: <20181214115708.508349431@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115702.151309521@linuxfoundation.org>
References: <20181214115702.151309521@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lorenzo Stoakes <lstoakes@gmail.com>

commit 3b913179c3fa89dd0e304193fa0c746fc0481447 upstream.

This removes the 'write' and 'force' use from get_user_pages_locked()
and replaces them with 'gup_flags' to make the use of FOLL_FORCE
explicit in callers as use of this flag can result in surprising
behaviour (and hence bugs) within the mm subsystem.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[bwh: Backported to 4.4: adjust context]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/mm.h |    3 +--
 mm/frame_vector.c  |    8 +++++++-
 mm/gup.c           |   12 +++---------
 mm/nommu.c         |    5 ++++-
 4 files changed, 15 insertions(+), 13 deletions(-)

--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1203,8 +1203,7 @@ long get_user_pages(struct task_struct *
 		    struct vm_area_struct **vmas);
 long get_user_pages_locked(struct task_struct *tsk, struct mm_struct *mm,
 		    unsigned long start, unsigned long nr_pages,
-		    int write, int force, struct page **pages,
-		    int *locked);
+		    unsigned int gup_flags, struct page **pages, int *locked);
 long __get_user_pages_unlocked(struct task_struct *tsk, struct mm_struct *mm,
 			       unsigned long start, unsigned long nr_pages,
 			       struct page **pages, unsigned int gup_flags);
--- a/mm/frame_vector.c
+++ b/mm/frame_vector.c
@@ -41,10 +41,16 @@ int get_vaddr_frames(unsigned long start
 	int ret = 0;
 	int err;
 	int locked;
+	unsigned int gup_flags = 0;
 
 	if (nr_frames == 0)
 		return 0;
 
+	if (write)
+		gup_flags |= FOLL_WRITE;
+	if (force)
+		gup_flags |= FOLL_FORCE;
+
 	if (WARN_ON_ONCE(nr_frames > vec->nr_allocated))
 		nr_frames = vec->nr_allocated;
 
@@ -59,7 +65,7 @@ int get_vaddr_frames(unsigned long start
 		vec->got_ref = true;
 		vec->is_pfns = false;
 		ret = get_user_pages_locked(current, mm, start, nr_frames,
-			write, force, (struct page **)(vec->ptrs), &locked);
+			gup_flags, (struct page **)(vec->ptrs), &locked);
 		goto out;
 	}
 
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -737,18 +737,12 @@ static __always_inline long __get_user_p
  */
 long get_user_pages_locked(struct task_struct *tsk, struct mm_struct *mm,
 			   unsigned long start, unsigned long nr_pages,
-			   int write, int force, struct page **pages,
+			   unsigned int gup_flags, struct page **pages,
 			   int *locked)
 {
-	unsigned int flags = FOLL_TOUCH;
-
-	if (write)
-		flags |= FOLL_WRITE;
-	if (force)
-		flags |= FOLL_FORCE;
-
 	return __get_user_pages_locked(tsk, mm, start, nr_pages,
-				       pages, NULL, locked, true, flags);
+				       pages, NULL, locked, true,
+				       gup_flags | FOLL_TOUCH);
 }
 EXPORT_SYMBOL(get_user_pages_locked);
 
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -201,9 +201,12 @@ EXPORT_SYMBOL(get_user_pages);
 
 long get_user_pages_locked(struct task_struct *tsk, struct mm_struct *mm,
 			   unsigned long start, unsigned long nr_pages,
-			   int write, int force, struct page **pages,
+			   unsigned int gup_flags, struct page **pages,
 			   int *locked)
 {
+	int write = gup_flags & FOLL_WRITE;
+	int force = gup_flags & FOLL_FORCE;
+
 	return get_user_pages(tsk, mm, start, nr_pages, write, force,
 			      pages, NULL);
 }


