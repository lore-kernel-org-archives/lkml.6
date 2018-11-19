Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBF0C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06BE62148E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kVsqPnYJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06BE62148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390283AbeKTDPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:15:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:53220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388976AbeKTDPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:15:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4DDD20C01;
        Mon, 19 Nov 2018 16:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646282;
        bh=ZwFDO+LXMebvo7w7VxylYjA0w0ZRKTW0mJr1zk9t1EI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kVsqPnYJRr19Ibyy/Ffd4PopVjTxLSx9ezbEd3v7p8qQSYfqlY9XFKKLmSpDjIzSK
         4sRKg3FyV/oJxwSko5Pq1xKajvGvm5tfsEf/TqKU5o++9Rh7NGYk4A/9viVzcxA0OW
         QpCeVXLFrSt5MGvXtTdqeFYyuM2bTkLY1KkjyHrY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Averin <vvs@virtuozzo.com>,
        Aaron Lu <aaron.lu@intel.com>, Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 105/124] mm/swapfile.c: use kvzalloc for swap_info_struct allocation
Date:   Mon, 19 Nov 2018 17:29:19 +0100
Message-Id: <20181119162631.909904560@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162612.951907286@linuxfoundation.org>
References: <20181119162612.951907286@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2830,7 +2830,7 @@ static struct swap_info_struct *alloc_sw
 	unsigned int type;
 	int i;
 
-	p = kzalloc(sizeof(*p), GFP_KERNEL);
+	p = kvzalloc(sizeof(*p), GFP_KERNEL);
 	if (!p)
 		return ERR_PTR(-ENOMEM);
 
@@ -2841,7 +2841,7 @@ static struct swap_info_struct *alloc_sw
 	}
 	if (type >= MAX_SWAPFILES) {
 		spin_unlock(&swap_lock);
-		kfree(p);
+		kvfree(p);
 		return ERR_PTR(-EPERM);
 	}
 	if (type >= nr_swapfiles) {
@@ -2855,7 +2855,7 @@ static struct swap_info_struct *alloc_sw
 		smp_wmb();
 		nr_swapfiles++;
 	} else {
-		kfree(p);
+		kvfree(p);
 		p = swap_info[type];
 		/*
 		 * Do not memset this entry: a racing procfs swap_next()


