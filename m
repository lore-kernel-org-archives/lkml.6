Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F90C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A601F21904
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550497980;
	bh=JPuOPPwe1vpd79QlefI/HJMcOG+y33JJ+4UuB/2XBbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qYHtsblVWKRDwGz7JcpE73KqCV75nW+Fq4RK7KrIJ5pdvOd2XsIsTCC/E4FEUQHvt
	 WbQzqobT7uiJzN+5vcaiY+Tx6OvNXVAIIGsl3brm9FxO2jPaJ5PLcQ2bNC35hRmlh2
	 NBCJKGXPxtkwCkxfCs4AV7ABLp7ALerF6cZSngBA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732850AbfBRNw7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:52:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:60810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731591AbfBRNwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:52:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C27621901;
        Mon, 18 Feb 2019 13:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497972;
        bh=JPuOPPwe1vpd79QlefI/HJMcOG+y33JJ+4UuB/2XBbY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zMr55T5G3jEhozuL8wJeRaaoa/aOCThoFreL/M/QT1WMIBuWEeZ8NY9/436xekPPh
         ES4RNJteQoJbvhQmx6dkTLzGRPnQe6s56dPGgH1+Moif049Ohfs0OIO6KxLoJYQKRa
         lzTEEzObYJnQqn3XgHfA9kle4hICgiFZ2XW1ZXXI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Chinner <dchinner@redhat.com>,
        Wolfgang Walter <linux@stwm.de>, Roman Gushchin <guro@fb.com>,
        Spock <dairinin@gmail.com>, Rik van Riel <riel@surriel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.19 69/85] Revert "mm: slowly shrink slabs with a relatively small number of objects"
Date:   Mon, 18 Feb 2019 14:43:35 +0100
Message-Id: <20190218133506.595726183@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133459.758004711@linuxfoundation.org>
References: <20190218133459.758004711@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Chinner <dchinner@redhat.com>

commit a9a238e83fbb0df31c3b9b67003f8f9d1d1b6c96 upstream.

This reverts commit 172b06c32b9497 ("mm: slowly shrink slabs with a
relatively small number of objects").

This change changes the agressiveness of shrinker reclaim, causing small
cache and low priority reclaim to greatly increase scanning pressure on
small caches.  As a result, light memory pressure has a disproportionate
affect on small caches, and causes large caches to be reclaimed much
faster than previously.

As a result, it greatly perturbs the delicate balance of the VFS caches
(dentry/inode vs file page cache) such that the inode/dentry caches are
reclaimed much, much faster than the page cache and this drives us into
several other caching imbalance related problems.

As such, this is a bad change and needs to be reverted.

[ Needs some massaging to retain the later seekless shrinker
  modifications.]

Link: http://lkml.kernel.org/r/20190130041707.27750-3-david@fromorbit.com
Fixes: 172b06c32b9497 ("mm: slowly shrink slabs with a relatively small number of objects")
Signed-off-by: Dave Chinner <dchinner@redhat.com>
Cc: Wolfgang Walter <linux@stwm.de>
Cc: Roman Gushchin <guro@fb.com>
Cc: Spock <dairinin@gmail.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/vmscan.c |   10 ----------
 1 file changed, 10 deletions(-)

--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -477,16 +477,6 @@ static unsigned long do_shrink_slab(stru
 	delta *= 4;
 	do_div(delta, shrinker->seeks);
 
-	/*
-	 * Make sure we apply some minimal pressure on default priority
-	 * even on small cgroups. Stale objects are not only consuming memory
-	 * by themselves, but can also hold a reference to a dying cgroup,
-	 * preventing it from being reclaimed. A dying cgroup with all
-	 * corresponding structures like per-cpu stats and kmem caches
-	 * can be really big, so it may lead to a significant waste of memory.
-	 */
-	delta = max_t(unsigned long long, delta, min(freeable, batch_size));
-
 	total_scan += delta;
 	if (total_scan < 0) {
 		pr_err("shrink_slab: %pF negative objects to delete nr=%ld\n",


