Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A6FC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 02:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 437342174A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 02:02:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 437342174A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbeH0Fqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 01:46:36 -0400
Received: from mga03.intel.com ([134.134.136.65]:18333 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727305AbeH0Fqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 01:46:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Aug 2018 19:02:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,293,1531810800"; 
   d="scan'208";a="75801390"
Received: from devel-ww.sh.intel.com ([10.239.48.110])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Aug 2018 19:01:39 -0700
From:   Wei Wang <wei.w.wang@intel.com>
To:     virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org,
        akpm@linux-foundation.org, dgilbert@redhat.com
Cc:     torvalds@linux-foundation.org, pbonzini@redhat.com,
        wei.w.wang@intel.com, liliang.opensource@gmail.com,
        yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com,
        riel@redhat.com, peterx@redhat.com, quintela@redhat.com
Subject: [PATCH v37 2/3] mm/page_poison: expose page_poisoning_enabled to kernel modules
Date:   Mon, 27 Aug 2018 09:32:18 +0800
Message-Id: <1535333539-32420-3-git-send-email-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535333539-32420-1-git-send-email-wei.w.wang@intel.com>
References: <1535333539-32420-1-git-send-email-wei.w.wang@intel.com>
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

