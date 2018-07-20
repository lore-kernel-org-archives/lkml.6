Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F81ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C74FB20833
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:34:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C74FB20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388833AbeGTNWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:22:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58424 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388096AbeGTNWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:22:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 91BA1401DEC0;
        Fri, 20 Jul 2018 12:34:40 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-17.ams2.redhat.com [10.36.116.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 94C58111AF1D;
        Fri, 20 Jul 2018 12:34:38 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: [PATCH v1 2/2] kdump: include PG_reserved value in VMCOREINFO
Date:   Fri, 20 Jul 2018 14:34:22 +0200
Message-Id: <20180720123422.10127-3-david@redhat.com>
In-Reply-To: <20180720123422.10127-1-david@redhat.com>
References: <20180720123422.10127-1-david@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 20 Jul 2018 12:34:40 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 20 Jul 2018 12:34:40 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'david@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PG_reserved pages should never be touched by enybody except their owner.
Let's allow dumping tools to skip these pages.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dave Young <dyoung@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Michal Hocko <mhocko@kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 kernel/crash_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index b66aced5e8c2..ab216accf96a 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -451,6 +451,7 @@ static int __init crash_save_vmcoreinfo_init(void)
 	log_buf_vmcoreinfo_setup();
 	VMCOREINFO_LENGTH(free_area.free_list, MIGRATE_TYPES);
 	VMCOREINFO_NUMBER(NR_FREE_PAGES);
+	VMCOREINFO_NUMBER(PG_reserved);
 	VMCOREINFO_NUMBER(PG_lru);
 	VMCOREINFO_NUMBER(PG_private);
 	VMCOREINFO_NUMBER(PG_swapcache);
-- 
2.17.1

