Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F75C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 010B4206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="p46piCNj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 010B4206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733043AbeKTDEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:04:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:37810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732128AbeKTDEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:04:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55CE9206BA;
        Mon, 19 Nov 2018 16:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645632;
        bh=/e9e2zKdrmcPysxXfKvXcDgP2zrZfmqOBVeCRNlZQ/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p46piCNjl0fCIZaw27g9XAcOS8Ves0Sgp9E7CYSHdIElNlRU4Q1oNxrRGMa3kMKf5
         CdIalIr6IyDXChJWRZ4uciX1fIt4gzfrolC4Za96tBgF4JKAE0aU0c4GDOyg/JsBX/
         jYnq2gUYbxIS2vudWLLAiuvOHUBeOzgX501siWbg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 003/171] powerpc/mm: Fix page table dump to work on Radix
Date:   Mon, 19 Nov 2018 17:26:39 +0100
Message-Id: <20181119162619.522819221@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162618.909354448@linuxfoundation.org>
References: <20181119162618.909354448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit 0d923962ab69c27cca664a2d535e90ef655110ca ]

When we're running on Book3S with the Radix MMU enabled the page table
dump currently prints the wrong addresses because it uses the wrong
start address.

Fix it to use PAGE_OFFSET rather than KERN_VIRT_START.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/mm/dump_linuxpagetables.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- a/arch/powerpc/mm/dump_linuxpagetables.c
+++ b/arch/powerpc/mm/dump_linuxpagetables.c
@@ -418,12 +418,13 @@ static void walk_pagetables(struct pg_st
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
@@ -472,9 +473,14 @@ static int ptdump_show(struct seq_file *
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


