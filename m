Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 16C83C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAB89208D7
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:21:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAB89208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965758AbeFONUZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 09:20:25 -0400
Received: from mga11.intel.com ([192.55.52.93]:14574 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936195AbeFONUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 09:20:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jun 2018 06:20:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,227,1526367600"; 
   d="scan'208";a="64399403"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 15 Jun 2018 06:20:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 55085300; Fri, 15 Jun 2018 16:20:18 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Shaohua Li <shli@kernel.org>, linux-raid@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Yury Norov <ynorov@caviumnetworks.com>,
        linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/5] bitmap: Drop unnecessary 0 check for u32 array operations
Date:   Fri, 15 Jun 2018 16:20:14 +0300
Message-Id: <20180615132017.23889-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180615132017.23889-1-andriy.shevchenko@linux.intel.com>
References: <20180615132017.23889-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nbits == 0 is safe to be supplied to the function body, so,
remove unnecessary checks in bitmap_to_arr32() and bitmap_from_arr32().

Acked-by: Yury Norov <ynorov@caviumnetworks.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/bitmap.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 58f9750e49c6..33e95cd359a2 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -1132,14 +1132,10 @@ EXPORT_SYMBOL(bitmap_copy_le);
  *	@buf: array of u32 (in host byte order), the source bitmap
  *	@nbits: number of bits in @bitmap
  */
-void bitmap_from_arr32(unsigned long *bitmap, const u32 *buf,
-						unsigned int nbits)
+void bitmap_from_arr32(unsigned long *bitmap, const u32 *buf, unsigned int nbits)
 {
 	unsigned int i, halfwords;
 
-	if (!nbits)
-		return;
-
 	halfwords = DIV_ROUND_UP(nbits, 32);
 	for (i = 0; i < halfwords; i++) {
 		bitmap[i/2] = (unsigned long) buf[i];
@@ -1163,9 +1159,6 @@ void bitmap_to_arr32(u32 *buf, const unsigned long *bitmap, unsigned int nbits)
 {
 	unsigned int i, halfwords;
 
-	if (!nbits)
-		return;
-
 	halfwords = DIV_ROUND_UP(nbits, 32);
 	for (i = 0; i < halfwords; i++) {
 		buf[i] = (u32) (bitmap[i/2] & UINT_MAX);
-- 
2.17.1

