Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1F24BC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 05:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7E58208DA
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 05:09:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7E58208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755842AbeFOFJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 01:09:29 -0400
Received: from mga12.intel.com ([192.55.52.136]:33117 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755754AbeFOFIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 01:08:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2018 22:08:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,225,1526367600"; 
   d="scan'208";a="47272196"
Received: from devel-ww.sh.intel.com ([10.239.48.110])
  by fmsmga007.fm.intel.com with ESMTP; 14 Jun 2018 22:08:40 -0700
From:   Wei Wang <wei.w.wang@intel.com>
To:     virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org,
        akpm@linux-foundation.org
Cc:     torvalds@linux-foundation.org, pbonzini@redhat.com,
        wei.w.wang@intel.com, liliang.opensource@gmail.com,
        yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com,
        riel@redhat.com, peterx@redhat.com
Subject: [PATCH v33 3/4] mm/page_poison: expose page_poisoning_enabled to kernel modules
Date:   Fri, 15 Jun 2018 12:43:12 +0800
Message-Id: <1529037793-35521-4-git-send-email-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529037793-35521-1-git-send-email-wei.w.wang@intel.com>
References: <1529037793-35521-1-git-send-email-wei.w.wang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some usages, e.g. virtio-balloon, a kernel module needs to know if
page poisoning is in use. This patch exposes the page_poisoning_enabled
function to kernel modules.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/page_poison.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/page_poison.c b/mm/page_poison.c
index aa2b3d3..830f604 100644
--- a/mm/page_poison.c
+++ b/mm/page_poison.c
@@ -17,6 +17,11 @@ static int __init early_page_poison_param(char *buf)
 }
 early_param("page_poison", early_page_poison_param);
 
+/**
+ * page_poisoning_enabled - check if page poisoning is enabled
+ *
+ * Return true if page poisoning is enabled, or false if not.
+ */
 bool page_poisoning_enabled(void)
 {
 	/*
@@ -29,6 +34,7 @@ bool page_poisoning_enabled(void)
 		(!IS_ENABLED(CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC) &&
 		debug_pagealloc_enabled()));
 }
+EXPORT_SYMBOL_GPL(page_poisoning_enabled);
 
 static void poison_page(struct page *page)
 {
-- 
2.7.4

