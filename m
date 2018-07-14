Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F458ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 16:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B28F2089F
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 16:11:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B28F2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731151AbeGNQbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 12:31:00 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50795 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbeGNQbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 12:31:00 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1feN8o-0006my-2e; Sat, 14 Jul 2018 16:11:26 +0000
From:   Colin King <colin.king@canonical.com>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        linux-mm@kvack.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/hmm.c: remove redundant variables align_start and align_end
Date:   Sat, 14 Jul 2018 17:11:24 +0100
Message-Id: <20180714161124.3923-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variables align_start and align_end are being assigned but are
never used hence they are redundant and can be removed.

Cleans up clang warnings:
warning: variable 'align_start' set but not used [-Wunused-but-set-variable]
warning: variable 'align_size' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 mm/hmm.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index caf9df27599e..76e7a058b32f 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -973,10 +973,7 @@ static RADIX_TREE(hmm_devmem_radix, GFP_KERNEL);
 
 static void hmm_devmem_radix_release(struct resource *resource)
 {
-	resource_size_t key, align_start, align_size;
-
-	align_start = resource->start & ~(PA_SECTION_SIZE - 1);
-	align_size = ALIGN(resource_size(resource), PA_SECTION_SIZE);
+	resource_size_t key;
 
 	mutex_lock(&hmm_devmem_lock);
 	for (key = resource->start;
-- 
2.17.1

