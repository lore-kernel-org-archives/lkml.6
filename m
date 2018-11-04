Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BEAECDE46
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AFA920862
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1Pmg9SA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AFA920862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730745AbeKDXIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 18:08:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:46198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730678AbeKDXH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 18:07:59 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03A232087A;
        Sun,  4 Nov 2018 13:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541339574;
        bh=Ch4u0sCo4XgDglmGF7f6oaOnSVEzY2cZHrpcvKZLtKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b1Pmg9SAH7Lpx5B/e6WHpkow4tJhpe17P9fKAGia0a50+ECYb0vet1jm4F56OjwAq
         fYW5VCdP1/s/I2lAoNKGv7jaf2zZa/jB3Pt1cOL5fHnYMXOtAi8HK/E6BzZTzT/c9u
         VirdaqcJ0b34x6eK330FwhI3yemxDTLF/xW8BxIw=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 11/45] powerpc/mm: fix always true/false warning in slice.c
Date:   Sun,  4 Nov 2018 08:52:06 -0500
Message-Id: <20181104135240.88431-11-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181104135240.88431-1-sashal@kernel.org>
References: <20181104135240.88431-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Leroy <christophe.leroy@c-s.fr>

[ Upstream commit 37e9c674e7e6f445e12cb1151017bd4bacdd1e2d ]

This patch fixes the following warnings (obtained with make W=1).

arch/powerpc/mm/slice.c: In function 'slice_range_to_mask':
arch/powerpc/mm/slice.c:73:12: error: comparison is always true due to limited range of data type [-Werror=type-limits]
  if (start < SLICE_LOW_TOP) {
            ^
arch/powerpc/mm/slice.c:81:20: error: comparison is always false due to limited range of data type [-Werror=type-limits]
  if ((start + len) > SLICE_LOW_TOP) {
                    ^
arch/powerpc/mm/slice.c: In function 'slice_mask_for_free':
arch/powerpc/mm/slice.c:136:17: error: comparison is always true due to limited range of data type [-Werror=type-limits]
  if (high_limit <= SLICE_LOW_TOP)
                 ^
arch/powerpc/mm/slice.c: In function 'slice_check_range_fits':
arch/powerpc/mm/slice.c:185:12: error: comparison is always true due to limited range of data type [-Werror=type-limits]
  if (start < SLICE_LOW_TOP) {
            ^
arch/powerpc/mm/slice.c:195:39: error: comparison is always false due to limited range of data type [-Werror=type-limits]
  if (SLICE_NUM_HIGH && ((start + len) > SLICE_LOW_TOP)) {
                                       ^
arch/powerpc/mm/slice.c: In function 'slice_scan_available':
arch/powerpc/mm/slice.c:306:11: error: comparison is always true due to limited range of data type [-Werror=type-limits]
  if (addr < SLICE_LOW_TOP) {
           ^
arch/powerpc/mm/slice.c: In function 'get_slice_psize':
arch/powerpc/mm/slice.c:709:11: error: comparison is always true due to limited range of data type [-Werror=type-limits]
  if (addr < SLICE_LOW_TOP) {
           ^

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/mm/slice.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index 205fe557ca10..4f213ba33491 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -61,6 +61,13 @@ static void slice_print_mask(const char *label, const struct slice_mask *mask) {
 
 #endif
 
+static inline bool slice_addr_is_low(unsigned long addr)
+{
+	u64 tmp = (u64)addr;
+
+	return tmp < SLICE_LOW_TOP;
+}
+
 static void slice_range_to_mask(unsigned long start, unsigned long len,
 				struct slice_mask *ret)
 {
@@ -70,7 +77,7 @@ static void slice_range_to_mask(unsigned long start, unsigned long len,
 	if (SLICE_NUM_HIGH)
 		bitmap_zero(ret->high_slices, SLICE_NUM_HIGH);
 
-	if (start < SLICE_LOW_TOP) {
+	if (slice_addr_is_low(start)) {
 		unsigned long mend = min(end,
 					 (unsigned long)(SLICE_LOW_TOP - 1));
 
@@ -78,7 +85,7 @@ static void slice_range_to_mask(unsigned long start, unsigned long len,
 			- (1u << GET_LOW_SLICE_INDEX(start));
 	}
 
-	if ((start + len) > SLICE_LOW_TOP) {
+	if (SLICE_NUM_HIGH && !slice_addr_is_low(end)) {
 		unsigned long start_index = GET_HIGH_SLICE_INDEX(start);
 		unsigned long align_end = ALIGN(end, (1UL << SLICE_HIGH_SHIFT));
 		unsigned long count = GET_HIGH_SLICE_INDEX(align_end) - start_index;
@@ -133,7 +140,7 @@ static void slice_mask_for_free(struct mm_struct *mm, struct slice_mask *ret,
 		if (!slice_low_has_vma(mm, i))
 			ret->low_slices |= 1u << i;
 
-	if (high_limit <= SLICE_LOW_TOP)
+	if (slice_addr_is_low(high_limit - 1))
 		return;
 
 	for (i = 0; i < GET_HIGH_SLICE_INDEX(high_limit); i++)
@@ -182,7 +189,7 @@ static bool slice_check_range_fits(struct mm_struct *mm,
 	unsigned long end = start + len - 1;
 	u64 low_slices = 0;
 
-	if (start < SLICE_LOW_TOP) {
+	if (slice_addr_is_low(start)) {
 		unsigned long mend = min(end,
 					 (unsigned long)(SLICE_LOW_TOP - 1));
 
@@ -192,7 +199,7 @@ static bool slice_check_range_fits(struct mm_struct *mm,
 	if ((low_slices & available->low_slices) != low_slices)
 		return false;
 
-	if (SLICE_NUM_HIGH && ((start + len) > SLICE_LOW_TOP)) {
+	if (SLICE_NUM_HIGH && !slice_addr_is_low(end)) {
 		unsigned long start_index = GET_HIGH_SLICE_INDEX(start);
 		unsigned long align_end = ALIGN(end, (1UL << SLICE_HIGH_SHIFT));
 		unsigned long count = GET_HIGH_SLICE_INDEX(align_end) - start_index;
@@ -303,7 +310,7 @@ static bool slice_scan_available(unsigned long addr,
 				 int end, unsigned long *boundary_addr)
 {
 	unsigned long slice;
-	if (addr < SLICE_LOW_TOP) {
+	if (slice_addr_is_low(addr)) {
 		slice = GET_LOW_SLICE_INDEX(addr);
 		*boundary_addr = (slice + end) << SLICE_LOW_SHIFT;
 		return !!(available->low_slices & (1u << slice));
@@ -706,7 +713,7 @@ unsigned int get_slice_psize(struct mm_struct *mm, unsigned long addr)
 
 	VM_BUG_ON(radix_enabled());
 
-	if (addr < SLICE_LOW_TOP) {
+	if (slice_addr_is_low(addr)) {
 		psizes = mm->context.low_slices_psize;
 		index = GET_LOW_SLICE_INDEX(addr);
 	} else {
-- 
2.17.1

