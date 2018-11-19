Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A093C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0744120870
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCGEIHQ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0744120870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730292AbeKTCzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:55:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:52674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730034AbeKTCzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:55:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15D1920831;
        Mon, 19 Nov 2018 16:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645062;
        bh=rgmZ8+5s1vB/+hppiXugR3PoagxRQL380G3/0/wH6QU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DCGEIHQ2WUm+a4KSQZWIZYlxeBtXk+p4fohqJ0OTfQuHSsEUG28SzDDTCIdJVb61L
         FnEliCJZE2wAaPtgcKFFWFR8t3qyfIDJKg8JXimjH2cd+sOxwm7gJ4y5jvNR+eUp+q
         1K7zg+KcmOHj7jMfhNc3d1NpkGg8caG6irG6OnBE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 004/205] powerpc/mm: fix always true/false warning in slice.c
Date:   Mon, 19 Nov 2018 17:25:11 +0100
Message-Id: <20181119162617.721702763@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/mm/slice.c |   21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -61,6 +61,13 @@ static void slice_print_mask(const char
 
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
@@ -70,7 +77,7 @@ static void slice_range_to_mask(unsigned
 	if (SLICE_NUM_HIGH)
 		bitmap_zero(ret->high_slices, SLICE_NUM_HIGH);
 
-	if (start < SLICE_LOW_TOP) {
+	if (slice_addr_is_low(start)) {
 		unsigned long mend = min(end,
 					 (unsigned long)(SLICE_LOW_TOP - 1));
 
@@ -78,7 +85,7 @@ static void slice_range_to_mask(unsigned
 			- (1u << GET_LOW_SLICE_INDEX(start));
 	}
 
-	if ((start + len) > SLICE_LOW_TOP) {
+	if (SLICE_NUM_HIGH && !slice_addr_is_low(end)) {
 		unsigned long start_index = GET_HIGH_SLICE_INDEX(start);
 		unsigned long align_end = ALIGN(end, (1UL << SLICE_HIGH_SHIFT));
 		unsigned long count = GET_HIGH_SLICE_INDEX(align_end) - start_index;
@@ -133,7 +140,7 @@ static void slice_mask_for_free(struct m
 		if (!slice_low_has_vma(mm, i))
 			ret->low_slices |= 1u << i;
 
-	if (high_limit <= SLICE_LOW_TOP)
+	if (slice_addr_is_low(high_limit - 1))
 		return;
 
 	for (i = 0; i < GET_HIGH_SLICE_INDEX(high_limit); i++)
@@ -182,7 +189,7 @@ static bool slice_check_range_fits(struc
 	unsigned long end = start + len - 1;
 	u64 low_slices = 0;
 
-	if (start < SLICE_LOW_TOP) {
+	if (slice_addr_is_low(start)) {
 		unsigned long mend = min(end,
 					 (unsigned long)(SLICE_LOW_TOP - 1));
 
@@ -192,7 +199,7 @@ static bool slice_check_range_fits(struc
 	if ((low_slices & available->low_slices) != low_slices)
 		return false;
 
-	if (SLICE_NUM_HIGH && ((start + len) > SLICE_LOW_TOP)) {
+	if (SLICE_NUM_HIGH && !slice_addr_is_low(end)) {
 		unsigned long start_index = GET_HIGH_SLICE_INDEX(start);
 		unsigned long align_end = ALIGN(end, (1UL << SLICE_HIGH_SHIFT));
 		unsigned long count = GET_HIGH_SLICE_INDEX(align_end) - start_index;
@@ -303,7 +310,7 @@ static bool slice_scan_available(unsigne
 				 int end, unsigned long *boundary_addr)
 {
 	unsigned long slice;
-	if (addr < SLICE_LOW_TOP) {
+	if (slice_addr_is_low(addr)) {
 		slice = GET_LOW_SLICE_INDEX(addr);
 		*boundary_addr = (slice + end) << SLICE_LOW_SHIFT;
 		return !!(available->low_slices & (1u << slice));
@@ -706,7 +713,7 @@ unsigned int get_slice_psize(struct mm_s
 
 	VM_BUG_ON(radix_enabled());
 
-	if (addr < SLICE_LOW_TOP) {
+	if (slice_addr_is_low(addr)) {
 		psizes = mm->context.low_slices_psize;
 		index = GET_LOW_SLICE_INDEX(addr);
 	} else {


