Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6863CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F6E92148E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1qdV1Q3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F6E92148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388569AbeKTDJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:09:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:44812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387628AbeKTDJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:09:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C04D21104;
        Mon, 19 Nov 2018 16:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645928;
        bh=lg4YfKpD7qEYeb/vHGVLgOikIqzbFX9Qut0jPAR/Nzo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k1qdV1Q3E9rdrkzt6kWkLV66GaKH9GUHG9kNV6gfH1YiF+sXPIsiKkThZFno9C7tY
         zkugulaCvPrfN9gvsuEN+mAbpXY897ssUkyBtOJKO82Y8BiFSdd2NJze+J4HRYd68o
         UTQGU9f/NHk9MiA20hrlq7Npaxm1a/n7jJPzJdNc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Averin <vvs@virtuozzo.com>,
        Aaron Lu <aaron.lu@intel.com>, Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.18 142/171] mm/swapfile.c: use kvzalloc for swap_info_struct allocation
Date:   Mon, 19 Nov 2018 17:28:58 +0100
Message-Id: <20181119162638.994244818@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162618.909354448@linuxfoundation.org>
References: <20181119162618.909354448@linuxfoundation.org>
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

From: Vasily Averin <vvs@virtuozzo.com>

commit 873d7bcfd066663e3e50113dc4a0de19289b6354 upstream.

Commit a2468cc9bfdf ("swap: choose swap device according to numa node")
changed 'avail_lists' field of 'struct swap_info_struct' to an array.
In popular linux distros it increased size of swap_info_struct up to 40
Kbytes and now swap_info_struct allocation requires order-4 page.
Switch to kvzmalloc allows to avoid unexpected allocation failures.

Link: http://lkml.kernel.org/r/fc23172d-3c75-21e2-d551-8b1808cbe593@virtuozzo.com
Fixes: a2468cc9bfdf ("swap: choose swap device according to numa node")
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Acked-by: Aaron Lu <aaron.lu@intel.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Huang Ying <ying.huang@intel.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/swapfile.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2837,7 +2837,7 @@ static struct swap_info_struct *alloc_sw
 	unsigned int type;
 	int i;
 
-	p = kzalloc(sizeof(*p), GFP_KERNEL);
+	p = kvzalloc(sizeof(*p), GFP_KERNEL);
 	if (!p)
 		return ERR_PTR(-ENOMEM);
 
@@ -2848,7 +2848,7 @@ static struct swap_info_struct *alloc_sw
 	}
 	if (type >= MAX_SWAPFILES) {
 		spin_unlock(&swap_lock);
-		kfree(p);
+		kvfree(p);
 		return ERR_PTR(-EPERM);
 	}
 	if (type >= nr_swapfiles) {
@@ -2862,7 +2862,7 @@ static struct swap_info_struct *alloc_sw
 		smp_wmb();
 		nr_swapfiles++;
 	} else {
-		kfree(p);
+		kvfree(p);
 		p = swap_info[type];
 		/*
 		 * Do not memset this entry: a racing procfs swap_next()


