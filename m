Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AE9C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00F2920824
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="ifTLsn5t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00F2920824
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406010AbeKWDak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 22:30:40 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:39541 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403983AbeKWDaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 22:30:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1542905406; x=1574441406;
  h=from:to:cc:subject:date:message-id;
  bh=9HidV9vq6uOAZbu35DoYVQSDNjcPhgv67SSbRGZ00Ns=;
  b=ifTLsn5t56gaQSleYI6wXr8h/FY56HMBnNVk6NIpmarebakomnUfVvfu
   ukv1K03CjWYOZSxpper44g0qShh+SRQhnm8q09bJpHwIAYLPzrKAj3S0w
   ++icyckuCxrswg4RIAqpe2X8NlBHSKscdjjNXiz/8MFFv43ftVZcWmKD5
   E=;
X-IronPort-AV: E=Sophos;i="5.56,253,1539648000"; 
   d="scan'208";a="771919550"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2a-69849ee2.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 22 Nov 2018 16:50:03 +0000
Received: from u54ee758033e858cfa736.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2a-69849ee2.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id wAMGnxNH100567
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 22 Nov 2018 16:50:01 GMT
Received: from u54ee758033e858cfa736.ant.amazon.com (localhost [127.0.0.1])
        by u54ee758033e858cfa736.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id wAMGnwbI008114;
        Thu, 22 Nov 2018 17:49:58 +0100
Received: (from jsteckli@localhost)
        by u54ee758033e858cfa736.ant.amazon.com (8.15.2/8.15.2/Submit) id wAMGnwRd008113;
        Thu, 22 Nov 2018 17:49:58 +0100
From:   Julian Stecklina <jsteckli@amazon.de>
To:     kernel-hardening@lists.openwall.com
Cc:     Julian Stecklina <jsteckli@amazon.de>,
        Liran Alon <liran.alon@oracle.com>,
        Tycho Andersen <tycho@tycho.ws>,
        Jonathan Adams <jwadams@google.com>,
        David Woodhouse <dwmw2@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [RFC RESEND PATCH 3/6] mm, x86: make __kernel_map_pages always available
Date:   Thu, 22 Nov 2018 17:49:36 +0100
Message-Id: <0ba5f3c6d7fc0078d091c507cda980ef5cd710b2.1542905228.git.jsteckli@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1542905228.git.jsteckli@amazon.de>
References: <cover.1542905228.git.jsteckli@amazon.de>
In-Reply-To: <cover.1542905228.git.jsteckli@amazon.de>
References: <cover.1542905228.git.jsteckli@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__kernel_map_pages is currently only enabled when CONFIG_DEBUG_PAGEALLOC
is defined. Enable it unconditionally instead.

Signed-off-by: Julian Stecklina <jsteckli@amazon.de>
---
 arch/x86/mm/pageattr.c | 3 +--
 include/linux/mm.h     | 3 ++-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 51a5a69ecac9..bd3b194400c1 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -2025,8 +2025,6 @@ int set_pages_rw(struct page *page, int numpages)
 	return set_memory_rw(addr, numpages);
 }
 
-#ifdef CONFIG_DEBUG_PAGEALLOC
-
 static int __set_pages_p(struct page *page, int numpages)
 {
 	unsigned long tempaddr = (unsigned long) page_address(page);
@@ -2093,6 +2091,7 @@ void __kernel_map_pages(struct page *page, int numpages, int enable)
 	arch_flush_lazy_mmu_mode();
 }
 
+#ifdef CONFIG_DEBUG_PAGEALLOC
 #ifdef CONFIG_HIBERNATION
 
 bool kernel_page_present(struct page *page)
diff --git a/include/linux/mm.h b/include/linux/mm.h
index a61ebe8ad4ca..a0b9feefebb1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2589,9 +2589,10 @@ static inline void kernel_poison_pages(struct page *page, int numpages,
 					int enable) { }
 #endif
 
+extern void __kernel_map_pages(struct page *page, int numpages, int enable);
+
 #ifdef CONFIG_DEBUG_PAGEALLOC
 extern bool _debug_pagealloc_enabled;
-extern void __kernel_map_pages(struct page *page, int numpages, int enable);
 
 static inline bool debug_pagealloc_enabled(void)
 {
-- 
2.17.1

