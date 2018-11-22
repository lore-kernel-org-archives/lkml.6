Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 917F2C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54BA820684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:07:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54BA820684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393778AbeKVUpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 15:45:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50384 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387821AbeKVUpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 15:45:45 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E2CB0315487B;
        Thu, 22 Nov 2018 10:06:59 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-206.ams2.redhat.com [10.36.116.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1627C16BE8;
        Thu, 22 Nov 2018 10:06:46 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        devel@linuxdriverproject.org, linux-fsdevel@vger.kernel.org,
        linux-pm@vger.kernel.org, xen-devel@lists.xenproject.org,
        kexec-ml <kexec@lists.infradead.org>, pv-drivers@vmware.com,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Young <dyoung@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Baoquan He <bhe@redhat.com>, Omar Sandoval <osandov@fb.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Lianbo Jiang <lijiang@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: [PATCH v2 3/8] kexec: export PG_offline to VMCOREINFO
Date:   Thu, 22 Nov 2018 11:06:22 +0100
Message-Id: <20181122100627.5189-4-david@redhat.com>
In-Reply-To: <20181122100627.5189-1-david@redhat.com>
References: <20181122100627.5189-1-david@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 22 Nov 2018 10:07:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now, pages inflated as part of a balloon driver will be dumped
by dump tools like makedumpfile. While XEN is able to check in the
crash kernel whether a certain pfn is actuall backed by memory in the
hypervisor (see xen_oldmem_pfn_is_ram) and optimize this case, dumps of
other balloon inflated memory will essentially result in zero pages getting
allocated by the hypervisor and the dump getting filled with this data.

The allocation and reading of zero pages can directly be avoided if a
dumping tool could know which pages only contain stale information not to
be dumped.

We now have PG_offline which can be (and already is by virtio-balloon)
used for marking pages as logically offline. Follow up patches will
make use of this flag also in other balloon implementations.

Let's export PG_offline via PAGE_OFFLINE_MAPCOUNT_VALUE, so
makedumpfile can directly skip pages that are logically offline and the
content therefore stale. (we export is as a macro to match how it is
done for PG_buddy. This way it is clearer that this is not actually a flag
but only a very specific mapcount value to represent page types).

Please note that this is also helpful for a problem we were seeing under
Hyper-V: Dumping logically offline memory (pages kept fake offline while
onlining a section via online_page_callback) would under some condicions
result in a kernel panic when dumping them.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dave Young <dyoung@redhat.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Lianbo Jiang <lijiang@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Dave Young <dyoung@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 kernel/crash_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 933cb3e45b98..093c9f917ed0 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -464,6 +464,8 @@ static int __init crash_save_vmcoreinfo_init(void)
 	VMCOREINFO_NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE);
 #ifdef CONFIG_HUGETLB_PAGE
 	VMCOREINFO_NUMBER(HUGETLB_PAGE_DTOR);
+#define PAGE_OFFLINE_MAPCOUNT_VALUE	(~PG_offline)
+	VMCOREINFO_NUMBER(PAGE_OFFLINE_MAPCOUNT_VALUE);
 #endif
 
 	arch_crash_save_vmcoreinfo();
-- 
2.17.2

