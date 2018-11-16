Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09DCC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 08:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D21D2086B
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 08:30:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D21D2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389493AbeKPSmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 13:42:15 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35583 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389350AbeKPSl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 13:41:56 -0500
Received: by mail-ed1-f66.google.com with SMTP id x30so14202470edx.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 00:30:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=INIH8VEj3IknA0dWKCgx1UP4Knj40rfToyv6XxWgDjI=;
        b=fTLZ6MA0VZFV796DkEL3yWMr06ZLTuEFUxCZK/1qvFeLV4fUgb4ma/ICz928RC5Ic6
         6y5wMlqBSQohMoshs1KGIubMmb9MIk2LkF2agEN3EhkfWG2cN0JIhOufUJ6nlBHIR0OM
         m7tOyJqE5O3xIrnv0QM1yHsCiYL9C69zxXcE2d3qYERnbbnp5NuQn/r2zvelQsFyS6d/
         apIFcBruAuMpsLxWKr4sf44LwyWw2uVS5cuF5PuanZXGlA5I56IJ/iQWcM7y1UwNE7AR
         uORB7ORJw5uNZiW+Abb038fIegzTDHxxhjI3YCiwcLGbHlaY/0Jzkz5Yl5QoPoL9BP14
         d8oQ==
X-Gm-Message-State: AGRZ1gKRL7RjaOUy/E4G13taBvYCrFsCjOebPxneuVzkEq/tzzfece8h
        Z4rgimUsIdmTmIlgSRjjTgQ=
X-Google-Smtp-Source: AJdET5fE+tFR5EygNC3X9gz685mVgSc4MkoLDrALRwgTFEy36WoP9qpHVhs7em8FCk08JnlnIRN+jA==
X-Received: by 2002:a50:a399:: with SMTP id s25mr9101149edb.1.1542357035568;
        Fri, 16 Nov 2018 00:30:35 -0800 (PST)
Received: from tiehlicka.suse.cz (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id m13sm5305393edd.2.2018.11.16.00.30.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 00:30:34 -0800 (PST)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Oscar Salvador <OSalvador@suse.com>, Baoquan He <bhe@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH 2/5] mm: lower the printk loglevel for __dump_page messages
Date:   Fri, 16 Nov 2018 09:30:17 +0100
Message-Id: <20181116083020.20260-3-mhocko@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181116083020.20260-1-mhocko@kernel.org>
References: <20181116083020.20260-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

__dump_page messages use KERN_EMERG resp. KERN_ALERT loglevel (this is
the case since 2004). Most callers of this function are really detecting
a critical page state and BUG right after. On the other hand the
function is called also from contexts which just want to inform about
the page state and those would rather not disrupt logs that much (e.g.
some systems route these messages to the normal console).

Reduce the loglevel to KERN_WARNING to make dump_page easier to reuse
for other contexts while those messages will still make it to the kernel
log in most setups. Even if the loglevel setup filters warnings away
those paths that are really critical already print the more targeted
error or panic and that should make it to the kernel log.

Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/debug.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/mm/debug.c b/mm/debug.c
index a33177bfc856..d18c5cea3320 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -54,7 +54,7 @@ void __dump_page(struct page *page, const char *reason)
 	 * dump_page() when detected.
 	 */
 	if (page_poisoned) {
-		pr_emerg("page:%px is uninitialized and poisoned", page);
+		pr_warn("page:%px is uninitialized and poisoned", page);
 		goto hex_only;
 	}
 
@@ -65,27 +65,27 @@ void __dump_page(struct page *page, const char *reason)
 	 */
 	mapcount = PageSlab(page) ? 0 : page_mapcount(page);
 
-	pr_emerg("page:%px count:%d mapcount:%d mapping:%px index:%#lx",
+	pr_warn("page:%px count:%d mapcount:%d mapping:%px index:%#lx",
 		  page, page_ref_count(page), mapcount,
 		  page->mapping, page_to_pgoff(page));
 	if (PageCompound(page))
 		pr_cont(" compound_mapcount: %d", compound_mapcount(page));
 	pr_cont("\n");
 	if (PageAnon(page))
-		pr_emerg("anon ");
+		pr_warn("anon ");
 	else if (PageKsm(page))
-		pr_emerg("ksm ");
+		pr_warn("ksm ");
 	else if (mapping) {
-		pr_emerg("%ps ", mapping->a_ops);
+		pr_warn("%ps ", mapping->a_ops);
 		if (mapping->host->i_dentry.first) {
 			struct dentry *dentry;
 			dentry = container_of(mapping->host->i_dentry.first, struct dentry, d_u.d_alias);
-			pr_emerg("name:\"%*s\" ", dentry->d_name.len, dentry->d_name.name);
+			pr_warn("name:\"%*s\" ", dentry->d_name.len, dentry->d_name.name);
 		}
 	}
 	BUILD_BUG_ON(ARRAY_SIZE(pageflag_names) != __NR_PAGEFLAGS + 1);
 
-	pr_emerg("flags: %#lx(%pGp)\n", page->flags, &page->flags);
+	pr_warn("flags: %#lx(%pGp)\n", page->flags, &page->flags);
 
 hex_only:
 	print_hex_dump(KERN_ALERT, "raw: ", DUMP_PREFIX_NONE, 32,
@@ -93,11 +93,11 @@ void __dump_page(struct page *page, const char *reason)
 			sizeof(struct page), false);
 
 	if (reason)
-		pr_alert("page dumped because: %s\n", reason);
+		pr_warn("page dumped because: %s\n", reason);
 
 #ifdef CONFIG_MEMCG
 	if (!page_poisoned && page->mem_cgroup)
-		pr_alert("page->mem_cgroup:%px\n", page->mem_cgroup);
+		pr_warn("page->mem_cgroup:%px\n", page->mem_cgroup);
 #endif
 }
 
-- 
2.19.1

