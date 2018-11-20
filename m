Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09268C04EBC
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CE5F206B2
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:43:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CE5F206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbeKUAND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:13:03 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46524 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbeKUAMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:12:52 -0500
Received: by mail-ed1-f65.google.com with SMTP id o10so1924139edt.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 05:43:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/sEYolIbYeBRlPTEJk3IyaZRfhMjojYPi0YASgHfRGI=;
        b=rdMKhPjnbw/W99DJks3v4bJlG/nEtLvdV4le/2GBDNgRCQoSltCP4GrOmBBK3kNu4r
         oXYMOH3ffiu7hDNSULRkJKZVzmcGBZ6EVx6FDREK2TZSqHdYsn7DJZGAhi54bqT9RXws
         rYEXBSbLfacAJVAD8bhjwkXB/ysZMj3O9cup/riI1RvpmpRjY6Jc2rmc2ML6m2AFcZmX
         KKR+lFQpaCM7F8wyi4IlmMZpKAg5epYHaoGutuCfVJ81o30MwyypAEByEANEAlpu0eEn
         bJ8sIx9edeHaXaY6Jl+gE+rRHcApz6OSlC/FwMMi70tfQXbm+adqwFeTaU6wp9ZVTLw2
         uneQ==
X-Gm-Message-State: AA+aEWbXb1dyFE5H/l5atHu+HZxjjClhR5zG51V9WoFRPqlPpDqAuPZJ
        YmxvQWxDXFJ+/yVtQoYPahI=
X-Google-Smtp-Source: AFSGD/Xq+FylGFMKZlo0fPRxIfOZYXl+3i3vcWbXu5KuTcyyuMAc1+bVUL4AAeeLNkbOPYEcxvkmwQ==
X-Received: by 2002:a50:a6cf:: with SMTP id f15mr2266604edc.97.1542721418061;
        Tue, 20 Nov 2018 05:43:38 -0800 (PST)
Received: from tiehlicka.suse.cz (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id 49sm8428786edz.59.2018.11.20.05.43.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 05:43:37 -0800 (PST)
From:   Michal Hocko <mhocko@kernel.org>
To:     <linux-mm@kvack.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <OSalvador@suse.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: [RFC PATCH 3/3] mm, fault_around: do not take a reference to a locked page
Date:   Tue, 20 Nov 2018 14:43:23 +0100
Message-Id: <20181120134323.13007-4-mhocko@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181120134323.13007-1-mhocko@kernel.org>
References: <20181120134323.13007-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

filemap_map_pages takes a speculative reference to each page in the
range before it tries to lock that page. While this is correct it
also can influence page migration which will bail out when seeing
an elevated reference count. The faultaround code would bail on
seeing a locked page so we can pro-actively check the PageLocked
bit before page_cache_get_speculative and prevent from pointless
reference count churn.

Cc: "Kirill A. Shutemov" <kirill@shutemov.name>
Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/filemap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index 81adec8ee02c..c76d6a251770 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2553,6 +2553,9 @@ void filemap_map_pages(struct vm_fault *vmf,
 			goto next;
 
 		head = compound_head(page);
+
+		if (PageLocked(head))
+			goto next;
 		if (!page_cache_get_speculative(head))
 			goto next;
 
-- 
2.19.1

