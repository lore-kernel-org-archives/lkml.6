Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A8DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B980A20818
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CmtxvsXL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B980A20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407507AbeKWINq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 03:13:46 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52090 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732619AbeKWINq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 03:13:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7nPXyQ45DpHeedmABT+nvOizkx9iuu6h0ZtTt314jEo=; b=CmtxvsXL+TCDnnGanIzGeYDqL
        FKkaHq6wxBybwFiXukxitKIDHroKJ0zp2yx3tM7zJHy9/70rVcVrPU4AjMaHpNPrmAqmS58/ov5cH
        OfoQa85FKA67CMsBUdinBqmjutaRrHEy12u7jrcvOnsX3GNVC5tXOIj+HnP8OOD0LzWXwWn7X3/36
        u4rb23sYl8tm5r+BZx3VuuUhiokxYBbKPKTiu3Yt3pBAHhoRXBxXDxIRTiQ9hTyJzidZvlCdpbjVv
        Pn8puDirXVh2KAUhzOt3/eH2RUdROvDQbAVUrGkuz8mHYxcizjhDKyUE9fNW2qGKy2ZWCT/ehJB7F
        EeUyIOmRg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPwaP-0003LG-Ek; Thu, 22 Nov 2018 21:32:33 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 0/2] Better support for THP in page cache
Date:   Thu, 22 Nov 2018 13:32:22 -0800
Message-Id: <20181122213224.12793-1-willy@infradead.org>
X-Mailer: git-send-email 2.14.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the first step towards representing THPs more efficiently in
the page cache.  The next step is to insert one head page instead of
HPAGE_PMD_NR.  This passes a Trinity run, but I'm sure there's a
better test-case out there for THP.

Matthew Wilcox (2):
  mm: Remove redundant test from find_get_pages_contig
  page cache: Store only head pages in i_pages

 include/linux/pagemap.h |   9 ++++
 mm/filemap.c            | 106 +++++++++++-----------------------------
 mm/khugepaged.c         |   4 +-
 mm/shmem.c              |   2 +-
 mm/swap_state.c         |   2 +-
 5 files changed, 42 insertions(+), 81 deletions(-)

-- 
2.19.1

