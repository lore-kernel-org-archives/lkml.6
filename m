Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8E6C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 11:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BE7521473
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 11:36:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BE7521473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbeHUO41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 10:56:27 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40081 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbeHUO41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 10:56:27 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fs4xe-0007rQ-HM; Tue, 21 Aug 2018 11:36:34 +0000
From:   Colin King <colin.king@canonical.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "Michael S . Tsirkin" <mst@redhat.com>, linux-mm@kvack.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/gup_benchmark: fix unsigned comparison with less than zero
Date:   Tue, 21 Aug 2018 12:36:34 +0100
Message-Id: <20180821113634.3782-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the return from get_user_pages_fast is being checked
to be less than zero for an error check, however, the variable being
checked is unsigned so the check is always false. Fix this by using
a signed long instead.

Detected by Coccinelle ("Unsigned expression compared with zero: nr <= 0")

Fixes: 64c349f4ae78 ("mm: add infrastructure for get_user_pages_fast() benchmarking")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 mm/gup_benchmark.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/gup_benchmark.c b/mm/gup_benchmark.c
index 6a473709e9b6..a9a15e7a1185 100644
--- a/mm/gup_benchmark.c
+++ b/mm/gup_benchmark.c
@@ -31,6 +31,8 @@ static int __gup_benchmark_ioctl(unsigned int cmd,
 	nr = gup->nr_pages_per_call;
 	start_time = ktime_get();
 	for (addr = gup->addr; addr < gup->addr + gup->size; addr = next) {
+		long n;
+
 		if (nr != gup->nr_pages_per_call)
 			break;
 
@@ -40,10 +42,10 @@ static int __gup_benchmark_ioctl(unsigned int cmd,
 			nr = (next - addr) / PAGE_SIZE;
 		}
 
-		nr = get_user_pages_fast(addr, nr, gup->flags & 1, pages + i);
-		if (nr <= 0)
+		n = get_user_pages_fast(addr, nr, gup->flags & 1, pages + i);
+		if (n <= 0)
 			break;
-		i += nr;
+		i += n;
 	}
 	end_time = ktime_get();
 
-- 
2.17.1

