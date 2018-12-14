Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 778A5C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BE4C214C1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789784;
	bh=jqZhj4tmnKukO3pMtsvGyJLHZ0tmxPbj0vUuR/MIURo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gz/4dB3guhK1wZcXdfJvrdECmOC+4p+XZROVME+cWBMIw8TgP2b/3AP+04Zd4RzF2
	 lP08ni1uI0/ueSIZuScht5g91EBJpMg7Kt48Vdc9p1ff5KsdLg+bbQzWWabXA0h0tX
	 kMRQmQOpnKsETnTqAd6tRnzNY5QosoKoxAg4OC8c=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BE4C214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732753AbeLNMQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:16:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:36552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732139AbeLNMQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:16:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5800D2148E;
        Fri, 14 Dec 2018 12:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789780;
        bh=jqZhj4tmnKukO3pMtsvGyJLHZ0tmxPbj0vUuR/MIURo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yd0qt94/l1Jg41WcnPJnRVduhSlrUba+mluQLgYstJ0HUKHOWZknRPAjqgiSF+2MY
         hIcwBtYMcAo+dluI3guxX0AqntmW/cwj2g0ga9JUN6DAk2t+3vvubeH82H4Ld+1rs3
         aOAs/flC1ax41ij8DdLtzhMgGPQyDjX1DpZyCSAc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 74/88] mm: remove write/force parameters from __get_user_pages_locked()
Date:   Fri, 14 Dec 2018 13:00:48 +0100
Message-Id: <20181214115708.318156906@linuxfoundation.org>
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

commit 859110d7497cdd0e6b21010d6f777049d676382c upstream.

This removes the redundant 'write' and 'force' parameters from
__get_user_pages_locked() to make the use of FOLL_FORCE explicit in
callers as use of this flag can result in surprising behaviour (and
hence bugs) within the mm subsystem.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[bwh: Backported to 4.4:
 - Drop change in get_user_pages_remote()
 - Adjust context]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/gup.c |   37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

--- a/mm/gup.c
+++ b/mm/gup.c
@@ -627,7 +627,6 @@ static __always_inline long __get_user_p
 						struct mm_struct *mm,
 						unsigned long start,
 						unsigned long nr_pages,
-						int write, int force,
 						struct page **pages,
 						struct vm_area_struct **vmas,
 						int *locked, bool notify_drop,
@@ -645,10 +644,6 @@ static __always_inline long __get_user_p
 
 	if (pages)
 		flags |= FOLL_GET;
-	if (write)
-		flags |= FOLL_WRITE;
-	if (force)
-		flags |= FOLL_FORCE;
 
 	pages_done = 0;
 	lock_dropped = false;
@@ -745,8 +740,15 @@ long get_user_pages_locked(struct task_s
 			   int write, int force, struct page **pages,
 			   int *locked)
 {
-	return __get_user_pages_locked(tsk, mm, start, nr_pages, write, force,
-				       pages, NULL, locked, true, FOLL_TOUCH);
+	unsigned int flags = FOLL_TOUCH;
+
+	if (write)
+		flags |= FOLL_WRITE;
+	if (force)
+		flags |= FOLL_FORCE;
+
+	return __get_user_pages_locked(tsk, mm, start, nr_pages,
+				       pages, NULL, locked, true, flags);
 }
 EXPORT_SYMBOL(get_user_pages_locked);
 
@@ -767,9 +769,15 @@ __always_inline long __get_user_pages_un
 {
 	long ret;
 	int locked = 1;
+
+	if (write)
+		gup_flags |= FOLL_WRITE;
+	if (force)
+		gup_flags |= FOLL_FORCE;
+
 	down_read(&mm->mmap_sem);
-	ret = __get_user_pages_locked(tsk, mm, start, nr_pages, write, force,
-				      pages, NULL, &locked, false, gup_flags);
+	ret = __get_user_pages_locked(tsk, mm, start, nr_pages, pages, NULL,
+				      &locked, false, gup_flags);
 	if (locked)
 		up_read(&mm->mmap_sem);
 	return ret;
@@ -861,8 +869,15 @@ long get_user_pages(struct task_struct *
 		unsigned long start, unsigned long nr_pages, int write,
 		int force, struct page **pages, struct vm_area_struct **vmas)
 {
-	return __get_user_pages_locked(tsk, mm, start, nr_pages, write, force,
-				       pages, vmas, NULL, false, FOLL_TOUCH);
+	unsigned int flags = FOLL_TOUCH;
+
+	if (write)
+		flags |= FOLL_WRITE;
+	if (force)
+		flags |= FOLL_FORCE;
+
+	return __get_user_pages_locked(tsk, mm, start, nr_pages,
+				       pages, vmas, NULL, false, flags);
 }
 EXPORT_SYMBOL(get_user_pages);
 


