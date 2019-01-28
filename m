Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A358C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AA8D21738
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548686722;
	bh=zEBa/bQcb3Z4zx36/j2o5y05tI1/QDoC3xDJgGlS9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qMhXJbo8eYGNun727b9OErJ3Su5we98l+11LSJljCLSF2pTzEGsrIWhljD4+JGOoh
	 egPERdXTG/FUbN5U3/MnLp1yBSEbKyyerbc5uJQSBCpkV62u1XIeFSvcCktRNGOe5z
	 sWPyRh6HEOy4onz8fHTwYZnZnm9Z5tw10JOvirp0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfA1OpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 09:45:20 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34773 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbfA1OpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 09:45:17 -0500
Received: by mail-ed1-f66.google.com with SMTP id b3so13259919ede.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 06:45:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=20RN4Ot/Ll9C5dQDy9pNPCPR7Irx0eiJja18LrztjV4=;
        b=JNWJYx9FVYG1HxjEaScFfTqRZNdBTNqoc4QTQfdZU+urG4yOe6NJf/ccqf6OLZldZg
         pr0t0xzYrsWWeRNoxJxqYq2H8tYD30veo/5A2oX4ZcCF0f45dcQEp4j+KYo3X6Rlh7XO
         faBqchQ/9UA6DP6EekvZzGAv1nbKb7ujLjbXrVOJNkiB8sm9F8kgwAaJ3z9Jk7lA+aWu
         ezrZf1EPmnh1EA2jwlmE4MF8wUNsqjnUZBlf3Gby8NP0EK7Q0Hs712oQVjlxS8hXzD3P
         cO1aXbRHOvSaKnzSztKusCJqcYB1QeOATtv+ZiLNLqhHzRW+h81LC0O+rVE5ITqgJN5+
         m8yQ==
X-Gm-Message-State: AJcUukeCxZCIv/Xaaemaz2l0/ylmcylRXblvWggPGH/Io9Gl1OtX7fRB
        O8Wz3u3DTFI1sp1XpSiG2ck=
X-Google-Smtp-Source: ALg8bN5V/XrVCAGFvAeKOM6OXjDXHjVZ8bDG7fiP1ZYe7gGffkuJLxpuoCDWNjAhGPGfBirUc3C4Tg==
X-Received: by 2002:a05:6402:758:: with SMTP id p24mr22446609edy.92.1548686715871;
        Mon, 28 Jan 2019 06:45:15 -0800 (PST)
Received: from tiehlicka.microfocus.com (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id j8sm2919064ejr.17.2019.01.28.06.45.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 06:45:15 -0800 (PST)
From:   Michal Hocko <mhocko@kernel.org>
To:     Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        gerald.schaefer@de.ibm.com, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH 1/2] mm, memory_hotplug: is_mem_section_removable do not pass the end of a zone
Date:   Mon, 28 Jan 2019 15:45:05 +0100
Message-Id: <20190128144506.15603-2-mhocko@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190128144506.15603-1-mhocko@kernel.org>
References: <20190128144506.15603-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

Mikhail has reported the following VM_BUG_ON triggered when reading
sysfs removable state of a memory block:
 page:000003d082008000 is uninitialized and poisoned
 page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
 Call Trace:
 ([<0000000000385b26>] test_pages_in_a_zone+0xde/0x160)
  [<00000000008f15c4>] show_valid_zones+0x5c/0x190
  [<00000000008cf9c4>] dev_attr_show+0x34/0x70
  [<0000000000463ad0>] sysfs_kf_seq_show+0xc8/0x148
  [<00000000003e4194>] seq_read+0x204/0x480
  [<00000000003b53ea>] __vfs_read+0x32/0x178
  [<00000000003b55b2>] vfs_read+0x82/0x138
  [<00000000003b5be2>] ksys_read+0x5a/0xb0
  [<0000000000b86ba0>] system_call+0xdc/0x2d8
 Last Breaking-Event-Address:
  [<0000000000385b26>] test_pages_in_a_zone+0xde/0x160
 Kernel panic - not syncing: Fatal exception: panic_on_oops

The reason is that the memory block spans the zone boundary and we are
stumbling over an unitialized struct page. Fix this by enforcing zone
range in is_mem_section_removable so that we never run away from a
zone.

Reported-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
Debugged-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/memory_hotplug.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index b9a667d36c55..07872789d778 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1233,7 +1233,8 @@ static bool is_pageblock_removable_nolock(struct page *page)
 bool is_mem_section_removable(unsigned long start_pfn, unsigned long nr_pages)
 {
 	struct page *page = pfn_to_page(start_pfn);
-	struct page *end_page = page + nr_pages;
+	unsigned long end_pfn = min(start_pfn + nr_pages, zone_end_pfn(page_zone(page)));
+	struct page *end_page = pfn_to_page(end_pfn);
 
 	/* Check the starting page of each pageblock within the range */
 	for (; page < end_page; page = next_active_pageblock(page)) {
-- 
2.20.1

