Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64214C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 08:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3830A2086B
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 08:30:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3830A2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389417AbeKPSl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 13:41:56 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43396 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389345AbeKPSl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 13:41:56 -0500
Received: by mail-ed1-f65.google.com with SMTP id f4so6217748edq.10
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 00:30:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kntFfEclka7mr+wFcmXDsLg76irP2LElxuloHHO2sP0=;
        b=L+9ZA1RU8RphevcRoXdU4oPehbcMq6aYQ+7OgtgAPnWtBWDbDAPmbDyMF2O3YvQzDZ
         FNeeN5a5ufT9aYLFqXSDTaGNDhfvP89exvM66PXGI3OXYHW25H8oj8Q9IAiwnwx1+gjY
         KiWDOZKHMiYLKgYBDVhEwXkJ+uqv1rFmNgNV7yCLwyiAwINqd90aNi66E+4OtWJhHEsa
         EzMjQQhiHG0dS/Yt3PbG7BLJF8GD2e+iX4VAf12/YFofQam4pQ62x3sl2PFaPAKGltvZ
         09LSCd5m8VFlrwBInQzPN+wlzDDrXdo89TcvxGtX6cADvMhOPsCbUFGQ79jtMTTZNTva
         DpPg==
X-Gm-Message-State: AGRZ1gIHsDghyYXleYwHao0bjMP88zdVf7B0E4nmdfvrg5bKD+sp8CaS
        FJHKvZXIYgT8/IQEaxUPfaw=
X-Google-Smtp-Source: AJdET5cHmrA/9d8gt2m9s3jppc+ITDsH27WkS168KT/9iVSh/xLvu2q+OrytpijuwyxwGdBr3BNLOA==
X-Received: by 2002:a17:906:1f09:: with SMTP id w9-v6mr8039762ejj.22.1542357034515;
        Fri, 16 Nov 2018 00:30:34 -0800 (PST)
Received: from tiehlicka.suse.cz (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id m13sm5305393edd.2.2018.11.16.00.30.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 00:30:33 -0800 (PST)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Oscar Salvador <OSalvador@suse.com>, Baoquan He <bhe@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH 1/5] mm: print more information about mapping in __dump_page
Date:   Fri, 16 Nov 2018 09:30:16 +0100
Message-Id: <20181116083020.20260-2-mhocko@kernel.org>
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

