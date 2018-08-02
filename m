Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF041C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 22:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79EEB215FB
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 22:59:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79EEB215FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732395AbeHCAwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 20:52:01 -0400
Received: from mga11.intel.com ([192.55.52.93]:40743 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732357AbeHCAwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 20:52:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Aug 2018 15:58:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,437,1526367600"; 
   d="scan'208";a="72912983"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by fmsmga002.fm.intel.com with ESMTP; 02 Aug 2018 15:58:41 -0700
Subject: [PATCH 6/7] x86/mm/pageattr: pass named flag instead of 0/1
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, keescook@google.com,
        tglx@linutronix.de, mingo@kernel.org, aarcange@redhat.com,
        jgross@suse.com, jpoimboe@redhat.com, gregkh@linuxfoundation.org,
        peterz@infradead.org, hughd@google.com,
        torvalds@linux-foundation.org, bp@alien8.de, luto@kernel.org,
        ak@linux.intel.com
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Thu, 02 Aug 2018 15:58:33 -0700
References: <20180802225823.4711C55B@viggo.jf.intel.com>
In-Reply-To: <20180802225823.4711C55B@viggo.jf.intel.com>
Message-Id: <20180802225833.58861DAF@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

This is a cleanup.  There should be functional changes in this patch.

change_page_attr_set/clear() take an 0/1 argument to indicate whether
CPA_ARRAY should be passed down to change_page_attr_set/clear().
Rather than having a 0/1 argument to turn a single flag on/off, just
pass down the flag itself.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/mm/pageattr.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff -puN arch/x86/mm/pageattr.c~x86-pageattr-pass-flags arch/x86/mm/pageattr.c
--- a/arch/x86/mm/pageattr.c~x86-pageattr-pass-flags	2018-08-02 14:14:50.037483273 -0700
+++ b/arch/x86/mm/pageattr.c	2018-08-02 14:14:50.041483273 -0700
@@ -1525,17 +1525,17 @@ out:
 }
 
 static inline int change_page_attr_set(unsigned long *addr, int numpages,
-				       pgprot_t mask, int array)
+				       pgprot_t mask, int flags)
 {
 	return change_page_attr_set_clr(addr, numpages, mask, __pgprot(0), 0,
-		(array ? CPA_ARRAY : 0), NULL);
+		flags, NULL);
 }
 
 static inline int change_page_attr_clear(unsigned long *addr, int numpages,
-					 pgprot_t mask, int array)
+					 pgprot_t mask, int flags)
 {
 	return change_page_attr_set_clr(addr, numpages, __pgprot(0), mask, 0,
-		(array ? CPA_ARRAY : 0), NULL);
+		flags, NULL);
 }
 
 static inline int cpa_set_pages_array(struct page **pages, int numpages,
@@ -1609,7 +1609,8 @@ static int _set_memory_array(unsigned lo
 				_PAGE_CACHE_MODE_UC_MINUS : new_type;
 
 	ret = change_page_attr_set(addr, addrinarray,
-				   cachemode2pgprot(set_type), 1);
+				   cachemode2pgprot(set_type),
+				   CPA_ARRAY);
 
 	if (!ret && new_type == _PAGE_CACHE_MODE_WC)
 		ret = change_page_attr_set_clr(addr, addrinarray,
@@ -1732,7 +1733,8 @@ int set_memory_array_wb(unsigned long *a
 
 	/* WB cache mode is hard wired to all cache attribute bits being 0 */
 	ret = change_page_attr_clear(addr, addrinarray,
-				      __pgprot(_PAGE_CACHE_MASK), 1);
+				      __pgprot(_PAGE_CACHE_MASK),
+				      CPA_ARRAY);
 	if (ret)
 		return ret;
 
_
