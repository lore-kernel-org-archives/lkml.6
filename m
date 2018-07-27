Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46872C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E04A2088E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:31:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E04A2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730182AbeG0JwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 05:52:20 -0400
Received: from mga06.intel.com ([134.134.136.31]:26914 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbeG0JwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 05:52:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jul 2018 01:31:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,408,1526367600"; 
   d="scan'208";a="76407873"
Received: from devel-ww.sh.intel.com ([10.239.48.110])
  by orsmga001.jf.intel.com with ESMTP; 27 Jul 2018 01:31:20 -0700
From:   Wei Wang <wei.w.wang@intel.com>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        andy.shevchenko@gmail.com, ynorov@caviumnetworks.com,
        corbet@lwn.net, linux@rasmusvillemoes.dk
Cc:     dgilbert@redhat.com, wei.w.wang@intel.com
Subject: [PATCH v2] linux/bitmap.h: comments on BITMAP_LAST_WORD_MASK
Date:   Fri, 27 Jul 2018 16:03:31 +0800
Message-Id: <1532678611-9136-1-git-send-email-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When "nbits = 0" which means no bits to mask, this macro is expected to
return 0, instead of 0xffffffff. Currently, the "nbits = 0" case is
avoided by the callers themselves (e.g.__bitmap_intersects,
__bitmap_weight). This corner case should be explicitly noted.

This patch simply adds a comment above the macro as a note to users about
the corner case.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Yury Norov <ynorov@caviumnetworks.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/bitmap.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 1ee46f4..4e64d1f 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -194,6 +194,7 @@ extern int bitmap_print_to_pagebuf(bool list, char *buf,
 				   const unsigned long *maskp, int nmaskbits);
 
 #define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
+/* "nbits = 0" is not applicable to this macro. Callers should avoid that. */
 #define BITMAP_LAST_WORD_MASK(nbits) (~0UL >> (-(nbits) & (BITS_PER_LONG - 1)))
 
 #define small_const_nbits(nbits) \
-- 
2.7.4

