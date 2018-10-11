Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33512C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 09:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAE0020835
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 09:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbOIpeCj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAE0020835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbeJKQjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 12:39:04 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36588 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbeJKQjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 12:39:04 -0400
Received: by mail-wm1-f66.google.com with SMTP id a8-v6so8526504wmf.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 02:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=gJaz1qpBBhqH2D6/8KrdfZeAdF8Y1819jeBjQPJGdYY=;
        b=CbOIpeCjVYbmyzfLFr5hVtZfVJa8O5kEZoXthB77ZXxB9MJP+8j1UtMZI48tcNQXNZ
         6KMNPQuu1nB7HQT3kAE9CZDFI2jzOxo/Zv8wzn24DvsA5YXiAb8uu+CYRDpXbhHaQhRE
         t8hI34/zdWkXMMOLYWDtthF1Mp/BvL7CWID4y1xCNMywQub7gYd5EZkKqFzDYUVbWRAV
         PUH6nxxte1b1Djm7LMnRrhZhphEFh+f2KLs9HnbU/c3FftRisUsbfBOwQ85JliEjaFw7
         ffbRbbNZjb+o/EfQgP19v5TpCLXbjmr+89oq5INgMy1Bm2jIvHHYFzAbQLWxmWGebfRU
         dOJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=gJaz1qpBBhqH2D6/8KrdfZeAdF8Y1819jeBjQPJGdYY=;
        b=cmAVWH+u4CI4J7MIk6hm21RjPKVS4FNBqy72vyucpszGi5WxRT5fuvjslIwUyaHmSz
         BX3xZBP6egUHwiMWYZZeDiwzu9RpZ/rLyDqLqP3AJL12dHbTKjtLYRfgrbbtrLFz0mCd
         rbk4ytWG8zILJ9IHaeVWEkWDkLO9Z+MDknakRYEo7ypg6KrK0eAg9RGN2ZlAJ2L83p3t
         itCHP7QGExIuit5JRgV2gP6IZ1c2X7fc8VVPx+9P+MN0cwzIYVbuDiUOnAG3l9obiqRp
         JZAcAsvOOz9keztoAd1SqjfNSnfAR8D3DKI6awjw46qnVHFoGIzoT5DEdzZ2RZAFS3YZ
         Ohvw==
X-Gm-Message-State: ABuFfoiDIWP0L5OWhrZ14X+XBwQoznz1jFkvQViKEXz4dD41HaW2jMVj
        wqpeaIJE6IJPHykqj+hIE3k=
X-Google-Smtp-Source: ACcGV60rmQwc8BXQKklUh2DI/Js3KvwGSpcs7fcA40xyp1RDDqBLq82qqWgPjSZrMYLqxwF7059aTg==
X-Received: by 2002:a1c:d712:: with SMTP id o18-v6mr981557wmg.54.1539249160477;
        Thu, 11 Oct 2018 02:12:40 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 195-v6sm25550813wmx.21.2018.10.11.02.12.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 02:12:39 -0700 (PDT)
Date:   Thu, 11 Oct 2018 11:12:37 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] scheduler fix
Message-ID: <20181011091237.GB78343@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

Please pull the latest sched-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

   # HEAD: e054637597ba36d3729ba6a3a3dd7aad8e2a3003 mm, sched/numa: Remove remaining traces of NUMA rate-limiting

Cleanup of dead code left over from the recent sched/numa fixes.

 Thanks,

	Ingo

------------------>
Srikar Dronamraju (1):
      mm, sched/numa: Remove remaining traces of NUMA rate-limiting


 include/linux/mmzone.h |  4 ----
 mm/page_alloc.c        | 10 ----------
 2 files changed, 14 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 3f4c0b167333..d4b0c79d2924 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -667,10 +667,6 @@ typedef struct pglist_data {
 	enum zone_type kcompactd_classzone_idx;
 	wait_queue_head_t kcompactd_wait;
 	struct task_struct *kcompactd;
-#endif
-#ifdef CONFIG_NUMA_BALANCING
-	/* Lock serializing the migrate rate limiting window */
-	spinlock_t numabalancing_migrate_lock;
 #endif
 	/*
 	 * This is a per-node reserve of pages that are not available
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 706a738c0aee..e2ef1c17942f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6193,15 +6193,6 @@ static unsigned long __init calc_memmap_size(unsigned long spanned_pages,
 	return PAGE_ALIGN(pages * sizeof(struct page)) >> PAGE_SHIFT;
 }
 
-#ifdef CONFIG_NUMA_BALANCING
-static void pgdat_init_numabalancing(struct pglist_data *pgdat)
-{
-	spin_lock_init(&pgdat->numabalancing_migrate_lock);
-}
-#else
-static void pgdat_init_numabalancing(struct pglist_data *pgdat) {}
-#endif
-
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static void pgdat_init_split_queue(struct pglist_data *pgdat)
 {
@@ -6226,7 +6217,6 @@ static void __meminit pgdat_init_internals(struct pglist_data *pgdat)
 {
 	pgdat_resize_init(pgdat);
 
-	pgdat_init_numabalancing(pgdat);
 	pgdat_init_split_queue(pgdat);
 	pgdat_init_kcompactd(pgdat);
 

----- End forwarded message -----
