Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC69CC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 10:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0B86214C2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 10:06:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0B86214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390781AbeHPNEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 09:04:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39232 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728018AbeHPNEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 09:04:15 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4878A814FDCE;
        Thu, 16 Aug 2018 10:06:46 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-94.ams2.redhat.com [10.36.116.94])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4326610EE784;
        Thu, 16 Aug 2018 10:06:43 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Kemi Wang <kemi.wang@intel.com>,
        David Rientjes <rientjes@google.com>,
        Jia He <jia.he@hxt-semitech.com>,
        Oscar Salvador <osalvador@suse.de>,
        Petr Tesarik <ptesarik@suse.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Mathieu Malaterre <malat@debian.org>,
        Baoquan He <bhe@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Ross Zwisler <zwisler@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v1 3/5] mm/memory_hotplug: check if sections are already online/offline
Date:   Thu, 16 Aug 2018 12:06:26 +0200
Message-Id: <20180816100628.26428-4-david@redhat.com>
In-Reply-To: <20180816100628.26428-1-david@redhat.com>
References: <20180816100628.26428-1-david@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 16 Aug 2018 10:06:46 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 16 Aug 2018 10:06:46 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'david@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's add some more sanity checking now that onlining/offlining code
works completely on section basis. This will make sure that we will
never try to online/offline sections that are already (or partially) in
the desired state.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mmzone.h |  2 ++
 mm/memory_hotplug.c    |  5 +++++
 mm/sparse.c            | 28 ++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 0859130e4db8..addfa41c047a 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1228,6 +1228,8 @@ static inline int online_section_nr(unsigned long nr)
 }
 
 #ifdef CONFIG_MEMORY_HOTPLUG
+bool mem_sections_online(unsigned long pfn, unsigned long end_pfn);
+bool mem_sections_offline(unsigned long pfn, unsigned long end_pfn);
 void online_mem_sections(unsigned long start_pfn, unsigned long end_pfn);
 #ifdef CONFIG_MEMORY_HOTREMOVE
 void offline_mem_sections(unsigned long start_pfn, unsigned long end_pfn);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 30d2fa42b0bb..3dc6d2a309c2 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -901,6 +901,8 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages, int online_typ
 		return -EINVAL;
 	if (!IS_ALIGNED(nr_pages, PAGES_PER_SECTION))
 		return -EINVAL;
+	if (!mem_sections_offline(pfn, pfn + nr_pages))
+		return -EINVAL;
 
 	/*
 	 * We can't use pfn_to_nid() because nid might be stored in struct page
@@ -1609,6 +1611,9 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 		return -EINVAL;
 	if (!IS_ALIGNED(nr_pages, PAGES_PER_SECTION))
 		return -EINVAL;
+	if (!mem_sections_online(start_pfn, end_pfn))
+		return -EINVAL;
+
 	/* This makes hotplug much easier...and readable.
 	   we assume this for now. .*/
 	if (!test_pages_in_a_zone(start_pfn, end_pfn, &valid_start, &valid_end))
diff --git a/mm/sparse.c b/mm/sparse.c
index 10b07eea9a6e..44693cf38ca9 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -520,6 +520,34 @@ void __init sparse_init(void)
 
 #ifdef CONFIG_MEMORY_HOTPLUG
 
+/* check if all mem sections are online */
+bool mem_sections_online(unsigned long pfn, unsigned long end_pfn)
+{
+	for (; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
+		unsigned long section_nr = pfn_to_section_nr(pfn);
+
+		if (WARN_ON(!valid_section_nr(section_nr)))
+			continue;
+		if (!online_section_nr(section_nr))
+			return false;
+	}
+	return true;
+}
+
+/* check if all mem sections are offline */
+bool mem_sections_offline(unsigned long pfn, unsigned long end_pfn)
+{
+	for (; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
+		unsigned long section_nr = pfn_to_section_nr(pfn);
+
+		if (WARN_ON(!valid_section_nr(section_nr)))
+			continue;
+		if (online_section_nr(section_nr))
+			return false;
+	}
+	return true;
+}
+
 /* Mark all memory sections within the pfn range as online */
 void online_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
 {
-- 
2.17.1

