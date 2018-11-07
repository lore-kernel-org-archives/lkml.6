Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C29FC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B5972081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:18:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B5972081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730115AbeKGTs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 14:48:28 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35903 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbeKGTs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 14:48:27 -0500
Received: by mail-wm1-f68.google.com with SMTP id a8-v6so15163246wmf.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 02:18:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kntFfEclka7mr+wFcmXDsLg76irP2LElxuloHHO2sP0=;
        b=RWBvmdk0Wff4ix52eqRgte2hPUhrzAZMKjH6qU+Xe+YIFGn7rnIdvb6i+gTVF121Gp
         /8xUgq1mp4iKV+l8vnilaUIhtawhQMahRDZsn6hz5e8zGfk0ouujJljnlRV7wUgyrKkK
         ea5xC6eJO4csvyt763CdBtGV3B5cNQmB8GVcGJWNjTkijK7FiPOMqSYozkLSTPGgxX/D
         iKDUZlDjHUqb60zCf7T15hoPJfExT7oMRJDa0TWSqurk5XA64kbXrOi3y1fq9tN2jWaW
         OAkJN4eM4PrToqX+I8hiE2/3czTXSEybq+fBbM7amebGwzrVblrJXUQwCEmhg4aKV5mz
         sXNw==
X-Gm-Message-State: AGRZ1gJ9VbhDC0w6pkxqOYxGydKYKgi6ILi/AwhaXnrseXqhP6KNLdp/
        WtrDVeaETwb2WOKjrb2zH2jYmnIh
X-Google-Smtp-Source: AJdET5dR6WUz/KIbvc4O5dgbexkLTMFjMGHXCSeQv1Bflzz/RwXz/1Eu9NQEUmyJmMP30SHDzyMfsA==
X-Received: by 2002:a1c:992:: with SMTP id 140-v6mr1448126wmj.136.1541585924255;
        Wed, 07 Nov 2018 02:18:44 -0800 (PST)
Received: from tiehlicka.suse.cz (ip-37-188-140-85.eurotel.cz. [37.188.140.85])
        by smtp.gmail.com with ESMTPSA id w18-v6sm217527wrn.66.2018.11.07.02.18.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 02:18:43 -0800 (PST)
From:   Michal Hocko <mhocko@kernel.org>
To:     <linux-mm@kvack.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <OSalvador@suse.com>,
        Baoquan He <bhe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [RFC PATCH 1/5] mm: print more information about mapping in __dump_page
Date:   Wed,  7 Nov 2018 11:18:26 +0100
Message-Id: <20181107101830.17405-2-mhocko@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181107101830.17405-1-mhocko@kernel.org>
References: <20181107101830.17405-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

__dump_page prints the mapping pointer but that is quite unhelpful
for many reports because the pointer itself only helps to distinguish
anon/ksm mappings from other ones (because of lowest bits
set). Sometimes it would be much more helpful to know what kind of
mapping that is actually and if we know this is a file mapping then also
try to resolve the dentry name.

Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/debug.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/mm/debug.c b/mm/debug.c
index cdacba12e09a..a33177bfc856 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -44,6 +44,7 @@ const struct trace_print_flags vmaflag_names[] = {
 
 void __dump_page(struct page *page, const char *reason)
 {
+	struct address_space *mapping = page_mapping(page);
 	bool page_poisoned = PagePoisoned(page);
 	int mapcount;
 
@@ -70,6 +71,18 @@ void __dump_page(struct page *page, const char *reason)
 	if (PageCompound(page))
 		pr_cont(" compound_mapcount: %d", compound_mapcount(page));
 	pr_cont("\n");
+	if (PageAnon(page))
+		pr_emerg("anon ");
+	else if (PageKsm(page))
+		pr_emerg("ksm ");
+	else if (mapping) {
+		pr_emerg("%ps ", mapping->a_ops);
+		if (mapping->host->i_dentry.first) {
+			struct dentry *dentry;
+			dentry = container_of(mapping->host->i_dentry.first, struct dentry, d_u.d_alias);
+			pr_emerg("name:\"%*s\" ", dentry->d_name.len, dentry->d_name.name);
+		}
+	}
 	BUILD_BUG_ON(ARRAY_SIZE(pageflag_names) != __NR_PAGEFLAGS + 1);
 
 	pr_emerg("flags: %#lx(%pGp)\n", page->flags, &page->flags);
-- 
2.19.1

