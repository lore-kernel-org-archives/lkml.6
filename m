Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19EBC282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FFBD2075C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549278531;
	bh=/lb5Fe7r/BlrRMPcQVVn36ZkfXAyX5nLWCqFxIGxxjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vjlLhapTnWOtiGJ5t/t0k5fnGGh7EeMdZ8WSJKKON0A5/K4AqsXkQgXS6yG2wyJsu
	 TWlgn3uSMPX9bdWI/7xMa6lI1XSZnFZTfGmlD6MeOP2WU64jLTbF10U3z5owSJu97h
	 gFqHlB+0lSzgCumpk0hLe4n8+30yZH6K7yODhAwQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730859AbfBDLIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 06:08:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:39326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729522AbfBDKlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:41:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8245F2087C;
        Mon,  4 Feb 2019 10:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549276881;
        bh=/lb5Fe7r/BlrRMPcQVVn36ZkfXAyX5nLWCqFxIGxxjM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z8ALoKmU56/J/SjfnRadi7zS+auXsYgYt9Pvg+ZnIMRpYnKMrZzHwjrgg0ig1xI/Q
         B4vmYy9Hzcxc6GCB932dmfoWOA7Z5D7qBm4RYjx/dM1B6QPu2Q1EY64bq33LNoJcdQ
         ELRU++nfEFOm5TxqE9Ppx1qFycsgXgges+yfvFSo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Sasha Levin <sasha.levin@oracle.com>,
        Amanieu dAntras <amanieu@gmail.com>
Subject: [PATCH 4.4 27/65] arm64: mm: remove page_mapping check in __sync_icache_dcache
Date:   Mon,  4 Feb 2019 11:36:20 +0100
Message-Id: <20190204103615.281076226@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103610.583715954@linuxfoundation.org>
References: <20190204103610.583715954@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shaokun Zhang <zhangshaokun@hisilicon.com>

commit 20c27a4270c775d7ed661491af8ac03264d60fc6 upstream.

__sync_icache_dcache unconditionally skips the cache maintenance for
anonymous pages, under the assumption that flushing is only required in
the presence of D-side aliases [see 7249b79f6b4cc ("arm64: Do not flush
the D-cache for anonymous pages")].

Unfortunately, this breaks migration of anonymous pages holding
self-modifying code, where userspace cannot be reasonably expected to
reissue maintenance instructions in response to a migration.

This patch fixes the problem by removing the broken page_mapping(page)
check from the cache syncing code, otherwise we may end up fetching and
executing stale instructions from the PoU.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: <stable@vger.kernel.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
Cc: Amanieu d'Antras <amanieu@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/mm/flush.c |    4 ----
 1 file changed, 4 deletions(-)

--- a/arch/arm64/mm/flush.c
+++ b/arch/arm64/mm/flush.c
@@ -70,10 +70,6 @@ void __sync_icache_dcache(pte_t pte, uns
 {
 	struct page *page = pte_page(pte);
 
-	/* no flushing needed for anonymous pages */
-	if (!page_mapping(page))
-		return;
-
 	if (!test_and_set_bit(PG_dcache_clean, &page->flags)) {
 		__flush_dcache_area(page_address(page),
 				PAGE_SIZE << compound_order(page));


