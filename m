Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73685C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 456622192C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="bKmg92sU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732067AbfBOSOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 13:14:38 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:33759 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731847AbfBOSOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 13:14:32 -0500
Received: by mail-yb1-f195.google.com with SMTP id w2so4158937ybi.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 10:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NSVRB4KCxOzLiCcKtVzLdp3bqBiDRMqjw6+T+tZutHo=;
        b=bKmg92sUiX5H/aar4+WmpOfQmxy/hG1c2YHfPUxNtki4sheyTomFyVrzH9ntdCRAyx
         WMef03M9PiBmcDvaDgiyaJdE3worIGUODUmyeQUiwXDn71kT5mpQ3K+F72km/7vMxHgy
         qyAJdWh9IBCOY7HBWtwuWspK227bmgvl9cvZEw+iU4fXonyASI0DzvnLcU5B1GD8iu3h
         JZfIHl+MyP1yGWCCOHxU3Tfh3CSQNvbxVXxC3+vnDvUWdFnamgPTq9sckkgQalxoa1zn
         9+Ox8YJd/kmPVpOlKAcgEfei6I5y+YerssXk7839LFJ9gDZAAkteIWz8EFKtCe3v+15h
         CBUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NSVRB4KCxOzLiCcKtVzLdp3bqBiDRMqjw6+T+tZutHo=;
        b=ApMh5Ik1s0fU0AGzNtkw0E7I9fdnOtfGoJyjW7GVA5oJ39QV9LTB/RYJtFkh0PHIeo
         6T86TdYh/sjz21NKg0k5yE/mFuKBpdCmOg8+zp7wWg6ZTHUoAYlu+BZ42ZxwFpCntoMH
         G9docVYw5nuYK1FI0QQnQsTse3Qqivmqz97YczotRVAfuaRLAPmdaiiLc3OWevo7IeSu
         ccZlZ5qkxmRXVqUjdxWvVvJxDDI58g5F4xrPUTG/N8gUY31aMBsNPjSPrViWi8zrn21n
         /inL6tSHFOm6HKoTcE1pHTrxhiC6NDtU5/bLhVR64OU/r0fqG1CeuB0W/C4+odDbYe4f
         CgZw==
X-Gm-Message-State: AHQUAubqUxCukz4Cp3nQ2sUGkWb1PAOHVau1MNrM8KQgcZaQmr3UAsJP
        ryAp43p23+mUHXZl7Y8M+hxmLQ==
X-Google-Smtp-Source: AHgI3IbpwW5Q4dPkw9VzQm4AkpJI/omhQBlFnrFV+tByaOQ7rIM3b+THxwDztmiDkRMQVJE8hFe0rQ==
X-Received: by 2002:a25:6e8b:: with SMTP id j133mr8968247ybc.220.1550254471365;
        Fri, 15 Feb 2019 10:14:31 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::4:33c1])
        by smtp.gmail.com with ESMTPSA id h205sm4730096ywh.85.2019.02.15.10.14.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 10:14:30 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 1/6] mm: memcontrol: track LRU counts in the vmstats array
Date:   Fri, 15 Feb 2019 13:14:20 -0500
Message-Id: <20190215181425.32624-2-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190215181425.32624-1-hannes@cmpxchg.org>
References: <20190215181425.32624-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memcg code currently maintains private per-zone breakdowns of the
LRU counters. This is necessary for reclaim decisions which are still
zone-based, but there are a variety of users of these counters that
only want the aggregate per-lruvec or per-memcg LRU counts, and they
need to painfully sum up the zone counters on each request for that.

These would be better served using the memcg vmstats arrays, which
track VM statistics at the desired scope already. They just don't have
the LRU counts right now.

So to kick off the conversion, begin tracking LRU counts in those.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/mm_inline.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 04ec454d44ce..6f2fef7b0784 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -29,7 +29,7 @@ static __always_inline void __update_lru_size(struct lruvec *lruvec,
 {
 	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
 
-	__mod_node_page_state(pgdat, NR_LRU_BASE + lru, nr_pages);
+	__mod_lruvec_state(lruvec, NR_LRU_BASE + lru, nr_pages);
 	__mod_zone_page_state(&pgdat->node_zones[zid],
 				NR_ZONE_LRU_BASE + lru, nr_pages);
 }
-- 
2.20.1

