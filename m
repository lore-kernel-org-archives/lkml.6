Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A84C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 18:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E66C252C8
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 18:25:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E66C252C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751533AbeFXSZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 14:25:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60787 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750794AbeFXSZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 14:25:38 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fX9hh-0003Wr-5L; Sun, 24 Jun 2018 18:25:37 +0000
From:   Colin King <colin.king@canonical.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm, swap: make swap_slots_cache_mutex and swap_slots_cache_enable_mutex static
Date:   Sun, 24 Jun 2018 19:25:36 +0100
Message-Id: <20180624182536.4937-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The mutexes swap_slots_cache_mutex and swap_slots_cache_enable_mutex are
local to the source and do not need to be in global scope, so make them
static.

Cleans up sparse warnings:
symbol 'swap_slots_cache_mutex' was not declared. Should it be static?
symbol 'swap_slots_cache_enable_mutex' was not declared. Should it be
static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 mm/swap_slots.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/swap_slots.c b/mm/swap_slots.c
index a791411fed71..008ccb22fee6 100644
--- a/mm/swap_slots.c
+++ b/mm/swap_slots.c
@@ -38,9 +38,9 @@ static DEFINE_PER_CPU(struct swap_slots_cache, swp_slots);
 static bool	swap_slot_cache_active;
 bool	swap_slot_cache_enabled;
 static bool	swap_slot_cache_initialized;
-DEFINE_MUTEX(swap_slots_cache_mutex);
+static DEFINE_MUTEX(swap_slots_cache_mutex);
 /* Serialize swap slots cache enable/disable operations */
-DEFINE_MUTEX(swap_slots_cache_enable_mutex);
+static DEFINE_MUTEX(swap_slots_cache_enable_mutex);
 
 static void __drain_swap_slots_cache(unsigned int type);
 static void deactivate_swap_slots_cache(void);
-- 
2.17.0

