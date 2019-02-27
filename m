Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8321C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 22:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FC6320863
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 22:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="UyLXQp/x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730190AbfB0WMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 17:12:15 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41640 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729412AbfB0WMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 17:12:14 -0500
Received: by mail-qt1-f196.google.com with SMTP id v10so21216045qtp.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 14:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=gJVRQLlqnwk8sxjewpHNesdly6P+LqOTjUsl1nOlzTg=;
        b=UyLXQp/xZQLZdLznUzhv0eDX+KSDYCghve1vumeb29D+/9quguhYCPT4+S9j2aGDsb
         mNAbWPvVLEeIuu3AH58JDKad3Pwl3VoBmhOZiEpJnuKEnickaMF5t3GzyjlWcW9pOXDJ
         p6zOpKL2o78jVDEiunfb70Sf+0dRcjKWPz/CQMUqOdg6kr/zR2hKntRFPoAZ3qaNXhjh
         Hf6RmnyaJyacgGy5nNz1y+ML1+srkoE3Uv3d/D59N3GbV53AXFx+53QbolnIAPuPcb40
         YMJ+BywVLOBaQbZrm+1Fp1/cwb9pebK9SyjHDHrATqqrqBO8ZS3hoNZn9eLsImqfUBa+
         GNag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gJVRQLlqnwk8sxjewpHNesdly6P+LqOTjUsl1nOlzTg=;
        b=VfyfR2oRkwDIzDxdGpSDuhuSm4RPBSGnW1h1mNqP7IEWqT3xVGnAN+X53Bb7hIHCrV
         6WBeKrFWzFFFIWt95gxHwfWI6M8HkHmVBiWY+wG5zOMqxfd2m2H935GiJO6zi9C2aEmD
         bTknMgcpCeFkeDi+F+2M7n9+bFogj6wJnbYm54dDjqjYsVAD88mpm7W3pUPJqST0jCru
         9qDkH/0o5ymOkHvsMnPcJfZeN3fl4sQMU71ZrOXSgOX+oLcq1SUowo85TGTE1JcP2AfG
         kWba/SNsHgGSrO/JelbmaBDVCotG9q3FohZ3c9kS6QAbEVsPEyzv+DrqpeVtpCLtafHt
         ezaw==
X-Gm-Message-State: APjAAAVFSsn4L/gytFokN+Yo8FH+qZBAQ7XoHPddrHLJ89/eWWqD3l4J
        ENsi4nHBVM6lFG50niCLrZ8TRw==
X-Google-Smtp-Source: APXvYqwmi81Gngi8eMRRAO/I0i5iJ1vm93qc7mPf9+eZoRVTqADL3XHCZ4Q7jR52GigDXpvfSOMR9Q==
X-Received: by 2002:a0c:8b50:: with SMTP id d16mr3753432qvc.233.1551305533940;
        Wed, 27 Feb 2019 14:12:13 -0800 (PST)
Received: from Qians-MBP.fios-router.home (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id u1sm12116671qki.36.2019.02.27.14.12.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 14:12:13 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] powerpc: fix "section_base" set but not used
Date:   Wed, 27 Feb 2019 17:11:59 -0500
Message-Id: <20190227221159.78055-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/powerpc/mm/init_64.c: In function 'vmemmap_free':
arch/powerpc/mm/init_64.c:277:16: error: variable 'section_base' set but
not used [-Werror=unused-but-set-variable]

Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/powerpc/mm/init_64.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index a5091c034747..a4c155af1597 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -274,7 +274,6 @@ void __ref vmemmap_free(unsigned long start, unsigned long end,
 
 	for (; start < end; start += page_size) {
 		unsigned long nr_pages, addr;
-		struct page *section_base;
 		struct page *page;
 
 		/*
@@ -290,7 +289,6 @@ void __ref vmemmap_free(unsigned long start, unsigned long end,
 			continue;
 
 		page = pfn_to_page(addr >> PAGE_SHIFT);
-		section_base = pfn_to_page(vmemmap_section_start(start));
 		nr_pages = 1 << page_order;
 		base_pfn = PHYS_PFN(addr);
 
-- 
2.17.2 (Apple Git-113)

