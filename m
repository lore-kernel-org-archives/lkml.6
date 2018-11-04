Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F918C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 14:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07A03204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 14:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMkUdLKu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07A03204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730695AbeKDXH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 18:07:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:46260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730564AbeKDXH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 18:07:57 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FD6120862;
        Sun,  4 Nov 2018 13:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541339573;
        bh=8yWIuV+anyDbC5DMrP80T9BmoF4mLDCsnyK2RmmbR+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kMkUdLKusHAZCcp9Ell66sy+q+AcCXCfKig0rnKvjD3ROZPFpeoRCM45nE8ZL9hlN
         exOQMYHfo0hkysqLeX3VqUD1jh44draUEE9foqLawbqio/W3tCU6AfpxQyG5+FXDcX
         0rkChHDC01iLXY+LAPQeklZ/NVxArd/csNf9cWgU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 10/45] powerpc/mm: Fix page table dump to work on Radix
Date:   Sun,  4 Nov 2018 08:52:05 -0500
Message-Id: <20181104135240.88431-10-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181104135240.88431-1-sashal@kernel.org>
References: <20181104135240.88431-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit 0d923962ab69c27cca664a2d535e90ef655110ca ]

When we're running on Book3S with the Radix MMU enabled the page table
dump currently prints the wrong addresses because it uses the wrong
start address.

Fix it to use PAGE_OFFSET rather than KERN_VIRT_START.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/mm/dump_linuxpagetables.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/dump_linuxpagetables.c b/arch/powerpc/mm/dump_linuxpagetables.c
index 876e2a3c79f2..bdf33b989f98 100644
--- a/arch/powerpc/mm/dump_linuxpagetables.c
+++ b/arch/powerpc/mm/dump_linuxpagetables.c
@@ -418,12 +418,13 @@ static void walk_pagetables(struct pg_state *st)
 	unsigned int i;
 	unsigned long addr;
 
+	addr = st->start_address;
+
 	/*
 	 * Traverse the linux pagetable structure and dump pages that are in
 	 * the hash pagetable.
 	 */
-	for (i = 0; i < PTRS_PER_PGD; i++, pgd++) {
-		addr = KERN_VIRT_START + i * PGDIR_SIZE;
+	for (i = 0; i < PTRS_PER_PGD; i++, pgd++, addr += PGDIR_SIZE) {
 		if (!pgd_none(*pgd) && !pgd_huge(*pgd))
 			/* pgd exists */
 			walk_pud(st, pgd, addr);
@@ -472,9 +473,14 @@ static int ptdump_show(struct seq_file *m, void *v)
 {
 	struct pg_state st = {
 		.seq = m,
-		.start_address = KERN_VIRT_START,
 		.marker = address_markers,
 	};
+
+	if (radix_enabled())
+		st.start_address = PAGE_OFFSET;
+	else
+		st.start_address = KERN_VIRT_START;
+
 	/* Traverse kernel page tables */
 	walk_pagetables(&st);
 	note_page(&st, 0, 0, 0);
-- 
2.17.1

