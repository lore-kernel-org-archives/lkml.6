Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35274C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0482720878
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:03:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0482720878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbeLCKDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:03:42 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33691 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbeLCKDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:03:42 -0500
Received: by mail-ed1-f65.google.com with SMTP id p6so1911685eds.0;
        Mon, 03 Dec 2018 02:03:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jPdQ2xohPGQO5/youIzdD6XhrzLSdiPyktb/A7gR3XQ=;
        b=FD2m9KSZo+Xaqpa4MotfpPMcdfbtbMX/yvJphPYOm8iJTSHggeEeRYFPru0qKClOqF
         538HCrdL2sO7Q94jDD1l/pY4h+fjcu+iaKMf+NSBoHNcc/EZRMr3mMnkpTHrTUCPGEsJ
         /S+kxjODTx2y4RA3ahjoUf6cj9Qup4g0Y5rWUmX7WaMOgSRWPUqRz+fRFPAIsjQ5M+qG
         ly5k0roJuw6gt3OUsk3B9YLJHZV/Jg8cE1cum922J6PkIyJ0cCYw5SvS7EZOcjmy/pQM
         dv4P+AjReLRq9+hoeD2KbFV1kJSAOYlG2Dc/2jH7FQ7MeS8xutSBcDQIQP/V3MIO3uqQ
         zz0A==
X-Gm-Message-State: AA+aEWYA1/W99F7PsAOxVt1vl7asYmU8Y4EsNvduucQijRcyHzOHDRqv
        3V6PLZktkg7aFwUlfySLRDA=
X-Google-Smtp-Source: AFSGD/UFvc0nAOOz+A9P/ainnX0MOvW1MEMDO0U2Zi9/O/8F4j//xH+y6i/ZxE0x54J2PFR9kNfbdw==
X-Received: by 2002:a17:906:279a:: with SMTP id j26-v6mr12480469ejc.112.1543831400455;
        Mon, 03 Dec 2018 02:03:20 -0800 (PST)
Received: from tiehlicka.suse.cz (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id w13sm3719321edl.54.2018.12.03.02.03.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 02:03:19 -0800 (PST)
From:   Michal Hocko <mhocko@kernel.org>
To:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Oscar Salvador <OSalvador@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@gmail.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Stable tree <stable@vger.kernel.org>
Subject: [RFC PATCH] hwpoison, memory_hotplug: allow hwpoisoned pages to be offlined
Date:   Mon,  3 Dec 2018 11:03:09 +0100
Message-Id: <20181203100309.14784-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

We have received a bug report that an injected MCE about faulty memory
prevents memory offline to succeed. The underlying reason is that the
HWPoison page has an elevated reference count and the migration keeps
failing. There are two problems with that. First of all it is dubious
to migrate the poisoned page because we know that accessing that memory
is possible to fail. Secondly it doesn't make any sense to migrate a
potentially broken content and preserve the memory corruption over to a
new location.

Oscar has found out that it is the elevated reference count from
memory_failure that is confusing the offlining path. HWPoisoned pages
are isolated from the LRU list but __offline_pages might still try to
migrate them if there is any preceding migrateable pages in the pfn
range. Such a migration would fail due to the reference count but
the migration code would put it back on the LRU list. This is quite
wrong in itself but it would also make scan_movable_pages stumble over
it again without any way out.

This means that the hotremove with hwpoisoned pages has never really
worked (without a luck). HWPoisoning really needs a larger surgery
but an immediate and backportable fix is to skip over these pages during
offlining. Even if they are still mapped for some reason then
try_to_unmap should turn those mappings into hwpoison ptes and cause
SIGBUS on access. Nobody should be really touching the content of the
page so it should be safe to ignore them even when there is a pending
reference count.

Debugged-by: Oscar Salvador <osalvador@suse.com>
Cc: stable
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
Hi,
I am sending this as an RFC now because I am not fully sure I see all
the consequences myself yet. This has passed a testing by Oscar but I
would highly appreciate a review from Naoya about my assumptions about
hwpoisoning. E.g. it is not entirely clear to me whether there is a
potential case where the page might be still mapped. I have put
try_to_unmap just to be sure. It would be really great if I could drop
that part because then it is not really great which of the TTU flags to
use to cover all potential cases.

I have marked the patch for stable but I have no idea how far back it
should go. Probably everything that already has hotremove and hwpoison
code.

Thanks in advance!

 mm/memory_hotplug.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index c6c42a7425e5..08c576d5a633 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -34,6 +34,7 @@
 #include <linux/hugetlb.h>
 #include <linux/memblock.h>
 #include <linux/compaction.h>
+#include <linux/rmap.h>
 
 #include <asm/tlbflush.h>
 
@@ -1366,6 +1367,17 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 			pfn = page_to_pfn(compound_head(page))
 				+ hpage_nr_pages(page) - 1;
 
+		/*
+		 * HWPoison pages have elevated reference counts so the migration would
+		 * fail on them. It also doesn't make any sense to migrate them in the
+		 * first place. Still try to unmap such a page in case it is still mapped.
+		 */
+		if (PageHWPoison(page)) {
+			if (page_mapped(page))
+				try_to_unmap(page, TTU_IGNORE_MLOCK | TTU_IGNORE_ACCESS);
+			continue;
+		}
+
 		if (!get_page_unless_zero(page))
 			continue;
 		/*
-- 
2.19.1

